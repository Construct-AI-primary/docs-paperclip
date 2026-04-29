---
title: "Vendor Tendering Integration Specification"
description: "Technical specification for the external vendor portal integration, RFQ publication workflow, and vendor-facing features of the Tendering system"
gigabrain_tags: vendor-portal, rfp, rft, quotation, vendor-management, supplier-integration, procurement, document-management, bbbee
last_updated: 2026-04-29
version: 1.0
---

# Vendor Tendering Integration Specification

## 1. Overview

This document specifies the integration between the Paperclip Tendering system and external vendor/supplier portals. It covers the architecture for vendor self-service, RFQ publication workflows, document exchange, and the sync patterns that keep the internal and external systems aligned.

### Scope

| Component | Description |
|-----------|-------------|
| Vendor Portal | Self-service web portal for vendors to register, view tenders, submit quotations |
| RFQ Publication | Automated publishing of tender RFQs to the external portal |
| Document Management | Bid document upload, version control, and secure distribution |
| Sync Patterns | Scheduled and event-driven synchronisation between internal system and vendor portal |
| Error Handling | Retry logic, dead-letter queues, and alerting |

## 2. Vendor Portal Architecture

### 2.1 System Context

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     PAPERCLIP TENDERING SYSTEM                            │
│                                                                          │
│  ┌──────────────────────┐          ┌──────────────────────────────┐     │
│  │   Internal API       │◄────────▶│  Vendor Portal API          │     │
│  │   /api/v1/tendering  │          │  /api/v1/vendor-portal      │     │
│  └──────────────────────┘          └─────────────┬────────────────┘     │
│                                                   │                      │
│  ┌──────────────────────┐                        │                      │
│  │   Sync Engine        │────────────────────────┘                      │
│  │   (cron + triggers)  │                                               │
│  └──────────────────────┘                                               │
│                                                                          │
│  ┌──────────────────────┐          ┌──────────────────────────────┐     │
│  │   Document Store     │          │  Vendor Database (public)    │     │
│  │   (internal + CDN)   │          │  - vendor_profiles           │     │
│  └──────────────────────┘          │  - public_tenders            │     │
│                                    │  - vendor_quotations         │     │
│                                    │  - vendor_documents          │     │
│                                    └──────────────────────────────┘     │
└─────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Vendor Portal API

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `POST` | `/api/v1/vendor-portal/register` | Vendor self-registration | None (CAPTCHA) |
| `POST` | `/api/v1/vendor-portal/login` | Vendor authentication | None |
| `GET` | `/api/v1/vendor-portal/tenders` | List published tenders | JWT (vendor) |
| `GET` | `/api/v1/vendor-portal/tenders/{id}` | Tender details + documents | JWT (vendor) |
| `POST` | `/api/v1/vendor-portal/tenders/{id}/submit` | Submit quotation | JWT (vendor) |
| `GET` | `/api/v1/vendor-portal/submissions` | Vendor's submission history | JWT (vendor) |
| `PUT` | `/api/v1/vendor-portal/profile` | Update vendor profile | JWT (vendor) |
| `POST` | `/api/v1/vendor-portal/profile/documents` | Upload qualification docs | JWT (vendor) |

### 2.3 Authentication Flow

```
Vendor Browser              Vendor Portal API              Auth Service
     │                            │                            │
     │   POST /login (email+pwd)   │                            │
     │───────────────────────────▶│                            │
     │                            │   Validate credentials      │
     │                            │───────────────────────────▶│
     │                            │◀───────────────────────────│
     │                            │                            │
     │   { token, vendor_id }     │                            │
     │◀───────────────────────────│                            │
     │                            │                            │
     │   GET /tenders (JWT)       │                            │
     │───────────────────────────▶│                            │
     │                            │   Verify JWT (issuer)      │
     │                            │   Check RLS (org scope)    │
     │                            │                            │
     │   { tenders: [...] }       │                            │
     │◀───────────────────────────│                            │
```

- Vendors authenticate via email/password with JWT token issuance
- Tokens are scoped to the vendor's organisation (the vendor's company, not the issuer)
- JWT expiry: 24 hours (configurable), refresh tokens with 30-day expiry
- Rate limits: 100 requests/min per vendor token

## 3. Sync Patterns

### 3.1 Scheduled Sync

| Schedule | Frequency | Data Direction | Description |
|----------|-----------|----------------|-------------|
| Every 5 minutes | High | Internal → Portal | Publish newly published or updated RFQs |
| Every 15 minutes | Medium | Portal → Internal | Sync new vendor submissions, profile updates |
| Every 60 minutes | Low | Bidirectional | Full reconciliation sync (checksum verification) |
| Daily (02:00) | Batch | Portal → Internal | Purge expired tenders, archive completed submissions |

### 3.2 Trigger-Based Sync

| Trigger | Action | Latency |
|---------|--------|---------|
| RFQ status → "published" | Immediate push to vendor portal | < 30s |
| RFQ status → "cancelled" | Immediate removal from public listing | < 30s |
| Vendor submits quotation | Webhook callback to internal system | < 10s |
| Vendor profile updated | Queue update for internal review | < 5min |
| RFQ closing date reached | Automated status change + notifications | Scheduled |

### 3.3 Sync Engine Implementation

```
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│  Change Data      │────▶  Sync Queue      │────▶  Conflict        │
│  Capture (CDC)   │    │  (Redis + PG)    │    │  Resolution      │
└──────────────────┘    └──────────────────┘    └────────┬─────────┘
                                                          │
                                                          ▼
                                                  ┌──────────────────┐
                                                  │  Vendor Portal   │
                                                  │  DB (PostgreSQL) │
                                                  └──────────────────┘
```

- CDC captures changes on `tender_rfqs` (status changes, document updates)
- Sync queue handles ordering, deduplication, and retry
- Conflict resolution uses last-writer-wins with timestamp comparison
- Failed syncs are logged to `tender_sync_history` with error details

### 3.4 Reconciliation

```sql
-- Daily reconciliation: compare checksums between internal and portal
SELECT rfq_id, md5(CAST(data AS TEXT)) AS checksum
FROM tender_rfqs
WHERE status IN ('published', 'accepting_bids');

-- Portal-side equivalent
SELECT rfq_id, md5(CAST(data AS TEXT)) AS checksum
FROM public_tenders
WHERE status IN ('published', 'accepting_bids');
```

- Discrepancies are queued for re-sync
- Maximum 3 retry attempts before alert escalation

## 4. RFQ Publication Workflow

### 4.1 Publication Stages

```
Internal Draft ──▶ Review ──▶ Approve ──▶ Publish ──▶ Vendor Notification
                                                          │
                                                          ▼
                                                  ┌──────────────────┐
                                                  │  Accepting Bids  │
                                                  │  (closing date)  │
                                                  └────────┬─────────┘
                                                           │
                                                           ▼
                                                  ┌──────────────────┐
                                                  │  Auto-close      │
                                                  │  (cron trigger)  │
                                                  └──────────────────┘
```

### 4.2 Publication Validation

Before publication, the system validates:

| Check | Rule | Failure Action |
|-------|------|---------------|
| RFQ completeness | All mandatory fields populated (scope, dates, criteria) | Block publication |
| Document attachment | At least one bid document attached | Block publication |
| Closing date | Must be >= 7 days from now (configurable) | Block publication |
| Vendor list | At least 3 prequalified vendors notified (optional) | Warning |
| Budget approval | Approved budget >= estimated value (configurable) | Warning |
| Legal review | Compliance checklist signed off (optional) | Warning |

### 4.3 Vendor Notification

| Channel | Content | Timing |
|---------|---------|--------|
| Email | Tender title, closing date, brief scope, link to portal | Immediately on publish |
| Portal notification | In-app notification on vendor dashboard | Immediately |
| SMS (opt-in) | Tender reference and closing date | Immediately |

### 4.4 Publication Event Payload

```json
{
  "event": "rfq.published",
  "rfq_id": "uuid",
  "rfq_number": "RFQ-2026-0042",
  "title": "Electrical Subcontractor - Steelpoort Mine",
  "tender_type": "subcontract",
  "closing_date": "2026-05-15T11:00:00Z",
  "documents": [
    { "id": "doc-001", "name": "Scope of Works.pdf", "size": 2450000 }
  ],
  "notified_vendors": ["vendor-a", "vendor-b", "vendor-c"]
}
```

## 5. Document Management

### 5.1 Document Lifecycle

```
Upload ──▶ Virus Scan ──▶ Encrypt ──▶ Store (S3/CDN) ──▶ Access Control
                                                              │
                                                              ▼
                                              ┌───────────────────────────┐
                                              │  Vendor Download (portal) │
                                              │  Internal Review (system) │
                                              └───────────────────────────┘
```

### 5.2 Document Types

| Type | Visibility | Retention | Max Size |
|------|-----------|-----------|----------|
| Bid documents (scope, specs, BOQ) | All invited vendors | 90 days post-close | 50 MB |
| Vendor qualification (CIDB, BBBEE, tax) | Internal only | Until expiry | 25 MB |
| Submitted quotation docs | Evaluation team + vendor | 5 years | 100 MB |
| Award letters | Vendor + internal | Permanent | 10 MB |
| Contract documents | Vendor + Contracts team | Permanent | 50 MB |

### 5.3 Document Storage Architecture

```
┌──────────────┐     ┌──────────────────┐     ┌──────────────────┐
│  Upload API   │────▶│  Virus Scanner   │────▶│  Encrypt (AES)  │
└──────────────┘     └──────────────────┘     └────────┬─────────┘
                                                         │
                                                         ▼
                                               ┌──────────────────┐
                                               │  Object Store     │
                                               │  (S3-compatible)  │
                                               └────────┬─────────┘
                                                         │
                                               ┌──────────────────┐
                                               │  CDN (signed     │
                                               │  URLs, expiry)   │
                                               └──────────────────┘
```

- All documents stored in S3-compatible object store with server-side encryption
- Download URLs are time-signed (1-hour expiry for vendors, 24-hour for internal)
- Document access logged to audit trail (who downloaded what, when)
- Vendor-uploaded documents are quarantined until virus scan passes

## 6. Error Handling and Retry

### 6.1 Retry Strategy

| Operation | Max Retries | Backoff | Retry-on |
|-----------|-------------|---------|----------|
| Publish RFQ to portal | 3 | Exponential (1s, 5s, 30s) | Network error, 5xx |
| Sync vendor submission | 3 | Exponential (2s, 10s, 60s) | Network error, 5xx, 409 |
| Vendor notification email | 5 | Exponential (1min, 5min, 15min, 30min, 60min) | SMTP error, timeout |
| Document upload to CDN | 3 | Exponential (5s, 30s, 120s) | Upload failure, 5xx |
| Reconciliation sync | 2 | Linear (60s, 300s) | Checksum mismatch |

### 6.2 Error Categories

| Category | Examples | Handling |
|----------|----------|----------|
| Transient | Network timeout, 503, connection reset | Automatic retry with backoff |
| Authentication | JWT expired, invalid API key | Refresh token, retry once |
| Validation | Missing fields, invalid data | Log error, return to sender, no retry |
| Resource | Portal down, storage full | Escalate to admin after backoff exhausted |
| Data conflict | Version mismatch, stale data | Run reconciliation, log conflict |

### 6.3 Dead-Letter Queue (DLQ)

```
┌──────────────────┐     ┌──────────────────┐
│  Failed Message   │────▶│  DLQ (Redis)     │
│  (after retries)  │     │  TTL: 7 days     │
└──────────────────┘     └────────┬─────────┘
                                  │
                                  ▼
                         ┌──────────────────┐
                         │  Admin Alert     │
                         │  (Slack/Email)   │
                         └──────────────────┘
```

- Messages that exhaust all retries go to DLQ
- DLQ entries are reviewed daily by InfraForge AI
- Manual replay or skip actions available in admin dashboard
- DLQ entries have 7-day TTL before automatic archival

### 6.4 Vendor-Facing Error Responses

```json
{
  "error": {
    "code": "SUBMISSION_CLOSED",
    "message": "The submission period for this tender has closed.",
    "details": {
      "tender": "RFQ-2026-0042",
      "closing_date": "2026-05-15T11:00:00Z",
      "current_time": "2026-05-16T08:00:00Z"
    },
    "reference": "ERR-SUB-2026-0042-001"
  }
}
```

- All vendor-facing errors include a human-readable message and a reference ID for support
- Internal errors never expose stack traces or system details to vendors

### 6.5 Monitoring and Alerting

| Metric | Source | Alert |
|--------|--------|-------|
| RFQ publish failure rate | Sync engine | > 5% in 1 hour |
| Vendor submission sync lag | Sync engine | > 15 minutes |
| Email notification failure | Notification service | > 10% in 1 hour |
| DLQ depth | DLQ monitor | > 50 messages |
| Vendor portal uptime | Health check | < 99.5% |

---

**Version**: 1.0
**Last Updated**: 2026-04-29
**Related Documents**: `BIDDING-GOVT-INTEGRATION.md`, `BUILDER-MEAS-INTEGRATION.md`, `DATABASE-SPEC.md`

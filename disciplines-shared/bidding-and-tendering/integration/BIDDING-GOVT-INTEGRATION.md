---
title: "Government Bidding Integration Specification"
description: "Technical specification for integrating with South African government tender portals via OCDS API with web scraping fallback"
gigabrain_tags: ocds, government-tenders, etenders, cidb, bbbee, web-scraping, api-integration, south-africa, procurement
last_updated: 2026-04-29
version: 1.0
---

# Government Bidding Integration Specification

## 1. Overview

This document specifies the integration between the Paperclip Bidding system and South African government tender portals. The primary integration target is the **etenders.gov.za** portal via the **Open Contracting Data Standard (OCDS)** API, with a web scraping fallback for portals that do not expose an OCDS feed or during API downtime.

### Supported Government Sources

| Source | Type | Priority | Status |
|--------|------|----------|--------|
| etenders.gov.za (OCDS API) | API | Primary | Active |
| etenders.gov.za (Web Portal) | Scraping | Fallback | Active |
| CIDB (Construction iD B) | API | Secondary | Planned |
| National Treasury eTender | API | Secondary | Planned |
| Provincial portals (Gauteng, WC, KZN) | Scraping | Tertiary | Planned |
| Municipal portals | Scraping | Tertiary | Planned |

## 2. OCDS API Integration

### 2.1 Endpoint Details

| Parameter | Value |
|-----------|-------|
| Base URL | `https://etenders.gov.za/api/ocds/v1` |
| Releases Endpoint | `GET /releases` |
| Records Endpoint | `GET /records` |
| Release Package Endpoint | `GET /release-packages/{ocid}` |
| Data Format | JSON (OCDS v1.1) |
| Rate Limit | 30 requests per minute per IP |
| Timeout | 30 seconds (configurable) |
| Authentication | API Key (header-based) |

### 2.2 Query Parameters

```
GET /api/ocds/v1/releases?procurementMethod=open&tenderPeriod.endDate=gt:2026-04-29&limit=100
```

| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `procurementMethod` | string | Filter by procurement method | `open`, `limited`, `selective` |
| `tenderPeriod.endDate` | string | Filter by submission deadline (gt/lt/gte/lte) | `gt:2026-04-29` |
| `tender.value.amount` | number | Filter by estimated value range | `gte:25000,lte:250000` |
| `mainProcurementCategory` | string | Filter by category | `goods`, `works`, `services` |
| `tender.submissionMethod` | string | Submission method filter | `electronic`, `physical` |
| `page` | integer | Pagination (1-based) | `1` |
| `limit` | integer | Results per page (max 200) | `100` |
| `sort` | string | Sort order | `-date`, `+date` |

### 2.3 Authentication

```
GET /api/ocds/v1/releases
Authorization: ApiKey {api_key}
X-Request-Id: {correlation_id}
```

- API keys are issued by National Treasury upon registration
- Keys are stored encrypted in `govt_portal_sources.api_key_encrypted` using `KEY_GOVT_PORTAL`
- Key rotation is supported via the admin interface
- Rate limit headers are respected: `X-RateLimit-Remaining`, `X-RateLimit-Reset`

### 2.4 OCDS Response Mapping

```json
{
  "ocid": "ocds-abc123-2026-001",
  "id": "2026-001",
  "date": "2026-04-29T08:00:00Z",
  "tag": ["tender"],
  "initiationType": "tender",
  "tender": {
    "id": "T2026-001",
    "title": "Construction of School Infrastructure",
    "description": "...",
    "status": "active",
    "procurementMethod": "open",
    "mainProcurementCategory": "works",
    "value": { "amount": 1500000, "currency": "ZAR" },
    "tenderPeriod": {
      "startDate": "2026-04-29T00:00:00Z",
      "endDate": "2026-06-15T11:00:00Z"
    },
    "submissionMethod": ["electronic"],
    "documents": [
      {
        "id": "doc-001",
        "documentType": "biddingDocuments",
        "title": "Tender Document",
        "url": "https://etenders.gov.za/docs/2026-001.pdf"
      }
    ],
    "items": [
      {
        "id": "item-001",
        "description": "Classroom block construction",
        "quantity": 1,
        "unit": { "name": "lump sum" }
      }
    ]
  },
  "buyer": {
    "name": "Department of Basic Education",
    "id": "ZA-DBE"
  }
}
```

| OCDS Field | DB Column | Transformation |
|------------|-----------|----------------|
| `ocid` | `external_id` | Direct mapping |
| `tender.id` | `tender_number` | Direct mapping |
| `tender.title` | `title` | Direct mapping |
| `tender.description` | `description` | Direct mapping |
| `tender.mainProcurementCategory` | `tender_type` | Normalised to enum |
| `tender.procurementMethod` | `procurement_method` | Normalised to enum |
| `tender.value.amount` | `estimated_value` | Decimal parse |
| `tender.value.currency` | `currency` | Direct mapping |
| `buyer.name` | `issuing_organization` | Direct mapping |
| `tender.tenderPeriod.endDate` | `bid_submission_deadline` | ISO-8601 parse |
| `tender.documents` | `source_data` | Stored as JSONB |

## 3. Web Scraping Fallback Architecture

### 3.1 Architecture

```
                  ┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
                  │  OCDS API       │────▶│  Integration     │────▶│  govt_tender_   │
                  │  (Primary)      │     │  Orchestrator    │     │  discovery      │
                  └─────────────────┘     └──────────────────┘     └─────────────────┘
                           │                       │
                           ▼                       ▼
                  ┌─────────────────┐     ┌──────────────────┐
                  │  Web Scraper    │────▶│  Normalisation   │
                  │  (Fallback)     │     │  Layer           │
                  └─────────────────┘     └──────────────────┘
```

### 3.2 Scraper Components

| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Headless Browser** | Playwright/Puppeteer | Renders JavaScript-heavy government portals |
| **HTML Parser** | Cheerio/BeautifulSoup | Extracts structured data from HTML |
| **Rate Limiter** | Token bucket | Respects robots.txt and rate limits |
| **Proxy Rotator** | Residential proxy pool | Avoids IP blocking |
| **Scheduler** | Cron-based | Configurable sync intervals |

### 3.3 Fallback Trigger Conditions

| Condition | Action | Recovery |
|-----------|--------|----------|
| OCDS API returns 5xx | Immediate fallback to scraping | Retry API after 15 min |
| OCDS API rate limited (429) | Backoff + fallback | Resume API after rate limit window |
| OCDS API timeout (>30s) | Fallback for that request | Retry API on next sync cycle |
| Portal has no OCDS feed | Permanent scraping | N/A |
| Scraper also fails | Log error, alert admin | Manual intervention |

### 3.4 Scraper Configuration

```yaml
sources:
  - name: etenders_web
    url: https://etenders.gov.za/Tenders/ActiveTenders
    type: html_table
    selectors:
      table: "#tenders-table"
      row: "tr.tender-row"
      fields:
        tender_number: "td:nth-child(1) a"
        title: "td:nth-child(2)"
        department: "td:nth-child(3)"
        closing_date: "td:nth-child(4)"
        value: "td:nth-child(5)"
    pagination:
      type: query_param
      param: page
      start: 1
      max_pages: 50
    rate_limit:
      requests_per_minute: 10
      delay_between_requests_ms: 6000
```

## 4. Data Transformation Pipeline

### 4.1 Pipeline Stages

```
Raw OCDS/Scraped Data
        │
        ▼
┌─────────────────┐
│ Stage 1: Parse  │  Validate JSON/HTML structure
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Stage 2: Map    │  Map to canonical schema
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Stage 3: Enrich │  Add CIDB grading, BBBEE, geo-tags
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Stage 4: Match  │  Keyword matching, opportunity scoring
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Stage 5: Store  │  Insert into govt_tender_discovery
└─────────────────┘
```

### 4.2 Enrichment Rules

| Enrichment | Source | Logic |
|------------|--------|-------|
| CIDB Grading | CIDB API / keyword extraction | Parse tender description for CIDB references |
| BBBEE Level | Keyword extraction | Extract BBBEE requirements from text |
| Province | Geo-mapping | Map issuing department to province |
| Opportunity Score | Scoring engine | Weighted: value match (40%), capability (30%), past wins (20%), strategic (10%) |
| Keywords | NLP engine | Extract from title + description against configured keyword list |

### 4.3 Deduplication

```sql
-- Deduplication logic: match on external_id or tender_number
INSERT INTO govt_tender_discovery (...)
SELECT ...
WHERE NOT EXISTS (
  SELECT 1 FROM govt_tender_discovery
  WHERE external_id = :external_id
     OR tender_number = :tender_number
);
```

## 5. Health Monitoring

### 5.1 Metrics

| Metric | Source | Alert Threshold |
|--------|--------|-----------------|
| API success rate | Sync job | < 95% over 1 hour |
| API response time | Sync job | > 10s average over 5 min |
| Scraper success rate | Sync job | < 80% over 1 hour |
| Sync lag | Sync job | > 2 hours since last successful sync |
| New tenders discovered | Sync job | 0 new in 24 hours (possible issue) |
| Rate limit hits | API client | > 10 in 1 hour |

### 5.2 Health Check Endpoint

```
GET /api/v1/bidding/health

Response: {
  "status": "healthy" | "degraded" | "down",
  "sources": [
    {
      "source_id": "etenders_ocds",
      "status": "healthy",
      "last_sync": "2026-04-29T10:00:00Z",
      "tenders_discovered_24h": 45,
      "error_rate": 0.02
    }
  ],
  "scrapers": [
    {
      "source_id": "etenders_web",
      "status": "standby",
      "last_active": "2026-04-29T09:30:00Z"
    }
  ]
}
```

### 5.3 Heartbeat Integration

- Sync jobs emit heartbeats to the agent monitoring system (see `HEARTBEAT-MONITORING-CONFIG.md`)
- Missed heartbeats trigger alerts to the InfraForge AI operations channel
- Automatic retry with exponential backoff: 1min → 5min → 15min → 60min

## 6. Security Considerations

### 6.1 Credential Management

| Credential | Storage | Encryption Key | Rotation |
|------------|---------|----------------|----------|
| OCDS API Key | `govt_portal_sources.api_key_encrypted` | `KEY_GOVT_PORTAL` | 90 days |
| OCDS API Secret | `govt_portal_sources.api_secret_encrypted` | `KEY_GOVT_PORTAL` | 90 days |
| Scraper proxy credentials | Environment variables | N/A (env) | As needed |
| Scraper session tokens | In-memory only | N/A | Per session |

### 6.2 Access Control

- Government portal credentials are accessible only to the Bidding system (not Tendering)
- API key decryption requires elevated permissions (`bidding_admin` role)
- All credential access is logged to the audit trail
- Credentials are never exposed in API responses or logs

### 6.3 Data Protection

- Raw OCDS responses stored in `source_data` JSONB field (contains no credentials)
- PII from government portals is minimised — only tender metadata is stored
- All data at rest encrypted via PostgreSQL TDE
- Network traffic to government portals is TLS 1.2+ enforced

### 6.4 Compliance

- Integration complies with South African POPIA (no unnecessary personal data storage)
- CIDB and BBBEE data handled per construction industry data protection guidelines
- Government data cached per fair use terms of etenders.gov.za
- Rate limits respected to avoid service disruption to government portals

---

**Version**: 1.0
**Last Updated**: 2026-04-29
**Related Documents**: `TENDERING-VENDOR-INTEGRATION.md`, `BUILDER-MEAS-INTEGRATION.md`, `DATABASE-SPEC.md`

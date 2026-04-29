---
title: "Bidding & Tendering — Master Implementation Plan"
description: "Complete implementation roadmap for the dual-system Bidding (inbound) and Tendering (outbound) platform"
gigabrain_tags: implementation-plan, bidding, tendering, procurement, roadmap, phased-implementation, government-integration, vendor-portal
last_updated: 2026-04-29
version: 1.0
status: approved
total_estimated_hours: 46-64
---

# Bidding & Tendering — Master Implementation Plan

## Executive Summary

This plan covers the end-to-end implementation of the **Bidding & Tendering** dual-system platform. The build is split into 5 phases spanning approximately **46–64 engineering hours**, executed by a multi-company agent team.

| System | Direction | Core Function |
|--------|-----------|---------------|
| **Bidding** | Inbound (←) | Government tender discovery, bid preparation, submission |
| **Tendering** | Outbound (→) | RFQ management, vendor engagement, evaluation, award |

Both systems share a common database layer with Option B parallel tables, RLS policies, and credential isolation. The build order ensures the database foundation is in place before API/service layer work begins on either system.

---

## Phase 1: Foundation — ZA Govt Integration, Database Schema, API Routes

**Estimated: 5–10 hours**

### 1.1 Database Schema (InfraForge AI — 3–4 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 1.1.1 | Create `govt_portal_sources` table | None |
| 1.1.2 | Create `govt_tender_discovery` table | 1.1.1 |
| 1.1.3 | Create `bid_opportunities` table | 1.1.2 |
| 1.1.4 | Create `bid_submissions` table | 1.1.3 |
| 1.1.5 | Create `tender_rfqs` table | None |
| 1.1.6 | Create `vendor_prequalification` table | None |
| 1.1.7 | Create `quotation_comparisons` table | 1.1.4, 1.1.5 |
| 1.1.8 | Create `tender_awards` table | 1.1.6 |
| 1.1.9 | RLS policies on all tables | 1.1.1–1.1.8 |
| 1.1.10 | Indexes + audit logging setup | 1.1.9 |

### 1.2 ZA Govt OCDS Integration (InfraForge AI — 2–3 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 1.2.1 | OCDS API client with rate limiting | 1.1.1 |
| 1.2.2 | OCDS → `govt_tender_discovery` mapping | 1.2.1 |
| 1.2.3 | Web scraping fallback (Playwright) | 1.2.1 |
| 1.2.4 | Data deduplication logic | 1.2.2 |

### 1.3 API Routes (InfraForge AI — 1–2 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 1.3.1 | Bidding API prefix `/api/v1/bidding` | 1.1.2 |
| 1.3.2 | Tendering API prefix `/api/v1/tendering` | 1.1.5 |
| 1.3.3 | Shared health endpoint `/api/v1/shared/health` | 1.3.1, 1.3.2 |

### 1.4 Encryption & Security (InfraForge AI — 1 hour)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 1.4.1 | `KEY_GOVT_PORTAL` encryption setup | 1.1.1 |
| 1.4.2 | `KEY_VENDOR_PORTAL` encryption setup | 1.1.6 |

### Gate Criteria — Phase 1
- [ ] All tables created with RLS policies tested
- [ ] OCDS API client authenticates and returns valid tender data
- [ ] Web scraper fallback parses at least one portal page correctly
- [ ] API routes return valid health check response
- [ ] Encryption keys deployed and credential isolation verified

---

## Phase 2: Bidding System — Govt Tender Discovery, Bid Preparation, Submission Portal

**Estimated: 10–15 hours**

### 2.1 Tender Discovery Engine (DomainForge AI — 3–4 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 2.1.1 | Keyword matching engine with configurable keyword lists | 1.2.2 |
| 2.1.2 | Opportunity scoring algorithm | 2.1.1 |
| 2.1.3 | CIDB/BBBEE enrichment layer | 1.2.2 |
| 2.1.4 | Automated sync scheduler (5min/15min/60min intervals) | 1.2.4 |

### 2.2 Bid Opportunity Pipeline (DomainForge AI — 3–4 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 2.2.1 | Bid evaluation workflow (go/no-go decision) | 2.1.2 |
| 2.2.2 | Bid manager assignment and routing | 2.2.1 |
| 2.2.3 | Bid deadline tracking and notification | 2.2.1 |

### 2.3 Bid Preparation Suite (DomainForge AI + Loopy AI — 3–4 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 2.3.1 | Document management (upload, versioning) | 1.3.1 |
| 2.3.2 | Compliance checklist (CIDB, BBBEE, tax clearance) | 2.2.1 |
| 2.3.3 | Bid compilation and review workflow | 2.3.1 |

### 2.4 Market Intelligence (DomainForge AI — 2–3 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 2.4.1 | Win/loss tracking dashboard | 2.3.2 |
| 2.4.2 | Competitor tracking and analytics | 2.4.1 |
| 2.4.3 | Procurement trend reporting | 2.4.1 |

### Gate Criteria — Phase 2
- [ ] Tender discovery returns matched opportunities with scores
- [ ] Bid opportunity pipeline supports full evaluation workflow
- [ ] Document management working with version control
- [ ] Compliance checklists function for standard SA requirements
- [ ] Win/loss dashboard displays accurate analytics

---

## Phase 3: Tendering System — RFQ Management, Evaluation Engine, Award Pipeline

**Estimated: 15–20 hours**

### 3.1 Multi-Type Tender Management (DomainForge AI — 4–5 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 3.1.1 | SUBCON (subcontract) workflow + validation | 1.3.2 |
| 3.1.2 | PO (purchase order) workflow + validation | 1.3.2 |
| 3.1.3 | SO (service order) workflow + validation | 1.3.2 |
| 3.1.4 | WO (work order) workflow + validation | 1.3.2 |
| 3.1.5 | HO (head office purchase) workflow + validation | 1.3.2 |
| 3.1.6 | Tender lifecycle state machine (draft → closed) | 3.1.1–3.1.5 |

### 3.2 Bid Evaluation Engine (DomainForge AI — 4–5 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 3.2.1 | Weighted scoring model (technical, commercial, compliance) | 1.1.7 |
| 3.2.2 | Auto bid tabulation with comparison views | 3.2.1 |
| 3.2.3 | Committee-based evaluation with sign-off workflow | 3.2.1 |

### 3.3 Award-to-Contract Pipeline (DomainForge AI — 3–4 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 3.3.1 | Award record generation from evaluation results | 3.2.3 |
| 3.3.2 | Award letter generation (template-based) | 3.3.1 |
| 3.3.3 | Award → Contract handover (Contracts discipline) | 3.3.1 |

### 3.4 Vendor Prequalification (DomainForge AI + Loopy AI — 3–4 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 3.4.1 | Vendor registration workflow with CIDB/BBBEE validation | 1.1.6 |
| 3.4.2 | Document collection (tax clearance, insurance, safety) | 3.4.1 |
| 3.4.3 | Approval workflow with expiry tracking | 3.4.1 |

### 3.5 Quotation Collection (DomainForge AI — 2–3 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 3.5.1 | Vendor quotation submission interface | 3.4.3 |
| 3.5.2 | Quotation comparison and analysis | 3.5.1 |

### Gate Criteria — Phase 3
- [ ] All 5 tender types operational with type-specific validation
- [ ] Evaluation engine produces accurate weighted scores
- [ ] Award pipeline generates letters and triggers contract handover
- [ ] Vendor prequalification accepts and validates documents
- [ ] Quotation comparison shows side-by-side vendor pricing

---

## Phase 4: External Portal — Vendor Registration, Public Tender Listing, Admin Dashboard

**Estimated: 8–12 hours**

### 4.1 Vendor Portal Frontend (Loopy AI — 4–6 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 4.1.1 | Public tender listing page | 3.1.6 |
| 4.1.2 | Vendor registration and profile management | 3.4.3 |
| 4.1.3 | Vendor login/authentication (JWT) | 4.1.2 |
| 4.1.4 | Quotation submission interface | 4.1.3 |
| 4.1.5 | Document upload for vendors | 4.1.3 |

### 4.2 Sync Engine (InfraForge AI — 2–3 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 4.2.1 | CDC-based sync from internal → portal tables | 3.1.6 |
| 4.2.2 | Trigger-based sync (publish event → immediate push) | 4.2.1 |
| 4.2.3 | Daily reconciliation (checksum verification) | 4.2.1 |
| 4.2.4 | Dead-letter queue for failed syncs | 4.2.1 |

### 4.3 Admin Dashboard (DomainForge AI — 2–3 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 4.3.1 | Portal management (publish/unpublish tenders) | 3.1.6 |
| 4.3.2 | Vendor approval management | 3.4.3 |
| 4.3.3 | Sync health monitoring | 4.2.3 |

### Gate Criteria — Phase 4
- [ ] Public tender listing page renders published RFQs correctly
- [ ] Vendor registration flow complete with email verification
- [ ] Sync engine pushes new RFQs to portal within 30s
- [ ] Daily reconciliation passes with zero discrepancies
- [ ] Admin dashboard shows sync status and pending approvals

---

## Phase 5: Integration & Testing — BUILDER-MEAS Integration, Cross-Project Testing, Security Audit

**Estimated: 8–12 hours**

### 5.1 BUILDER-MEAS Integration (DomainForge AI + InfraForge AI — 3–4 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 5.1.1 | BUILDER-MEAS-009: BOQ ingestion endpoint | 3.1.6 |
| 5.1.2 | BUILDER-MEAS-010: Trade packaging logic | 5.1.1 |
| 5.1.3 | BUILDER-MEAS-011: Auto-RFQ generation from trade packages | 5.1.2 |
| 5.1.4 | BUILDER-MEAS-012: Quotation progress monitoring | 3.5.2 |
| 5.1.5 | BUILDER-MEAS-013: Award → BOQ update callback | 3.3.1 |

### 5.2 Cross-Project Testing (QualityForge AI — 3–4 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 5.2.1 | End-to-end bidding workflow test | 2.2.3, 2.3.2 |
| 5.2.2 | End-to-end tendering workflow test | 3.5.2, 3.3.3 |
| 5.2.3 | BUILDER-MEAS 009–013 integration test | 5.1.1–5.1.5 |
| 5.2.4 | Vendor portal end-to-end test | 4.1.5 |
| 5.2.5 | RLS policy security tests (cross-tenant isolation) | 1.1.9 |

### 5.3 Security Audit (QualityForge AI — 1–2 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 5.3.1 | Credential isolation verification | 1.4.1, 1.4.2 |
| 5.3.2 | XSS/CSRF testing on vendor portal | 4.1.1 |
| 5.3.3 | API endpoint authorisation testing | 1.3.1, 1.3.2 |

### 5.4 Deployment & Smoke Tests (InfraForge AI — 1–2 hours)

| Task | Description | Dependencies |
|------|-------------|--------------|
| 5.4.1 | Staging deployment with database migration | All |
| 5.4.2 | Smoke test suite execution | 5.4.1 |
| 5.4.3 | Production readiness sign-off | 5.3.3 |

### Gate Criteria — Phase 5
- [ ] All BUILDER-MEAS 009–013 workflows tested end-to-end
- [ ] Cross-project tests pass for both bidding and tendering
- [ ] Security audit shows no cross-tenant access vulnerabilities
- [ ] Smoke tests pass in staging environment
- [ ] Production sign-off obtained from all stakeholders

---

## Timeline

| Phase | Name | Hours | Dependencies | Start | End |
|-------|------|-------|--------------|-------|-----|
| 1 | Foundation | 5–10 | None | Day 1 | Day 2 |
| 2 | Bidding System | 10–15 | Phase 1 | Day 2 | Day 5 |
| 3 | Tendering System | 15–20 | Phase 1 | Day 2 | Day 6 |
| 4 | External Portal | 8–12 | Phase 3 | Day 5 | Day 8 |
| 5 | Integration & Testing | 8–12 | Phase 2, 3, 4 | Day 7 | Day 10 |

**Parallel execution**: Phases 2 and 3 can run in parallel (same dependency on Phase 1).
**Total calendar time**: 8–10 working days assuming 1–2 concurrent streams.

---

## Gate Criteria — Per Phase Summary

| Phase | Gate | Verification Method |
|-------|------|---------------------|
| 1 | Database schema complete, RLS tested | SQL migrations run, curl health check |
| 2 | Bidding workflow operational | E2E test: discover → evaluate → prepare |
| 3 | Tendering workflow operational | E2E test: create → publish → evaluate → award |
| 4 | Vendor portal accessible and syncing | Browser test + sync reconciliation check |
| 5 | All integrations green, security clean | Test suite + audit report |

---

## Risk Management

### Technical Risks

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| OCDS API downtime or changes | Medium | High | Web scraping fallback, graceful degradation |
| Scraper breaks on portal redesign | Medium | Medium | Selector-based config, quick redeploy |
| RLS performance degradation | Low | High | Index analysis, query plan review |
| Sync conflicts between internal and portal | Medium | Medium | Last-writer-wins, daily reconciliation |
| Vendor portal auth bypass | Low | Critical | JWT + OWASP top 10 testing |

### Operational Risks

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Agent team coordination delays | Medium | Medium | Daily standups, shared RACI |
| Requirement gaps discovered mid-build | Medium | Medium | Build in discovery sprints, document decisions |
| Government credential rotation process | Low | Low | Automated rotation reminders (90 days) |

---

## Agent Assignments

| Phase | Lead Agent | Supporting Agents |
|-------|-----------|-------------------|
| Phase 1: Foundation | InfraForge AI | — |
| Phase 2: Bidding System | DomainForge AI | Loopy AI (portal), InfraForge AI (API) |
| Phase 3: Tendering System | DomainForge AI | Loopy AI (vendor UI), InfraForge AI (API) |
| Phase 4: External Portal | Loopy AI | InfraForge AI (sync engine) |
| Phase 5: Integration & Testing | QualityForge AI | DomainForge AI, InfraForge AI |

---

## Dependencies

### Internal Dependencies

| Dependency | Owner | Phase Required |
|------------|-------|----------------|
| PostgreSQL database with RLS support | Infrastructure | Phase 1 |
| Object storage (S3-compatible) | Infrastructure | Phase 2 |
| Email notification service | Platform | Phase 3 |
| JWT auth service | Platform | Phase 4 |
| Redis for sync queue | Infrastructure | Phase 4 |

### External Dependencies

| Dependency | Type | Phase Required |
|------------|------|----------------|
| etenders.gov.za OCDS API access | Government | Phase 1 |
| CIDB API access (planned) | Government | Phase 2 |
| SMTP relay for vendor notifications | Infrastructure | Phase 3 |
| SMS gateway (optional) | Third-party | Phase 3 |

---

**Version**: 1.0
**Last Updated**: 2026-04-29
**Related Documents**: `2026-04-29-execution-sequence.md`, `BIDDING-GOVT-INTEGRATION.md`, `TENDERING-VENDOR-INTEGRATION.md`, `BUILDER-MEAS-INTEGRATION.md`

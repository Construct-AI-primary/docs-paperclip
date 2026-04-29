---
title: "Cross-Company RACI Matrix — Bidding & Tendering"
description: "Responsible, Accountable, Consulted, Informed matrix for both systems across all implementation phases"
author: "Platform Architecture Team"
date: 2026-04-29
version: 1.0
---

# Cross-Company RACI Matrix — Bidding & Tendering

## RACI Key

| Letter | Meaning | Description |
|--------|---------|-------------|
| **R** | Responsible | Does the work |
| **A** | Accountable | Answers for the outcome (one per row) |
| **C** | Consulted | Provides input/knowledge |
| **I** | Informed | Receives progress updates |

## System-Level RACI

| System | InfraForge AI | DomainForge AI | Loopy AI | QualityForge AI | CEO |
|--------|---------------|----------------|----------|-----------------|-----|
| **Bidding (System 1)** | C | R | R | C | A |
| **Tendering (System 2)** | R | R | C | C | A |
| **Shared Infrastructure** | R | C | I | I | A |
| **External Portal** | C | C | R | I | A |

## Phase-Level RACI

### Phase 1: Discovery & Design

| Activity | InfraForge AI | DomainForge AI | Loopy AI | QualityForge AI | CEO |
|----------|---------------|----------------|----------|-----------------|-----|
| Govt portal source analysis | C | R | I | I | A |
| Tender type requirements (SUBCON/PO/SO/WO/HO) | I | R | I | C | A |
| Database architecture (Option B parallel tables) | R | C | I | I | A |
| API surface design | R | C | C | I | A |
| UI/UX wireframes | I | R | R | C | A |
| Security architecture | R | C | I | I | A |

### Phase 2: Setup & Schema

| Activity | InfraForge AI | DomainForge AI | Loopy AI | QualityForge AI | CEO |
|----------|---------------|----------------|----------|-----------------|-----|
| Create database schema (bidding tables) | R | C | I | I | A |
| Create database schema (tendering tables) | R | C | I | I | A |
| Configure RLS policies | R | I | I | C | A |
| Encrypted credential storage | R | I | I | I | A |
| Seed test data | R | C | I | C | I |

### Phase 3: Implementation

| Activity | InfraForge AI | DomainForge AI | Loopy AI | QualityForge AI | CEO |
|----------|---------------|----------------|----------|-----------------|-----|
| Bidding: Govt tender integration service | C | R | I | C | A |
| Bidding: Bid preparation UI | I | R | R | I | A |
| Bidding: Market intelligence dashboards | I | R | C | C | A |
| Tendering: RFQ management service | R | R | I | C | A |
| Tendering: Evaluation engine | C | R | I | C | A |
| Tendering: Award-to-contract pipeline | C | R | I | C | A |
| External vendor portal | C | C | R | I | A |
| API routes (bidding + tendering) | R | C | I | C | A |

### Phase 4: Deployment

| Activity | InfraForge AI | DomainForge AI | Loopy AI | QualityForge AI | CEO |
|----------|---------------|----------------|----------|-----------------|-----|
| Integration testing | C | R | R | A | I |
| Security audit | R | C | I | A | I |
| Performance benchmarking | R | C | C | A | I |
| Production deployment | R | R | R | C | A |
| User training | I | R | R | I | I |
| Go-live verification | C | C | C | A | A |

## Issue-Level RACI (Future Project)

| Issue | Primary Agent (Company) | Accountable | InfraForge | DomainForge | Loopy AI | QualityForge |
|-------|------------------------|-------------|------------|-------------|----------|--------------|
| BID-TEND-001 | database-infraforge (IF) | IF | A | I | I | I |
| BID-TEND-002 | procurement-domainforge-procurement-contracts (DF) | DF | C | A | I | C |
| BID-TEND-003 | loopy-ai (LA) | LA | C | C | A | I |
| BID-TEND-004 | database-infraforge (IF) | IF | A | C | I | I |
| BID-TEND-005 | procurement-domainforge-procurement-contracts (DF) | DF | I | A | R | C |
| BID-TEND-006 | loopy-ai (LA) | LA | I | C | A | I |
| BID-TEND-007 | procurement-strategy-domainforge-procurement-strategy (DF) | DF | C | A | I | C |
| BID-TEND-008 | validator-qualityforge (QF) | QF | I | C | I | A |
| BID-TEND-009 | measurement-ceo (CEO) | CEO | I | I | I | I |

## Escalation Path

```
Issue blocker → Primary Agent → Company Lead → Cross-Company CEO → Board
   15min        30min           1hr             4hrs            24hrs
```

- **Level 1** (15min): Agent tries alternate approach, consults knowledge bundle
- **Level 2** (30min): Escalate to company lead agent
- **Level 3** (1hr): Cross-company escalation (domainforge-ai-procurementdirector)
- **Level 4** (4hrs): CEO escalation (measurement-ceo)
- **Level 5** (24hrs): Board-level decision needed

## Communication Channels

| Communication Type | Method | Frequency |
|-------------------|--------|-----------|
| Phase gate decisions | Issue status update | Per phase |
| Blocker escalation | Activity log + status change | As needed |
| Daily status | Aggregated activity report | Daily |
| Weekly sync | Cross-company standup | Weekly |
| Security review | Audit log review | Bi-weekly |
| Final sign-off | BID-TEND-009 issue close | End of project |

## Cross-Project Coordination Points

| Project | Coordination Requirement | RACI Role |
|---------|------------------------|-----------|
| QualityForge (PROCURE-TEST) | UI component validation for tendering pages | C |
| MeasureForge (MEASURE-TENDER) | BUILDER-MEAS workflow integration alignment | C |
| Contracts (00435) | Award-to-contract conversion handoff | I |
| Finance (01200) | Budget allocation and payment terms | I |
| Logistics (01700) | Delivery/fulfillment terms on PO tenders | I |

---

**Version**: 1.0
**Last Updated**: 2026-04-29
---
title: "Bidding & Tendering — Code and Documentation Placement Guide"
description: "Comprehensive guide for placing code and documentation in the cross-discipline bidding & tendering platform — covering two complementary systems: (1) Bidding ON government/external work, (2) Issuing tenders TO vendors/subcontractors/suppliers"
gigabrain_tags: cross-discipline, bidding, tendering, procurement, contracts, tender-management, government-bidding, documentation, code-placement
para_section: disciplines-shared/bidding-and-tendering
last_updated: 2026-04-29
---

# Bidding & Tendering — Code and Documentation Placement Guide

## Overview

This guide defines the standard locations for all code and documentation related to the cross-discipline **Bidding & Tendering** platform. The platform serves two complementary systems:

### System 1: Bidding (Bidding ON Work — Inbound)

Discovering and bidding on government and private sector tender opportunities. The organization acts as the **bidder**.

- **Users**: Procurement Team (01900), Estimating Team, Commercial Team
- **Sources**: etenders.gov.za (OCDS API), CIDB, National Treasury, Provincial portals, Private sector
- **Goal**: Win new work by identifying opportunities, preparing compliant bids, and submitting proposals

### System 2: Tendering (Issuing Tenders TO Vendors — Outbound)

Creating and managing tenders that go out to subcontractors, suppliers, and service providers. The organization acts as the **client**.

- **Users**: Procurement Team (01900), Contracts Team (00435), Admin Team (HO purchases)
- **Types**: Subcontract (SUBCON), Purchase Orders (PO), Service Orders (SO), Work Orders (WO), HO Purchases
- **Goal**: Engage the supply chain efficiently, evaluate bids fairly, and award contracts that deliver project requirements

## System Architecture Overview

```
┌──────────────────────────────────────────────────────────────────────────┐
│               BIDDING & TENDERING UNIFIED PLATFORM                       │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌─────────────────────────┐         ┌──────────────────────────────┐    │
│  │  SYSTEM 1: BIDDING        │         │  SYSTEM 2: TENDERING          │    │
│  │  (Bidding ON Work)       │         │  (Issuing Tenders TO Vendors)  │    │
│  │                         │         │                              │    │
│  │  • ZA Govt Tender        │         │  • Subcontract Tenders        │    │
│  │    Intelligence           │         │  • Purchase Order Tenders     │    │
│  │  • OCDS API Integration   │         │  • Service Order Tenders      │    │
│  │  • Web Scraping Fallback  │         │  • Work Order Tenders         │    │
│  │  • Bid Preparation Tools  │         │  • HO Purchase Tenders        │    │
│  │  • Bid Submission Portal  │         │  • Bid Evaluation Engine      │    │
│  │  • Win/Loss Analytics     │         │  • Award → Contract Conv.     │    │
│  │  • Market Intelligence    │         │  • External Vendor Portal     │    │
│  └──────────┬──────────────┘         └──────────┬───────────────────┘   │
│             │                                    │                        │
│             └──────────────┬────────────────────┘                        │
│                             ▼                                            │
│              ┌──────────────────────────────────────┐                    │
│              │ SHARED INFRASTRUCTURE                  │                    │
│              │                                      │                    │
│              │  • Option B Parallel Tables           │                    │
│              │  • Organization-scoped RLS            │                    │
│              │  • Credential Isolation               │                    │
│              │  • Category-separated Audit Logging   │                    │
│              │  • Multi-company Agent Delegation     │                    │
│              └──────────────────────────────────────┘                    │
│                             │                                            │
│                             ▼                                            │
│              ┌──────────────────────────────────────┐                    │
│              │ CONSUMING TEAMS                       │                    │
│              │                                      │                    │
│              │  • Procurement (01900)                │                    │
│              │  • Contracts (00435)                  │                    │
│              │  • Admin / HO                         │                    │
│              │  • Estimating / Commercial            │                    │
│              └──────────────────────────────────────┘                    │
│                                                                           │
└──────────────────────────────────────────────────────────────────────────┘
```

## Workflow Integration

### Bidding Workflows (Inbound)

| Workflow | Description | Source |
|----------|-------------|--------|
| BIDDING-001 | Government tender discovery (OCDS API) | etenders.gov.za |
| BIDDING-002 | Web scraping fallback discovery | etenders.gov.za portal |
| BIDDING-003 | Bid opportunity evaluation | Internal |
| BIDDING-004 | Bid preparation and compliance | Internal |
| BIDDING-005 | Bid submission | External portal |
| BIDDING-006 | Win/loss tracking and analysis | Internal |

### Tendering Workflows (Outbound)

| Workflow | Integration Point | Description |
|----------|------------------|-------------|
| BUILDER-MEAS-009 | BOQ Disaggregation → `tender_rfqs` | Bill of Quantities split into tender packages |
| BUILDER-MEAS-010 | Trade Package → `tender_rfqs.trade_category` | Trade-specific packaging |
| BUILDER-MEAS-011 | RFQ Generation → `tender_rfqs` (INSERT) | Automated RFQ generation |
| BUILDER-MEAS-012 | Quotation Collection → `quotation_comparisons` | Bid collection and comparison |
| BUILDER-MEAS-013 | Subcontract Award → `tender_rfqs.best_bid_id` | Award processing |

## Documentation Placement

### Root Level Files

| File | Location | Purpose |
|------|----------|---------|
| Platform Structure | `./DISCIPLINE-PLATFORM-STRUCTURE.md` | Dual-system architecture overview |
| Workflows Catalog | `./DISCIPLINE-WORKFLOWS-CATALOG.md` | All bidding + tendering workflows |
| This Guide | `./CODE-AND-DOC-PLACEMENT.md` | Placement standards |
| README | `./README.md` | Discipline overview |

### Subdirectories

```
disciplines-shared/bidding-and-tendering/
├── DISCIPLINE-PLATFORM-STRUCTURE.md      # Dual-system architecture and component map
├── DISCIPLINE-WORKFLOWS-CATALOG.md       # Bidding + Tendering workflow definitions
├── CODE-AND-DOC-PLACEMENT.md            # This guide
├── README.md                            # Discipline overview and quick start
│
├── knowledge/                           # Knowledge base
│   ├── PAGE-KNOWLEDGE.md                # Main knowledge entry
│   ├── AGENT-DELEGATION-MAP.md          # Agent delegation across companies
│   ├── CROSS-COMPANY-RACI.md            # Responsible/Accountable/Consulted/Informed
│   └── HEARTBEAT-MONITORING-CONFIG.md   # Agent heartbeat monitoring setup
│
├── database/                            # Database schema definitions
│   ├── create-bidding-tendering-schema.sql  # Full DDL — all parallel tables
│   └── DATABASE-SPEC.md                 # Detailed spec: indexes, RLS, encryption
│
├── integration/                         # Integration architecture
│   ├── BIDDING-GOVT-INTEGRATION.md      # Government bidding integration spec (OCDS API, scraping)
│   ├── TENDERING-VENDOR-INTEGRATION.md  # Vendor tendering integration spec (RFQ, evaluation)
│   └── BUILDER-MEAS-INTEGRATION.md      # BUILDER-MEAS workflow integration points
│
├── plans/                               # Planning documents
│   ├── 2026-04-29-bidding-tendering-plan.md     # Master implementation plan
│   └── 2026-04-29-execution-sequence.md          # Execution order and dependencies
│
├── procedures/                          # Operational procedures
│   ├── bidding-discovery-procedure.md   # How to discover and evaluate bid opportunities
│   ├── tender-creation-procedure.md     # How to create/publish tenders
│   ├── bid-evaluation-procedure.md      # How to evaluate vendor bids
│   └── award-to-contract-procedure.md   # How to convert awards to contracts
│
├── ui-components/                       # Component specifications
│   ├── BIDDING-COMPONENTS.md            # Bidding system UI components
│   ├── TENDERING-COMPONENTS.md          # Tendering system UI components
│   └── SHARED-COMPONENTS.md             # Shared UI components
│
└── projects/                           # Project implementations (created during build)
    └── BID-TEND-001/                    # Master project
```

## Code Placement (For Build Phase)

### Frontend Components

```
ui/src/pages/01900-procurement/components/
├── bidding/                             # System 1: Bidding ON work
│   ├── GovtTenderDiscovery.tsx          # ZA Government tender intelligence
│   ├── BidOpportunityList.tsx           # Discovered opportunity listing
│   ├── BidPreparationPanel.tsx          # Bid document preparation
│   ├── BidSubmissionPanel.tsx           # Bid submission interface
│   ├── WinLossDashboard.tsx             # Win/loss tracking and analytics
│   └── MarketIntelligence.tsx           # Procurement intelligence reports
│
└── tendering/                           # System 2: Issuing tenders TO vendors
    ├── TenderList.tsx                   # Tender listing with search/filter
    ├── TenderDetail.tsx                 # Tender detail view
    ├── RFQGenerator.tsx                 # RFQ creation from BOQ/trade packages
    ├── BidSubmissionPanel.tsx           # Vendor bid submission review
    ├── EvaluationDashboard.tsx          # Bid evaluation scoring
    ├── TenderAwardPanel.tsx             # Award processing
    ├── VendorPortal.tsx                 # External vendor public portal
    └── components/
        ├── TenderStatusBadge.tsx
        ├── BidComparisonTable.tsx
        ├── EvaluationScoreCard.tsx
        └── TenderDocumentUpload.tsx
```

### Backend Services and Routes

```
server/src/
├── routes/
│   ├── bidding.js                       # /api/bidding/* routes (System 1)
│   └── tendering.js                     # /api/tendering/* routes (System 2)
│
├── services/
│   ├── bidding/
│   │   ├── govtDiscoveryService.js      # ZA government tender discovery
│   │   ├── bidPreparationService.js     # Bid preparation logic
│   │   ├── bidSubmissionService.js      # Bid submission management
│   │   └── marketIntelligenceService.js # Market analysis
│   │
│   └── tendering/
│       ├── tenderService.js             # Core tender CRUD
│       ├── rfqService.js                # RFQ generation logic
│       ├── bidService.js                # Vendor bid management
│       ├── evaluationService.js         # Evaluation scoring engine
│       ├── awardService.js              # Award processing
│       └── vendorPortalService.js       # External portal logic
│
└── jobs/
    ├── govtTenderSyncJob.js             # Scheduled sync for government tenders
    └── tenderReminderJob.js             # Bid deadline reminders
```

### Database Migrations

```
packages/db/src/schema/
├── bidding.ts                           # Bidding system tables (govt sources, bid ops)
├── tendering.ts                         # Tendering system tables (RFQs, evaluations)
└── index.ts                             # Export both from schema index

packages/shared/src/types/
├── bidding.ts                           # Bidding types (bid opportunity, submission, etc.)
├── tendering.ts                         # Tendering types (RFQ, bid, evaluation, award)
└── bidding-tendering-constants.ts       # Shared constants (statuses, types, codes)
```

## Integration Checklist

When adding new functionality:

### For Bidding (System 1)
- [ ] Add government portal source in `packages/db/src/schema/bidding.ts`
- [ ] Add discovery service logic to `server/src/services/bidding/`
- [ ] Add API routes to `server/src/routes/bidding.js`
- [ ] Create UI components in `ui/src/pages/01900-procurement/components/bidding/`
- [ ] Update `DISCIPLINE-WORKFLOWS-CATALOG.md` with new bidding workflow

### For Tendering (System 2)
- [ ] Add tender table schema in `packages/db/src/schema/tendering.ts`
- [ ] Add service logic to `server/src/services/tendering/`
- [ ] Add API routes to `server/src/routes/tendering.js`
- [ ] Create UI components in `ui/src/pages/01900-procurement/components/tendering/`
- [ ] Update `DISCIPLINE-WORKFLOWS-CATALOG.md` with new tendering workflow

## Cross-Discipline Dependencies

| Discipline | Bidding Dependency | Tendering Dependency |
|------------|-------------------|---------------------|
| 01900 Procurement | Bid opportunity evaluation | Tender lifecycle management |
| 00435 Contracts | Bid compliance → contract terms | Award-to-contract conversion |
| 02025 Measurement (QS) | Bid pricing from BOQ | BOQ disaggregation into tender packages |
| 01700 Logistics | - | Delivery terms on PO tenders |
| 01200 Finance | Bid pricing approval | Budget allocation for tender awards |

---

**Document Version**: 1.1
**Last Updated**: 2026-04-29
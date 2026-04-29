---
title: "Bidding & Tendering Shared Discipline"
description: "Cross-discipline platform integrating two complementary systems: (1) Bidding — bidding ON government and external work opportunities, (2) Tendering — issuing tenders TO vendors, subcontractors, and suppliers for internal procurement needs"
gigabrain_tags: bidding, tendering, procurement, contracts, government-tenders, bid-evaluation, supplier-selection, subcontractor-management, construction-tendering
last_updated: 2026-04-29
---

# Bidding & Tendering Shared Discipline

## Overview

The Bidding & Tendering Shared Discipline unifies two complementary but distinct systems that serve the complete procurement lifecycle across **Procurement (01900)**, **Contracts (00435)**, and **Admin** teams:

| System | Direction | Purpose | Users |
|--------|-----------|---------|-------|
| **Bidding** | Inbound (←) | Bidding ON government/external work opportunities — discovering tenders, preparing bids, submitting proposals | Procurement, Estimating |
| **Tendering** | Outbound (→) | Issuing tenders TO vendors, subcontractors, and suppliers — RFQ creation, bid collection, evaluation, award | Procurement, Contracts, Admin |

Together, they create a closed loop: bidding wins work → work creates procurement needs → tendering engages the supply chain → contracts fulfill the work.

## Architecture

### System 1: Bidding (Bidding ON Work)

Automated discovery and response to South African government and private sector tender opportunities:

- **ZA Government Tender Intelligence** — OCDS API integration (etenders.gov.za) with web scraping fallback
- **Intelligent Discovery** — Keyword matching, value range targeting (R25k–R250k sweet spot), organization/department intelligence
- **Bid Preparation** — Document management, compliance checking, bid compilation
- **Real-Time Monitoring** — Configurable alert schedules (hourly urgent, daily standard, weekly comprehensive)
- **Procurement Intelligence** — Market analysis, competitor tracking, win/loss analysis

### System 2: Tendering (Issuing Tenders TO Vendors)

Internal multi-type tender management for engaging the supply chain:

- **Subcontracts (SUBCON)** — Trade-specific works (electrical, plumbing, HVAC, structural steel, fire protection, civil)
- **Purchase Orders (PO)** — Materials and equipment procurement
- **Service Orders (SO)** — Testing, inspection, commissioning, and consulting services
- **Work Orders (WO)** — Internal labor and construction task management
- **HO Purchases** — Head Office administrative procurement

### Shared Database Layer

Both systems share a security-separated **Option B parallel tables** architecture with:
- Organization-scoped RLS policies
- Credential isolation per source type (govt portals vs vendor portals)
- Category-separated audit logging
- Independent encryption schemas per source

## Quick Links

| Document | Location | Purpose |
|----------|----------|---------|
| Platform Structure | `./DISCIPLINE-PLATFORM-STRUCTURE.md` | Complete architecture overview |
| Workflows Catalog | `./DISCIPLINE-WORKFLOWS-CATALOG.md` | All workflow definitions |
| Code Placement Guide | `./CODE-AND-DOC-PLACEMENT.md` | File and folder standards |
| Knowledge Base | `./knowledge/PAGE-KNOWLEDGE.md` | Central knowledge entry |
| Database Schema | `./database/create-tendering-schema.sql` | Complete DDL |
| Bidding Integration | `./integration/BIDDING-GOVT-INTEGRATION.md` | Government bidding spec |
| Tendering Integration | `./integration/TENDERING-VENDOR-INTEGRATION.md` | Vendor tendering spec |
| Master Plan | `./plans/2026-04-29-bidding-tendering-plan.md` | Implementation roadmap |

## Key Capabilities

### Bidding Capabilities
- **Government Tender Discovery** — Automated OCDS API + web scraping with intelligent matching
- **Bid Preparation** — Document assembly, compliance checking, qualification matching
- **Alert Engine** — Real-time notifications for relevant opportunities
- **Market Intelligence** — Procurement trends, competitor analysis, win/loss tracking

### Tendering Capabilities
- **Multi-Type Tender Management** — Five procurement types (SUBCON, PO, SO, WO, HO) with type-specific workflows
- **Bid Evaluation Engine** — Weighted scoring with technical, commercial, and compliance dimensions
- **Automated Award-to-Contract Conversion** — Approved awards generate contract records for Contracts team
- **External Subcontractor Portal** — Public pages for vendor registration, tender search, document download
- **BUILDER-MEAS Workflow Integration** — BOQ disaggregation (009) → trade packaging (010) → RFQ gen (011) → quotation collection (012) → award (013)

## Agent Team

| Company | Bidding Role | Tendering Role |
|---------|-------------|----------------|
| **InfraForge AI** | Govt portal integration DB, API routes | Tender database schema, RLS policies, API routes |
| **DomainForge AI** | Bid strategy, intelligence, compliance | Tender strategy, workflow orchestration, evaluation |
| **Loopy AI** | External bid submission portal | External subcontractor portal |
| **QualityForge AI** | Bid QA, compliance validation | Cross-project testing coordination |

## Status

**Phase: Planning (Documentation Stage)** — Complete specification documents are being prepared for Paperclip build execution. The documentation clearly separates the Bidding and Tendering systems while defining their shared infrastructure.

---

**Document Version**: 1.0
**Last Updated**: 2026-04-29
---
title: "Bidding & Tendering — Master Knowledge Base"
description: "Comprehensive knowledge base covering the dual-system platform for (1) Bidding ON government/external work and (2) Issuing tenders TO vendors/subcontractors/suppliers"
gigabrain_tags: bidding, tendering, procurement, contracts, government-tenders, bid-evaluation, supplier-selection, subcontractor-management, construction-tendering, OCDS, RFQ, award, RLS
para_section: disciplines-shared/bidding-and-tendering
last_updated: 2026-04-29
---

# Bidding & Tendering — Master Knowledge Base

## Overview

The **Bidding & Tendering Platform** is a unified dual-system serving the complete procurement lifecycle. It bridges two complementary activities:

| Activity | Direction | Description |
|----------|-----------|-------------|
| **Bidding** | Inbound (←) | The organization bids ON government and private sector work opportunities |
| **Tendering** | Outbound (→) | The organization issues tenders TO vendors, subcontractors, and suppliers |

## Tender Types

### System 1: Bidding Types (Our bids to win work)

| Code | Description | Example |
|------|-------------|---------|
| GOVT | Government tenders (national, provincial, municipal) | etenders.gov.za construction tenders |
| PRVT | Private sector tenders | Commercial developer RFPs |
| SUBC | Subcontract bidding | Bidding as subcontractor on main contracts |

### System 2: Tendering Types (Tenders we issue)

| Code | Name | Description | Users |
|------|------|-------------|-------|
| SUBCON | Subcontract | Trade-specific works (electrical, plumbing, HVAC, steel, fire, civil) | Procurement |
| PO | Purchase Order | Materials and equipment procurement | Procurement, Admin |
| SO | Service Order | Testing, inspection, commissioning, consulting | Procurement |
| WO | Work Order | Internal labor and construction task management | Procurement |
| HO | HO Purchase | Head Office administrative procurement | Admin |

## Workflow Lifecycle

### Bidding Lifecycle (Inbound)

```
Discovery → Evaluation → Preparation → Submission → Award/Rejection → Analysis
```

1. **Discovery** — Automated OCDS API scanning + web scraping identifies new opportunities
2. **Evaluation** — Bid opportunity assessed against organizational capability and capacity
3. **Preparation** — Documents assembled, compliance checked, pricing prepared
4. **Submission** — Bid submitted via external portal or direct delivery
5. **Award/Rejection** — Outcome received and recorded
6. **Analysis** — Win/loss tracking, lessons learned, competitive intelligence updated

### Tendering Lifecycle (Outbound)

```
Draft → Published → Accepting Bids → Under Evaluation → Awarded → Contract → Closed
```

| Status | Description | Trigger |
|--------|-------------|---------|
| Draft | Tender being prepared internally | Manual creation or BOQ import |
| Published | Tender visible to vendors | Manual publish action |
| Accepting Bids | Vendors submitting quotations | Automatic after publish |
| Under Evaluation | Evaluation committee reviewing bids | Bid deadline passed |
| Awarded | Preferred bidder selected | Evaluation complete |
| Contract | Contract generated from award | Award acceptance |
| Closed | All obligations fulfilled | Contract signed |
| Cancelled | Tender withdrawn | Manual cancellation |

## Key Terminology

| Term | Definition |
|------|------------|
| **RFQ** | Request for Quotation — formal request for vendor pricing |
| **RFP** | Request for Proposal — detailed proposal including methodology |
| **BOQ** | Bill of Quantities — itemized list of work items with quantities |
| **CIDB** | Construction Industry Development Board — South African construction grading |
| **BBBEE** | Broad-Based Black Economic Empowerment — South African transformation score |
| **OCDS** | Open Contracting Data Standard — government procurement data standard |
| **RLS** | Row-Level Security — PostgreSQL data isolation at row level |
| **UNSPSC** | United Nations Standard Products and Services Code — procurement classification |
| **SUBCON** | Subcontract — trade-specific construction package |
| **PO** | Purchase Order — materials/equipment order |
| **SO** | Service Order — testing/inspection/consulting engagement |
| **WO** | Work Order — internal labor/task assignment |
| **HO** | Head Office — administrative procurement |
| **Pre-qualification** | Vendor vetting before tender participation |
| **Evaluation Criteria** | Weighted scoring dimensions (technical, commercial, compliance) |

## Relationship to Existing Documentation

This shared discipline defines the **next-generation** Bidding & Tendering platform. It builds upon and references these existing systems in the legacy docs-construct-ai repository:

| Existing Resource | Location | Relationship |
|------------------|----------|-------------|
| Multi-Source Tender Integration System | `docs-construct-ai/disciplines/01900_procurement/integration/1900_TENDER-INTEGRATION-SYSTEM.MD` | Existing production-ready govt integration (9 tables, 3 sources) — will be migrated to Option B architecture |
| Tender Management Documentation | `docs-construct-ai/disciplines/01900_procurement/tenders/1900_TENDER-MANAGEMENT-DOCUMENTATION.MD` | Existing tender management UI with feminine hygiene procurement, real-time monitoring, alerts |
| Tender System Summary | `docs-construct-ai/disciplines/01900_procurement/tenders/1900_TENDER-MANAGEMENT-SYSTEM-SUMMARY.MD` | Executive summary — time savings, efficiency metrics |
| Tender Search Results | `docs-construct-ai/disciplines/01900_procurement/tenders/1900_TENDER-SEARCHRESULTS.MD` | Proven search templates and validation patterns |
| Procurement Order Prompt | `docs-construct-ai/disciplines/01900_procurement/agent-data/prompts/01900_PROCUREMENT_ORDER_PROMPT.md` | Agent prompt templates for procurement workflows |
| AI-Native Procurement Prompt | `docs-construct-ai/disciplines/01900_procurement/agent-data/prompts/01900_AI-NATIVE-PROCUREMENT-OPERATIONS-PROMPT.md` | AI-native procurement operations prompt |
| Supplier Selection Implementation | `docs-construct-ai/disciplines/01900_procurement/plan/1900_UI_SUPPLIER_SELECTION_IMPLEMENTATION.MD` | UI implementation plan for supplier selection |
| Supplier Outreach Workflow | `docs-construct-ai/disciplines/01900_procurement/workflow_docs/orders/1900_PROCUREMENT_SUPPLIER_OUTREACH_WORKFLOW.MD` | Supplier outreach and engagement workflow |
| PO Template | `docs-construct-ai/disciplines/01900_procurement/templates/1900_PURCHASE_ORDER_TEMPLATE.MD` | Purchase order template definition |
| SO Template | `docs-construct-ai/disciplines/01900_procurement/templates/1900_SERVICE_ORDER_TEMPLATE.MD` | Service order template definition |
| WO Template | `docs-construct-ai/disciplines/01900_procurement/templates/1900_WORK_ORDER_TEMPLATE.MD` | Work order template definition |
| Scope of Work Template | `docs-construct-ai/disciplines/01900_procurement/templates/1900_SCOPE_OF_WORK_TEMPLATE.MD` | SOW template with appendices A-F |
| Appendix A (Specifications) | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_A_SPECIFICATIONS.MD` | Product/technical specifications |
| Appendix B (Safety) | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_B_SAFETY.MD` | Safety requirements |
| Appendix C (Delivery) | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_C_DELIVERY.MD` | Delivery terms |
| Appendix D (Training) | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_D_TRAINING.MD` | Training requirements |
| Appendix E (Logistics) | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_E_LOGISTICS.MD` | Logistics requirements |
| Appendix F (Packing) | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_F_PACKING.MD` | Packing requirements |
| Template System | `docs-construct-ai/disciplines/01900_procurement/templates/1900_PROCUREMENT-TEMPLATE-SYSTEM.MD` | Template system architecture |
| O&G Project Typology | `docs-construct-ai/disciplines/01900_procurement/agent-data/domain-knowledge/project-typologies/0010_OIL-AND-GAS.MD` | Oil & Gas procurement example (PO/SO/WO patterns) |
| Agent Skill Mapping | `docs-construct-ai/disciplines/01900_procurement/agent-data/registry/01900_AGENT_SKILL_MAPPING.MD` | Agent capabilities mapping |
| Agent Naming Map | `docs-construct-ai/disciplines/01900_procurement/agent-data/registry/1900_AGENT-NAMING-MAP.MD` | Agent naming conventions |
| API Specification | `docs-construct-ai/disciplines/01900_procurement/agent-data/1900_API_SPEC.MD` | Procurement API specifications |
| Integrations | `docs-construct-ai/disciplines/01900_procurement/agent-data/1900_INTEGRATIONS.MD` | Procurement integration points |

### ZA Government Integration

| Source | Type | Status | Legacy System Ref |
|--------|------|--------|-------------------|
| etenders.gov.za (OCDS API) | API | Active | Existing `integration_sources` table → migrate |
| etenders.gov.za (Web Portal) | Scraping | Fallback | Existing web scraper → migrate |
| CIDB | API | Planned | _New_ |
| National Treasury | API | Planned | _New_ |
| CSD (Central Supplier Database) | API | Active | Existing `supplier_verifications` → migrate |
| Provincial portals | Scraping | Planned | _New_ |

### BUILDER-MEAS Workflow Integration

| Workflow | Integration | Description |
|----------|-------------|-------------|
| BUILDER-MEAS-009 | BOQ → tender_rfqs | BOQ items mapped to tender packages |
| BUILDER-MEAS-010 | Trade → tender_rfqs | Trade category assignment |
| BUILDER-MEAS-011 | tender_rfqs INSERT | Automated RFQ generation |
| BUILDER-MEAS-012 | quotation_comparisons | Bid collection and comparison |
| BUILDER-MEAS-013 | best_bid_id update | Award processing |

### Cross-Discipline Integration

| Discipline | Function | Integration |
|------------|----------|-------------|
| 01900 Procurement | Tender lifecycle | Primary |
| 00435 Contracts | Award-to-contract | Via award status |
| 02025 Measurement (QS) | BOQ source data | Via BUILDER-MEAS |
| 01700 Logistics | Delivery tracking | On PO tenders |
| 01200 Finance | Budget/Payment | On award value |

## Security Principles

1. **Credential Isolation** — Govt portal credentials encrypted separately from vendor portal credentials
2. **RLS Enforced** — All tables have organization-scoped RLS policies
3. **Audit Trail** — Complete sync history with per-category logging
4. **Error Recovery** — Retry logic with exponential backoff
5. **No Cross-Contamination** — Separate tables for bidding vs tendering, separate encryption keys
6. **Data Encryption** — All sensitive fields encrypted at rest (bank details, credential tokens)

## Success Criteria

- [ ] ZA Government OCDS API integration operational with health monitoring
- [ ] Web scraping fallback functional for API downtime
- [ ] All 5 tender types (SUBCON, PO, SO, WO, HO) supported with type-specific validation
- [ ] Bid evaluation engine with weighted scoring
- [ ] Award-to-contract conversion pipeline tested end-to-end
- [ ] External vendor portal with public tender listing and registration
- [ ] BUILDER-MEAS-009..013 workflow integration validated
- [ ] Security audit passed (no cross-tenant access)
- [ ] RLS policies tested with organization-scoped queries
- [ ] Agent heartbeat monitoring operational

## Related Documents

| Document | Location |
|----------|----------|
| Platform Structure | `./DISCIPLINE-PLATFORM-STRUCTURE.md` |
| Code & Doc Placement | `./CODE-AND-DOC-PLACEMENT.md` |
| Cross-Company RACI | `./knowledge/CROSS-COMPANY-RACI.md` |
| Agent Delegation Map | `./knowledge/AGENT-DELEGATION-MAP.md` |
| Heartbeat Config | `./knowledge/HEARTBEAT-MONITORING-CONFIG.md` |
| Database Spec | `./database/DATABASE-SPEC.md` |
| Govt Integration | `./integration/BIDDING-GOVT-INTEGRATION.md` |
| Vendor Integration | `./integration/TENDERING-VENDOR-INTEGRATION.md` |
| BUILDER-MEAS Integration | `./integration/BUILDER-MEAS-INTEGRATION.md` |
| Master Plan | `./plans/2026-04-29-bidding-tendering-plan.md` |

---

**Version**: 1.0
**Last Updated**: 2026-04-29
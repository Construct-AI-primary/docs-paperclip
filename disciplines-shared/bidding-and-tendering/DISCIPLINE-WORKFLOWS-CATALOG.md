---
title: "Bidding & Tendering Workflows Catalog"
description: "Complete catalog of 19 workflows across both systems — Bidding (6), Tendering (10), and Shared (3)"
last_updated: 2026-04-29
version: 1.0
gigabrain_tags: workflows, bidding, tendering, procurement, contracts, bid-evaluation, govt-tenders, vendor-management
---

# Bidding & Tendering Workflows Catalog

## Overview

This catalog documents all 19 workflows across the Bidding & Tendering platform:

| System | Workflow Count | Scope |
|--------|---------------|-------|
| **Bidding (System 1)** | 6 | Discovering and bidding on government/external work |
| **Tendering (System 2)** | 10 | Issuing tenders to vendors and managing the lifecycle |
| **Shared Cross-Cutting** | 3 | Alert engine, document management, audit & compliance |

## Bidding Workflows (System 1)

| ID | Workflow Name | Trigger | Primary Agent | Input | Output |
|----|--------------|---------|---------------|-------|--------|
| BID-001 | Govt Tender Discovery (OCDS) | Scheduled (hourly) | procurement-strategy-domainforge-procurement-strategy | OCDS API response | New tender records in `govt_tender_discovery` |
| BID-002 | Web Scraping Fallback | OCDS API failure | procurement-strategy-domainforge-procurement-strategy | etenders.gov.za portal HTML | Scraped tender records |
| BID-003 | Opportunity Evaluation | New discovery created | procurement-domainforge-procurement-contracts | Tender discovery record | Bid decision (pursue/decline) |
| BID-004 | Bid Preparation & Compliance | Decision = pursue | procurement-domainforge-procurement-contracts | Bid requirements, docs | Completed bid package |
| BID-005 | Bid Submission | Bid package complete | loopy-ai | Bid documents | Submitted bid record |
| BID-006 | Win/Loss Analysis | Award/rejection received | procurement-domainforge-procurement-contracts | Bid outcome | Win/loss report, insights |

### BID-001: Govt Tender Discovery (OCDS API)
- **Trigger**: Scheduled every 60 minutes (configurable per source)
- **Input**: OCDS API endpoint (`https://ocds-api.etenders.gov.za/api/OCDSReleases`) with query parameters
- **Steps**: API call → Parse OCDS response → Map fields → Score opportunity → Store in `govt_tender_discovery`
- **Output**: New tender records with `status: 'new'`
- **Edge cases**: API timeout (→ BID-002), duplicate detection (by `external_id`), rate limit handling

### BID-002: Web Scraping Fallback
- **Trigger**: OCDS API returns error or timeout
- **Input**: etenders.gov.za search portal URL
- **Steps**: Launch browser → Navigate search → Extract listings → Parse content → Cross-reference with existing → Store
- **Output**: Scraped tender records (same schema as BID-001)
- **Edge cases**: CAPTCHA detection, login walls, portal redesign (selector fallbacks)

### BID-003: Opportunity Evaluation
- **Trigger**: New discovery record with `status: 'new'`
- **Input**: Tender discovery data, organizational capability matrix
- **Steps**: Score capability match → Check resource availability → Evaluate compliance requirements → Recommend pursue/decline
- **Output**: Bid opportunity with decision and rationale
- **Edge cases**: Incomplete capability data, multiple simultaneous opportunities

### BID-004: Bid Preparation & Compliance
- **Trigger**: Opportunity decision set to `pursue`
- **Input**: Tender requirements, specifications, BOQ
- **Steps**: Assemble documents → Verify compliance → Prepare pricing → Internal review → Finalize
- **Output**: Completed bid package for submission
- **Edge cases**: Missing compliance documents, pricing approval delays

### BID-005: Bid Submission
- **Trigger**: Bid package status = `ready`
- **Input**: Completed bid package
- **Steps**: Package documents → Submit via portal/email/physical → Record submission → Update opportunity status
- **Output**: Submitted bid record with reference number
- **Edge cases**: Portal submission failures, document size limits, deadline management

### BID-006: Win/Loss Analysis
- **Trigger**: Bid result received (award/rejection notification)
- **Input**: Bid outcome details, award amount, competitor info
- **Steps**: Record outcome → Analyze win/loss factors → Update competitive intelligence → Generate report
- **Output**: Win/loss report with lessons learned and market insights
- **Edge cases**: Delayed results, partial awards, no feedback from client

## Tendering Workflows (System 2)

| ID | Workflow Name | Trigger | Primary Agent | Input | Output |
|----|--------------|---------|---------------|-------|--------|
| TEND-001 | RFQ Creation (SUBCON) | BOQ import or manual | procurement-domainforge-procurement-contracts | BOQ from BUILDER-MEAS-009 | Subcontract RFQ record |
| TEND-002 | RFQ Creation (PO) | Material requisition | procurement-domainforge-procurement-contracts | Material list | Purchase order RFQ |
| TEND-003 | RFQ Creation (SO) | Service request | procurement-domainforge-procurement-contracts | Service specification | Service order RFQ |
| TEND-004 | RFQ Creation (WO) | Internal task request | procurement-domainforge-procurement-contracts | Task description | Work order RFQ |
| TEND-005 | RFQ Creation (HO) | Admin purchase request | Admin team user | Purchase description | HO purchase RFQ |
| TEND-006 | Bid Collection | RFQ published | procurement-domainforge-procurement-contracts | Published RFQ | Collected vendor quotations |
| TEND-007 | Evaluation & Scoring | Bid deadline passed | procurement-domainforge-procurement-contracts | Quotations, criteria | Evaluated bids with scores |
| TEND-008 | Award Processing | Evaluation complete | procurement-domainforge-procurement-contracts | Scores, recommendation | Award record |
| TEND-009 | Award-to-Contract | Award accepted | procurement-domainforge-procurement-contracts | Award record | Contract generated |
| TEND-010 | Vendor Management | Ongoing | procurement-domainforge-procurement-contracts | Vendor applications | Pre-qualified vendor list |

### TEND-001..005: RFQ Creation (Per Type)
- **Trigger**: Type-specific (BOQ import, material requisition, service request, task request, admin purchase)
- **Steps**: Validate input → Set tender type → Map trade category → Set evaluation criteria → Create RFQ record
- **Output**: RFQ record with `status: 'draft'`
- **Type-specific validations**: SUBCON (CIDB grading), PO (delivery terms), SO (certifications), WO (resource availability), HO (budget code)

### TEND-006: Bid Collection
- **Trigger**: RFQ status changed to `published`
- **Steps**: Notify vendors → Accept quotations → Track submissions → Flag deadline
- **Output**: Quotations in `quotation_comparisons` table
- **Edge cases**: Late submissions, incomplete quotations, vendor withdrawal

### TEND-007: Evaluation & Scoring
- **Trigger**: RFQ closing deadline passed
- **Steps**: Form evaluation panel → Score technical → Score commercial → Score compliance → Calculate overall → Recommend award
- **Output**: Evaluated bids with scores and recommendation
- **Evaluation dimensions**: Technical (40%), Commercial (40%), Compliance (20%)

### TEND-008: Award Processing
- **Trigger**: Evaluation panel recommendation approved
- **Steps**: Create award record → Notify winning vendor → Set acceptance period → Update RFQ status
- **Output**: Award record with `status: 'awarded'`
- **Edge cases**: Winning vendor declines, negotiation needed, budget constraints

### TEND-009: Award-to-Contract Conversion
- **Trigger**: Vendor accepts award
- **Steps**: Generate contract from award terms → Route for signatures → Link to contracts system → Update status
- **Output**: Contract record, award status = `contract`
- **Integration**: Links to Contracts (00435) discipline

### TEND-010: Vendor Management
- **Trigger**: Ongoing / vendor application
- **Steps**: Review application → Verify credentials → Check references → Approve/reject → Monitor status
- **Output**: Pre-qualified vendor records with approval status and expiry
- **Edge cases**: Expired certifications, blacklisted vendors, trade category changes

## Shared Cross-Cutting Workflows

| ID | Workflow Name | Trigger | Primary Agent | Description |
|----|--------------|---------|---------------|-------------|
| SHARED-001 | Alert Engine | Configurable schedules | procurement-domainforge-procurement-contracts | Notify users of new opportunities, bid deadlines, award announcements |
| SHARED-002 | Document Management | Any document operation | proc-domainforge-procurement-contracts | Upload, store, version, and manage tender documents |
| SHARED-003 | Audit & Compliance | System operations | validator-qualityforge | Track all mutations, verify RLS, audit trail |

## Workflow Dependency Map

```
BID-001 ──→ BID-002 (fallback)
  │
  ▼
BID-003 ──→ BID-004 ──→ BID-005 ──→ BID-006
  │                            │
  └────────────────────────────┘

BUILDER-MEAS-009 ──→ BUILDER-MEAS-010 ──→ TEND-001..005
                                                    │
                                                    ▼
                                              TEND-006 (bid collection)
                                                    │
                                                    ▼
                                              TEND-007 (evaluation)
                                                    │
                                                    ▼
                                              TEND-008 (award)
                                                    │
                                                    ▼
                                              TEND-009 (contract)
                                                    │
                                              Contracts (00435)
```

## Integration Points with BUILDER-MEAS

| BUILDER-MEAS | Workflow | Integration |
|--------------|----------|-------------|
| 009 (BOQ Disaggregation) | TEND-001 | BOQ itemized list → RFQ line items |
| 010 (Trade Package) | TEND-001 | Trade category assigned to RFQ |
| 011 (RFQ Generation) | TEND-001..005 | Automated RFQ creation |
| 012 (Quotation Collection) | TEND-006 | Bid collection from vendors |
| 013 (Subcontract Award) | TEND-008..009 | Award processing and conversion |

---

**Version**: 1.0
**Last Updated**: 2026-04-29
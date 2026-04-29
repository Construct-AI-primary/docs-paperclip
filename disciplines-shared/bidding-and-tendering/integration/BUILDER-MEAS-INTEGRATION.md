---
title: "BUILDER-MEAS Workflow Integration"
description: "Technical specification for the BUILDER-MEAS-009 through 013 workflow integration between the Measurement (QS) and Tendering systems"
gigabrain_tags: builder-meas, measurement, quantity-surveying, boq, rfq, trade-packaging, award, construction-workflow, integration
last_updated: 2026-04-29
version: 1.0
---

# BUILDER-MEAS Workflow Integration

## 1. Overview

This document specifies the integration between the **BUILDER-MEAS** measurement platform and the **Bidding & Tendering** platform. The integration covers workflows BUILDER-MEAS-009 through BUILDER-MEAS-013, which represent the end-to-end pipeline from Bill of Quantities (BOQ) disaggregation through trade packaging, RFQ generation, quotation collection, and award processing.

### Workflow Summary

| Workflow | Name | Source → Target | Description |
|----------|------|-----------------|-------------|
| **BUILDER-MEAS-009** | BOQ Disaggregation | Measurement → Tendering | Break down BOQ into line items for tender packaging |
| **BUILDER-MEAS-010** | Trade Packaging | Measurement → Tendering | Group BOQ items into trade-specific tender packages |
| **BUILDER-MEAS-011** | RFQ Generation | Tendering | Generate formal RFQ documents from trade packages |
| **BUILDER-MEAS-012** | Quotation Collection | Tendering → Vendors | Collect and compare vendor quotations |
| **BUILDER-MEAS-013** | Award Processing | Tendering → Measurement | Process award decisions, update measurement records |

## 2. BUILDER-MEAS-009: BOQ Disaggregation

### 2.1 Purpose

Disaggregate a project's Bill of Quantities (BOQ) into individual line items that can be assigned to trade packages. This is the entry point for the tendering workflow — the BOQ produced by Quantity Surveyors is broken down from its hierarchical structure into atomic line items.

### 2.2 Data Flow

```
Measurement Platform                    Tendering Platform
┌──────────────────┐                  ┌──────────────────┐
│  BOQ Master      │                  │  BOQ Line Items  │
│  - project_id    │                  │  - line_item_id  │
│  - boq_version   │    POST /api/    │  - boq_reference │
│  - sections[]    │──▶ v1/tendering/ │  - description   │
│  - items[]       │    boq/ingest    │  - quantity      │
│  - totals        │                  │  - unit          │
└──────────────────┘                  │  - rate          │
                                      │  - amount        │
                                      │  - trade_category│
                                      │  - status        │
                                      └──────────────────┘
```

### 2.3 Integration Endpoint

```http
POST /api/v1/tendering/boq/ingest
Content-Type: application/json
Authorization: Bearer {internal_service_token}

{
  "project_id": "uuid",
  "boq_version_id": "uuid",
  "boq_reference": "BOQ-PROJ-2026-001",
  "source": "builder-meas",
  "line_items": [
    {
      "item_code": "A.1.1",
      "description": "Reinforced concrete column class 2",
      "quantity": 45.0,
      "unit": "m3",
      "rate": 8500.00,
      "amount": 382500.00,
      "section": "Concrete Works",
      "trade_category": "structural"
    }
  ],
  "metadata": {
    "project_name": "Steelpoort Mine Offices",
    "version": "2.1",
    "currency": "ZAR"
  }
}
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `project_id` | UUID | Yes | Project identifier shared across platforms |
| `boq_version_id` | UUID | Yes | Version identifier for traceability |
| `boq_reference` | string | Yes | Human-readable BOQ reference |
| `line_items` | array | Yes | Array of BOQ line items |
| `line_items[].item_code` | string | Yes | Standard item code (works section based) |
| `line_items[].trade_category` | string | No | Suggested trade category for packaging |

### 2.4 Validation Rules

| Rule | Logic | Failure |
|------|-------|---------|
| Duplicate ingestion | Validate against `boq_reference` + `boq_version_id` | Return 409 Conflict |
| Item consistency | All line items have item_code, description, quantity, unit | Return 422 with item index |
| Project exists | Project ID must reference known project | Return 404 |
| Version integrity | BOQ version must be latest or explicitly marked | Return 409 or warning |

## 3. BUILDER-MEAS-010: Trade Packaging

### 3.1 Purpose

Group BOQ line items into trade-specific tender packages. Each package represents a scope of work suitable for a single subcontractor or supplier engagement. The system uses trade category heuristics with manual override capability.

### 3.2 Packaging Rules

```yaml
trade_packages:
  structural:
    includes: [structural, concrete, steel, foundation]
    target_rfq_type: subcontract
  electrical:
    includes: [electrical, lighting, cabling, switchgear]
    target_rfq_type: subcontract
  mechanical:
    includes: [mechanical, hvac, plumbing, fire]
    target_rfq_type: subcontract
  materials:
    includes: [supply_only, material, equipment]
    target_rfq_type: purchase_order
  services:
    includes: [testing, inspection, consultancy]
    target_rfq_type: service_order
```

### 3.3 Integration Endpoint

```http
POST /api/v1/tendering/boq/{boq_id}/package
Content-Type: application/json
Authorization: Bearer {internal_service_token}

{
  "packaging_strategy": "auto",  // "auto" | "manual"
  "line_item_ids": ["uuid-1", "uuid-2"],
  "manual_packages": [
    {
      "name": "Electrical Works - Main Building",
      "trade_category": "electrical",
      "line_item_ids": ["uuid-3", "uuid-4", "uuid-5"]
    }
  ]
}
```

### 3.4 Response

```json
{
  "packages": [
    {
      "package_id": "uuid",
      "name": "Structural Works",
      "trade_category": "structural",
      "total_value": 1250000.00,
      "line_items": 12,
      "target_rfq_type": "subcontract",
      "auto_generated": true
    }
  ],
  "unassigned_items": ["uuid-17", "uuid-18"],
  "validation_warnings": ["Item uuid-17 has ambiguous trade category"]
}
```

## 4. BUILDER-MEAS-011: RFQ Generation

### 4.1 Purpose

Automatically generate a tender RFQ from a trade package. The system creates a draft RFQ in the Tendering platform with scope, estimated value, and linked line items, ready for procurement officer review and publication.

### 4.2 Data Flow

```
Measurement Platform            Tendering Platform
┌──────────────────┐           ┌──────────────────┐
│  Trade Package   │           │  tender_rfqs     │
│  - package_id    │  POST /   │  - rfq_number    │
│  - line_items[]  │───▶ api/  │  - title         │
│  - total_value   │    v1/   │  - description    │
│  - trade_cat     │    tender│  - scope_of_works │
│  - project_ref   │    ing/  │  - estimated_value│
└──────────────────┘    rfqs/ │  - boq_reference  │
                     generate │  - trade_category │
                              │  - status: draft  │
                              └──────────────────┘
```

### 4.3 Integration Endpoint

```http
POST /api/v1/tendering/rfqs/generate
Content-Type: application/json
Authorization: Bearer {internal_service_token}

{
  "package_id": "uuid",
  "source": "builder-meas-011",
  "project_reference": "STEELPOORT-MINE-OFFICES",
  "closing_date": null,
  "procurement_officer_id": "uuid"
}
```

### 4.4 RFQ Template Mapping

| Trade Package Field | RFQ Field | Transformation |
|--------------------|-----------|----------------|
| `package.name` | `title` | Prefixed with "RFQ - " |
| `trade_category` | `trade_category` | Direct mapping |
| `target_rfq_type` | `tender_type` | Maps: subcontract→SUBCON, purchase_order→PO, service_order→SO |
| `line_items` | `scope_of_works` | Concatenated item descriptions + quantities |
| `total_value` | `estimated_value` | Direct mapping (rounded to nearest ZAR) |
| `project_reference` | `project_reference` | Direct mapping |
| N/A | `boq_reference_id` | Set from originating BOQ version |

## 5. BUILDER-MEAS-012: Quotation Collection

### 5.1 Purpose

Track quotation collection against RFQs generated from BOQ packages. This workflow provides visibility into the bid response rate, pricing comparison, and evaluation readiness.

### 5.2 Monitoring Endpoint

```http
GET /api/v1/tendering/rfqs/{rfq_id}/quotation-progress
Authorization: Bearer {internal_service_token}

Response: {
  "rfq_id": "uuid",
  "rfq_number": "RFQ-2026-0042",
  "status": "accepting_bids",
  "invited_vendors": 5,
  "quotations_received": 3,
  "quotations_pending": 2,
  "closing_date": "2026-05-15T11:00:00Z",
  "days_remaining": 7,
  "progress_percentage": 60
}
```

### 5.3 Quotation Received Notification

```http
POST /api/v1/measurement/rfqs/{rfq_id}/quotation-event
Authorization: Bearer {internal_service_token}

{
  "event_type": "quotation_received",
  "rfq_id": "uuid",
  "vendor_id": "uuid",
  "vendor_name": "ABC Electrical (Pty) Ltd",
  "quoted_amount": 425000.00,
  "received_at": "2026-05-10T14:30:00Z"
}
```

### 5.4 Comparison Data Export

```http
GET /api/v1/tendering/rfqs/{rfq_id}/comparison-export
Authorization: Bearer {internal_service_token}

Response: {
  "rfq": { "id": "uuid", "title": "..." },
  "line_items": [
    {
      "item_code": "A.1.1",
      "description": "Reinforced concrete column",
      "quantity": 45,
      "unit": "m3",
      "vendor_quotes": [
        { "vendor": "Vendor A", "rate": 8500, "total": 382500 },
        { "vendor": "Vendor B", "rate": 8200, "total": 369000 }
      ]
    }
  ],
  "totals": {
    "estimated": 1250000,
    "lowest_bid": 1180000,
    "highest_bid": 1350000,
    "average_bid": 1265000
  }
}
```

## 6. BUILDER-MEAS-013: Award Processing

### 6.1 Purpose

When a tender award is made, update the Measurement platform with the awarded values for cost reconciliation and project financial tracking.

### 6.2 Data Flow

```
Tendering Platform                Measurement Platform
┌──────────────────┐            ┌──────────────────┐
│  Tender Award    │            │  BOQ Award Data  │
│  - award_id      │  POST /   │  - boq_line_id   │
│  - rfq_id        │──▶ api/v1/│  - awarded_rate  │
│  - vendor_id     │   measure │  - awarded_total │
│  - award_amount  │   ment/   │  - vendor_name   │
│  - line_items[]  │   boq/    │  - award_date    │
│  with rates      │   award   │  - status        │
└──────────────────┘            └──────────────────┘
```

### 6.3 Integration Endpoint

```http
POST /api/v1/measurement/boq/award
Content-Type: application/json
Authorization: Bearer {internal_service_token}

{
  "award_id": "uuid",
  "boq_reference": "BOQ-PROJ-2026-001",
  "package_id": "uuid",
  "vendor": {
    "id": "uuid",
    "name": "ABC Electrical (Pty) Ltd",
    "registration_number": "2020/123456/07"
  },
  "award_amount": 425000.00,
  "award_date": "2026-05-20",
  "line_items": [
    {
      "item_code": "A.1.1",
      "description": "Reinforced concrete column class 2",
      "quantity": 45.0,
      "unit": "m3",
      "boq_rate": 8500.00,
      "awarded_rate": 8200.00,
      "awarded_total": 369000.00
    }
  ],
  "currency": "ZAR",
  "payment_terms": "30 days from invoice"
}
```

### 6.4 Award Rollback

```http
POST /api/v1/measurement/boq/award/{award_id}/rollback
Content-Type: application/json
Authorization: Bearer {internal_service_token}

{
  "reason": "Vendor declined award",
  "rollback_type": "full",  // "full" | "partial"
  "affected_line_items": ["item-code-1", "item-code-2"]
}
```

## 7. Error Scenarios

### 7.1 Error Handling Matrix

| Scenario | Error Code | HTTP Status | Recovery |
|----------|------------|-------------|----------|
| BOQ version mismatch | `BOQ_VERSION_CONFLICT` | 409 | Retry with correct version |
| Package already has RFQ | `PACKAGE_ALREADY_RFQED` | 409 | Navigate to existing RFQ |
| Line items already awarded | `ITEMS_ALREADY_AWARDED` | 409 | Rollback first or exclude items |
| Invalid trade category | `INVALID_TRADE_CATEGORY` | 422 | Correct category mapping |
| Missing project reference | `MISSING_PROJECT_REF` | 422 | Provide project reference |
| Award amount exceeds estimate | `AWARD_EXCEEDS_ESTIMATE` | 422 | Requires override approval |
| Vendor not prequalified | `VENDOR_NOT_PREQUALIFIED` | 422 | Complete prequalification first |
| Network timeout | `INTERNAL_TIMEOUT` | 504 | Automatic retry with backoff |

### 7.2 State Machine Consistency

```
BOQ Line Item States:
  ingested → packaged → rfq_generated → quoted → awarded → closed
                                    ↓
                              cancelled
```

- Each state transition must be validated
- Once an item is in `awarded` state, it cannot be repackaged
- Only the Measurement platform can return an item to `ingested` from `packaged` or `quoted` (via rollback)

### 7.3 Cross-Platform Reconciliation

```sql
-- Daily reconciliation query
SELECT
  m.boq_version_id,
  m.total_line_items,
  t.packaged_items,
  t.rfq_generated_items,
  t.awarded_items
FROM measurement.boq_versions m
LEFT JOIN tendering.boq_reconciliation t ON m.boq_version_id = t.boq_version_id
WHERE m.updated_at > NOW() - INTERVAL '24 hours';
```

- Discrepancies > 1% trigger automatic alert
- Manual reconciliation available in admin dashboard

---

**Version**: 1.0
**Last Updated**: 2026-04-29
**Related Documents**: `BIDDING-GOVT-INTEGRATION.md`, `TENDERING-VENDOR-INTEGRATION.md`, `DATABASE-SPEC.md`

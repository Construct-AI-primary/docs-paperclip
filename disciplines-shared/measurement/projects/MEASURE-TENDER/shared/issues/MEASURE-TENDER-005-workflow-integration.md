---
title: "MEASURE-TENDER-005: BUILDER-MEAS Workflow Integration"
description: "Integrate Subcontract Tender System with BUILDER-MEAS-009 to 013 workflows for seamless BOQ to subcontract award"
gigabrain_tags: issue, measurement, tender, workflow-integration, builder-meas, boq-disaggregation, trade-packages
labels: ["measurement", "tender", "integration", "workflow"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001", "MEASURE-TENDER-002", "MEASURE-TENDER-003", "MEASURE-TENDER-004"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/issues
last_updated: 2026-04-25
status: backlog
priority: Critical
story_points: 21
due_date: "2026-05-20"
assigned_to: measureforge-ai
company: measureforge-ai
team: engineering
---

# MEASURE-TENDER-005: BUILDER-MEAS Workflow Integration

## Overview

Integrate the Subcontract Tender System (MEASURE-TENDER) with the existing BUILDER-MEAS workflows (009-013) to create a seamless pipeline from BOQ extraction through subcontract award. This is the **critical glue** that connects measurement → disaggregation → trade packages → RFQ → quotation → award.

## Workflow Integration Points

### Integration Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         COMPLETE INTEGRATION FLOW                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  BUILDER-MEAS-009          BUILDER-MEAS-010         BUILDER-MEAS-011        │
│  ┌─────────────────┐        ┌─────────────────┐      ┌─────────────────┐     │
│  │ BOQ Extraction │ ────▶ │ Trade Package   │ ───▶ │ RFQ Generation  │     │
│  │ & Disaggregation│        │ Formulation     │      │ & Publishing    │     │
│  └────────┬────────┘        └────────┬────────┘      └────────┬────────┘     │
│           │                          │                         │              │
│           │ Generate                 │ Assign                  │ Create       │
│           │ trade_categories[]        │ scope_of_works          │ subcontract_  │
│           │ boq_reference_id         │ specifications           │ rfqs records │
│           ▼                          ▼                         ▼              │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │                    MEASURE-TENDER DATABASE                             │   │
│  │  subcontract_rfqs (INSERT with boq_reference_id, trade_category)    │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
│                                      │                                       │
│                                      ▼                                       │
│  BUILDER-MEAS-012              BUILDER-MEAS-013                             │
│  ┌─────────────────┐        ┌─────────────────┐                           │
│  │ Quotation      │ ────▶ │ Subcontract     │                           │
│  │ Collection     │        │ Award           │                           │
│  └────────┬────────┘        └────────┬────────┘                           │
│           │                          │                                      │
│           │ Collect                  │ Set best_bid_id                      │
│           │ quotations               │ Generate agreement                    │
│           │ quotation_               │ Update status                        │
│           │ comparisons               │ subcontract_rfqs                     │
│           ▼                          ▼                                      │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │                    MEASURE-TENDER DATABASE                             │   │
│  │  quotation_comparisons (INSERT/UPDATE)                                │   │
│  │  subcontract_rfqs (UPDATE status='awarded', best_bid_id)             │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Detailed Integration Specs

#### BUILDER-MEAS-009 → MEASURE-TENDER

**Trigger**: BOQ disaggregation complete
**Action**: Create `subcontract_rfqs` records with `boq_reference_id`

```javascript
// In BUILDER-MEAS-009 workflow
async function onBOQDisaggregationComplete(boqData) {
  const tradeSchedules = await disaggregateBOQ(boqData);
  
  for (const schedule of tradeSchedules) {
    // Create RFQ in MEASURE-TENDER
    const rfq = await SubcontractRFQService.createRFQ({
      title: `${schedule.trade_category} - ${boqData.project_name}`,
      description: `Subcontract package for ${schedule.trade_category}`,
      trade_category: schedule.trade_category,
      scope_of_works: schedule.scope,
      specifications: schedule.specifications,
      estimated_value: schedule.total_value,
      boq_reference_id: boqData.id,  // CRITICAL LINK
      organization_id: boqData.organization_id,
      project_reference: boqData.project_reference
    });
    
    // Store rfq_id back in BOQ data for tracking
    await updateBOQWithRFQIds(boqData.id, rfq.id);
  }
}
```

#### BUILDER-MEAS-010 → MEASURE-TENDER

**Trigger**: Trade package formulation complete
**Action**: Update `subcontract_rfqs` with full scope details

```javascript
// In BUILDER-MEAS-010 workflow
async function onTradePackageComplete(tradePackage, rfqId) {
  await SubcontractRFQService.updateRFQ(rfqId, {
    scope_of_works: tradePackage.scope_of_works,
    specifications: tradePackage.specifications,
    cidb_grading_required: tradePackage.cidb_required,
    drawings_references: tradePackage.drawings
  });
}
```

#### BUILDER-MEAS-011 → MEASURE-TENDER

**Trigger**: Subcontract tender document generated
**Action**: Publish RFQ and trigger sub-vendor notifications

```javascript
// In BUILDER-MEAS-011 workflow
async function onTenderDocumentGenerated(rfqId, tenderDocs) {
  // Publish to sub-vendors
  await SubcontractRFQService.publishRFQ(rfqId, {
    documents: tenderDocs,
    notify_prequalified: true,
    closing_date: calculateClosingDate(14)  // 14 days default
  });
  
  // Update workflow status
  await updateWorkflowStatus('RFQ_PUBLISHED', rfqId);
}
```

#### BUILDER-MEAS-012 → MEASURE-TENDER

**Trigger**: Quotation received from subcontractor
**Action**: Insert into `quotation_comparisons`

```javascript
// In BUILDER-MEAS-012 workflow
async function onQuotationReceived(rfqId, quotationData) {
  const quotation = await SubcontractRFQService.submitQuotation(rfqId, {
    subcontractor_id: quotationData.subcontractor_id,
    quoted_amount: quotationData.amount,
    validity_period_days: quotationData.validity,
    programme_commitment: quotationData.programme,
    attachments: quotationData.documents
  });
  
  // Trigger scoring calculation
  await calculateScores(quotation.id);
}
```

#### BUILDER-MEAS-013 → MEASURE-TENDER

**Trigger**: Subcontract awarded
**Action**: Update RFQ status and set `best_bid_id`

```javascript
// In BUILDER-MEAS-013 workflow
async function onSubcontractAwarded(rfqId, bestQuotationId) {
  // Update RFQ with award
  await SubcontractRFQService.awardRFQ(rfqId, {
    best_bid_id: bestQuotationId,
    award_date: new Date(),
    contract_value: bestQuotation.quoted_amount
  });
  
  // Generate subcontract agreement
  const agreement = await generateSubcontractAgreement(rfqId, bestQuotation);
  
  // Trigger onboarding workflow
  await triggerSubcontractorOnboarding(bestQuotation.subcontractor_id, agreement);
}
```

### Data Flow Specifications

#### BOQ Reference Linkage

```javascript
// Schema: subcontract_rfqs.boq_reference_id -> BOQ source
{
  boq_reference_id: UUID,  // Links to MeasureForge BOQ record
  boq_element_count: INT,  // Number of BOQ items in this RFQ
  boq_total_value: DECIMAL, // Original BOQ value for this trade
  variance_tracking: {
    boq_value: DECIMAL,
    rfq_value: DECIMAL,
    variance_pct: DECIMAL
  }
}
```

#### Scoring Algorithm

```javascript
async function calculateScores(quotationId) {
  const quotation = await getQuotation(quotationId);
  const rfq = await getRFQ(quotation.rfq_id);
  
  // Technical Score (40% weight)
  const technicalScore = evaluateTechnicalCompliance(quotation, rfq);
  
  // Commercial Score (40% weight)
  const commercialScore = evaluateCommercialCompetitiveness(quotation.quoted_amount, rfq);
  
  // B-BBEE Score (20% weight)
  const bbbeeScore = calculateBBBEEScore(quotation.subcontractor.bbbee_level);
  
  const overallScore = (technicalScore * 0.4) + (commercialScore * 0.4) + (bbbeeScore * 0.2);
  
  await updateQuotation(quotationId, {
    technical_score: technicalScore,
    commercial_score: commercialScore,
    overall_score: overallScore
  });
  
  return overallScore;
}
```

### Workflow State Machine

```
RFQ State Transitions:
                                                    
  draft ──▶ published ──▶ closed ──▶ awarded
    │          │            │           │
    │          │            │           │
    ▼          ▼            ▼           ▼
 cancelled   notifying    evaluating   active
             subs                      contract
```

## Acceptance Criteria

- [ ] BOQ reference linkage implemented (MEASURE-TENDER ↔ BUILDER-MEAS-009)
- [ ] Trade category mapping working correctly
- [ ] RFQ auto-creation from trade packages
- [ ] Quotation collection feeding into comparison matrix
- [ ] Scoring algorithm calculating overall scores
- [ ] Award workflow updating RFQ status
- [ ] Variance tracking between BOQ value and RFQ value
- [ ] Complete audit trail for compliance
- [ ] Error handling for failed integrations

## Dependencies

- MEASURE-TENDER-001: Database Schema complete
- MEASURE-TENDER-002: Integration Service complete
- MEASURE-TENDER-003: API Routes complete
- MEASURE-TENDER-004: UI Dashboard complete
- BUILDER-MEAS-009 to 013 workflows in MeasureForge AI

## Integration Test Cases

```javascript
const testCases = [
  {
    name: 'BOQ to RFQ creation',
    steps: [
      'Complete BOQ disaggregation',
      'Verify subcontract_rfqs record created',
      'Verify boq_reference_id linked correctly'
    ],
    expected: 'RFQ created with correct trade category'
  },
  {
    name: 'Quotation to award flow',
    steps: [
      'Submit 3 quotations',
      'Verify scoring calculated',
      'Recommend award',
      'Verify RFQ status = awarded',
      'Verify best_bid_id set'
    ],
    expected: 'Complete award workflow successful'
  }
];
```

---

**Issue Type**: Integration/Flow Orchestration
**Estimated Hours**: 16-20 hours
**Agent Assignment**: measureforge-ai (MeasureForge AI)

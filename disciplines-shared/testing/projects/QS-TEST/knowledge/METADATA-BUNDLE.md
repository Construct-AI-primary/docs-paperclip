---
title: 02025 Quantity Surveying — Complete Metadata Bundle
description: Single JSON bundle of all 8-field metadata for 02025 page components, ready for upload to QC-ROOT issue
author: KnowledgeForge AI
date: 2026-04-30
version: 1.0
---

# 02025 Quantity Surveying — Complete Metadata Bundle

## Bundle Summary

| Metric | Value |
|--------|-------|
| Total page components | 16 (3 state buttons + 9 modal triggers + 4 supporting) |
| Template pages scored | 12 (all state buttons & modal triggers) |
| Operational pages scored | 4 (chatbot, workflow orchestrator, templates, cost analysis) |
| Supabase tables referenced | 4 (quantity_surveying_boq, quantity_surveying_measurements, quantity_surveying_costs, vectors) |
| Extraction date | 2026-04-30 |
| Upload target | QC-ROOT-QS-2026 issue Documents |

## Full Bundle Structure

```json
{
  "project": "QS-TEST",
  "discipline": "02025-quantity-surveying",
  "extraction_date": "2026-04-30",
  "total_components": 16,
  "template_pages": [
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "state-button-agents",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/02025/",
      "ui_buttons": {"id": "agents-button", "class": "state-button", "action": "setState('agents')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Agents'"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "state-button-upserts",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/02025/",
      "ui_buttons": {"id": "upserts-button", "class": "state-button", "action": "setState('upserts')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Upserts'"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "state-button-workspace",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/02025/",
      "ui_buttons": {"id": "workspace-button", "class": "state-button", "action": "setState('workspace')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Workspace'"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "modal-boq-creation",
      "template_score": 0.88,
      "supabase_schema": {"table": "quantity_surveying_boq", "columns": ["id","item_code","description","unit","quantity","rate","amount"], "indexes": ["primary_key","item_code_idx"]},
      "qc_checklist": ["Button renders in Agents state", "Modal opens: 02025-BOQCreationModal", "BOQ form fields match schema", "BOQ item persists", "Multi-step flow works"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "modal-measurement-validation",
      "template_score": 0.88,
      "supabase_schema": {"table": "quantity_surveying_measurements", "columns": ["id","boq_id","dimension","formula","calculated_qty"], "indexes": ["primary_key","boq_id_idx"]},
      "qc_checklist": ["Button renders in Agents state", "Modal opens: 02025-MeasurementValidationModal", "Measurement form fields match schema", "Dimension calculations validate", "Submission persists"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "modal-cloud-upsert",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 02025-UpsertCloudModal", "Insert succeeds", "Error handling works"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "modal-upsert-url",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 02025-UpsertUrlModal", "URL fetch succeeds", "Data insert succeeds"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "modal-upsert-files",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 02025-UpsertFileModal", "File upload/parse succeeds", "Data insert succeeds"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "modal-cost-analysis",
      "template_score": 0.85,
      "supabase_schema": {"table": "quantity_surveying_costs", "columns": ["id","boq_id","resource","unit_rate","total_cost"], "indexes": ["primary_key"]},
      "qc_checklist": ["Button renders in Workspace state", "02025-CostAnalysisModal opens", "Rate build-up validates", "Cost breakdown renders", "Resource costing persists"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "modal-project-comparison",
      "template_score": 0.82,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "02025-ProjectComparisonModal opens", "Project comparison data loads", "Charts render"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "modal-cross-discipline-sharing",
      "template_score": 0.82,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "DisciplinePermissionMatrixModal opens", "Matrix displays correctly"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "discipline": "02025",
      "component": "modal-vector-data-manager",
      "template_score": 0.82,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Workspace state", "VectorDataManagerModal opens", "Vector insert succeeds", "hnsw query returns results"],
      "last_updated": "2026-04-30"
    }
  ],
  "operational_pages": [
    {
      "page_id": "02025-quantity-surveying",
      "page_type": "chatbot",
      "discipline": "02025",
      "primary_metric": "HITL confidence threshold",
      "critical_buttons": [{"id": "chatbot-toggle", "action": "open_chatbot"}],
      "business_rules": ["Confidence threshold >= 0.7 triggers HITL", "Citations enabled", "Document count enabled", "History persists per session"],
      "last_tested": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "page_type": "workflow-orchestrator",
      "discipline": "02025",
      "primary_metric": "End-to-end BOQ completion",
      "business_rules": ["BOQ approval chain must complete", "Measurement workflow validates dimensions", "Cost estimation generates valid outputs"],
      "last_tested": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "page_type": "templates",
      "discipline": "02025",
      "primary_metric": "Template population accuracy",
      "critical_buttons": [{"id": "generate-template", "action": "populate_template"}],
      "business_rules": ["BOQ template populates correctly", "Cost estimation template validates", "Compliance rules applied"],
      "last_tested": "2026-04-30"
    },
    {
      "page_id": "02025-quantity-surveying",
      "page_type": "cost-analysis",
      "discipline": "02025",
      "primary_metric": "Rate build-up accuracy",
      "critical_buttons": [{"id": "cost-analysis", "action": "open_cost_analysis"}, {"id": "project-comparison", "action": "compare_projects"}],
      "business_rules": ["Rate build-up form validates resources", "Cost breakdown structure renders correctly", "Resource costing persists", "Project comparison loads historical data"],
      "last_tested": "2026-04-30"
    }
  ],
  "summary": {
    "total_components": 16,
    "template_pages": 12,
    "operational_pages": 4,
    "phases": 5,
    "issues": 15,
    "companies_involved": 4,
    "agents_assigned": 6,
    "supabase_tables": 4,
    "extraction_date": "2026-04-30",
    "ready_for_qc": true
  }
}
```

## Upload Instructions

To make this knowledge available to all sub-agents:

1. Upload this bundle to the **QC-ROOT-QS-2026** issue's Documents tab
2. Document key: `"full-page-metadata"`
3. All sub-agents inherit automatically via `parentId`
4. Agents query: `Documents.full-page-metadata.template_pages` or `.operational_pages`

---

**Version**: 1.0
**Last Updated**: 2026-04-30
**Author**: KnowledgeForge AI

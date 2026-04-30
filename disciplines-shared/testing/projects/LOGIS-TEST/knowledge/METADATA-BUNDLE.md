---
title: 01700 Logistics — Complete Metadata Bundle
description: Single JSON bundle of all 8-field metadata for 01700 page components, ready for upload to QC-ROOT issue
author: KnowledgeForge AI
date: 2026-04-30
version: 1.0
---

# 01700 Logistics — Complete Metadata Bundle

## Bundle Summary

| Metric | Value |
|--------|-------|
| Total page components | 17 (3 state buttons + 10 modal triggers + 4 supporting) |
| Template pages scored | 13 (all state buttons & modal triggers) |
| Operational pages scored | 4 (chatbot, workflow orchestrator, templates, fleet tracking, customs compliance, integrations, agent delegation) |
| Supabase tables referenced | 5 (logistics_freight, logistics_customs, logistics_fleet, suppliers, vectors) |
| Extraction date | 2026-04-30 |
| Upload target | QC-ROOT-LOGIS-2026 issue Documents |

## Full Bundle Structure

```json
{
  "project": "LOGIS-TEST",
  "discipline": "01700-logistics",
  "extraction_date": "2026-04-30",
  "total_components": 17,
  "template_pages": [
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "state-button-agents",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/01700/",
      "ui_buttons": {"id": "agents-button", "class": "state-button", "action": "setState('agents')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Agents'"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "state-button-upserts",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/01700/",
      "ui_buttons": {"id": "upserts-button", "class": "state-button", "action": "setState('upserts')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Upserts'"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "state-button-workspace",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/01700/",
      "ui_buttons": {"id": "workspace-button", "class": "state-button", "action": "setState('workspace')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Workspace'"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-freight-booking",
      "template_score": 0.88,
      "supabase_schema": {"table": "logistics_freight", "columns": ["id","shipment_id","origin","destination","carrier","mode","weight_kg","status","created_at","updated_at"], "indexes": ["primary_key","shipment_id_idx"]},
      "qc_checklist": ["Button renders in Agents state", "Modal opens: 01700-FreightBookingModal", "Shipment form matches schema", "Booking persists", "Modal closes"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-customs-clearance",
      "template_score": 0.88,
      "supabase_schema": {"table": "logistics_customs", "columns": ["id","declaration_id","shipment_id","clearance_status","duty_amount","documents","customs_officer","cleared_at"], "indexes": ["primary_key","declaration_id_idx"]},
      "qc_checklist": ["Button renders in Agents state", "Modal opens: 01700-CustomsClearanceModal", "Declaration form matches schema", "Clearance persists", "Doc upload works"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-cloud-upsert",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 01700-UpsertCloudModal", "Insert succeeds", "Error handling works"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-upsert-url",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 01700-UpsertUrlModal", "URL fetch succeeds", "Data insert succeeds"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-upsert-files",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 01700-UpsertFileModal", "File upload/parse succeeds", "Data insert succeeds"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-fleet-management",
      "template_score": 0.88,
      "supabase_schema": {"table": "logistics_fleet", "columns": ["id","vehicle_id","driver","route","status","last_gps_lat","last_gps_lng","fuel_level","maintenance_due","created_at"], "indexes": ["primary_key","vehicle_id_idx"]},
      "qc_checklist": ["Button renders in Workspace state", "01700-FleetManagementModal opens", "Fleet CRUD persists", "Vehicle status updates", "GPS coords render"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-warehouse-management",
      "template_score": 0.85,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "01700-WarehouseManagementModal opens", "Inventory displays", "Stock updates persist"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-supplier-directory",
      "template_score": 0.88,
      "supabase_schema": {"table": "suppliers", "columns": ["id","name","type","contact","status","rating"], "indexes": ["primary_key","name_idx"]},
      "qc_checklist": ["Button renders in Workspace state", "01700-SupplierDirectoryModal opens", "Supplier CRUD persists", "Card JSONs render"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-cross-discipline-sharing",
      "template_score": 0.82,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "DisciplinePermissionMatrixModal opens", "Matrix displays"],
      "last_updated": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "discipline": "01700",
      "component": "modal-vector-data-manager",
      "template_score": 0.82,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Workspace state", "VectorDataManagerModal opens", "Vector insert succeeds", "hnsw query returns"],
      "last_updated": "2026-04-30"
    }
  ],
  "operational_pages": [
    {
      "page_id": "01700-logistics",
      "page_type": "chatbot",
      "discipline": "01700",
      "primary_metric": "HITL confidence threshold",
      "critical_buttons": [{"id": "chatbot-toggle", "action": "open_chatbot"}],
      "business_rules": ["Confidence threshold >= 0.7 triggers HITL", "Citations enabled", "Document count enabled", "History persists per session"],
      "last_tested": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "page_type": "workflow-orchestrator",
      "discipline": "01700",
      "primary_metric": "End-to-end freight booking completion",
      "business_rules": ["Freight booking workflow completes", "Customs clearance chain valid", "Fleet dispatch triggers correctly"],
      "last_tested": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "page_type": "templates",
      "discipline": "01700",
      "primary_metric": "Template population accuracy",
      "critical_buttons": [{"id": "generate-template", "action": "populate_template"}],
      "business_rules": ["Bill of Lading populates correctly", "Customs Declaration validates", "Shipping Manifest renders", "Compliance rules applied"],
      "last_tested": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "page_type": "fleet-tracking",
      "discipline": "01700",
      "primary_metric": "Real-time position accuracy",
      "business_rules": ["Fleet dashboard displays vehicle positions", "Route optimization computes valid routes", "Vehicle status transitions correct"],
      "last_tested": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "page_type": "customs-compliance",
      "discipline": "01700",
      "primary_metric": "Regulatory check pass rate",
      "business_rules": ["Customs declaration validates against regulations", "Document upload accepts required formats", "Compliance score calculated correctly"],
      "last_tested": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "page_type": "integrations",
      "discipline": "01700",
      "primary_metric": "Vector query response time",
      "business_rules": ["Vector insert → hnsw query returns correct results", "Cross-discipline sharing permissions enforced", "Document retrieval returns docs by discipline filter"],
      "last_tested": "2026-04-30"
    },
    {
      "page_id": "01700-logistics",
      "page_type": "agent-delegation",
      "discipline": "01700",
      "primary_metric": "Delegation success rate",
      "business_rules": ["CEO creates root goal", "Heartbeat assigns sub-tasks via assigneeAgentId + parentId", "Status propagates up the hierarchy", "Approval requests route correctly"],
      "last_tested": "2026-04-30"
    }
  ],
  "summary": {
    "total_components": 17,
    "template_pages": 13,
    "operational_pages": 7,
    "phases": 5,
    "issues": 15,
    "companies_involved": 4,
    "agents_assigned": 7,
    "supabase_tables": 5,
    "extraction_date": "2026-04-30",
    "ready_for_qc": true
  }
}
```

## Upload Instructions

To make this knowledge available to all sub-agents:

1. Upload this bundle to the **QC-ROOT-LOGIS-2026** issue's Documents tab
2. Document key: `"full-page-metadata"`
3. All sub-agents inherit automatically via `parentId`
4. Agents query: `Documents.full-page-metadata.template_pages` or `.operational_pages`

---

**Version**: 1.0
**Last Updated**: 2026-04-30
**Author**: KnowledgeForge AI

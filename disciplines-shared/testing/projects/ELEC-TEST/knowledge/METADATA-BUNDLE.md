---
title: 00860 Electrical Engineering — Complete Metadata Bundle
description: Single JSON bundle of all 8-field metadata for 00860 page components, ready for upload to QC-ROOT issue
author: KnowledgeForge AI
date: 2026-04-28
version: 1.0
---

# 00860 Electrical Engineering — Complete Metadata Bundle

## Bundle Summary

| Metric | Value |
|--------|-------|
| Total page components | 21 (3 state buttons + 12 modal triggers + 6 supporting) |
| Template pages scored | 15 (all state buttons & modal triggers) |
| Operational pages scored | 6 (chatbot, workflow orchestrator, templates, load flow, protection coordination, agent delegation) |
| Supabase tables referenced | 4 (electrical_calculations, cable_schedules, protection_studies, vectors) |
| Extraction date | 2026-04-28 |
| Upload target | QC-ROOT-ELECTRICAL-2026 issue Documents |

## Full Bundle Structure

```json
{
  "project": "ELEC-TEST",
  "discipline": "00860-electrical-engineering",
  "extraction_date": "2026-04-28",
  "total_components": 21,
  "template_pages": [
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "state-button-agents",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/00860/",
      "ui_buttons": {"id": "agents-button", "class": "state-button", "action": "setState('agents')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Agents'"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "state-button-upserts",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/00860/",
      "ui_buttons": {"id": "upserts-button", "class": "state-button", "action": "setState('upserts')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Upserts'"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "state-button-workspace",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/00860/",
      "ui_buttons": {"id": "workspace-button", "class": "state-button", "action": "setState('workspace')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Workspace'"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-load-calculation",
      "template_score": 0.88,
      "supabase_schema": {"table": "electrical_calculations", "columns": ["id","project_id","load_type","voltage","current","power_factor","calculated_load","created_at","updated_at"], "indexes": ["primary_key"]},
      "qc_checklist": ["Button renders in Agents state", "Modal opens: 00860-LoadCalculationModal", "Form fields match schema", "Calculation persists", "Modal closes"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-cable-sizing",
      "template_score": 0.88,
      "supabase_schema": {"table": "cable_schedules", "columns": ["id","cable_id","from_location","to_location","cable_type","size_mm2","current_rating","voltage_drop","length_m","created_at"], "indexes": ["primary_key","cable_id_idx"]},
      "qc_checklist": ["Button renders in Agents state", "Modal opens: 00860-CableSizingModal", "Form fields match schema", "Calculation returns valid results", "Persists"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-protection-coordination",
      "template_score": 0.88,
      "supabase_schema": {"table": "protection_studies", "columns": ["id","study_id","device_type","fault_current","clearing_time","coordination_interval","status","created_at"], "indexes": ["primary_key","study_id_idx"]},
      "qc_checklist": ["Button renders in Agents state", "Modal opens: 00860-ProtectionCoordinationModal", "Form fields match schema", "Analysis returns valid results", "Persists"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-cloud-upsert",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 00860-UpsertCloudModal", "Insert succeeds", "Error handling works"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-upsert-url",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 00860-UpsertUrlModal", "URL fetch succeeds", "Data insert succeeds"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-upsert-files",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 00860-UpsertFileModal", "File upload/parse succeeds", "Data insert succeeds"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-sld-viewer",
      "template_score": 0.85,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "SLDViewerModal opens", "Diagram renders", "Zoom/pan controls work"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-cable-schedule",
      "template_score": 0.85,
      "supabase_schema": {"table": "cable_schedules", "columns": ["id","cable_id","from_location","to_location","cable_type","size_mm2","current_rating","voltage_drop","length_m","created_at"], "indexes": ["primary_key","cable_id_idx"]},
      "qc_checklist": ["Button renders in Workspace state", "00860-CableScheduleModal opens", "Data loads correctly", "Filter/search works"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-protection-studies",
      "template_score": 0.85,
      "supabase_schema": {"table": "protection_studies", "columns": ["id","study_id","device_type","fault_current","clearing_time","coordination_interval","status","created_at"], "indexes": ["primary_key","study_id_idx"]},
      "qc_checklist": ["Button renders in Workspace state", "00860-ProtectionStudiesModal opens", "Data loads correctly", "Results display properly"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-cross-discipline-sharing",
      "template_score": 0.82,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "DisciplinePermissionMatrixModal opens", "Matrix displays correctly"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-manage-workspaces",
      "template_score": 0.82,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "WorkspaceManagementModal opens", "CRUD works"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "discipline": "00860",
      "component": "modal-vector-data-manager",
      "template_score": 0.82,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Workspace state", "VectorDataManagerModal opens", "Vector insert succeeds", "hnsw query returns results"],
      "last_updated": "2026-04-28"
    }
  ],
  "operational_pages": [
    {
      "page_id": "00860-electrical-engineering",
      "page_type": "chatbot",
      "discipline": "00860",
      "primary_metric": "HITL confidence threshold",
      "critical_buttons": [{"id": "chatbot-toggle", "action": "open_chatbot"}],
      "business_rules": ["Confidence threshold >= 0.7 triggers HITL", "Citations enabled", "Document count enabled", "History persists per session", "Gold theme (#DAA520/#B8860B)"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "page_type": "workflow-orchestrator",
      "discipline": "00860",
      "primary_metric": "End-to-end electrical calculation completion",
      "business_rules": ["Load flow analysis must complete", "Cable sizing workflow valid", "Protection coordination workflow generates report"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "page_type": "templates",
      "discipline": "00860",
      "primary_metric": "Template population accuracy",
      "critical_buttons": [{"id": "generate-template", "action": "populate_template"}],
      "business_rules": ["SLD template populates correctly", "Cable schedule template validates", "Protection study template renders", "Template export works"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "page_type": "load-flow-analysis",
      "discipline": "00860",
      "primary_metric": "Load flow calculation accuracy",
      "critical_buttons": [{"id": "run-load-flow", "action": "execute_load_flow"}, {"id": "export-results", "action": "export_load_flow"}],
      "business_rules": ["Load flow calculation converges", "Voltage profile results valid", "Power factor correction suggested", "Export generates report"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "page_type": "protection-coordination",
      "discipline": "00860",
      "primary_metric": "Coordination study accuracy",
      "critical_buttons": [{"id": "run-study", "action": "execute_protection_study"}],
      "business_rules": ["Fault current calculation correct", "TCC curves render correctly", "Coordination intervals valid", "Device settings documented"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "00860-electrical-engineering",
      "page_type": "agent-delegation",
      "discipline": "00860",
      "primary_metric": "Delegation success rate",
      "business_rules": ["CEO creates root goal", "Heartbeat assigns sub-tasks via assigneeAgentId + parentId", "Status propagates up the hierarchy", "Approval requests route correctly"],
      "last_tested": "2026-04-28"
    }
  ],
  "summary": {
    "total_components": 21,
    "template_pages": 15,
    "operational_pages": 6,
    "phases": 5,
    "issues": 16,
    "companies_involved": 4,
    "agents_assigned": 7,
    "supabase_tables": 4,
    "extraction_date": "2026-04-28",
    "ready_for_qc": true
  }
}
```

## Upload Instructions

To make this knowledge available to all sub-agents:

1. Upload this bundle to the **QC-ROOT-ELECTRICAL-2026** issue's Documents tab
2. Document key: `"full-page-metadata"`
3. All sub-agents inherit automatically via `parentId`
4. Agents query: `Documents.full-page-metadata.template_pages` or `.operational_pages`

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: KnowledgeForge AI

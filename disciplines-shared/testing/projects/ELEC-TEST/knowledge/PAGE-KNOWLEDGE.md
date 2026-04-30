---
title: 00860 Electrical Engineering Page — Component Knowledge
description: Complete page architecture, component inventory, and 8-field metadata for the 00860 electrical engineering discipline page
author: QualityForge AI / KnowledgeForge AI
date: 2026-04-28
version: 1.0
memory_layer: working_knowledge
para_section: testing/projects/ELEC-TEST/knowledge
---

# 00860 Electrical Engineering Page — Component Knowledge

## Page Overview

- **Page ID**: `00860-electrical-engineering`
- **Discipline Code**: `00860`
- **File Path**: `client/src/pages/00860-electrical-engineering/components/00860-electrical-engineering-page.js`
- **Background Image**: `getThemedImagePath("00860.png")` — EPCM-standard cover or gradient fallback
- **Chatbot**: `ElectricalEngineeringChatbot` — gold theme (#DAA520/#B8860B), HITL confidence=0.7
- **Nav Container**: `A-00860-navigation-container` — fixed bottom center
- **Button Container**: `A-00860-button-container` — fixed viewport center, CSS Grid
- **Logout**: Fixed bottom-left, `window.handleLogout()`

## 8-Field Metadata — All Components

### State Navigation Buttons

```json
[
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "state-button-agents",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "agents-button",
      "class": "state-button",
      "action": "setState('agents')",
      "target_state": "agents"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders with class 'state-button'",
      "Button label matches 'Agents'",
      "Click handler sets currentState to 'agents'",
      "Button container visibility toggles on click"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "state-button-upserts",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "upserts-button",
      "class": "state-button",
      "action": "setState('upserts')",
      "target_state": "upserts"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders with class 'state-button'",
      "Button label matches 'Upserts'",
      "Click handler sets currentState to 'upserts'"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "state-button-workspace",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "workspace-button",
      "class": "state-button",
      "action": "setState('workspace')",
      "target_state": "workspace"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders with class 'state-button'",
      "Button label matches 'Workspace'",
      "Click handler sets currentState to 'workspace'"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Agents State Modals (3 buttons)

```json
[
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-load-calculation",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "load-calculation-button",
      "class": "modal-trigger-button",
      "action": "openModal('00860-LoadCalculationModal')",
      "target": "00860-LoadCalculationModal"
    },
    "supabase_schema": {
      "table": "electrical_calculations",
      "columns": ["id", "project_id", "load_type", "voltage", "current", "power_factor", "calculated_load", "created_at", "updated_at"],
      "indexes": ["primary_key"]
    },
    "qc_checklist": [
      "Button renders in Agents state",
      "Modal opens: 00860-LoadCalculationModal",
      "Load calculation form fields match electrical_calculations schema",
      "Calculation submission persists to database",
      "Modal closes properly"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-cable-sizing",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "cable-sizing-button",
      "class": "modal-trigger-button",
      "action": "openModal('00860-CableSizingModal')",
      "target": "00860-CableSizingModal"
    },
    "supabase_schema": {
      "table": "cable_schedules",
      "columns": ["id", "cable_id", "from_location", "to_location", "cable_type", "size_mm2", "current_rating", "voltage_drop", "length_m", "created_at"],
      "indexes": ["primary_key", "cable_id_idx"]
    },
    "qc_checklist": [
      "Button renders in Agents state",
      "Modal opens: 00860-CableSizingModal",
      "Cable sizing form fields match cable_schedules schema",
      "Cable sizing calculation returns valid results",
      "Submission persists to database"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-protection-coordination",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "protection-coordination-button",
      "class": "modal-trigger-button",
      "action": "openModal('00860-ProtectionCoordinationModal')",
      "target": "00860-ProtectionCoordinationModal"
    },
    "supabase_schema": {
      "table": "protection_studies",
      "columns": ["id", "study_id", "device_type", "fault_current", "clearing_time", "coordination_interval", "status", "created_at"],
      "indexes": ["primary_key", "study_id_idx"]
    },
    "qc_checklist": [
      "Button renders in Agents state",
      "Modal opens: 00860-ProtectionCoordinationModal",
      "Protection study form fields match protection_studies schema",
      "Coordination analysis returns valid results",
      "Submission persists to database"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Upserts State Modals (3 buttons)

```json
[
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-cloud-upsert",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "cloud-upsert-button",
      "class": "modal-trigger-button",
      "action": "openModal('00860-UpsertCloudModal')",
      "target": "00860-UpsertCloudModal"
    },
    "supabase_schema": {
      "table": "vectors",
      "columns": ["id", "embedding", "metadata", "discipline"],
      "indexes": ["primary_key", "hnsw"]
    },
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 00860-UpsertCloudModal",
      "Data insertion to supabase_vectors succeeds",
      "Error handling for malformed data"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-upsert-from-url",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "upsert-url-button",
      "class": "modal-trigger-button",
      "action": "openModal('00860-UpsertUrlModal')",
      "target": "00860-UpsertUrlModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 00860-UpsertUrlModal",
      "URL fetch operation succeeds",
      "Data insertion succeeds after fetch"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-upsert-files",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "upsert-files-button",
      "class": "modal-trigger-button",
      "action": "openModal('00860-UpsertFileModal')",
      "target": "00860-UpsertFileModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 00860-UpsertFileModal",
      "File upload and parse succeeds",
      "Parsed data inserted to database"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Workspace State Modals (6 buttons)

```json
[
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-sld-viewer",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "sld-viewer-button",
      "class": "modal-trigger-button",
      "action": "openModal('00860-SLDViewerModal')",
      "target": "00860-SLDViewerModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Workspace state",
      "SLDViewerModal opens",
      "Single line diagram renders correctly",
      "Zoom/pan controls work"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-cable-schedule",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "cable-schedule-button",
      "class": "modal-trigger-button",
      "action": "openModal('00860-CableScheduleModal')",
      "target": "00860-CableScheduleModal"
    },
    "supabase_schema": {
      "table": "cable_schedules",
      "columns": ["id", "cable_id", "from_location", "to_location", "cable_type", "size_mm2", "current_rating", "voltage_drop", "length_m", "created_at"],
      "indexes": ["primary_key", "cable_id_idx"]
    },
    "qc_checklist": [
      "Button renders in Workspace state",
      "00860-CableScheduleModal opens",
      "Cable schedule data loads correctly",
      "Filter and search functions work"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-protection-studies",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "protection-studies-button",
      "class": "modal-trigger-button",
      "action": "openModal('00860-ProtectionStudiesModal')",
      "target": "00860-ProtectionStudiesModal"
    },
    "supabase_schema": {
      "table": "protection_studies",
      "columns": ["id", "study_id", "device_type", "fault_current", "clearing_time", "coordination_interval", "status", "created_at"],
      "indexes": ["primary_key", "study_id_idx"]
    },
    "qc_checklist": [
      "Button renders in Workspace state",
      "00860-ProtectionStudiesModal opens",
      "Protection study data loads correctly",
      "Study results display properly"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-cross-discipline-sharing",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "cross-discipline-sharing-button",
      "class": "modal-trigger-button",
      "action": "openModal('DisciplinePermissionMatrixModal')",
      "target": "DisciplinePermissionMatrixModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Workspace state",
      "DisciplinePermissionMatrixModal opens",
      "Permission matrix displays correctly"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-manage-workspaces",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "manage-workspaces-button",
      "class": "modal-trigger-button",
      "action": "openModal('WorkspaceManagementModal')",
      "target": "WorkspaceManagementModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Workspace state",
      "WorkspaceManagementModal opens",
      "Workspace CRUD operations work"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "00860-electrical-engineering",
    "discipline": "00860",
    "component": "modal-vector-data-manager",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/00860/",
    "ui_buttons": {
      "id": "vector-data-manager-button",
      "class": "modal-trigger-button",
      "action": "openModal('VectorDataManagerModal')",
      "target": "VectorDataManagerModal"
    },
    "supabase_schema": {
      "table": "vectors",
      "columns": ["id", "embedding", "metadata", "discipline"],
      "indexes": ["primary_key", "hnsw"]
    },
    "qc_checklist": [
      "Button renders in Workspace state",
      "VectorDataManagerModal opens",
      "Vector insert succeeds",
      "hnsw query returns results"
    ],
    "last_updated": "2026-04-28"
  }
]
```

## Page-Level QC Checklist

- [ ] 3 state buttons render (Agents, Upserts, Workspace)
- [ ] 12 modal trigger buttons render across all states
- [ ] Buttons sorted alphabetically via `sortButtonsAlphabetically()`
- [ ] Grid layout calculated via `calculateGridLayout()`
- [ ] Background image loads: `00860.png` or gradient fallback
- [ ] Navigation container: fixed bottom center
- [ ] Button container: fixed viewport center, CSS Grid
- [ ] Animation: fade-in effect with `isButtonContainerVisible`
- [ ] Logout: fixed bottom-left, `window.handleLogout()` works
- [ ] Chatbot: gold theme (#DAA520/#B8860B), HITL confidence=0.7
- [ ] CSS classes: `electrical-engineering-page`, `page-background`, `A-00860-*` prefix
- [ ] Initial state: `null` (prevents flash on load)
- [ ] State values: `"agents"`, `"upserts"`, `"workspace"`

## Existing Testing Resources Consolidated

The following existing test documents from the 00860 discipline should be referenced during execution:

| Document | Focus | Used In |
|----------|-------|---------|
| `testing/00860_TESTING_GUIDE_LOAD_FLOW_MODAL.MD` | Load flow modal testing | ELEC-003, ELEC-009 |
| `testing/00860_TESTING_GUIDE_CABLE_SIZING.MD` | Cable sizing testing | ELEC-003, ELEC-008 |
| `testing/00860_TESTING_GUIDE_PROTECTION_COORDINATION.MD` | Protection coordination testing | ELEC-003, ELEC-010 |
| `testing/00860_ELECTRICAL_SYSTEM_TEST_REPORT.MD` | Previous test results (baseline) | ELEC-014 (baseline) |
| `testing/00860_ELECTRICAL_WORKFLOW_TROUBLESHOOTING.MD` | Workflow debugging | ELEC-007 |
| `testing/00860_ELECTRICAL_READINESS_DASHBOARD.MD` | Dashboard structure | ELEC-013a |
| `testing/00860_ELECTRICAL_SKILLS_VALIDATION_REPORT.MD` | Skills assessment | ELEC-013 |

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: KnowledgeForge AI / QualityForge AI

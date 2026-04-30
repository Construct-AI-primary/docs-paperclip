---
title: 02025 Quantity Surveying Page — Component Knowledge
description: Complete page architecture, component inventory, and 8-field metadata for the 02025 quantity surveying discipline page
author: QualityForge AI / KnowledgeForge AI
date: 2026-04-30
version: 1.0
memory_layer: working_knowledge
para_section: testing/projects/QS-TEST/knowledge
---

# 02025 Quantity Surveying Page — Component Knowledge

## Page Overview

- **Page ID**: `02025-quantity-surveying`
- **Discipline Code**: `02025`
- **File Path**: `client/src/pages/02025-quantity-surveying/components/02025-quantity-surveying-page.js`
- **Background Image**: `getThemedImagePath("02025.png")` — olive gradient (#808000) or olive-themed EPCM cover
- **Chatbot**: `QuantitySurveyingChatbot` — olive theme (#808000/#6B8E23), HITL confidence=0.7
- **Nav Container**: `A-02025-navigation-container` — fixed bottom center
- **Button Container**: `A-02025-button-container` — fixed viewport center, CSS Grid
- **Logout**: Fixed bottom-left, `window.handleLogout()`

## 8-Field Metadata — All Components

### State Navigation Buttons

```json
[
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "state-button-agents",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/02025/",
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
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "state-button-upserts",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/02025/",
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
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "state-button-workspace",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/02025/",
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
    "last_updated": "2026-04-30"
  }
]
```

### Agents State Modals (2 buttons)

```json
[
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "modal-boq-creation",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/02025/",
    "ui_buttons": {
      "id": "boq-creation-button",
      "class": "modal-trigger-button",
      "action": "openModal('02025-BOQCreationModal')",
      "target": "02025-BOQCreationModal"
    },
    "supabase_schema": {
      "table": "quantity_surveying_boq",
      "columns": ["id", "item_code", "description", "unit", "quantity", "rate", "amount"],
      "indexes": ["primary_key", "item_code_idx"]
    },
    "qc_checklist": [
      "Button renders in Agents state",
      "Modal opens: 02025-BOQCreationModal",
      "BOQ form fields match quantity_surveying_boq schema",
      "BOQ item creation persists to database",
      "Multi-step BOQ entry flow works (item by item)"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "modal-measurement-validation",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/02025/",
    "ui_buttons": {
      "id": "measurement-validation-button",
      "class": "modal-trigger-button",
      "action": "openModal('02025-MeasurementValidationModal')",
      "target": "02025-MeasurementValidationModal"
    },
    "supabase_schema": {
      "table": "quantity_surveying_measurements",
      "columns": ["id", "boq_id", "dimension", "formula", "calculated_qty"],
      "indexes": ["primary_key", "boq_id_idx"]
    },
    "qc_checklist": [
      "Button renders in Agents state",
      "Modal opens: 02025-MeasurementValidationModal",
      "Measurement form fields match quantity_surveying_measurements schema",
      "Dimension calculations validate correctly",
      "Measurement submission persists to database"
    ],
    "last_updated": "2026-04-30"
  }
]
```

### Upserts State Modals (3 buttons)

```json
[
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "modal-cloud-upsert",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02025/",
    "ui_buttons": {
      "id": "cloud-upsert-button",
      "class": "modal-trigger-button",
      "action": "openModal('02025-UpsertCloudModal')",
      "target": "02025-UpsertCloudModal"
    },
    "supabase_schema": {
      "table": "vectors",
      "columns": ["id", "embedding", "metadata", "discipline"],
      "indexes": ["primary_key", "hnsw"]
    },
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 02025-UpsertCloudModal",
      "Data insertion to supabase_vectors succeeds",
      "Error handling for malformed data"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "modal-upsert-from-url",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02025/",
    "ui_buttons": {
      "id": "upsert-url-button",
      "class": "modal-trigger-button",
      "action": "openModal('02025-UpsertUrlModal')",
      "target": "02025-UpsertUrlModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 02025-UpsertUrlModal",
      "URL fetch operation succeeds",
      "Data insertion succeeds after fetch"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "modal-upsert-files",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02025/",
    "ui_buttons": {
      "id": "upsert-files-button",
      "class": "modal-trigger-button",
      "action": "openModal('02025-UpsertFileModal')",
      "target": "02025-UpsertFileModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 02025-UpsertFileModal",
      "File upload and parse succeeds",
      "Parsed data inserted to database"
    ],
    "last_updated": "2026-04-30"
  }
]
```

### Workspace State Modals (4 buttons)

```json
[
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "modal-cost-analysis",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02025/",
    "ui_buttons": {
      "id": "cost-analysis-button",
      "class": "modal-trigger-button",
      "action": "openModal('02025-CostAnalysisModal')",
      "target": "02025-CostAnalysisModal"
    },
    "supabase_schema": {
      "table": "quantity_surveying_costs",
      "columns": ["id", "boq_id", "resource", "unit_rate", "total_cost"],
      "indexes": ["primary_key"]
    },
    "qc_checklist": [
      "Button renders in Workspace state",
      "02025-CostAnalysisModal opens",
      "Rate build-up form validates correctly",
      "Cost breakdown structure renders",
      "Resource costing persists to quantity_surveying_costs table"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "modal-project-comparison",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/02025/",
    "ui_buttons": {
      "id": "project-comparison-button",
      "class": "modal-trigger-button",
      "action": "openModal('02025-ProjectComparisonModal')",
      "target": "02025-ProjectComparisonModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Workspace state",
      "02025-ProjectComparisonModal opens",
      "Project comparison data loads correctly",
      "Cost comparison charts render"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "modal-cross-discipline-sharing",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/02025/",
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
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02025-quantity-surveying",
    "discipline": "02025",
    "component": "modal-vector-data-manager",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/02025/",
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
    "last_updated": "2026-04-30"
  }
]
```

## Page-Level QC Checklist

- [ ] 3 state buttons render (Agents, Upserts, Workspace)
- [ ] 9 modal trigger buttons render across all states
- [ ] Buttons sorted alphabetically via `sortButtonsAlphabetically()`
- [ ] Grid layout calculated via `calculateGridLayout()`
- [ ] Background image loads: `02025.png` or olive gradient (#808000)
- [ ] Navigation container: fixed bottom center
- [ ] Button container: fixed viewport center, CSS Grid
- [ ] Animation: fade-in effect with `isButtonContainerVisible`
- [ ] Logout: fixed bottom-left, `window.handleLogout()` works
- [ ] Chatbot: olive theme (#808000/#6B8E23), HITL confidence=0.7
- [ ] CSS classes: `quantity-surveying-page`, `page-background`, `A-02025-*` prefix
- [ ] Initial state: `null` (prevents flash on load)
- [ ] State values: `"agents"`, `"upserts"`, `"workspace"`

## Existing Testing Resources Consolidated

The following existing test documents from the 02025 discipline should be referenced during execution:

| Document | Focus | Used In |
|----------|-------|---------|
| `testing/02025_TESTING_GUIDE_BOQ_MODAL.MD` | BOQ modal testing | QS-003, QS-008 |
| `testing/02025_TESTING_GUIDE_COST_ANALYSIS.MD` | Cost analysis testing | QS-009 |
| `testing/02025_LANGUAGE_TESTING_PLAN.MD` | i18n, WCAG, performance | QS-012 |
| `testing/02025_QS_SYSTEM_TEST_REPORT.MD` | Previous test results | QS-014 (baseline) |
| `testing/02025_QS_WORKFLOW_TROUBLESHOOTING.MD` | Workflow debugging | QS-007 |
| `testing/02025_QS_READINESS_DASHBOARD.MD` | Dashboard structure | QS-013a |
| `testing/02025_QS_SKILLS_VALIDATION_REPORT.MD` | Skills assessment | QS-013 |

---

**Version**: 1.0
**Last Updated**: 2026-04-30
**Author**: KnowledgeForge AI / QualityForge AI

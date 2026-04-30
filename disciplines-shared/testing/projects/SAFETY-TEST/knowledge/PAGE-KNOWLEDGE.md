---
title: 02400 Safety Page — Component Knowledge
description: Complete page architecture, component inventory, and 8-field metadata for the 02400 safety discipline page
author: QualityForge AI / KnowledgeForge AI
date: 2026-04-30
version: 1.0
memory_layer: working_knowledge
para_section: testing/projects/SAFETY-TEST/knowledge
---

# 02400 Safety Page — Component Knowledge

## Page Overview

- **Page ID**: `02400-safety`
- **Discipline Code**: `02400`
- **File Path**: `client/src/pages/02400-safety/components/02400-safety-page.js`
- **Background Image**: `getThemedImagePath("02400.png")` — safety blue gradient
- **Chatbot**: `SafetyChatbot` — safety blue theme (#0D47A1/#1565C0), HITL confidence=0.7
- **Nav Container**: `A-02400-navigation-container` — fixed bottom center
- **Button Container**: `A-02400-button-container` — fixed viewport center, CSS Grid
- **Logout**: Fixed bottom-left, `window.handleLogout()`

## 8-Field Metadata — All Components

### State Navigation Buttons

```json
[
  {
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "state-button-agents",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/02400/",
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
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "state-button-upserts",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/02400/",
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
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "state-button-workspace",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/02400/",
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
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-freight-booking",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": {
      "id": "freight-booking-button",
      "class": "modal-trigger-button",
      "action": "openModal('02400-FreightBookingModal')",
      "target": "02400-FreightBookingModal"
    },
    "supabase_schema": {
      "table": "safety_freight",
      "columns": ["id", "shipment_id", "origin", "destination", "carrier", "mode", "weight_kg", "status", "created_at", "updated_at"],
      "indexes": ["primary_key", "shipment_id_idx"]
    },
    "qc_checklist": [
      "Button renders in Agents state",
      "Modal opens: 02400-FreightBookingModal",
      "Shipment form fields match safety_freight schema",
      "Freight booking persists to database",
      "Modal closes properly"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-customs-clearance",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": {
      "id": "customs-clearance-button",
      "class": "modal-trigger-button",
      "action": "openModal('02400-CustomsClearanceModal')",
      "target": "02400-CustomsClearanceModal"
    },
    "supabase_schema": {
      "table": "safety_customs",
      "columns": ["id", "declaration_id", "shipment_id", "clearance_status", "duty_amount", "documents", "customs_officer", "cleared_at"],
      "indexes": ["primary_key", "declaration_id_idx"]
    },
    "qc_checklist": [
      "Button renders in Agents state",
      "Modal opens: 02400-CustomsClearanceModal",
      "Declaration form fields match safety_customs schema",
      "Clearance submission persists to database",
      "Document upload works correctly"
    ],
    "last_updated": "2026-04-30"
  }
]
```

### Upserts State Modals (3 buttons)

```json
[
  {
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-cloud-upsert",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": {
      "id": "cloud-upsert-button",
      "class": "modal-trigger-button",
      "action": "openModal('02400-UpsertCloudModal')",
      "target": "02400-UpsertCloudModal"
    },
    "supabase_schema": {
      "table": "vectors",
      "columns": ["id", "embedding", "metadata", "discipline"],
      "indexes": ["primary_key", "hnsw"]
    },
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 02400-UpsertCloudModal",
      "Data insertion to supabase_vectors succeeds",
      "Error handling for malformed data"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-upsert-from-url",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": {
      "id": "upsert-url-button",
      "class": "modal-trigger-button",
      "action": "openModal('02400-UpsertUrlModal')",
      "target": "02400-UpsertUrlModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 02400-UpsertUrlModal",
      "URL fetch operation succeeds",
      "Data insertion succeeds after fetch"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-upsert-files",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": {
      "id": "upsert-files-button",
      "class": "modal-trigger-button",
      "action": "openModal('02400-UpsertFileModal')",
      "target": "02400-UpsertFileModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 02400-UpsertFileModal",
      "File upload and parse succeeds",
      "Parsed data inserted to database"
    ],
    "last_updated": "2026-04-30"
  }
]
```

### Workspace State Modals (5 buttons)

```json
[
  {
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-fleet-management",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": {
      "id": "fleet-management-button",
      "class": "modal-trigger-button",
      "action": "openModal('02400-FleetManagementModal')",
      "target": "02400-FleetManagementModal"
    },
    "supabase_schema": {
      "table": "safety_fleet",
      "columns": ["id", "vehicle_id", "driver", "route", "status", "last_gps_lat", "last_gps_lng", "fuel_level", "maintenance_due", "created_at"],
      "indexes": ["primary_key", "vehicle_id_idx"]
    },
    "qc_checklist": [
      "Button renders in Workspace state",
      "02400-FleetManagementModal opens",
      "Fleet CRUD operations persist",
      "Vehicle status updates correctly",
      "GPS coordinates display on map"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-warehouse-management",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": {
      "id": "warehouse-management-button",
      "class": "modal-trigger-button",
      "action": "openModal('02400-WarehouseManagementModal')",
      "target": "02400-WarehouseManagementModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Workspace state",
      "02400-WarehouseManagementModal opens",
      "Warehouse inventory displays correctly",
      "Stock level updates persist"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-supplier-directory",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": {
      "id": "supplier-directory-button",
      "class": "modal-trigger-button",
      "action": "openModal('02400-SupplierDirectoryModal')",
      "target": "02400-SupplierDirectoryModal"
    },
    "supabase_schema": {
      "table": "suppliers",
      "columns": ["id", "name", "type", "contact", "status", "rating"],
      "indexes": ["primary_key", "name_idx"]
    },
    "qc_checklist": [
      "Button renders in Workspace state",
      "02400-SupplierDirectoryModal opens",
      "Supplier CRUD operations persist",
      "Supplier card JSONs render correctly"
    ],
    "last_updated": "2026-04-30"
  },
  {
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-cross-discipline-sharing",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/02400/",
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
    "page_id": "02400-safety",
    "discipline": "02400",
    "component": "modal-vector-data-manager",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/02400/",
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
- [ ] 10 modal trigger buttons render across all states
- [ ] Buttons sorted alphabetically via `sortButtonsAlphabetically()`
- [ ] Grid layout calculated via `calculateGridLayout()`
- [ ] Background image loads: `02400.png` (safety blue gradient)
- [ ] Navigation container: fixed bottom center
- [ ] Button container: fixed viewport center, CSS Grid
- [ ] Animation: fade-in effect with `isButtonContainerVisible`
- [ ] Logout: fixed bottom-left, `window.handleLogout()` works
- [ ] Chatbot: safety blue theme (#0D47A1/#1565C0), HITL confidence=0.7
- [ ] CSS classes: `safety-page`, `page-background`, `A-02400-*` prefix
- [ ] Initial state: `null` (prevents flash on load)
- [ ] State values: `"agents"`, `"upserts"`, `"workspace"`

## Supabase Schemas Reference

| Table | Primary Key | Key Columns | Used By |
|-------|-------------|-------------|---------|
| `safety_freight` | id | shipment_id, origin, destination, carrier, mode, weight_kg, status | SAFETY-003 |
| `safety_customs` | id | declaration_id, shipment_id, clearance_status, duty_amount, documents | SAFETY-003 |
| `safety_fleet` | id | vehicle_id, driver, route, status, last_gps_lat, last_gps_lng, fuel_level, maintenance_due | SAFETY-005, SAFETY-009 |
| `suppliers` | id | name, type, contact, status, rating | SAFETY-005 |
| `vectors` | id | embedding, metadata, discipline | SAFETY-004, SAFETY-011 |

---

**Version**: 1.0
**Last Updated**: 2026-04-30
**Author**: KnowledgeForge AI / QualityForge AI

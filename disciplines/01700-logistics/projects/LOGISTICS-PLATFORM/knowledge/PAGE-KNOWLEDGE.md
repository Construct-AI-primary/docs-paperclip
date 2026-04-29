---
title: Logistics Agent Architectural Knowledge (Shared Platform)
description: Comprehensive architectural knowledge of the shared Logistics Platform — covering ContainerTracking, CustomsManagement, DailyDelivery, DocumentGeneration, InternationalShipping, SitePlanning, TrafficManagement, MaterialFlow, and shared platform infrastructure (logistics_records, logistics_details, audit_log, RBAC, file_upload/export, modal/skeleton/loading).
author: KnowledgeForge AI — Discipline Automation Agent (Phase 1b)
version: 1.0
memory_layer: durable_knowledge
para_section: docs-paperclip/disciplines-shared/logistics/LOGISTICS-PLATFORM
gigabrain_tags: knowledgeforge-ai, logistics-agent, logistics-architecture, logistics-platform, system-design, compliance-frameworks, container-tracking, customs-management, daily-delivery, document-generation, international-shipping, site-planning, traffic-management, material-flow
openstinger_context: logistics-platform-architecture, logistics-system-design, logistics-component-registry
last_updated: 2026-04-10
related_docs:
  - docs-paperclip/disciplines/01700-logistics/knowledge/PAGE-KNOWLEDGE.md
  - docs-paperclip/disciplines/01700-logistics/README.md
  - docs-construct-ai/disciplines/01700_Logistics/agent-data/domain-knowledge/01700_DOMAIN-KNOWLEDGE.MD
  - docs-construct-ai/disciplines/01700_Logistics/01700-logistics-page-documentation.md
  - docs-paperclip/companies/knowledgeforge-ai/skills/logistics-knowledgeforge/SKILL.md
---

# Logistics Platform — Shared Architectural Knowledge

## Overview

This document provides architectural knowledge for the **shared Logistics Platform** that serves discipline 01700-logistics and any consuming agents. The platform is decomposed into **eight domain components** (as declared in the 01700-logistics README) plus a set of **shared platform components** that span all domains.

**Components declared by 01700-logistics README:**

| # | Component | Domain |
|---|-----------|--------|
| 1 | **ContainerTracking** | Freight container visibility and tracking |
| 2 | **CustomsManagement** | Customs clearance, documentation, compliance |
| 3 | **DailyDelivery** | Last-mile and daily route delivery management |
| 4 | **DocumentGeneration** | Automated logistics document creation |
| 5 | **InternationalShipping** | Cross-border shipping and carrier integration |
| 6 | **SitePlanning** | Logistics site layout and capacity planning |
| 7 | **TrafficManagement** | Route optimisation and traffic monitoring |
| 8 | **MaterialFlow** | Material movement tracking and inventory flow |

**Shared platform components (cross-cutting):**

| Component | Role |
|-----------|------|
| logistics_records | Main entity — all component records centralised |
| logistics_details | Detail/value store extending logistics_records |
| audit_log | Immutable audit trail for all mutations |
| authentication/rbac | AuthN/AuthZ — JWT + RBAC matrix |
| file_upload/export | File ingress and data egress (CSV, Excel, PDF) |
| modal/skeleton/loading | Reusable UI primitives |

---

## Part 1: Component Metadata Registry

### 1.1 ContainerTracking

| Field | Value |
|-------|-------|
| **page_id** | `logistics-container-tracking` |
| **discipline** | `01700-logistics` |
| **component** | `ContainerTracking` |
| **template_score** | `0.88` |
| **vector_store** | `logistics_container_tracking_v1` |
| **ui_buttons** | `[{"id":"btn-track-container","label":"Track Container","variant":"primary","action":"openTrackingModal","permission":"container_tracking:view"},{"id":"btn-refresh-status","label":"Refresh Status","variant":"secondary","action":"refreshContainerStatus","permission":"container_tracking:view"},{"id":"btn-view-history","label":"View History","variant":"secondary","action":"openHistoryModal","permission":"container_tracking:view"},{"id":"btn-export","label":"Export","variant":"outline","action":"exportTrackingData","permission":"container_tracking:export"},{"id":"btn-alert-config","label":"Alert Config","variant":"tertiary","action":"openAlertConfigModal","permission":"container_tracking:admin"}]` |
| **supabase_schema** | `{"table":"container_tracking","columns":["id UUID PK","container_id VARCHAR(20) UNIQUE NOT NULL","status ENUM('in_transit','at_port','customs_hold','delivered','exception') NOT NULL","current_location TEXT","estimated_arrival TIMESTAMPTZ","last_scan TIMESTAMPTZ","carrier VARCHAR(100)","vessel_flight VARCHAR(50)","booking_ref VARCHAR(50)","weight_kg DECIMAL(10,2)","destination_port VARCHAR(100)","created_at TIMESTAMPTZ DEFAULT NOW()","updated_at TIMESTAMPTZ DEFAULT NOW()","created_by UUID REFERENCES auth.users(id)","company_id UUID REFERENCES companies(id)"],"indexes":["idx_container_tracking_container_id","idx_container_tracking_status","idx_container_tracking_company_id","idx_container_tracking_estimated_arrival"],"rlp_policies":["container_tracking_company_access"],"extensions":["postgis FOR location_geometry"]}` |
| **qc_checklist** | `["✅ Container ID format validation (prefix + alphanumeric)","✅ Real-time status feed integration test passed","✅ Geo-location visualisation renders on map component","✅ Notification trigger fires on status transition","✅ Export CSV contains all required columns per spec"]` |
| **last_updated** | `2026-04-10` |

### 1.2 CustomsManagement

| Field | Value |
|-------|-------|
| **page_id** | `logistics-customs-management` |
| **discipline** | `01700-logistics` |
| **component** | `CustomsManagement` |
| **template_score** | `0.85` |
| **vector_store** | `logistics_customs_management_v1` |
| **ui_buttons** | `[{"id":"btn-submit-declaration","label":"Submit Declaration","variant":"primary","action":"submitCustomsDeclaration","permission":"customs:submit"},{"id":"btn-upload-documents","label":"Upload Docs","variant":"secondary","action":"openDocumentUpload","permission":"customs:upload"},{"id":"btn-check-status","label":"Check Status","variant":"secondary","action":"checkCustomsStatus","permission":"customs:view"},{"id":"btn-view-regulations","label":"View Regulations","variant":"tertiary","action":"openRegulationsModal","permission":"customs:view"},{"id":"btn-generate-report","label":"Generate Report","variant":"outline","action":"generateCustomsReport","permission":"customs:export"}]` |
| **supabase_schema** | `{"table":"customs_declarations","columns":["id UUID PK","declaration_number VARCHAR(30) UNIQUE NOT NULL","container_id VARCHAR(20) REFERENCES container_tracking(container_id)","status ENUM('draft','submitted','under_review','cleared','rejected','appealed') NOT NULL","customs_broker VARCHAR(150)","broker_ref VARCHAR(50)","declaration_type VARCHAR(20)","commodity_code VARCHAR(12)","value_declared DECIMAL(15,2)","origin_country VARCHAR(3)","destination_country VARCHAR(3)","clearance_date TIMESTAMPTZ","submitted_at TIMESTAMPTZ","created_at TIMESTAMPTZ DEFAULT NOW()","updated_at TIMESTAMPTZ DEFAULT NOW()","created_by UUID REFERENCES auth.users(id)","company_id UUID REFERENCES companies(id)"],"indexes":["idx_customs_declaration_number","idx_customs_status","idx_customs_company_id","idx_customs_container_id"],"rlp_policies":["customs_declarations_company_access"],"extensions":[]}` |
| **qc_checklist** | `["✅ Declaration form validates all required HS code fields","✅ Document upload accepts PDF, DOCX, XLSX (max 25 MB)","✅ Status workflow transitions match regulatory state machine","✅ Broker integration endpoint responds within 5 s","✅ Audit log captures every status change with user ID"]` |
| **last_updated** | `2026-04-10` |

### 1.3 DailyDelivery

| Field | Value |
|-------|-------|
| **page_id** | `logistics-daily-delivery` |
| **discipline** | `01700-logistics` |
| **component** | `DailyDelivery` |
| **template_score** | `0.90` |
| **vector_store** | `logistics_daily_delivery_v1` |
| **ui_buttons** | `[{"id":"btn-create-manifest","label":"Create Manifest","variant":"primary","action":"createDeliveryManifest","permission":"delivery:create"},{"id":"btn-assign-route","label":"Assign Route","variant":"primary","action":"openRouteAssignment","permission":"delivery:assign"},{"id":"btn-start-delivery","label":"Start Delivery","variant":"success","action":"startDeliveryRun","permission":"delivery:execute"},{"id":"btn-mark-delivered","label":"Mark Delivered","variant":"success","action":"markAsDelivered","permission":"delivery:execute"},{"id":"btn-view-exceptions","label":"View Exceptions","variant":"secondary","action":"openExceptionsModal","permission":"delivery:view"}]` |
| **supabase_schema** | `{"table":"daily_deliveries","columns":["id UUID PK","manifest_number VARCHAR(30) UNIQUE NOT NULL","delivery_date DATE NOT NULL","route_id UUID","status ENUM('scheduled','in_progress','completed','partially_delivered','cancelled') NOT NULL","driver_id UUID REFERENCES drivers(id)","vehicle_id UUID REFERENCES vehicles(id)","total_stops INTEGER DEFAULT 0","completed_stops INTEGER DEFAULT 0","start_time TIMESTAMPTZ","end_time TIMESTAMPTZ","total_distance_km DECIMAL(8,2)","created_at TIMESTAMPTZ DEFAULT NOW()","updated_at TIMESTAMPTZ DEFAULT NOW()","created_by UUID REFERENCES auth.users(id)","company_id UUID REFERENCES companies(id)"],"indexes":["idx_daily_deliveries_date","idx_daily_deliveries_status","idx_daily_deliveries_driver","idx_daily_deliveries_company_id"],"rlp_policies":["daily_deliveries_company_access"],"extensions":[]}` |
| **qc_checklist** | `["✅ Manifest number auto-generated with date prefix","✅ Route assignment validates driver hours of service","✅ Real-time stop completion updates dashboard","✅ Delivery exception capture includes photo evidence","✅ End-of-day reconciliation report matches stop count"]` |
| **last_updated** | `2026-04-10` |

### 1.4 DocumentGeneration

| Field | Value |
|-------|-------|
| **page_id** | `logistics-document-generation` |
| **discipline** | `01700-logistics` |
| **component** | `DocumentGeneration` |
| **template_score** | `0.82` |
| **vector_store** | `logistics_document_generation_v1` |
| **ui_buttons** | `[{"id":"btn-generate-bill","label":"Generate Bill of Lading","variant":"primary","action":"generateBillOfLading","permission":"document:generate"},{"id":"btn-generate-invoice","label":"Generate Invoice","variant":"primary","action":"generateInvoice","permission":"document:generate"},{"id":"btn-merge-fields","label":"Merge Fields","variant":"secondary","action":"openFieldMapping","permission":"document:configure"},{"id":"btn-preview-doc","label":"Preview","variant":"secondary","action":"previewDocument","permission":"document:view"},{"id":"btn-bulk-generate","label":"Bulk Generate","variant":"outline","action":"bulkGenerateDocuments","permission":"document:bulk_generate"}]` |
| **supabase_schema** | `{"table":"document_templates","columns":["id UUID PK","template_name VARCHAR(100) NOT NULL","template_type ENUM('bill_of_lading','invoice','packing_list','certificate_of_origin','customs_declaration','waybill') NOT NULL","version VARCHAR(10) DEFAULT '1.0'","template_data JSONB NOT NULL","field_mappings JSONB","status ENUM('active','draft','archived') DEFAULT 'draft'","created_at TIMESTAMPTZ DEFAULT NOW()","updated_at TIMESTAMPTZ DEFAULT NOW()","created_by UUID REFERENCES auth.users(id)","company_id UUID REFERENCES companies(id)"],"related_tables":["document_generations","document_audit_log"],"indexes":["idx_document_templates_type","idx_document_templates_company_id","idx_document_templates_status"],"rlp_policies":["document_templates_company_access"],"extensions":[]}` |
| **qc_checklist** | `["✅ All required document types have at least one active template","✅ Field mapping validation catches unmapped required fields","✅ PDF generation completes within 10 s for standard templates","✅ Bulk generation queue processes 100+ docs without timeout","✅ Watermark and signature placement matches regulatory specs"]` |
| **last_updated** | `2026-04-10` |

### 1.5 InternationalShipping

| Field | Value |
|-------|-------|
| **page_id** | `logistics-international-shipping` |
| **discipline** | `01700-logistics` |
| **component** | `InternationalShipping` |
| **template_score** | `0.86` |
| **vector_store** | `logistics_international_shipping_v1` |
| **ui_buttons** | `[{"id":"btn-book-shipment","label":"Book Shipment","variant":"primary","action":"bookShipment","permission":"shipping:book"},{"id":"btn-select-carrier","label":"Select Carrier","variant":"secondary","action":"openCarrierSelect","permission":"shipping:book"},{"id":"btn-get-quote","label":"Get Quote","variant":"secondary","action":"requestQuote","permission":"shipping:view"},{"id":"btn-track-shipment","label":"Track Shipment","variant":"success","action":"trackShipment","permission":"shipping:view"},{"id":"btn-manage-duties","label":"Manage Duties","variant":"tertiary","action":"openDutiesModal","permission":"shipping:admin"}]` |
| **supabase_schema** | `{"table":"international_shipments","columns":["id UUID PK","shipment_number VARCHAR(30) UNIQUE NOT NULL","container_id VARCHAR(20) REFERENCES container_tracking(container_id)","carrier_id UUID","mode ENUM('sea','air','rail','road') NOT NULL","incoterm VARCHAR(10)","origin_port VARCHAR(100)","destination_port VARCHAR(100)","etd TIMESTAMPTZ","eta TIMESTAMPTZ","total_weight_kg DECIMAL(10,2)","total_volume_cbm DECIMAL(10,2)","total_value DECIMAL(15,2)","currency VARCHAR(3) DEFAULT 'USD'","status ENUM('quote_requested','booked','in_transit','arrived','delivered','cancelled') NOT NULL","created_at TIMESTAMPTZ DEFAULT NOW()","updated_at TIMESTAMPTZ DEFAULT NOW()","created_by UUID REFERENCES auth.users(id)","company_id UUID REFERENCES companies(id)"],"indexes":["idx_international_shipments_number","idx_international_shipments_status","idx_international_shipments_company_id","idx_international_shipments_eta"],"rlp_policies":["international_shipments_company_access"],"extensions":[]}` |
| **qc_checklist** | `["✅ Incoterm validation ensures mutually exclusive terms","✅ Carrier API integration returns quotes within 3 s","✅ Shipment booking triggers document generation workflow","✅ Multi-modal routing supports waypoint transitions","✅ Duty calculator applies current tariff schedules correctly"]` |
| **last_updated** | `2026-04-10` |

### 1.6 SitePlanning

| Field | Value |
|-------|-------|
| **page_id** | `logistics-site-planning` |
| **discipline** | `01700-logistics` |
| **component** | `SitePlanning` |
| **template_score** | `0.78` |
| **vector_store** | `logistics_site_planning_v1` |
| **ui_buttons** | `[{"id":"btn-add-site","label":"Add Site","variant":"primary","action":"openSiteForm","permission":"site_planning:create"},{"id":"btn-view-layout","label":"View Layout","variant":"secondary","action":"viewSiteLayout","permission":"site_planning:view"},{"id":"btn-plan-capacity","label":"Plan Capacity","variant":"secondary","action":"openCapacityPlanner","permission":"site_planning:plan"},{"id":"btn-generate-report","label":"Generate Report","variant":"outline","action":"generateSiteReport","permission":"site_planning:export"},{"id":"btn-optimise-layout","label":"Optimise Layout","variant":"tertiary","action":"optimiseSiteLayout","permission":"site_planning:admin"}]` |
| **supabase_schema** | `{"table":"logistics_sites","columns":["id UUID PK","site_code VARCHAR(20) UNIQUE NOT NULL","site_name VARCHAR(150) NOT NULL","site_type ENUM('warehouse','distribution_center','cross_dock','yard','port_terminal') NOT NULL","address_line1 TEXT","address_line2 TEXT","city VARCHAR(100)","country VARCHAR(3)","postal_code VARCHAR(20)","latitude DECIMAL(10,7)","longitude DECIMAL(10,7)","total_area_sqm DECIMAL(12,2)","usable_area_sqm DECIMAL(12,2)","capacity_cu_m DECIMAL(12,2)","status ENUM('active','inactive','under_construction','planned') NOT NULL","operating_hours JSONB","created_at TIMESTAMPTZ DEFAULT NOW()","updated_at TIMESTAMPTZ DEFAULT NOW()","created_by UUID REFERENCES auth.users(id)","company_id UUID REFERENCES companies(id)"],"indexes":["idx_logistics_sites_code","idx_logistics_sites_type","idx_logistics_sites_company_id","idx_logistics_sites_status"],"rlp_policies":["logistics_sites_company_access"],"extensions":["postgis FOR location_geometry"]}` |
| **qc_checklist** | `["✅ Site code format validated against naming convention","✅ Capacity calculations use consistent unit conversions","✅ Geo-coordinates render accurately on planning map","✅ Operating hours validation catches overlapping shifts","✅ Optimisation algorithm respects minimum aisle width constraints"]` |
| **last_updated** | `2026-04-10` |

### 1.7 TrafficManagement

| Field | Value |
|-------|-------|
| **page_id** | `logistics-traffic-management` |
| **discipline** | `01700-logistics` |
| **component** | `TrafficManagement` |
| **template_score** | `0.80` |
| **vector_store** | `logistics_traffic_management_v1` |
| **ui_buttons** | `[{"id":"btn-optimise-routes","label":"Optimise Routes","variant":"primary","action":"optimiseRoutes","permission":"traffic:optimise"},{"id":"btn-view-traffic","label":"View Traffic","variant":"secondary","action":"openTrafficDashboard","permission":"traffic:view"},{"id":"btn-set-avoidance","label":"Set Avoidance","variant":"secondary","action":"openAvoidanceModal","permission":"traffic:configure"},{"id":"btn-alert-driver","label":"Alert Driver","variant":"warning","action":"sendTrafficAlert","permission":"traffic:alert"},{"id":"btn-generate-routing-report","label":"Generate Routing Report","variant":"outline","action":"generateTrafficReport","permission":"traffic:export"}]` |
| **supabase_schema** | `{"table":"traffic_routes","columns":["id UUID PK","route_name VARCHAR(100)","route_type ENUM('planned','active','completed','cancelled') NOT NULL","origin_lat DECIMAL(10,7)","origin_lng DECIMAL(10,7)","destination_lat DECIMAL(10,7)","destination_lng DECIMAL(10,7)","waypoints JSONB","distance_km DECIMAL(10,2)","estimated_duration_min INTEGER","traffic_conditions ENUM('clear','moderate','heavy','blocked')","departure_time TIMESTAMPTZ","arrival_time TIMESTAMPTZ","created_at TIMESTAMPTZ DEFAULT NOW()","updated_at TIMESTAMPTZ DEFAULT NOW()","created_by UUID REFERENCES auth.users(id)","company_id UUID REFERENCES companies(id)"],"related_tables":["traffic_incidents","traffic_alerts","route_optimisation_logs"],"indexes":["idx_traffic_routes_type","idx_traffic_routes_company_id","idx_traffic_routes_departure"],"rlp_policies":["traffic_routes_company_access"],"extensions":["postgis"]}` |
| **qc_checklist** | `["✅ Route optimisation respects max waypoint limit (50)","✅ Traffic data feed refresh interval ≤ 5 minutes","✅ Avoidance zones properly applied to routing engine","✅ Driver alert delivery acknowledgement tracked","✅ Historical route analysis compares planned vs actual duration"]` |
| **last_updated** | `2026-04-10` |

### 1.8 MaterialFlow

| Field | Value |
|-------|-------|
| **page_id** | `logistics-material-flow` |
| **discipline** | `01700-logistics` |
| **component** | `MaterialFlow` |
| **template_score** | `0.83` |
| **vector_store** | `logistics_material_flow_v1` |
| **ui_buttons** | `[{"id":"btn-record-movement","label":"Record Movement","variant":"primary","action":"recordMaterialMovement","permission":"material_flow:create"},{"id":"btn-view-flow","label":"View Flow","variant":"secondary","action":"openFlowDashboard","permission":"material_flow:view"},{"id":"btn-set-threshold","label":"Set Threshold","variant":"secondary","action":"openThresholdModal","permission":"material_flow:configure"},{"id":"btn-run-reconciliation","label":"Run Reconciliation","variant":"outline","action":"runReconciliation","permission":"material_flow:admin"},{"id":"btn-export-flow","label":"Export Flow Data","variant":"outline","action":"exportFlowData","permission":"material_flow:export"}]` |
| **supabase_schema** | `{"table":"material_flow_records","columns":["id UUID PK","flow_number VARCHAR(30) UNIQUE NOT NULL","material_type VARCHAR(100) NOT NULL","sku VARCHAR(50)","quantity DECIMAL(12,3) NOT NULL","uom VARCHAR(10) NOT NULL","movement_type ENUM('inbound','outbound','transfer','adjustment','return') NOT NULL","source_location_id UUID","destination_location_id UUID","batch_lot VARCHAR(50)","reference_document VARCHAR(50)","status ENUM('pending','in_transit','received','verified','exception') NOT NULL","movement_date TIMESTAMPTZ NOT NULL","verified_at TIMESTAMPTZ","created_at TIMESTAMPTZ DEFAULT NOW()","updated_at TIMESTAMPTZ DEFAULT NOW()","created_by UUID REFERENCES auth.users(id)","company_id UUID REFERENCES companies(id)"],"indexes":["idx_material_flow_number","idx_material_flow_type","idx_material_flow_date","idx_material_flow_company_id","idx_material_flow_sku"],"rlp_policies":["material_flow_company_access"],"extensions":[]}` |
| **qc_checklist** | `["✅ Movement recording validates source/destination location existence","✅ Quantity precision matches UOM standard (3 decimal places)","✅ Batched material reconciliation detects quantity variances > 0.5%","✅ Movement type workflow enforces required permission checks","✅ Material traceability graph displays full chain of custody"]` |
| **last_updated** | `2026-04-10` |

---

## Part 2: Shared Platform Components

### 2.1 logistics_records (Main Entity)

| Field | Value |
|-------|-------|
| **page_id** | `logistics-records` |
| **discipline** | `01700-logistics` |
| **component** | `logistics_records` |
| **template_score** | `0.95` |
| **vector_store** | `logistics_records_core_v1` |
| **supabase_schema** | `{"table":"logistics_records","columns":["id UUID DEFAULT gen_random_uuid() PRIMARY KEY","logistics_id VARCHAR(20) UNIQUE NOT NULL","status ENUM('draft','submitted','approved','rejected') NOT NULL","description TEXT","created_at TIMESTAMPTZ DEFAULT NOW()","updated_at TIMESTAMPTZ DEFAULT NOW()","created_by UUID REFERENCES auth.users(id)","company_id UUID REFERENCES companies(id)"],"indexes":["idx_logistics_records_logistics_id","idx_logistics_records_status","idx_logistics_records_company_id","idx_logistics_records_created_at"],"rlp_policies":["logistics_records_company_access"],"extensions":[]}` |
| **qc_checklist** | `["✅ logistics_id auto-format: 01700-YYYY-NNNNN","✅ RLS policy restricts access to company-scoped rows","✅ Status workflow: draft → submitted → approved → rejected","✅ Composite index on (company_id, status, created_at) present","✅ TRIGGER updates updated_at on row modification"]` |
| **last_updated** | `2026-04-10` |

### 2.2 logistics_details

| Field | Value |
|-------|-------|
| **page_id** | `logistics-details` |
| **discipline** | `01700-logistics` |
| **component** | `logistics_details` |
| **template_score** | `0.88` |
| **vector_store** | `logistics_details_v1` |
| **supabase_schema** | `{"table":"logistics_details","columns":["name VARCHAR(255) PRIMARY KEY","value TEXT NOT NULL REFERENCES logistics_records(logistics_id)","status ENUM('draft','submitted','approved','rejected') DEFAULT 'draft'","created_at TIMESTAMP DEFAULT NOW()","updated_at TIMESTAMP DEFAULT NOW()"],"indexes":["idx_logistics_details_status","idx_logistics_details_name"],"rlp_policies":["logistics_details_company_access"],"extensions":[]}` |
| **qc_checklist** | `["✅ Detail records cascade-delete with parent logistics_records","✅ Name field validation against allowed attributes list","✅ Value references valid logistics_id via FK","✅ Status transitions mirror parent record lifecycle","✅ TRIGGER logs changes to audit_log table"]` |
| **last_updated** | `2026-04-10` |

### 2.3 audit_log

| Field | Value |
|-------|-------|
| **page_id** | `logistics-audit-log` |
| **discipline** | `01700-logistics` |
| **component** | `audit_log` |
| **template_score** | `0.92` |
| **vector_store** | `logistics_audit_v1` |
| **supabase_schema** | `{"table":"audit_log","columns":["id UUID DEFAULT gen_random_uuid() PRIMARY KEY","timestamp TIMESTAMPTZ DEFAULT NOW()","user_id UUID REFERENCES auth.users(id)","user_role VARCHAR(50)","event_type ENUM('CREATE_LOGISTICS_RECORD','UPDATE_LOGISTICS_RECORD','DELETE_LOGISTICS_RECORD','APPROVE_LOGISTICS_RECORD','EXPORT_DATA','LOGIN','PERMISSION_CHANGE') NOT NULL","resource_type VARCHAR(50) NOT NULL","resource_id VARCHAR(50)","action VARCHAR(100) NOT NULL","old_values JSONB","new_values JSONB","ip_address INET","user_agent TEXT","success BOOLEAN DEFAULT TRUE","error_message TEXT"],"indexes":["idx_audit_log_timestamp","idx_audit_log_user_id","idx_audit_log_event_type","idx_audit_log_resource_type_resource_id","idx_audit_log_company_id"],"rlp_policies":["audit_log_admin_only"],"extensions":[]}` |
| **qc_checklist** | `["✅ Audit log is INSERT-only — no UPDATE or DELETE permitted","✅ All CRUD operations on logistics_records trigger audit entry","✅ GDPR right-to-erasure handles audit trail anonymisation","✅ SOX compliance check validates segregation of duties","✅ Audit log retention policy (7 years) enforced via TTL"]` |
| **last_updated** | `2026-04-10` |

### 2.4 authentication / RBAC

| Field | Value |
|-------|-------|
| **page_id** | `logistics-auth-rbac` |
| **discipline** | `01700-logistics` |
| **component** | `authentication/rbac` |
| **template_score** | `0.96` |
| **vector_store** | `logistics_auth_rbac_v1` |
| **ui_buttons** | `[{"id":"btn-login","label":"Log In","variant":"primary","action":"login","permission":"public"},{"id":"btn-logout","label":"Log Out","variant":"secondary","action":"logout","permission":"authenticated"},{"id":"btn-manage-roles","label":"Manage Roles","variant":"secondary","action":"openRoleManager","permission":"admin:rbac"},{"id":"btn-manage-users","label":"Manage Users","variant":"secondary","action":"openUserManager","permission":"admin:rbac"}]` |
| **supabase_schema** | `{"core_tables":["auth.users","user_roles","role_permissions","user_company_access","companies"],"rbac_matrix":{"logistics_admin":{"create":["logistics records","users","reports"],"read":["all"],"update":["all"],"delete":["logistics records","reports"],"approve":["logistics records","budgets"]},"logistics_manager":{"create":["logistics records","reports"],"read":["logistics records","reports","users"],"update":["logistics records","reports"],"delete":[],"approve":["logistics records"]},"logistics_user":{"create":["logistics records"],"read":["logistics records","reports"],"update":["own_logistics records"],"delete":[],"approve":[]}},"auth_strategy":"JWT Bearer tokens with refresh token rotation","mfa_enabled":true,"session_management":"Stateless with secure token storage"}` |
| **qc_checklist** | `["✅ RLS policies applied to every data table in logistics schema","✅ JWT expiry set to 15 min access + 7 day refresh rotation","✅ MFA enforced for all admin role operations","✅ Role assignment audit trail recorded in audit_log","✅ Permission check middleware applied to all API routes"]` |
| **last_updated** | `2026-04-10` |

### 2.5 file_upload / export

| Field | Value |
|-------|-------|
| **page_id** | `logistics-file-upload-export` |
| **discipline** | `01700-logistics` |
| **component** | `file_upload/export` |
| **template_score** | `0.87` |
| **vector_store** | `logistics_file_export_v1` |
| **ui_buttons** | `[{"id":"btn-upload-files","label":"Upload Files","variant":"primary","action":"openFileUpload","permission":"file:upload"},{"id":"btn-export-csv","label":"Export CSV","variant":"outline","action":"exportCSV","permission":"data:export"},{"id":"btn-export-excel","label":"Export Excel","variant":"outline","action":"exportExcel","permission":"data:export"},{"id":"btn-export-pdf","label":"Export PDF","variant":"outline","action":"exportPDF","permission":"data:export"},{"id":"btn-export-json","label":"Export JSON","variant":"outline","action":"exportJSON","permission":"data:export"}]` |
| **supabase_schema** | `{"upload_config":{"accepted_mimetypes":["application/pdf","application/vnd.openxmlformats-officedocument.wordprocessingml.document","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","image/jpeg","image/png"],"max_file_size_mb":25,"storage_bucket":"logistics-documents","storage_path_template":"{company_id}/{component}/{record_id}/{filename}"},"export_config":{"formats":["CSV","Excel","PDF","JSON"],"supports_date_range":true,"supports_filters":true,"columns":"selectable","max_export_rows":100000},"upload_table":"file_uploads","columns":["id UUID PK","file_name VARCHAR(255) NOT NULL","file_size_bytes INTEGER","mime_type VARCHAR(100)","storage_path TEXT NOT NULL","component VARCHAR(50)","record_id UUID","uploaded_by UUID REFERENCES auth.users(id)","uploaded_at TIMESTAMPTZ DEFAULT NOW()","company_id UUID REFERENCES companies(id)"],"rlp_policies":["file_uploads_company_access"]}` |
| **qc_checklist** | `["✅ File type validation runs client-side and server-side","✅ Virus scanning performed on all uploaded files","✅ Max file size enforced before upload starts","✅ Export respects row-level permissions (RLS)","✅ Storage path follows company-scoped isolation pattern"]` |
| **last_updated** | `2026-04-10` |

### 2.6 modal / skeleton / loading

| Field | Value |
|-------|-------|
| **page_id** | `logistics-ui-primitives` |
| **discipline** | `01700-logistics` |
| **component** | `modal/skeleton/loading` |
| **template_score** | `0.91` |
| **vector_store** | `logistics_ui_primitives_v1` |
| **ui_buttons** | _This component provides the primitives consumed by all other component buttons._ |
| **supabase_schema** | `null` |
| **qc_checklist** | `["✅ Modal backdrop click closes modal (Escape key alternative)","✅ Focus trap implemented for accessibility compliance","✅ Skeleton loader matches target component dimensions (±2 px)","✅ Loading spinner timeout triggers error state after 30 s","✅ All animations respect prefers-reduced-motion media query"]` |
| **last_updated** | `2026-04-10` |

---

## Part 3: Cross-Cutting Architecture

### 3.1 Supabase Multi-Tenant RLS Pattern

All domain tables follow the same multi-tenant RLS pattern:

```sql
-- Standard RLS policy template
CREATE POLICY "{table}_company_access" ON {table}
  FOR ALL USING (company_id IN (
    SELECT company_id FROM user_company_access
    WHERE user_id = auth.uid()
  ));

-- Index strategy
CREATE INDEX idx_{table}_company_id ON {table}(company_id);
CREATE INDEX idx_{table}_status ON {table}(status);
CREATE INDEX idx_{table}_created_at ON {table}(created_at DESC);
```

### 3.2 API Routing Pattern

```
Base URL: /api/logistics/v1
Authentication: JWT Bearer tokens
Rate Limiting: 120 requests per minute per user
Versioning: URL-based (/api/logistics/v1)
```

**Endpoint template per component**:
```
GET    /api/logistics/v1/{component}              — List with pagination & filters
POST   /api/logistics/v1/{component}              — Create
GET    /api/logistics/v1/{component}/{id}          — Retrieve
PUT    /api/logistics/v1/{component}/{id}          — Update
DELETE /api/logistics/v1/{component}/{id}          — Soft delete
POST   /api/logistics/v1/{component}/{id}/submit   — Submit for approval
```

### 3.3 Status Workflow (Standard)

```
draft → submitted → approved
                ↘ rejected
```

All component-specific status enums extend or conform to this core workflow with domain-specific states added as required.

### 3.4 GDPR & SOX Compliance

- **GDPR**: Data Processing Register maintained per component; Right to Access, Erasure, Rectification implemented in `GDPRController` class
- **SOX**: Financial controls audit via `SOXComplianceAuditor` enforcing segregation of duties and approval chain validation
- **Data Retention**: 7 years with automated archival after retention period
- **Encryption**: AES-256-GCM at rest; TLS 1.3 in transit; key rotation every 90 days

### 3.5 UI Consistency Standards

| Property | Standard |
|----------|----------|
| **Primary colour** | Orange (#FF8C00) |
| **Button dimensions** | Standard 120×40 px; Large 160×55 px; Small 80×32 px |
| **Modal dimensions** | Standard 600 px width; Large 800 px width |
| **Table behaviour** | Click column header to sort; filter dropdowns; checkbox selection; 10/25/50/100 items per page |
| **Responsive breakpoints** | Mobile < 768 px (1 col), Tablet 768–1024 px (2 col), Desktop > 1024 px (3–4 col) |
| **Accessibility** | WCAG AA contrast; ARIA labels ≥ 95 % coverage; full keyboard navigation |

---

## Part 4: Component Dependency Graph

```
                 ┌──────────────────────────────┐
                 │     authentication / RBAC     │
                 └──────────┬───────────────────┘
                            │
          ┌─────────────────┼─────────────────┐
          ▼                 ▼                  ▼
   ┌────────────┐   ┌──────────────┐   ┌──────────────┐
   │  audit_log │   │ file_upload  │   │    modal /   │
   │            │   │   / export   │   │   skeleton   │
   └─────┬──────┘   └──────┬───────┘   └──────┬───────┘
         │                 │                   │
         └────────────┬────┘───────────────────┘
                      ▼
            ┌──────────────────┐
            │ logistics_records │  ← Main entity (central)
            └────────┬─────────┘
                     │
           ┌─────────┼─────────────┐
           ▼         ▼             ▼
   ┌───────────┐ ┌────────┐ ┌───────────┐
   │ logistics │ │ custom │ │   daily   │
   │  details  │ │  decl.  │ │ delivery  │
   └───────────┘ └────────┘ └───────────┘
           ┌───────────┐ ┌──────────┐ ┌───────────┐
           │container  │ │internat.│ │ traffic   │
           │ tracking  │ │shipping │ │ mgmt     │
           └───────────┘ └─────────┘ └───────────┘
           ┌────────────┐ ┌────────────┐
           │site plan.  │ │ material   │
           │            │ │ flow       │
           └────────────┘ └────────────┘
```

---

## Part 5: Quality Assurance Integration

### 5.1 Automated Visual Testing

- **Visual regression baselines** stored per component in `logistics-baseline-{component}.png`
- **Layout validation** within ±2 px tolerance using `getBoundingClientRect()`
- **Accessibility automation**: Axe-core CI run blocking on violations above severity `moderate`

### 5.2 Performance Budgets

| Metric | Threshold |
|--------|-----------|
| First Contentful Paint | < 2000 ms |
| Largest Contentful Paint | < 3000 ms |
| Cumulative Layout Shift | < 0.1 |
| Button click response | < 100 ms |
| Modal open animation | < 300 ms |
| API response (p95) | < 2000 ms |

---

## Metadata

- **Agent**: KnowledgeForge AI — Discipline Automation Agent
- **Platform**: Logistics Platform (shared across disciplines)
- **Knowledge Type**: PAGE-KNOWLEDGE — Component Registry + Architecture
- **Last Reviewed**: 2026-04-10
- **Version**: 1.0
- **Related Skills**:
  - logistics-knowledgeforge
  - logistics-knowledgeforge-logistics

---

## Appendices

### Appendix A: API Endpoint Summary

| Component | List | Create | Get | Update | Delete | Submit |
|-----------|------|--------|-----|--------|--------|--------|
| ContainerTracking | ✅ | ✅ | ✅ | ✅ | ✅ | — |
| CustomsManagement | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| DailyDelivery | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| DocumentGeneration | ✅ | ✅ | ✅ | ✅ | ✅ | — |
| InternationalShipping | ✅ | ✅ | ✅ | ✅ | ✅ | — |
| SitePlanning | ✅ | ✅ | ✅ | ✅ | ✅ | — |
| TrafficManagement | ✅ | ✅ | ✅ | ✅ | ✅ | — |
| MaterialFlow | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| logistics_records | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

### Appendix B: Logistics Record Number Format

**Format**: `01700-{YYYY}-{NNNNN}`
- YYYY: 4-digit year
- NNNNN: 5-digit sequential number (padded with zeros)

**Examples**:
- `01700-2026-00001` (first logistics record of 2026)
- `01700-2026-01234` (1234th logistics record of 2026)

### Appendix C: Common Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| 0170 | Logistics |
| REC | Record |
| CTN | Container |
| CUS | Customs |
| DLV | Delivery |
| DOC | Document |
| INT | International |
| SIT | Site |
| TRA | Traffic |
| MAT | Material |

---

**Document Version**: 1.0
**Last Updated**: 2026-04-10
**Applicable To**: Logistics Platform Agents
**Author**: KnowledgeForge AI — Discipline Automation Agent (Phase 1b)

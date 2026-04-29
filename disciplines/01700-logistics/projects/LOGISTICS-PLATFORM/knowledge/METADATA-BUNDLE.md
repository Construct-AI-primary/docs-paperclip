---
title: "LOGISTICS-PLATFORM-000 — Metadata Bundle"
description: "Complete metadata bundle for the Logistics Platform project, compiling all 8-field component metadata, discipline configurations, CAD systems, and database tables."
author: "PromptForge AI — Discipline Automation Agent"
date: "2026-04-29"
version: "1.0"
---

# LOGISTICS-PLATFORM-000 — Metadata Bundle

## Project

| Field | Value |
|-------|-------|
| project_id | LOGISTICS-PLATFORM-000 |
| name | Logistics Platform |
| discipline | 01700-logistics |
| status | planned |
| pilot_issue | LOGISTICS-PLATFORM-001 |

## Disciplines

| Code | Name | Standards | CAD Systems | Analysis Types | Pilot Status | Pilot Issue |
|------|------|-----------|-------------|----------------|--------------|-------------|
| 01700 | Logistics | ISO 28000, TAPA FSR, GS1 | Supply Chain Mapping, Route Optimization | Route Analysis, Load Optimization, Customs Compliance | pending | LOGISTICS-PLATFORM-001 |

## Shared Components

| component_id | file_path | description | disciplines | qc_checklist |
|-------------|-----------|-------------|-------------|--------------|
| ContainerTracking | planned | Container tracking and monitoring | 01700 | [5 items] |
| CustomsManagement | planned | Customs documentation and compliance | 01700 | [5 items] |
| DailyDelivery | planned | Daily delivery scheduling and routing | 01700 | [5 items] |
| DocumentGeneration | planned | Logistics document generation | 01700 | [5 items] |
| InternationalShipping | planned | International shipping management | 01700 | [5 items] |
| SitePlanning | planned | Site logistics planning | 01700 | [5 items] |
| TrafficManagement | planned | Traffic and fleet management | 01700 | [5 items] |
| MaterialFlow | planned | Material flow tracking | 01700 | [5 items] |

## CAD Systems

| system_id | name | disciplines | file_types | integration_status |
|-----------|------|-------------|------------|-------------------|
| scm-tools | Supply Chain Mapping Tools | 01700 | .gpx, .kml, .geojson | planned |
| route-opt | Route Optimization Systems | 01700 | .json, .csv, .xml | planned |
| wms | Warehouse Management Systems | 01700 | .xml, .edi, .csv | planned |
| tms | Transportation Management Systems | 01700 | .json, .edi, .csv | planned |

## Database Tables

| table | columns | indexes |
|-------|---------|---------|
| logistics_records | id, logistics_id, status, description, created_at, updated_at, created_by, company_id | idx_logistics_records_logistics_id, idx_logistics_records_status, idx_logistics_records_company_id |
| logistics_details | name, value, status, created_at, updated_at | idx_logistics_details_name |
| audit_log | id, timestamp, user_id, event_type, resource_type, resource_id, action, old_values, new_values | idx_audit_log_timestamp, idx_audit_log_user_id |

## Summary

| Metric | Count |
|--------|-------|
| Components | 8 |
| Disciplines | 1 |
| CAD Systems | 4 |
| Phases | 3 |
| Issues (estimated) | 17 |
| Companies | 6 |
| Agents | 12 |
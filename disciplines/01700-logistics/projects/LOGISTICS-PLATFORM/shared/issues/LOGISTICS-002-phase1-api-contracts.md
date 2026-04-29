---
id: LOGISTICS-002
title: 01700 Define OpenAPI contracts for shared logistics services
description: Create OpenAPI 3.0 specifications for the shared logistics API layer covering shipment CRUD, delivery scheduling, customs document submission, document generation, site queries, traffic events, and material transactions
labels: ["logistics", "api", "1 — Foundation"]
blocked_by: []
depends_on: ["LOGISTICS-001"]
para_section: logistics/projects/LOGISTICS-PLATFORM/desktop/issues
phase: 1 — Foundation
status: todo
priority: Critical
story_points: 8
due_date: "2026-05-12"
assignee: interface-devforge
company: devforge-ai
delegation:
  parent_goal_id: "LOGISTICS-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Define API contracts that all 8 logistics modules implement"
  agent_goal: "As interface-devforge, create comprehensive OpenAPI specs for logistics services"
  task_goal: "Produce validated OpenAPI 3.0 specs covering all logistics endpoints"
---

# LOGISTICS-002: 01700 Define OpenAPI contracts for shared logistics services

## Executive Summary

This issue creates the API contract layer for the logistics platform. All 8 logistics modules (ContainerTracking, CustomsManagement, DailyDelivery, DocumentGeneration, InternationalShipping, SitePlanning, TrafficManagement, MaterialFlow) will implement these shared API contracts. The specification follows PAGE-KNOWLEDGE §2.1–2.2 architecture with RESTful design, Zod validation schemas, and consistent error handling patterns.

## Problem Statement / Scope

Before any backend implementation begins, the API contracts must be defined. All logistics modules need consistent request/response schemas, authentication patterns, pagination standards, and error handling. This issue covers OpenAPI 3.0 specs for: logistics records CRUD, delivery scheduling, customs document submission, document generation requests, site queries, traffic events, and material transactions. Cross-reference `docs-construct-ai/disciplines/01700_logistics/agent-data/01700_API_SPEC.md` for existing API endpoint definitions.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 2A | Define base URL, auth scheme (Bearer JWT), common headers, error response format | OpenAPI base spec finalized |
| 2B | Create logistics_records CRUD endpoints (`GET/POST/PUT/DELETE /api/logistics/records`) | All CRUD operations defined |
| 2C | Create logistics_details endpoints with status workflow transitions | Status workflow endpoints defined |
| 2D | Define pagination, sorting, filtering query parameter standards | Pagination spec finalized |
| 2E | Create Zod validation schemas for all request bodies | Zod schemas validated |
| 2F | Define rate limiting strategy per endpoint group | Rate limit spec documented |
| 2G | Validate all specs against OpenAPI 3.0 validator | 100% spec validation pass rate |

## Primary Users & Actions

- **Logistics Admin**: Create/manage logistics records, approve workflows
- **Dispatcher**: Schedule deliveries, assign drivers, update tracking
- **Customs Agent**: Submit customs documents, track clearance status
- **Site Manager**: Manage site logistics, traffic events, material receipts
- **Driver**: Update delivery status, capture proof of delivery

## Acceptance Criteria

- [ ] OpenAPI 3.0 YAML spec covers all logistics CRUD endpoints
- [ ] Authentication via Bearer JWT defined with role-based access
- [ ] Pagination standard: `page`, `page_size`, `sort_by`, `sort_order`, `filters`
- [ ] Error response format: `{error: {code, message, details}}` for 400/401/403/404/409/422
- [ ] Zod validation schemas defined for all request/response bodies
- [ ] Rate limiting: 100 req/min per user, 1000 req/min per company
- [ ] All specs pass OpenAPI 3.0 validation (no warnings)
- [ ] Cross-reference `01700_API_SPEC.md` from docs-construct-ai for schema alignment

## Dependencies

- **Blocked by:** None
- **Depends on:** LOGISTICS-001 (table schema informs API field definitions)
- **Blocks:** LOGISTICS-005, LOGISTICS-006, LOGISTICS-007, LOGISTICS-008, LOGISTICS-009, LOGISTICS-011, LOGISTICS-012, LOGISTICS-013, LOGISTICS-014
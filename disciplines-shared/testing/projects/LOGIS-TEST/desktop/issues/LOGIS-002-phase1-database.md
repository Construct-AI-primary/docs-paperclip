---
id: LOGIS-002
title: 01700 Database & API Connectivity
description: Verify Supabase database connectivity, schema integrity, CRUD operations, and hnsw index availability for all 01700 logistics tables
labels: ["testing", "logistics", "1 — Foundation", "database"]
blocked_by: []
depends_on: []
para_section: testing/projects/LOGIS-TEST/desktop/issues
phase: 1 — Foundation
status: todo
priority: Critical
story_points: 3
due_date: "2026-05-01"
assignee: database-infraforge
company: infraforge-ai
delegation:
  parent_goal_id: "QC-ROOT-LOGIS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify all database schemas, indexes, and connectivity for 01700 logistics tables."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01700 logistics page production readiness"
  agent_goal: "As database-infraforge, verify Supabase connectivity, schema integrity, CRUD operations, and hnsw index availability for all 01700 logistics tables"
  task_goal: "Execute database connectivity tests with 100% pass rate"
---

# LOGIS-002: 01700 Database & API Connectivity

## Executive Summary

This issue validates the database layer for the 01700 logistics page. All 5 Supabase tables must be accessible, have correct schemas, support CRUD operations, and have required indexes. A failure here blocks all data-dependent testing in Phases 2-4.

## Problem Statement / Scope

The 01700 logistics page relies on 5 Supabase tables: `logistics_freight`, `logistics_customs`, `logistics_fleet`, `suppliers`, and `vectors`. Each table must have the correct schema, support CRUD operations, and have appropriate indexes (including hnsw for vector operations). This issue covers only database connectivity and schema validation — no application-level testing.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 2A | Supabase connection | Connection to Supabase project succeeds |
| 2B | logistics_freight schema | Table exists with columns: id, shipment_id, origin, destination, carrier, mode, weight_kg, status, created_at, updated_at |
| 2C | logistics_customs schema | Table exists with columns: id, declaration_id, shipment_id, clearance_status, duty_amount, documents, customs_officer, cleared_at |
| 2D | logistics_fleet schema | Table exists with columns: id, vehicle_id, driver, route, status, last_gps_lat, last_gps_lng, fuel_level, maintenance_due, created_at |
| 2E | suppliers schema | Table exists with columns: id, name, type, contact, status, rating |
| 2F | vectors schema | Table exists with columns: id, embedding, metadata, discipline |
| 2G | CRUD operations | Insert, select, update, delete work on each table |
| 2H | hnsw index | vectors table has hnsw index on embedding column |

## Acceptance Criteria

- [ ] Supabase connection established successfully
- [ ] logistics_freight table exists with correct schema
- [ ] logistics_customs table exists with correct schema
- [ ] logistics_fleet table exists with correct schema
- [ ] suppliers table exists with correct schema
- [ ] vectors table exists with correct schema
- [ ] CRUD operations succeed on all tables
- [ ] hnsw index exists on vectors.embedding
- [ ] Row-level security policies are configured

## Dependencies

- **Blocked by:** None
- **Depends on:** None
- **Blocks:** LOGIS-003, LOGIS-004, LOGIS-005, LOGIS-009, LOGIS-010, LOGIS-011

## Estimated Duration

30 minutes

## Risk Level

**Critical** — blocks all data-dependent testing.

## QC Team Checks

- [ ] **logistics_freight:** Verify all columns match PAGE-KNOWLEDGE schema
- [ ] **logistics_customs:** Verify all columns match PAGE-KNOWLEDGE schema
- [ ] **logistics_fleet:** Verify all columns match PAGE-KNOWLEDGE schema
- [ ] **suppliers:** Verify all columns match PAGE-KNOWLEDGE schema
- [ ] **vectors:** Verify hnsw index exists and is functional
- [ ] **CRUD:** Test insert, select, update, delete on each table
- [ ] **RLS:** Verify row-level security policies are active

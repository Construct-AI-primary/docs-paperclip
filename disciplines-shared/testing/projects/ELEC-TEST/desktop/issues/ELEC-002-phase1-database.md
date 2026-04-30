---
id: ELEC-002
title: 00860 Database & API Connectivity — Schema Validation
description: Verify all 4 supabase tables are accessible and schemas match documented columns
labels: ["testing", "electrical-engineering", "1 — Foundation"]
blocked_by: []
depends_on: []
para_section: testing/projects/ELEC-TEST/desktop/issues
phase: 1 — Foundation
status: todo
priority: Critical
story_points: 5
due_date: "2026-05-01"
assignee: database-infraforge
company: infraforge-ai
delegation:
  parent_goal_id: "QC-ROOT-ELECTRICAL-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 00860 electrical engineering page production readiness"
  agent_goal: "As database-infraforge, verify all 4 supabase tables are accessible and schemas match documented columns"
  task_goal: "Execute database connectivity, schema validation, CRUD operations with 100% pass rate"
---

# ELEC-002: 00860 Database & API Connectivity — Schema Validation

## Executive Summary

This issue validates the database and API connectivity layer for the 00860 electrical engineering page. All four Supabase tables must be accessible, their schemas must match the documented column definitions, and basic CRUD operations must succeed. The presence of the required hnsw index on the vectors table is also verified. A failure here blocks all data-dependent testing in Phases 2 and 3.

## Problem Statement / Scope

The 00860 page relies on four Supabase tables: vectors, electrical_calculations, cable_schedules, and protection_studies. Before any modal form submission, chatbot query, or workflow execution can be tested, the database layer must be confirmed operational. This issue covers connectivity, schema conformance, CRUD viability, and index presence. No application-layer or UI testing is included.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 2A | Supabase connection test | Establish connection to Supabase project; return success status |
| 2B | Schema validation — electrical_calculations | All columns present and types match documented spec |
| 2B | Schema validation — cable_schedules | All columns present and types match documented spec |
| 2B | Schema validation — protection_studies | All columns present and types match documented spec |
| 2B | Schema validation — vectors | All columns present and types match documented spec |
| 2C | CRUD operations on each table | Insert, select, update, delete succeed on all 4 tables |
| 2D | hnsw index verification | hnsw index exists on vectors table for vector similarity search |

## Assigned Company & Agent

- **Company:** infraforge-ai
- **Agent:** database-infraforge
- **Sub-agents:** None

## Required Skills

- database-administration
- api-testing

## Acceptance Criteria

- [ ] Supabase connection succeeds with valid credentials
- [ ] `electrical_calculations` table: all documented columns present with correct types
- [ ] `cable_schedules` table: all documented columns present with correct types
- [ ] `protection_studies` table: all documented columns present with correct types
- [ ] `vectors` table: all documented columns present with correct types
- [ ] INSERT operation succeeds on each table
- [ ] SELECT operation returns inserted row on each table
- [ ] UPDATE operation modifies row on each table
- [ ] DELETE operation removes row on each table
- [ ] hnsw index exists on `vectors` table

## Dependencies

- **Blocked by:** None
- **Depends on:** None
- **Blocks:** ELEC-003, ELEC-004, ELEC-005, ELEC-006, ELEC-007, ELEC-008

## Estimated Duration

30 minutes

## Risk Level

**Critical** — blocks all data-dependent testing. Without verified database connectivity, no modal submission, chatbot query, or workflow test can succeed.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 00860 page:

- [ ] **All 4 tables accessible:** Confirm `vectors`, `electrical_calculations`, `cable_schedules`, `protection_studies` return rows or empty set without error
- [ ] **Column types match spec:** For each table, verify column names and data types match the documented schema definition
- [ ] **hnsw index present:** Query `pg_indexes` to confirm hnsw index exists on `vectors` table for the embedding column
- [ ] **CRUD operations succeed:** Execute one full CRUD cycle per table; verify each operation returns success
- [ ] **RLS policies:** Confirm Row-Level Security policies are active on each table (if applicable)
- [ ] **API endpoint reachable:** Confirm Supabase API endpoint responds within acceptable latency (< 500ms)

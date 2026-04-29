---
id: LOGISTICS-003
title: 01700 Implement core authentication and authorization for logistics platform
description: Set up Supabase Auth with organization-based multi-tenancy, define role-based access for logistics admin, dispatcher, driver, customs agent, site manager, and viewer roles
labels: ["logistics", "auth", "1 — Foundation"]
blocked_by: []
depends_on: ["LOGISTICS-001"]
para_section: logistics/projects/LOGISTICS-PLATFORM/desktop/issues
phase: 1 — Foundation
status: todo
priority: Critical
story_points: 8
due_date: "2026-05-14"
assignee: database-infraforge
company: infraforge-ai
delegation:
  parent_goal_id: "LOGISTICS-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Secure the logistics platform with role-based access control"
  agent_goal: "As database-infraforge, implement Supabase Auth with RLS and role-based access"
  task_goal: "Deploy working authentication and authorization for all 6 logistics roles"
---

# LOGISTICS-003: 01700 Implement core authentication and authorization for logistics platform

## Executive Summary

This issue implements the authentication and authorization layer for the logistics platform. Following PAGE-KNOWLEDGE §3.1 security architecture, this covers: Supabase Auth integration with organization-based multi-tenancy, RLS policies for all logistics tables, and role-based access for 6 logistics roles (logistics admin, dispatcher, driver, customs agent, site manager, viewer).

## Problem Statement / Scope

Before any logistics feature can be accessed, the authentication and authorization layer must be in place. Different logistics roles need different permissions: dispatchers schedule deliveries, drivers update delivery status, customs agents submit documents, site managers manage site logistics, and logistics admins have full control. This issue covers auth setup, role definitions, RLS policy implementation, and API middleware. Cross-reference `docs-construct-ai/disciplines/01700_logistics/agent-data/01700_SECURITY.md` for existing security patterns.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 3A | Configure Supabase Auth with email/password + SSO | Auth provider configured |
| 3B | Create roles table: logistics_admin, dispatcher, driver, customs_agent, site_manager, viewer | Role table seeded |
| 3C | Implement RLS policies on logistics_records per role | RLS enforced on read/write |
| 3D | Implement RLS policies on logistics_details per role | RLS enforced on status transitions |
| 3E | Create auth middleware for API endpoint protection | All endpoints require valid JWT |
| 3F | Test role isolation (viewer cannot write, driver cannot manage customs) | All role boundaries verified |

## Acceptance Criteria

- [ ] Supabase Auth configured with email/password sign-up and SSO
- [ ] 6 logistics roles defined and seeded in agent_roles table
- [ ] RLS on logistics_records: admin=CRUD, dispatcher=CRUD, driver=read+update_status, customs_agent=read+update_customs, site_manager=CRUD_site, viewer=read
- [ ] RLS on logistics_details: status transitions restricted by role
- [ ] API middleware validates JWT on every request
- [ ] Role isolation tests pass: no role can perform operations outside its permissions
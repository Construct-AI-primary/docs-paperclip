---
id: ELEC-001
title: 00860 Page Foundation — Login, Navigation & Logout
description: Verify all page foundation components (auth, nav container, state buttons, logout) render and function correctly
labels: ["testing", "electrical-engineering", "1 — Foundation"]
blocked_by: []
depends_on: []
para_section: testing/projects/ELEC-TEST/desktop/issues
phase: 1 — Foundation
status: todo
priority: Critical
story_points: 3
due_date: "2026-05-01"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-ELECTRICAL-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 00860 electrical engineering page production readiness"
  agent_goal: "As validator-qualityforge, verify all page foundation components (auth, nav container, state buttons, logout) render and function correctly"
  task_goal: "Execute page load validation, state button verification, logout test with 100% pass rate"
---

# ELEC-001: 00860 Page Foundation — Login, Navigation & Logout

## Executive Summary

This issue validates the foundational layer of the 00860 electrical engineering page. Successful completion of all checks is a prerequisite for every subsequent test in the ELEC-TEST suite. The foundation covers authentication flow, navigation container rendering, state button presence, logout functionality, and background image loading. A failure here blocks all Phase 2 and Phase 3 testing.

## Problem Statement / Scope

The 00860 page is the primary electrical engineering interface. Before any modal, chatbot, or workflow testing can proceed, the page must load securely, render its navigation container in the correct position, display all three state buttons (Agents, Upserts, Workspace), provide a working logout mechanism, and load the background image asset. This issue covers only the static and auth-layer components — no modal or data-layer testing is included.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1A | Page load and authentication | Page loads over HTTPS; user is redirected to auth if unauthenticated; session token is present |
| 1B | Navigation container verification | Nav container renders at fixed bottom center of viewport |
| 1C | State button rendering | Exactly 3 state buttons (Agents, Upserts, Workspace) are visible and clickable |
| 1D | Logout functionality | Logout SVG icon is present; clicking logout terminates session and redirects to login |
| 1E | Background image load | Background image asset loads without 404; CSS `background-image` property is applied (or gradient fallback) |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** None

## Required Skills

- quality-assurance
- systematic-testing
- ui-validation

## Acceptance Criteria

- [ ] Page loads over HTTPS with valid session
- [ ] Unauthenticated users are redirected to login
- [ ] Navigation container is fixed at bottom center of viewport
- [ ] Exactly 3 state buttons render: Agents, Upserts, Workspace
- [ ] Each state button is clickable and responds with visual feedback
- [ ] Logout SVG icon is present in the navigation container
- [ ] Clicking logout terminates the session
- [ ] Post-logout redirect lands on the login page
- [ ] Background image loads successfully (HTTP 200) or gradient fallback renders
- [ ] CSS class naming follows `A-00860-*` convention

## Dependencies

- **Blocked by:** None
- **Depends on:** None
- **Blocks:** ELEC-003, ELEC-004, ELEC-005, ELEC-006, ELEC-007, ELEC-008

## Estimated Duration

30 minutes

## Risk Level

**Critical** — blocks all subsequent testing. A failure in any foundation component halts the entire ELEC-TEST pipeline.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 00860 page:

- [ ] **State buttons:** Verify exactly 3 state buttons render (Agents, Upserts, Workspace)
- [ ] **Nav container position:** Confirm `position: fixed; bottom: 0; left: 50%; transform: translateX(-50%)` or equivalent centering
- [ ] **Logout SVG:** Confirm logout SVG element is present with correct `viewBox` and `path` attributes
- [ ] **Background image:** Confirm `background-image` CSS property resolves to a valid image URL or gradient; verify no 404 in network tab
- [ ] **CSS class naming:** All page-level elements use `A-00860-*` class prefix convention
- [ ] **Auth redirect:** Confirm unauthenticated requests redirect to `/login` or configured auth endpoint
- [ ] **Session token:** Confirm `localStorage` or cookie contains a valid session/JWT token after login

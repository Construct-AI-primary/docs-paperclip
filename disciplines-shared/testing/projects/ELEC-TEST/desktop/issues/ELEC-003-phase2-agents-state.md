---
id: ELEC-003
title: 00860 Agents State — Load Calculation, Cable Sizing & Protection Coordination
description: Verify Agents state button and all 3 associated modals (Load Calculation, Cable Sizing, Protection Coordination) open, validate, and submit correctly
labels: ["testing", "electrical-engineering", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["ELEC-001", "ELEC-002"]
para_section: testing/projects/ELEC-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: todo
priority: High
story_points: 8
due_date: "2026-05-02"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-ELECTRICAL-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 00860 electrical engineering page production readiness"
  agent_goal: "As validator-qualityforge, verify Agents state button and all 3 associated modals (Load Calculation, Cable Sizing, Protection Coordination) open, validate, and submit correctly"
  task_goal: "Execute modal open/close, form validation, data persistence for all 3 agents modals with >95% pass rate"
---

# ELEC-003: 00860 Agents State — Load Calculation, Cable Sizing & Protection Coordination

## Executive Summary

This issue validates the Agents state button and its three associated modals: Load Calculation, Cable Sizing, and Protection Coordination. The Agents state is the first of three page states and controls the core electrical engineering calculation workflows. All modal open/close behavior, form field validation, data submission, and persistence must be verified. A pass rate above 95% is required.

## Problem Statement / Scope

When the user clicks the Agents state button, the page must transition to the Agents state, displaying three buttons in alphabetical order: Cable Sizing, Load Calculation, and Protection Coordination. Each button opens a distinct modal with specific form fields, validation rules, and submission targets. This issue covers the full lifecycle of all three modals: rendering, interaction, validation, submission, and data persistence to the database. Each modal targets a different supabase table (electrical_calculations, cable_schedules, protection_studies).

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 3A | Agents button click sets correct state | Clicking Agents button highlights it; page state transitions to Agents; 3 buttons render in alphabetical order |
| 3B | Load Calculation modal open/close | Clicking Load Calculation opens modal; close button / backdrop click dismisses modal |
| 3C | Cable Sizing modal open/close | Clicking Cable Sizing opens modal; close button / backdrop click dismisses modal |
| 3D | Protection Coordination modal open/close | Clicking Protection Coordination opens modal; close button / backdrop click dismisses modal |
| 3E | Form field validation | All required fields enforce validation; invalid input shows error messages; valid input enables submit |
| 3F | Submission persistence | Submitted data persists in the corresponding database table; confirmation message displayed |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** None

## Required Skills

- quality-assurance
- ui-validation
- form-testing

## Acceptance Criteria

- [ ] Agents state button renders and is clickable
- [ ] Clicking Agents button highlights it and transitions page state
- [ ] Exactly 3 buttons render in Agents state: Cable Sizing, Load Calculation, Protection Coordination
- [ ] Buttons are sorted alphabetically
- [ ] LoadCalculationModal opens on button click
- [ ] LoadCalculationModal closes via close button and backdrop click
- [ ] Load calculation form fields match electrical_calculations table schema
- [ ] CableSizingModal opens on button click
- [ ] CableSizingModal closes via close button and backdrop click
- [ ] Cable sizing form fields match cable_schedules table schema
- [ ] ProtectionCoordinationModal opens on button click
- [ ] ProtectionCoordinationModal closes via close button and backdrop click
- [ ] Protection study form fields match protection_studies table schema
- [ ] Required field validation shows error messages for empty required fields
- [ ] Valid form submission succeeds
- [ ] Submitted data persists in the database
- [ ] Confirmation message displays after successful submission
- [ ] Modal closes after successful submission

## Dependencies

- **Blocked by:** ELEC-001 (page foundation), ELEC-002 (database connectivity)
- **Depends on:** ELEC-001, ELEC-002
- **Blocks:** None

## Estimated Duration

60 minutes

## Risk Level

**High** — Agents state is the primary electrical engineering interaction point. Failures here directly impact user ability to perform load calculations, cable sizing, and protection coordination.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 00860 page:

- [ ] **3 buttons render in Agents state:** Confirm exactly three buttons appear: Cable Sizing, Load Calculation, Protection Coordination
- [ ] **Alphabetical sort correct:** Verify buttons are sorted A-Z (Cable Sizing before Load Calculation before Protection Coordination)
- [ ] **LoadCalculationModal opens:** Confirm modal renders with correct title and form fields
- [ ] **CableSizingModal opens:** Confirm modal renders with cable sizing form fields
- [ ] **ProtectionCoordinationModal opens:** Confirm modal renders with protection study form fields
- [ ] **Form fields match schema:** Verify each form field maps to a column in respective table
- [ ] **Data persists:** After submission, query the database to confirm the row was inserted
- [ ] **Modal closes:** Confirm modal dismisses after successful submission

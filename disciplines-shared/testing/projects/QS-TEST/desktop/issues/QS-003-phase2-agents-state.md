---
id: QS-003
title: 02025 Agents State — BOQ Creation & Measurement Validation
description: Verify Agents state button and both associated modals (BOQ Creation, Measurement Validation) open, validate, and submit correctly
labels: ["testing", "quantity-surveying", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["QS-001", "QS-002"]
para_section: testing/projects/QS-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: todo
priority: High
story_points: 5
due_date: "2026-05-02"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-QS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02025 quantity surveying page production readiness"
  agent_goal: "As validator-qualityforge, verify Agents state button and both associated modals (BOQ Creation, Measurement Validation) open, validate, and submit correctly"
  task_goal: "Execute modal open/close, form validation, data persistence for both agents modals with >95% pass rate"
---

# QS-003: 02025 Agents State — BOQ Creation & Measurement Validation

## Executive Summary

This issue validates the Agents state button and its two associated modals: BOQ Creation and Measurement Validation. The Agents state is the first of three page states and controls the Bill of Quantities entry and measurement validation workflows. All modal open/close behavior, form field validation, data submission, and persistence must be verified. A pass rate above 95% is required.

## Problem Statement / Scope

When the user clicks the Agents state button, the page must transition to the Agents state, displaying two buttons in alphabetical order: BOQ Creation and Measurement Validation. Each button opens a distinct modal with specific form fields, validation rules, and submission targets. This issue covers the full lifecycle of both modals: rendering, interaction, validation, submission, and data persistence to the database. The BOQ Creation modal fields must match the quantity_surveying_boq table schema, and the Measurement Validation modal must handle dimension calculations correctly.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 3A | Agents button click sets correct state | Clicking Agents button highlights it; page state transitions to Agents; 2 buttons render in alphabetical order |
| 3B | BOQ Creation modal open/close | Clicking BOQ Creation opens modal; close button / backdrop click dismisses modal |
| 3C | Measurement Validation modal open/close | Clicking Measurement Validation opens modal; close button / backdrop click dismisses modal |
| 3D | Form field validation | All required fields enforce validation; invalid input shows error messages; valid input enables submit |
| 3E | Submission persistence | Submitted data persists in the corresponding database table; confirmation message displayed |

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
- [ ] Exactly 2 buttons render in Agents state: BOQ Creation, Measurement Validation
- [ ] Buttons are sorted alphabetically
- [ ] BOQCreationModal opens on button click
- [ ] BOQCreationModal closes via close button and backdrop click
- [ ] BOQ form fields match quantity_surveying_boq table schema
- [ ] MeasurementValidationModal opens on button click
- [ ] MeasurementValidationModal closes via close button and backdrop click
- [ ] Measurement form fields match quantity_surveying_measurements table schema
- [ ] Required field validation shows error messages for empty required fields
- [ ] Valid form submission succeeds
- [ ] Submitted data persists in the database
- [ ] Confirmation message displays after successful submission
- [ ] Modal closes after successful submission

## Dependencies

- **Blocked by:** QS-001 (page foundation), QS-002 (database connectivity)
- **Depends on:** QS-001, QS-002
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**High** — Agents state is the primary quantity surveying interaction point. Failures here directly impact user ability to create BOQ items and validate measurements.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 02025 page:

- [ ] **2 buttons render in Agents state:** Confirm exactly two buttons appear: BOQ Creation and Measurement Validation
- [ ] **Alphabetical sort correct:** Verify buttons are sorted A-Z (BOQ Creation before Measurement Validation)
- [ ] **BOQCreationModal opens:** Confirm modal renders with correct title and form fields
- [ ] **BOQ form fields match schema:** Verify each form field maps to a column in `quantity_surveying_boq` table
- [ ] **MeasurementValidationModal opens:** Confirm modal renders with measurement form fields
- [ ] **Dimension calculations validate:** Verify dimension input produces correct calculated quantity
- [ ] **Data persists:** After submission, query the database to confirm the row was inserted
- [ ] **Modal closes:** Confirm modal dismisses after successful submission

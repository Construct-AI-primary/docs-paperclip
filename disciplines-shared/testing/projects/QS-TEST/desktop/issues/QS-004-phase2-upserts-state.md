---
id: QS-004
title: 02025 Upserts State — Cloud, URL & File Upserts
description: Verify Upserts state button and all three associated modals (Cloud, URL, File) open, validate, and submit correctly
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
  allowed_sub_assignees: ["database-infraforge"]
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02025 quantity surveying page production readiness"
  agent_goal: "As validator-qualityforge, verify Upserts state button and all three associated modals (Cloud, URL, File) open, validate, and submit correctly"
  task_goal: "Execute upsert modal validation including data persistence checks with >95% pass rate"
---

# QS-004: 02025 Upserts State — Cloud, URL & File Upserts

## Executive Summary

This issue validates the Upserts state button and its three associated modals: Cloud Upsert, URL Upsert, and File Upsert. The Upserts state controls data ingestion into the system from three different sources. All modal open/close behavior, upload/input validation, data submission to the vectors store, and error handling must be verified. A pass rate above 95% is required.

## Problem Statement / Scope

When the user clicks the Upserts state button, the page must transition to the Upserts state, displaying three buttons in alphabetical order: Cloud Upsert, URL Upsert, and File Upsert. Each button opens a distinct modal with specific input types. The Cloud Upsert modal writes directly to the vectors table, the URL Upsert fetches external data before inserting, and the File Upsert parses uploaded documents before insertion. This issue covers the full lifecycle of all three upsert modals.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 4A | Upserts button click sets correct state | Clicking Upserts button highlights it; page state transitions to Upserts; 3 buttons render in alphabetical order |
| 4B | Cloud Upsert modal open/close | Clicking Cloud Upsert opens modal; close button / backdrop click dismisses modal |
| 4C | URL Upsert modal open/close | Clicking URL Upsert opens modal; close button / backdrop click dismisses modal |
| 4D | File Upsert modal open/close | Clicking File Upsert opens modal; close button / backdrop click dismisses modal |
| 4E | Data submission and persistence | Submitted data persists in vectors table; error handling for malformed data |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** database-infraforge (for DB-level verification)

## Required Skills

- quality-assurance
- ui-validation
- data-ingestion-testing

## Acceptance Criteria

- [ ] Upserts state button renders and is clickable
- [ ] Clicking Upserts button highlights it and transitions page state
- [ ] Exactly 3 buttons render in Upserts state: Cloud Upsert, URL Upsert, File Upsert
- [ ] Buttons are sorted alphabetically
- [ ] 02025-UpsertCloudModal opens on button click
- [ ] 02025-UpsertCloudModal closes via close button and backdrop click
- [ ] 02025-UpsertUrlModal opens on button click
- [ ] 02025-UpsertUrlModal closes via close button and backdrop click
- [ ] 02025-UpsertFileModal opens on button click
- [ ] 02025-UpsertFileModal closes via close button and backdrop click
- [ ] Cloud data insertion to vectors table succeeds
- [ ] URL fetch operation succeeds and data inserts
- [ ] File upload and parse succeeds and data inserts
- [ ] Error handling displays appropriate messages for malformed data
- [ ] Confirmation message displays after successful submission

## Dependencies

- **Blocked by:** QS-001 (page foundation), QS-002 (database connectivity)
- **Depends on:** QS-001, QS-002
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**High** — Upserts state controls all data ingestion. Failures here impact the system's ability to accept new data from any source.

## QC Team Checks

- [ ] **3 buttons render in Upserts state:** Confirm Cloud Upsert, URL Upsert, File Upsert
- [ ] **Alphabetical sort correct:** Cloud before URL before File
- [ ] **Cloud data insert:** Verify data written to vectors table successfully
- [ ] **URL fetch + insert:** Verify URL fetched and parsed data inserted
- [ ] **File parse + insert:** Verify uploaded file parsed and inserted
- [ ] **Error handling:** Test with invalid data formats

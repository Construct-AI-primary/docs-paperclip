---
id: ELEC-004
title: 00860 Upserts State — Cloud, URL & File Upserts
description: Verify Upserts state button and all 3 associated modals (Cloud, URL, File) open, validate, and submit data to vector store correctly
labels: ["testing", "electrical-engineering", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["ELEC-001", "ELEC-002"]
para_section: testing/projects/ELEC-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: todo
priority: High
story_points: 5
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
  agent_goal: "As validator-qualityforge, verify Upserts state button and all 3 associated modals (Cloud, URL, File) open, validate, and submit data to vector store correctly"
  task_goal: "Execute modal open/close, data validation, vector store persistence for all 3 upsert modals with >95% pass rate"
---

# ELEC-004: 00860 Upserts State — Cloud, URL & File Upserts

## Executive Summary

This issue validates the Upserts state button and its three associated modals: Cloud Upsert, Upsert from URL, and Upsert Files. The Upserts state enables users to upload electrical engineering documents and data into the vector store for AI-powered retrieval. All modal open/close behavior, file handling, data validation, and vector persistence must be verified.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 4A | Upserts button click sets correct state | Clicking Upserts button highlights it; page state transitions to Upserts; 3 buttons render |
| 4B | Cloud Upsert modal open/close | Clicking Cloud Upsert opens modal; close button dismisses; data insertion to vectors succeeds |
| 4C | Upsert from URL modal open/close | Clicking Upsert URL opens modal; URL fetch succeeds; data inserts to vectors |
| 4D | Upsert Files modal open/close | Clicking Upsert Files opens modal; file upload and parse succeeds; data inserts to vectors |
| 4E | Error handling | Malformed data shows error; network failures show appropriate message |

## Acceptance Criteria

- [ ] Upserts state button renders and is clickable
- [ ] Exactly 3 buttons render in Upserts state
- [ ] Cloud Upsert modal opens and closes correctly
- [ ] Data insertion to vectors table succeeds from cloud upsert
- [ ] Upsert from URL modal opens and closes correctly
- [ ] URL fetch operation succeeds and data inserts
- [ ] Upsert Files modal opens and closes correctly
- [ ] File upload and parse succeeds
- [ ] Error handling works for malformed data

## Dependencies

- **Blocked by:** ELEC-001, ELEC-002
- **Depends on:** ELEC-001, ELEC-002

## Risk Level

High — data ingestion failures affect all downstream AI features

## QC Team Checks

- [ ] All 3 upsert modals verified against PAGE-KNOWLEDGE metadata
- [ ] Vector insertion confirmed in vectors table

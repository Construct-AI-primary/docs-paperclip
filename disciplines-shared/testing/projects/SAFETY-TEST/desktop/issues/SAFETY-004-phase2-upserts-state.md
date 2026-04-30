---
id: SAFETY-004
title: 02400 Upserts State — Cloud, URL & File Upserts
description: Verify Upserts state buttons and modals (Cloud, URL, File) insert data to vectors table correctly
labels: ["testing", "safety", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["SAFETY-001", "SAFETY-002"]
para_section: testing/projects/SAFETY-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: todo
priority: High
story_points: 5
due_date: "2026-05-02"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-SAFETY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Delegate database persistence checks to database-infraforge sub-agent."
  allowed_sub_assignees: ["database-infraforge"]
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02400 safety page production readiness"
  agent_goal: "As validator-qualityforge, verify Upserts state buttons and modals (Cloud, URL, File) insert data to vectors table correctly"
  task_goal: "Execute upsert modal testing and delegate DB persistence checks with >95% pass rate"
---

# SAFETY-004: 02400 Upserts State — Cloud, URL & File Upserts

## Executive Summary

This issue validates the Upserts state of the 02400 safety page. Three modal triggers (Cloud Upsert, URL Upsert, File Upsert) must render correctly, open their respective modals, process data, and persist to the vectors table. Database persistence checks are delegated to database-infraforge.

## Problem Statement / Scope

The Upserts state contains 3 modal buttons: Cloud Upsert (02400-UpsertCloudModal), URL Upsert (02400-UpsertUrlModal), and File Upsert (02400-UpsertFileModal). Each modal provides different data ingestion mechanisms for the vectors table.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 4A | Cloud Upsert modal | Modal opens with data input form |
| 4B | Cloud Upsert submission | Vector data inserted to vectors table |
| 4C | URL Upsert modal | Modal opens with URL input field |
| 4D | URL Upsert fetch | URL fetch operation succeeds |
| 4E | URL Upsert insertion | Fetched data inserted to vectors table |
| 4F | File Upsert modal | Modal opens with file upload |
| 4G | File Upsert parse | File parsed correctly |
| 4H | File Upsert insertion | Parsed data inserted to vectors table |

## Acceptance Criteria

- [ ] Cloud Upsert button renders in Upserts state
- [ ] 02400-UpsertCloudModal opens and accepts data
- [ ] Cloud data insertion to vectors succeeds
- [ ] Error handling for malformed data
- [ ] URL Upsert button renders in Upserts state
- [ ] 02400-UpsertUrlModal opens and accepts URL
- [ ] URL fetch operation succeeds with valid URL
- [ ] Fetched data inserts correctly
- [ ] File Upsert button renders in Upserts state
- [ ] 02400-UpsertFileModal opens and accepts files
- [ ] File parsing succeeds (JSON, CSV, PDF)
- [ ] Parsed data inserts correctly

## Dependencies

- **Depends on:** SAFETY-001, SAFETY-002

## Estimated Duration

45 minutes

## Risk Level

High — data ingestion components.

## QC Team Checks

- [ ] **Cloud Upsert:** Modal renders with data input fields
- [ ] **Cloud Upsert:** Data persists to vectors table (delegate)
- [ ] **URL Upsert:** URL validation rejects malformed URLs
- [ ] **URL Upsert:** Fetch operation handles timeouts
- [ ] **File Upsert:** File type validation (JSON, CSV only)
- [ ] **File Upsert:** Parse errors handled gracefully

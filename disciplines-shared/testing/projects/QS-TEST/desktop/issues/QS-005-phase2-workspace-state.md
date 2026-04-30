---
id: QS-005
title: 02025 Workspace State — Cost Analysis, Project Comparison, Cross-Discipline & Vector Manager
description: Verify Workspace state button and all four associated modals (Cost Analysis, Project Comparison, Cross-Discipline Sharing, Vector Manager) open, validate, and function correctly
labels: ["testing", "quantity-surveying", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["QS-001", "QS-002"]
para_section: testing/projects/QS-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: todo
priority: High
story_points: 8
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
  agent_goal: "As validator-qualityforge, verify Workspace state button and all four associated modals (Cost Analysis, Project Comparison, Cross-Discipline Sharing, Vector Manager) open, validate, and function correctly"
  task_goal: "Execute workspace modal validation across all 4 modals with >95% pass rate"
---

# QS-005: 02025 Workspace State — Cost Analysis, Project Comparison, Cross-Discipline & Vector Manager

## Executive Summary

This issue validates the Workspace state button and its four associated modals: Cost Analysis, Project Comparison, Cross-Discipline Sharing, and Vector Data Manager. The Workspace state provides access to quantity surveying data analysis and management tools. All modal open/close behavior, data loading, CRUD operations, and persistence must be verified. A pass rate above 95% is required.

## Problem Statement / Scope

When the user clicks the Workspace state button, the page transitions to the Workspace state, displaying four buttons. Each button opens a distinct modal with specific features: cost analysis with rate build-up, project comparison with cost metrics, cross-discipline permission sharing, and vector data management with hnsw search. This issue covers the full lifecycle of all four workspace modals.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 5A | Workspace button click sets correct state | Clicking Workspace button highlights it; page state transitions to Workspace; 4 buttons render in alphabetical order |
| 5B | Cost Analysis modal open/close and functionality | Modal opens/closes; rate build-up form validates; cost breakdown renders; data persists to quantity_surveying_costs |
| 5C | Project Comparison modal open/close and functionality | Modal opens/closes; project comparison data loads; cost comparison charts render |
| 5D | Cross-Discipline Sharing modal open/close | Modal opens/closes; permission matrix displays correctly |
| 5E | Vector Data Manager modal open/close and functionality | Modal opens/closes; vector insert succeeds; hnsw query returns results |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** None

## Required Skills

- quality-assurance
- ui-validation
- data-analysis-testing
- vector-db-testing

## Acceptance Criteria

- [ ] Workspace state button renders and is clickable
- [ ] Clicking Workspace button highlights it and transitions page state
- [ ] Exactly 4 buttons render in Workspace state: Cost Analysis, Cross-Discipline Sharing, Project Comparison, Vector Data Manager
- [ ] Buttons are sorted alphabetically
- [ ] CostAnalysisModal opens/closes correctly
- [ ] Rate build-up form validates resource inputs
- [ ] Cost breakdown structure renders correctly
- [ ] Resource costing persists to quantity_surveying_costs table
- [ ] ProjectComparisonModal opens/closes correctly
- [ ] Project comparison data loads and charts render
- [ ] DisciplinePermissionMatrixModal opens/closes correctly
- [ ] Permission matrix displays correctly
- [ ] VectorDataManagerModal opens/closes correctly
- [ ] Vector insert succeeds
- [ ] hnsw query returns results

## Dependencies

- **Blocked by:** QS-001 (page foundation), QS-002 (database connectivity)
- **Depends on:** QS-001, QS-002
- **Blocks:** None

## Estimated Duration

60 minutes

## Risk Level

**High** — Workspace state provides critical data analysis tools. Failures here impact cost management and project comparison capabilities.

## QC Team Checks

- [ ] **4 buttons in alphabetical order:** Cost Analysis, Cross-Discipline Sharing, Project Comparison, Vector Data Manager
- [ ] **Cost analysis:** Rate build-up validates; cost breakdown renders; data persists
- [ ] **Project comparison:** Data loads; charts render accurately
- [ ] **Cross-discipline:** Permission matrix renders correctly
- [ ] **Vector manager:** Insert succeeds; hnsw query returns matching results

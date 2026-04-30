---
id: SAFETY-011
title: 02400 Integrations — VDB, Cross-Discipline Sharing, Document Retrieval
description: Verify vector insert→hnsw query, cross-discipline permission matrix, and document retrieval by discipline filter
labels: ["testing", "safety", "4 — Advanced"]
blocked_by: []
depends_on: ["SAFETY-001", "SAFETY-002"]
para_section: testing/projects/SAFETY-TEST/desktop/issues
phase: 4 — Advanced
status: todo
priority: Medium
story_points: 5
due_date: "2026-05-04"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-SAFETY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Delegate VDB index and query performance checks to database-infraforge sub-agent."
  allowed_sub_assignees: ["database-infraforge"]
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02400 safety page production readiness"
  agent_goal: "As validator-qualityforge, verify vector insert→hnsw query, cross-discipline permission matrix, and document retrieval by discipline filter"
  task_goal: "Execute integrations validation with >85% pass rate"
---

# SAFETY-011: 02400 Integrations — VDB, Cross-Discipline Sharing, Document Retrieval

## Executive Summary

This issue validates the integration features of the 02400 safety page: vector database operations (insert→hnsw query), cross-discipline sharing permissions, and document retrieval filtered by discipline.

## Problem Statement / Scope

The 02400 safety page integrates with three shared systems: Vector DB for semantic search (insert vectors then query via hnsw index), Cross-Discipline Sharing (permission matrix controlling access between disciplines), and Document Retrieval (fetch documents filtered by discipline code). Database performance checks are delegated to database-infraforge.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 11A | Vector insert | Vector data inserts to vectors table |
| 11B | hnsw query | Semantic query returns results using hnsw index |
| 11C | Cross-discipline sharing | Permission matrix prevents unauthorized access |
| 11D | Document retrieval | Documents returned filtered by discipline=02400 |
| 11E | Index policy | RLS policies enforce discipline-based access |

## Acceptance Criteria

- [ ] Vector insert succeeds with embedding and metadata
- [ ] hnsw query returns semantically similar results
- [ ] Cross-discipline sharing permissions enforced correctly
- [ ] Discipline 02400 users see only 02400 documents
- [ ] Document retrieval filters by discipline=02400
- [ ] RLS policies prevent unauthorized access to safety data
- [ ] hnsw index performant (sub-second queries)

## Dependencies

- **Depends on:** SAFETY-001, SAFETY-002

## Estimated Duration

45 minutes

## Risk Level

Medium — integration features.

## QC Team Checks

- [ ] **Vector insert→query:** Verify hnsw index used (EXPLAIN ANALYZE)
- [ ] **Permission matrix:** Test cross-discipline access denied
- [ ] **Document retrieval:** Verify discipline filter = '02400'
- [ ] **RLS:** Verify policies restrict access by discipline

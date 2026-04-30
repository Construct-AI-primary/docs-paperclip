---
id: SAFETY-013
title: 02400 Agent Delegation — Safety Director→Subordinate Heartbeat Validation
description: Verify safety director→subordinate delegation flow creates sub-tasks via assigneeAgentId+parentId, heartbeat detects assignments, and status propagates upward
labels: ["testing", "safety", "5 — Compliance & Sign-off"]
blocked_by: []
depends_on: ["SAFETY-001"]
para_section: testing/projects/SAFETY-TEST/desktop/issues
phase: 5 — Compliance & Sign-off
status: todo
priority: High
story_points: 5
due_date: "2026-05-05"
assignee: domainforge-ai-safetydirector
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-SAFETY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify all subordinate agents receive assignments and report back."
  allowed_sub_assignees: ["validator-qualityforge", "safety-domainforge-safety", "safety-domainforge-fleet", "safety-domainforge-customs"]
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02400 safety page production readiness"
  agent_goal: "As domainforge-ai-safetydirector, verify delegation flow creates sub-tasks via assigneeAgentId+parentId, heartbeat detects assignments, and status propagates upward"
  task_goal: "Execute delegation flow test and verify heartbeat loop integrity"
---

# SAFETY-013: 02400 Agent Delegation — Safety Director→Subordinate Heartbeat Validation

## Executive Summary

**Objective**: Test the full Paperclip delegation pipeline — Safety Director creates root goal, decomposes into sub-tasks, assigns via heartbeat, and status propagates upward through the hierarchy.

**⚠ Pre-requisite**: Verify the DomainForge safety-director agent content reflects Safety Director role (not other role) before execution.

**Success Criteria**: All delegation steps execute correctly with no breaks in the heartbeat chain.

## Required Actions

- **13A**: CEO creates root goal "QC-ROOT-SAFETY-2026" with delegation prompt
- **13B**: CEO decomposes into sub-tasks — sets assigneeAgentId for each subordinate, sets parentId to QC-ROOT
- **13C**: Sub-agent heartbeat loop detects assigned sub-task (polling GET /api/issues?assigneeAgentId={self})
- **13D**: Sub-agent executes sub-task, updates status to "in_progress" → "in_review" → "done"
- **13E**: Status change propagates upward to parent issue (CEO sees aggregate status)
- **13F**: Approval request routes correctly through the hierarchy

## Acceptance Criteria

- [ ] Safety Director creates root goal with delegation prompt
- [ ] Sub-tasks created with correct assigneeAgentId and parentId
- [ ] Sub-agent heartbeat detects assigned task
- [ ] Sub-task status transitions work (backlog→in_progress→in_review→done)
- [ ] Status propagates upward to parent issue
- [ ] Approval requests route correctly

## Risk Level

High — tests the core Paperclip delegation mechanism.

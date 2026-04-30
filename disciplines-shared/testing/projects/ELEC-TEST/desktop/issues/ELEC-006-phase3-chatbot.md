---
id: ELEC-006
title: 00860 Chatbot — ElectricalEngineeringChatbot HITL & Confidence Thresholds
description: Verify ElectricalEngineeringChatbot renders with gold theme, HITL confidence threshold of 0.7, citations, and document count
labels: ["testing", "electrical-engineering", "3 — Integration"]
blocked_by: []
depends_on: ["ELEC-001", "ELEC-002"]
para_section: testing/projects/ELEC-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 5
due_date: "2026-05-03"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-ELECTRICAL-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 00860 electrical engineering page production readiness"
  agent_goal: "As validator-qualityforge, verify ElectricalEngineeringChatbot renders with gold theme, HITL confidence threshold of 0.7, citations, and document count"
  task_goal: "Execute chatbot UI validation, HITL trigger test, citation verification with >90% pass rate"
---

# ELEC-006: 00860 Chatbot — ElectricalEngineeringChatbot HITL & Confidence Thresholds

## Executive Summary

This issue validates the ElectricalEngineeringChatbot component. The chatbot provides AI-powered assistance for electrical engineering queries with a gold theme (#DAA520/#B8860B). Key features include HITL (Human-In-The-Loop) at confidence threshold 0.7, citation display, document count, and session history persistence. All chatbot UI elements, interaction flows, and HITL triggering must be verified.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 6A | Chatbot toggle | Chatbot opens/closes correctly; gold theme applied |
| 6B | Chat message send | Message sends and response displays with citation |
| 6C | HITL threshold | Confidence <0.7 returns direct answer; >=0.7 triggers HITL approval |
| 6D | Document count | Document count displays next to response |
| 6E | Session history | History persists within session; clearing works |

## Acceptance Criteria

- [ ] Chatbot toggle button renders and opens chatbot
- [ ] Gold theme (#DAA520/#B8860B) applied to all chatbot elements
- [ ] Message input and send button function correctly
- [ ] Chatbot response includes citations when available
- [ ] Document count displays correctly
- [ ] HITL triggers when confidence >= 0.7
- [ ] HITL approval/rejection flow works
- [ ] Session history persists
- [ ] History clear function works

## Dependencies

- **Depends on:** ELEC-001, ELEC-002

## Risk Level

High — chatbot is key user-facing AI feature

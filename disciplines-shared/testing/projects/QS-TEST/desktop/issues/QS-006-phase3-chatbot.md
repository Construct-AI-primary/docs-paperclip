---
id: QS-006
title: 02025 Chatbot — HITL & Confidence Thresholds
description: Verify QuantitySurveyingChatbot loads with correct olive theme, citations, document count, HITL confidence threshold of 0.7, and conversation history persistence
labels: ["testing", "quantity-surveying", "3 — Integration"]
blocked_by: []
depends_on: ["QS-001", "QS-002"]
para_section: testing/projects/QS-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 5
due_date: "2026-05-03"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-QS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02025 quantity surveying page production readiness"
  agent_goal: "As validator-qualityforge, verify QuantitySurveyingChatbot loads with correct olive theme, citations, document count, HITL confidence threshold of 0.7, and conversation history persistence"
  task_goal: "Execute chatbot validation across all configured features with >90% pass rate"
---

# QS-006: 02025 Chatbot — HITL & Confidence Thresholds

## Executive Summary

This issue validates the QuantitySurveyingChatbot component, which provides AI-assisted Q&A for quantity surveying tasks. The chatbot must render with the correct olive theme (#808000/#6B8E23), properly handle Human-In-The-Loop (HITL) triggers at confidence threshold 0.7, display citations and document counts with responses, and persist conversation history within a session. A pass rate above 90% is required.

## Problem Statement / Scope

The QuantitySurveyingChatbot is the primary AI interface for the 02025 page, helping quantity surveyors answer BOQ questions, cost estimation queries, and measurement rules. This issue covers chatbot rendering, theme application, HITL confidence threshold behaviour, citation display, document count accuracy, and conversation history persistence. No workflow orchestration or template generation is included.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 6A | Chatbot toggle and theme verification | Chatbot opens/closes; olive theme (#808000/#6B8E23) applied to header and messages |
| 6B | Ask a QS-specific question | Response returns with citations; document count displayed; confidence score shown |
| 6C | HITL trigger test | Ask question generating <0.7 confidence; HITL modal appears with context; human response option available |
| 6D | Conversation history persistence | Send multiple messages; scroll back through history; verify context retained across turns |
| 6E | Session boundary | Refresh page; verify new session starts fresh (no history from previous session) |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** None

## Required Skills

- quality-assurance
- chatbot-testing
- ai-validation

## Acceptance Criteria

- [ ] Chatbot toggle button is visible
- [ ] Chatbot opens when toggle is clicked
- [ ] Olive theme (#808000/#6B8E23) is applied to header bar
- [ ] Olive theme is applied to message bubbles
- [ ] QS question returns a response
- [ ] Responses include citations
- [ ] Document count is displayed
- [ ] Confidence score is displayed
- [ ] HITL modal appears when confidence < 0.7
- [ ] HITL modal shows question context
- [ ] Human response can be provided
- [ ] Conversation history persists within session
- [ ] New session starts with empty history
- [ ] Chatbot closes when toggle is clicked again

## Dependencies

- **Blocked by:** QS-001 (page foundation), QS-002 (database connectivity)
- **Depends on:** QS-001, QS-002
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**High** — Chatbot is the primary AI interface for quantity surveying tasks. Failures here directly impact user ability to get AI-assisted answers.

## QC Team Checks

- [ ] **Olive theme:** Verify #808000/#6B8E23 applied to header bar, message bubbles, and accent elements
- [ ] **Citations present:** Confirm each response includes source citations
- [ ] **Document count:** Verify count matches number of documents retrieved
- [ ] **HITL at 0.7:** Trigger a low-confidence question; verify HITL modal appears
- [ ] **History persistence:** Send 3+ messages; verify history scroll works
- [ ] **Session boundary:** Refresh; verify history is cleared

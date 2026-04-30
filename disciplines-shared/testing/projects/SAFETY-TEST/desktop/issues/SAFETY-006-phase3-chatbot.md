---
id: SAFETY-006
title: 02400 Chatbot — HITL & Confidence Thresholds
description: Verify SafetyChatbot renders with safety blue theme, HITL confidence threshold of 0.7, citations, and history persistence
labels: ["testing", "safety", "3 — Integration"]
blocked_by: []
depends_on: ["SAFETY-001"]
para_section: testing/projects/SAFETY-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 5
due_date: "2026-05-02"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-SAFETY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify chatbot theme, HITL flow, confidence thresholds, and history persistence."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02400 safety page production readiness"
  agent_goal: "As validator-qualityforge, verify SafetyChatbot renders with safety blue theme (#0D47A1/#1565C0), HITL confidence threshold of 0.7, citations, and history persistence"
  task_goal: "Execute chatbot validation with >90% pass rate"
---

# SAFETY-006: 02400 Chatbot — HITL & Confidence Thresholds

## Executive Summary

This issue validates the SafetyChatbot component on the 02400 safety page. The chatbot must render with the safety blue theme (#0D47A1/#1565C0), trigger human-in-the-loop at confidence < 0.7, provide citations with sources, show document counts, and persist conversation history per session.

## Problem Statement / Scope

The SafetyChatbot is the primary AI assistant for the safety page. It must handle safety-specific queries about freight booking, customs clearance, fleet management, and supply chain operations. When confidence falls below 0.7, HITL must be triggered to ensure accurate responses.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 6A | Chatbot render | Chatbot renders with safety blue theme (#0D47A1/#1565C0) |
| 6B | Chatbot toggle | Chatbot opens/closes via toggle button |
| 6C | Confidence threshold | Responses with confidence >= 0.7 display directly |
| 6D | HITL trigger | Responses with confidence < 0.7 trigger HITL |
| 6E | Citations | Citations displayed with source documents |
| 6F | Document count | Document count shown per response |
| 6G | History persistence | Conversation history persists within session |

## Acceptance Criteria

- [ ] Chatbot renders with safety blue color scheme (#0D47A1 header, #1565C0 accents)
- [ ] Chatbot toggle button is visible and functional
- [ ] Responses with confidence >= 0.7 are shown directly
- [ ] Responses with confidence < 0.7 trigger HITL escalation
- [ ] HITL prompt shows confidence score and suggested response
- [ ] Citations are displayed with source document links
- [ ] Document count is shown per response
- [ ] Conversation history persists within browser session
- [ ] Chatbot closes and reopens without losing context

## Dependencies

- **Depends on:** SAFETY-001

## Estimated Duration

45 minutes

## Risk Level

Medium — chatbot is self-contained.

## QC Team Checks

- [ ] **Theme:** Verify primary color is #0D47A1, accent is #1565C0
- [ ] **HITL:** Test query that should trigger confidence < 0.7
- [ ] **Citations:** Verify source document links are clickable
- [ ] **History:** Refresh page and verify history is lost (session-only)
- [ ] **Safety context:** Chatbot responds to safety-specific queries

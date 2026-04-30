---
id: SAFETY-013a
title: Agent Feedback Loop — Live Monitoring & Escalation
description: Configure and verify real-time agent activity monitoring, stall detection (30min), status aggregation, and escalation procedures for all SAFETY-TEST agents
labels: ["testing", "safety", "5 — Compliance & Sign-off"]
blocked_by: []
depends_on: ["SAFETY-001"]
para_section: testing/projects/SAFETY-TEST/desktop/issues
phase: 5 — Compliance & Sign-off
status: todo
priority: High
story_points: 5
due_date: "2026-05-05"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-SAFETY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Configure and verify real-time agent activity monitoring, stall detection, status aggregation, and escalation procedures."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02400 safety page production readiness"
  agent_goal: "As validator-qualityforge, configure and verify real-time agent activity monitoring, stall detection (30min), status aggregation, and escalation procedures for all SAFETY-TEST agents"
  task_goal: "Execute feedback loop configuration and verification"
---

# SAFETY-013a: Agent Feedback Loop — Live Monitoring & Escalation

## Executive Summary

This issue configures and validates the agent feedback loop for SAFETY-TEST. It sets up real-time monitoring of all agents via Paperclip's ActivityEvent API, configures stall detection thresholds, creates escalation procedures, and generates the live agent activity dashboard.

## Problem Statement / Scope

Real-time visibility into agent activity is critical for tracking test execution progress. The feedback loop must poll the activity log every 15 minutes, aggregate status by agent, detect stalls (no heartbeat > 30min), escalate appropriately, and maintain a live dashboard.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 13aA | Activity log polling | Poller successfully queries activity log |
| 13aB | Status aggregation | Aggregates status by agent into dashboard |
| 13aC | Stall detection | Agents with heartbeat > 30min flagged |
| 13aD | Escalation trigger | Stalled agent → escalation sub-task created |
| 13aE | Dashboard generation | SAFETY-TEST-FEEDBACK-LOOP.md created |

## Acceptance Criteria

- [ ] Activity log API accessible at /api/companies/qualityforge-ai/activity
- [ ] Poller runs every 15 minutes
- [ ] Agent status aggregated correctly in dashboard
- [ ] Stall detection flags agents > 30min since last heartbeat
- [ ] Escalation sub-task created for stalled agents
- [ ] Phase gate status tracked in dashboard
- [ ] Dashboard file created at desktop/learning/SAFETY-TEST-FEEDBACK-LOOP.md

## Risk Level

High — enables real-time visibility.

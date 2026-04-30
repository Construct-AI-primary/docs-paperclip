---
id: QS-009
title: 02025 Cost Analysis — Rate Build-up & Cost Breakdown
description: Verify cost analysis modal with rate build-up form, cost breakdown structure, and resource costing functionality
labels: ["testing", "quantity-surveying", "4 — Advanced"]
blocked_by: []
depends_on: ["QS-001", "QS-002", "QS-003"]
para_section: testing/projects/QS-TEST/desktop/issues
phase: 4 — Advanced
status: todo
priority: Medium
story_points: 5
due_date: "2026-05-04"
assignee: quantity-surveying-domainforge-qs
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-QS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02025 quantity surveying page production readiness"
  agent_goal: "As quantity-surveying-domainforge-qs, verify cost analysis modal with rate build-up form, cost breakdown structure, and resource costing functionality"
  task_goal: "Execute cost analysis validation with >85% pass rate"
---

# QS-009: 02025 Cost Analysis — Rate Build-up & Cost Breakdown

## Executive Summary

This issue validates the Cost Analysis modal, which enables quantity surveyors to build up unit rates from labour, material, and plant resources, then aggregate them into a cost breakdown structure (CBS). The modal must correctly calculate composite rates, validate resource inputs against known benchmarks, and persist cost data to the quantity_surveying_costs table. A pass rate above 85% is required.

## Problem Statement / Scope

The Cost Analysis modal is accessed from the Workspace state and provides detailed cost analysis capabilities including rate build-up from base resources, cost breakdown by work package, and project-level cost aggregation. This issue covers rate build-up form validation, CBS rendering, resource cost calculation, data persistence, and comparison with benchmark rates. No project comparison or cross-discipline features are included.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 9A | Rate build-up form validation | Add labour, material, plant resources; verify unit rate calculation; validate against benchmarks |
| 9B | Cost breakdown structure rendering | Create CBS hierarchy; verify levels display correctly; verify cost roll-up |
| 9C | Resource costing persistence | Save cost data; verify insertion to quantity_surveying_costs; retrieve and verify |
| 9D | Benchmark comparison | Compare calculated rate against benchmark; verify variance indicators |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** quantity-surveying-domainforge-qs
- **Sub-agents:** None

## Required Skills

- quantity-surveying-domain-expertise
- cost-analysis
- rate-build-up

## Acceptance Criteria

- [ ] Rate build-up form renders with correct fields for labour, material, plant
- [ ] Unit rate calculation is mathematically correct
- [ ] CBS hierarchy renders correctly (Level 1→Level 2→Level 3)
- [ ] Cost roll-up aggregates correctly to parent levels
- [ ] Resource cost data persists to quantity_surveying_costs table
- [ ] Retrieved data matches submitted values
- [ ] Benchmark comparison shows variance indicators
- [ ] Rate validation flags out-of-range values
- [ ] Error handling for invalid resource inputs

## Dependencies

- **Blocked by:** QS-001, QS-002, QS-003 (BOQ data required)
- **Depends on:** QS-001, QS-002, QS-003
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**Medium** — Cost analysis is a key QS feature but has manual verification paths.

## QC Team Checks

- [ ] **Rate build-up:** Verify labour, material, plant rate calculations
- [ ] **CBS structure:** Verify hierarchy renders and costs roll up correctly
- [ ] **Persistence:** Verify data round-trips to quantity_surveying_costs table
- [ ] **Benchmarks:** Verify variance indicators display correctly

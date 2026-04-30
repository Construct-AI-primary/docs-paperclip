---
id: QS-007
title: 02025 QS Workflow Orchestrator — BOQ Approval & Measurement Workflow
description: Verify the QS workflow orchestrator executes BOQ approval chain, measurement validation workflow, and cost estimation workflow correctly
labels: ["testing", "quantity-surveying", "3 — Integration"]
blocked_by: []
depends_on: ["QS-001", "QS-002"]
para_section: testing/projects/QS-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 5
due_date: "2026-05-03"
assignee: quantity-surveying-domainforge-qs
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-QS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02025 quantity surveying page production readiness"
  agent_goal: "As quantity-surveying-domainforge-qs, verify the QS workflow orchestrator executes BOQ approval chain, measurement validation workflow, and cost estimation workflow correctly"
  task_goal: "Execute workflow validation across all 3 QS workflows with >90% pass rate"
---

# QS-007: 02025 QS Workflow Orchestrator — BOQ Approval & Measurement Workflow

## Executive Summary

This issue validates the QuantitySurveyingWorkflowOrchestrator, which manages three core quantity surveying workflows: BOQ approval chain, measurement validation workflow, and cost estimation workflow. Each workflow must progress through its defined states, enforce business rules, and produce correct outputs. A pass rate above 90% is required.

## Problem Statement / Scope

The QS workflow orchestrator coordinates multi-step processes unique to quantity surveying. The BOQ approval chain routes BOQ items through draft→review→approved→issued states. The measurement validation workflow checks dimension calculations against NRM standards. The cost estimation workflow generates resource-loaded cost estimates. This issue covers workflow execution, state transitions, error handling, and output verification.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 7A | BOQ approval chain execution | Create BOQ item; submit for review; approve; verify state transitions; issue final BOQ |
| 7B | Measurement validation workflow | Enter dimensions; run validation; verify NRM rule enforcement; correct flagged errors |
| 7C | Cost estimation workflow | Select BOQ items; add resources; run estimation; verify cost outputs |
| 7D | Error handling | Submit invalid data; verify error messages; verify graceful degradation |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** quantity-surveying-domainforge-qs
- **Sub-agents:** None

## Required Skills

- quantity-surveying-domain-expertise
- workflow-testing
- boq-management

## Acceptance Criteria

- [ ] BOQ approval chain completes through all states
- [ ] BOQ state transitions are logged
- [ ] Measurement validation enforces NRM rules
- [ ] Dimension errors are correctly flagged
- [ ] Corrected measurements pass validation
- [ ] Cost estimation generates correct outputs
- [ ] Resource costs are calculated correctly
- [ ] Error handling shows appropriate messages
- [ ] Workflow continues after non-critical errors

## Dependencies

- **Blocked by:** QS-001, QS-002
- **Depends on:** QS-001, QS-002
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**Medium** — Workflow orchestration is critical but has built-in error recovery.

## QC Team Checks

- [ ] **BOQ chain:** Verify draft→review→approved→issued with correct permissions at each gate
- [ ] **NRM compliance:** Verify measurement rules enforce NRM standards
- [ ] **Cost estimation:** Verify resource aggregation and total cost calculation

---
id: QS-008
title: 02025 Templates — BOQ Templates & Cost Estimation Templates
description: Verify BOQ templates and cost estimation templates populate, validate, and export correctly
labels: ["testing", "quantity-surveying", "3 — Integration"]
blocked_by: []
depends_on: ["QS-001", "QS-002"]
para_section: testing/projects/QS-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 8
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
  agent_goal: "As quantity-surveying-domainforge-qs, verify BOQ templates and cost estimation templates populate, validate, and export correctly"
  task_goal: "Execute template validation for all QS template types with >90% pass rate"
---

# QS-008: 02025 Templates — BOQ Templates & Cost Estimation Templates

## Executive Summary

This issue validates the QS template system, including BOQ templates and cost estimation templates. Templates must populate with correct data, apply compliance rules, support JSON export, and produce valid output documents. A pass rate above 90% is required.

## Problem Statement / Scope

The 02025 page provides structured templates for Bill of Quantities and cost estimation. BOQ templates include standard item descriptions, units of measure, and rate structures. Cost estimation templates include resource breakdowns, unit rate calculations, and total cost aggregation. Templates must apply compliance rules for NRM measurement standards and construction industry conventions. This issue covers template population, validation, compliance enforcement, and export functionality.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 8A | BOQ template generation | Select BOQ template; verify item descriptions populate; verify units correctly assigned; verify rate structure |
| 8B | Cost estimation template generation | Select cost estimation template; verify resource fields populate; verify unit rate calculation |
| 8C | Compliance rule enforcement | Enter non-compliant data; verify rule enforcement; verify correction guidance provided |
| 8D | JSON export | Export template as JSON; validate JSON structure; verify all fields present |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** quantity-surveying-domainforge-qs
- **Sub-agents:** None

## Required Skills

- quantity-surveying-domain-expertise
- template-validation
- compliance-testing

## Acceptance Criteria

- [ ] BOQ template populates with correct item descriptions
- [ ] Units of measure are correctly assigned per item type
- [ ] Rate structure includes labour, material, plant components
- [ ] Cost estimation template populates resource fields
- [ ] Unit rate calculation is mathematically correct
- [ ] Compliance rules enforce NRM standards
- [ ] Non-compliant data generates appropriate warnings
- [ ] JSON export produces valid structure
- [ ] All required fields present in export
- [ ] Export file can be re-imported without data loss

## Dependencies

- **Blocked by:** QS-001, QS-002
- **Depends on:** QS-001, QS-002
- **Blocks:** None

## Estimated Duration

60 minutes

## Risk Level

**Medium** — Template accuracy is important for quantity surveying deliverables.

## QC Team Checks

- [ ] **BOQ template:** Verify item descriptions, units, rate structure accuracy
- [ ] **Cost estimation template:** Verify resource fields, rate calculations
- [ ] **Compliance:** Verify NRM rule enforcement with test data
- [ ] **JSON export:** Validate structure and completeness

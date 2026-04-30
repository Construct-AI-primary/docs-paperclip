---
id: SAFETY-010
title: 02400 Customs Compliance — Documentation & Regulatory Checks
description: Verify customs compliance feature validates declarations, performs regulatory checks, and calculates compliance scores
labels: ["testing", "safety", "4 — Advanced"]
blocked_by: []
depends_on: ["SAFETY-001", "SAFETY-002"]
para_section: testing/projects/SAFETY-TEST/desktop/issues
phase: 4 — Advanced
status: todo
priority: Medium
story_points: 5
due_date: "2026-05-03"
assignee: safety-domainforge-customs
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-SAFETY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify customs compliance feature validates declarations, performs regulatory checks, and calculates compliance scores."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02400 safety page production readiness"
  agent_goal: "As safety-domainforge-customs, verify customs compliance feature validates declarations, performs regulatory checks, and calculates compliance scores"
  task_goal: "Execute customs compliance validation with >85% pass rate"
---

# SAFETY-010: 02400 Customs Compliance — Documentation & Regulatory Checks

## Executive Summary

This issue validates the customs compliance features of the 02400 safety page. The customs compliance module must validate customs declarations against regulatory requirements, verify required documents, and calculate compliance scores for each shipment.

## Problem Statement / Scope

The customs compliance feature includes declaration validation against HS code regulations, document completeness checking, regulatory rule enforcement (restricted goods, sanctions screening), and compliance scoring. This ensures all shipments meet regulatory requirements before clearance.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 10A | Declaration validation | Customs declaration validates against regulations |
| 10B | Document checklist | Required documents verified for completeness |
| 10C | Regulatory rules | Restricted goods detection works |
| 10D | Sanctions screening | Sanctioned countries/entities flagged |
| 10E | Compliance score | Compliance score calculated correctly |
| 10F | Score threshold | Score >= 80% passes, < 80% flagged for review |

## Acceptance Criteria

- [ ] Customs declaration form validates HS codes
- [ ] Required document checklist is enforced
- [ ] Restricted goods detection flags prohibited items
- [ ] Sanctions screening checks origin/destination countries
- [ ] Compliance score is calculated and displayed
- [ ] Score >= 80% shows "Compliant" status
- [ ] Score < 80% shows "Review Required" status
- [ ] Regulatory rule violations are explained
- [ ] Document upload accepts required formats
- [ ] Compliance report generates PDF

## Dependencies

- **Depends on:** SAFETY-001, SAFETY-002

## Estimated Duration

45 minutes

## Risk Level

Medium — regulatory compliance feature.

## QC Team Checks

- [ ] **HS codes:** Format validation (6-10 digit codes)
- [ ] **Documents:** Checklist requires declaration, invoice, packing list, COO
- [ ] **Restricted goods:** Test with prohibited item → flag raised
- [ ] **Sanctions:** Test with sanctioned country → flag raised
- [ ] **Score:** Verify calculation: (passed checks / total checks) * 100

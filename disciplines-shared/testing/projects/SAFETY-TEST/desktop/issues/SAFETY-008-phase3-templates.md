---
id: SAFETY-008
title: 02400 Templates — Bill of Lading, Customs Declaration, Shipping Manifest
description: Verify safety templates (Bill of Lading, Customs Declaration, Shipping Manifest) populate correctly and comply with regulations
labels: ["testing", "safety", "3 — Integration"]
blocked_by: []
depends_on: ["SAFETY-001", "SAFETY-002"]
para_section: testing/projects/SAFETY-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 8
due_date: "2026-05-03"
assignee: safety-domainforge-safety
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-SAFETY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify all 3 safety templates populate correctly and comply with regulations."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02400 safety page production readiness"
  agent_goal: "As safety-domainforge-safety, verify safety templates (Bill of Lading, Customs Declaration, Shipping Manifest) populate correctly and comply with regulations"
  task_goal: "Execute template validation with >90% pass rate"
---

# SAFETY-008: 02400 Templates — Bill of Lading, Customs Declaration, Shipping Manifest

## Executive Summary

This issue validates the safety template system. Three templates (Bill of Lading, Customs Declaration, Shipping Manifest) must populate correctly with safety data, validate against compliance rules, and generate proper JSON output.

## Problem Statement / Scope

The 02400 safety page provides 3 key templates: Bill of Lading (shipment details, carrier info, cargo description), Customs Declaration (HS codes, duty calculation, country of origin), and Shipping Manifest (container list, port details, voyage info). Each must validate data, apply compliance rules, and generate structured output.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 8A | Bill of Lading | Template populates with shipment data |
| 8B | B/L compliance | Compliance rules applied (carrier validation, cargo limits) |
| 8C | B/L JSON output | Generated JSON is valid and complete |
| 8D | Customs Declaration | Template populates with customs data |
| 8E | C/D compliance | HS code validation, duty calculation correct |
| 8F | C/D JSON output | Generated JSON is valid and complete |
| 8G | Shipping Manifest | Template populates with manifest data |
| 8H | Manifest compliance | Container count, port validation correct |
| 8I | Manifest JSON output | Generated JSON is valid and complete |

## Acceptance Criteria

- [ ] Bill of Lading template renders with correct fields
- [ ] B/L populates from safety_freight data
- [ ] B/L compliance rules validate carrier and cargo limits
- [ ] B/L generates valid JSON
- [ ] Customs Declaration template renders with correct fields
- [ ] C/D populates from safety_customs data
- [ ] C/D HS code validation works
- [ ] C/D duty calculation is accurate
- [ ] C/D generates valid JSON
- [ ] Shipping Manifest template renders with correct fields
- [ ] Manifest populates with container/voyage data
- [ ] Manifest compliance rules validate container counts
- [ ] Manifest generates valid JSON

## Dependencies

- **Depends on:** SAFETY-001, SAFETY-002

## Estimated Duration

60 minutes

## Risk Level

High — regulatory compliance critical.

## QC Team Checks

- [ ] **Bill of Lading:** Verify carrier validation rules
- [ ] **Bill of Lading:** Cargo weight/volume limits enforced
- [ ] **Customs Declaration:** HS code format validation
- [ ] **Customs Declaration:** Duty calculation correctness
- [ ] **Shipping Manifest:** Container count validation
- [ ] **Shipping Manifest:** Port code validation

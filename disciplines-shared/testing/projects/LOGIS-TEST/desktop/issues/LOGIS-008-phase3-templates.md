---
id: LOGIS-008
title: 01700 Templates — Bill of Lading, Customs Declaration, Shipping Manifest
description: Verify logistics templates (Bill of Lading, Customs Declaration, Shipping Manifest) populate correctly and comply with regulations
labels: ["testing", "logistics", "3 — Integration"]
blocked_by: []
depends_on: ["LOGIS-001", "LOGIS-002"]
para_section: testing/projects/LOGIS-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 8
due_date: "2026-05-03"
assignee: logistics-domainforge-logistics
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-LOGIS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify all 3 logistics templates populate correctly and comply with regulations."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01700 logistics page production readiness"
  agent_goal: "As logistics-domainforge-logistics, verify logistics templates (Bill of Lading, Customs Declaration, Shipping Manifest) populate correctly and comply with regulations"
  task_goal: "Execute template validation with >90% pass rate"
---

# LOGIS-008: 01700 Templates — Bill of Lading, Customs Declaration, Shipping Manifest

## Executive Summary

This issue validates the logistics template system. Three templates (Bill of Lading, Customs Declaration, Shipping Manifest) must populate correctly with logistics data, validate against compliance rules, and generate proper JSON output.

## Problem Statement / Scope

The 01700 logistics page provides 3 key templates: Bill of Lading (shipment details, carrier info, cargo description), Customs Declaration (HS codes, duty calculation, country of origin), and Shipping Manifest (container list, port details, voyage info). Each must validate data, apply compliance rules, and generate structured output.

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
- [ ] B/L populates from logistics_freight data
- [ ] B/L compliance rules validate carrier and cargo limits
- [ ] B/L generates valid JSON
- [ ] Customs Declaration template renders with correct fields
- [ ] C/D populates from logistics_customs data
- [ ] C/D HS code validation works
- [ ] C/D duty calculation is accurate
- [ ] C/D generates valid JSON
- [ ] Shipping Manifest template renders with correct fields
- [ ] Manifest populates with container/voyage data
- [ ] Manifest compliance rules validate container counts
- [ ] Manifest generates valid JSON

## Dependencies

- **Depends on:** LOGIS-001, LOGIS-002

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

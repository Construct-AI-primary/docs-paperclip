---
id: ELEC-012
title: 00860 UX/Compliance — CSS, EPCM, Accessibility
description: Verify UX compliance across CSS styling, EPCM engineering standards, and accessibility requirements for the 00860 electrical engineering page
labels: ["testing", "electrical-engineering", "5 — Compliance"]
blocked_by: []
depends_on: ["ELEC-001", "ELEC-003", "ELEC-004", "ELEC-005"]
para_section: testing/projects/ELEC-TEST/desktop/issues
phase: 5 — Compliance
status: todo
priority: High
story_points: 5
due_date: "2026-05-05"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-ELECTRICAL-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 00860 electrical engineering page production readiness"
  agent_goal: "As validator-qualityforge, verify UX compliance across CSS styling, EPCM engineering standards, and accessibility requirements"
  task_goal: "Execute UX/compliance audit with 100% pass rate on all CSS, EPCM, and accessibility checks"
---

# ELEC-012: 00860 UX/Compliance — CSS, EPCM, Accessibility

## Executive Summary

This issue validates that the 00860 electrical engineering page meets UX and compliance standards covering CSS styling consistency, EPCM (Engineering, Procurement, and Construction Management) industry standards, and web accessibility (WCAG) requirements. Compliance with these standards is mandatory for production deployment.

## Problem Statement / Scope

The 00860 page must conform to organizational CSS design guidelines, EPCM engineering documentation standards for electrical deliverables, and WCAG 2.1 AA accessibility requirements. This includes visual consistency across all UI components, proper labelling and tagging for EPCM compliance, and screen reader / keyboard navigation support. No functional testing of calculations or integrations is included.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 12A | CSS style audit | All components follow the design system tokens; no style drift from approved theme |
| 12B | EPCM standards compliance | Electrical documentation, labels, and deliverables follow EPCM naming and formatting conventions |
| 12C | Accessibility — screen readers | All interactive elements have appropriate ARIA labels; screen reader navigation is logical |
| 12D | Accessibility — keyboard navigation | All interactive elements are reachable and operable via keyboard; focus indicators are visible |
| 12E | Accessibility — colour contrast | All text/background combinations meet WCAG 2.1 AA contrast ratio thresholds |
| 12F | Responsive design | Page renders correctly at all supported viewport widths |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** None

## Required Skills

- quality-assurance
- ui-validation
- accessibility-testing
- standards-compliance

## Acceptance Criteria

- [ ] All CSS values match the approved design tokens
- [ ] No deprecated or non-standard CSS properties are used
- [ ] EPCM naming conventions are followed on all electrical output labels
- [ ] EPCM deliverable formatting matches the project specification
- [ ] All interactive elements have correct ARIA labels
- [ ] Screen reader navigation follows a logical DOM order
- [ ] All interactive elements are keyboard-reachable (Tab order)
- [ ] Focus indicators are visible on all interactive elements
- [ ] All colour combinations meet WCAG 2.1 AA minimum contrast
- [ ] Page renders correctly at 320px, 768px, 1024px, and 1920px widths

## Dependencies

- **Blocked by:** None
- **Depends on:** ELEC-001, ELEC-003, ELEC-004, ELEC-005

## Estimated Duration

60 minutes

## Risk Level

**High** — compliance failures can block production release.

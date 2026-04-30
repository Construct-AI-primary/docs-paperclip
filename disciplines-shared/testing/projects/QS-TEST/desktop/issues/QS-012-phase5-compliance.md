---
id: QS-012
title: 02025 UX/Compliance — CSS, EPCM, Accessibility
description: Verify CSS class naming convention, grid layout, page standardization, responsive breakpoints, and ARIA labels
labels: ["testing", "quantity-surveying", "5 — Compliance & Sign-off"]
blocked_by: []
depends_on: ["QS-001"]
para_section: testing/projects/QS-TEST/desktop/issues
phase: 5 — Compliance & Sign-off
status: todo
priority: High
story_points: 5
due_date: "2026-05-05"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-QS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02025 quantity surveying page production readiness"
  agent_goal: "As validator-qualityforge, verify CSS class naming convention, grid layout, page standardization, responsive breakpoints, and ARIA labels"
  task_goal: "Execute UX/compliance checks and create remediation list for any violations"
---

# QS-012: 02025 UX/Compliance — CSS, EPCM, Accessibility

## Executive Summary

This issue validates the UX and compliance aspects of the 02025 quantity surveying page, including CSS class naming conventions, grid layout consistency, page standardization across disciplines, responsive breakpoints, and ARIA accessibility labelling. All checks must use the A-02025-* class prefix convention defined in the page documentation.

## Problem Statement / Scope

Every discipline page must follow EPCM design system standards and accessibility requirements. This issue covers CSS class naming (A-02025-* prefix), grid layout calculation via calculateGridLayout(), responsive breakpoint verification, ARIA label presence and correctness, colour contrast for olive theme elements, and consistency with other discipline pages. No functional testing of modals, chatbot, or workflows is included.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 12A | CSS class naming audit | All page elements use A-02025-* prefix; verify nav container, button container, and modal elements |
| 12B | Grid layout verification | Grid calculated correctly; columns/rows render as expected; no overlapping |
| 12C | Responsive breakpoints | Test at desktop (1920x1080), tablet (768x1024), mobile (375x667); verify layout adapts |
| 12D | ARIA labels audit | All interactive elements have aria-label; labels are descriptive and unique |
| 12E | Colour contrast check | Olive theme (#808000/#6B8E23) meets WCAG AA contrast ratios |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** None

## Required Skills

- quality-assurance
- css-testing
- accessibility-testing

## Acceptance Criteria

- [ ] All page elements use A-02025-* class prefix
- [ ] Grid layout renders correctly with no overlapping
- [ ] Desktop layout is fully functional
- [ ] Tablet layout is fully functional without horizontal scroll
- [ ] Mobile layout is functional and touch-friendly
- [ ] All buttons have descriptive ARIA labels
- [ ] All modals have ARIA roles and labels
- [ ] Colour contrast meets WCAG AA standards
- [ ] Page standardization matches other discipline pages
- [ ] No CSS specificity conflicts with global styles

## Dependencies

- **Blocked by:** QS-001
- **Depends on:** QS-001
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**High** — Compliance issues can block production release.

## QC Team Checks

- [ ] **CSS prefix:** Verify all A-02025-* class names match documentation
- [ ] **Grid layout:** Confirm calculateGridLayout() produces correct layout
- [ ] **Responsive:** Test at 3 breakpoints; verify no layout breakage
- [ ] **ARIA labels:** Audit all interactive elements for descriptive labels
- [ ] **Colour contrast:** Verify olive theme meets WCAG AA (4.5:1 ratio)

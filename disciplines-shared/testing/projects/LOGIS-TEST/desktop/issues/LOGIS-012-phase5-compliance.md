---
id: LOGIS-012
title: 01700 UX/Compliance — CSS, EPCM, Accessibility
description: Verify CSS class naming follows A-01700-* convention, grid layout, responsive breakpoints, EPCM standards, and ARIA accessibility labels
labels: ["testing", "logistics", "5 — Compliance & Sign-off"]
blocked_by: []
depends_on: ["LOGIS-001"]
para_section: testing/projects/LOGIS-TEST/desktop/issues
phase: 5 — Compliance & Sign-off
status: todo
priority: High
story_points: 5
due_date: "2026-05-04"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-LOGIS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify CSS class naming, grid layout, responsive design, and ARIA accessibility compliance."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01700 logistics page production readiness"
  agent_goal: "As validator-qualityforge, verify CSS class naming follows A-01700-* convention, grid layout, responsive breakpoints, EPCM standards, and ARIA accessibility labels"
  task_goal: "Execute compliance validation and report issues"
---

# LOGIS-012: 01700 UX/Compliance — CSS, EPCM, Accessibility

## Executive Summary

This issue validates the CSS and UX compliance of the 01700 logistics page. All CSS class names must follow the `A-01700-*` naming convention, grid layout must be properly calculated, responsive design must work across breakpoints, and ARIA accessibility labels must be present.

## Problem Statement / Scope

The 01700 logistics page must comply with EPCM (Enterprise Page Component Model) standards. This includes CSS class naming convention (`A-01700-*` prefix), proper grid layout via `calculateGridLayout()`, responsive breakpoints for desktop/tablet/mobile, and WCAG-compliant ARIA labels on all interactive elements.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 12A | CSS class naming | All page elements use A-01700-* prefix |
| 12B | Grid layout | calculateGridLayout() produces correct grid |
| 12C | Responsive design | Breakpoints work at 1200px, 768px, 480px |
| 12D | ARIA labels | All interactive elements have aria-label |
| 12E | Color contrast | Text meets WCAG AA contrast ratios |
| 12F | Keyboard nav | All modals reachable and closable via keyboard |
| 12G | Page standardization | Page follows 01700 page template structure |

## Acceptance Criteria

- [ ] All CSS classes use `A-01700-*` prefix
- [ ] Grid layout calculated correctly for button count
- [ ] Page renders correctly at 1200px+ (desktop)
- [ ] Page renders correctly at 768px-1199px (tablet)
- [ ] Page renders correctly at <768px (mobile)
- [ ] All buttons have aria-label attributes
- [ ] All modals have aria-modal and role="dialog"
- [ ] Focus trapping works within modals
- [ ] Color contrast meets WCAG AA standards
- [ ] Keyboard navigation (Tab, Enter, Escape) works
- [ ] Page follows standard 01700 page template
- [ ] Background image shows logistics blue gradient

## Dependencies

- **Depends on:** LOGIS-001

## Estimated Duration

45 minutes

## Risk Level

Medium — UX compliance.

## QC Team Checks

- [ ] **CSS classes:** Verify A-01700-* prefix on all page elements
- [ ] **Grid:** calculateGridLayout() returns columns matching button count
- [ ] **Responsive:** Test at 1920px, 1024px, 768px, 375px widths
- [ ] **ARIA:** All modal-trigger-button elements have aria-label
- [ ] **Contrast:** Check logistics blue (#0D47A1) on white background
- [ ] **Keyboard:** Tab through all state buttons and modal triggers

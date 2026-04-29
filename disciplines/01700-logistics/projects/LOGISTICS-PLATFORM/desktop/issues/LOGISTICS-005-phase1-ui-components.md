---
id: LOGISTICS-005
title: 01700 Build shared UI component library for logistics platform
description: Create reusable UI components: data tables, status badges, map components, timeline components, and form inputs with logistics-specific validation
labels: ["logistics", "ui", "1 — Foundation"]
blocked_by: []
depends_on: ["LOGISTICS-002", "LOGISTICS-004"]
para_section: logistics/projects/LOGISTICS-PLATFORM/desktop/issues
phase: 1 — Foundation
status: todo
priority: Critical
story_points: 8
due_date: "2026-05-16"
assignee: interface-devforge
company: devforge-ai
delegation:
  parent_goal_id: "LOGISTICS-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Build reusable UI foundation for all 8 logistics modules"
  agent_goal: "As interface-devforge, create shared UI component library with logistics-specific patterns"
  task_goal: "Deliver 6+ reusable components with tests and documentation"
---

# LOGISTICS-005: 01700 Build shared UI component library for logistics platform

## Executive Summary

This issue creates the shared UI component library for the logistics platform. All 8 logistics modules will use these components for consistent look and feel. Following PAGE-KNOWLEDGE §4.1–4.7 and §6.1–6.2 UI patterns, this covers: StateButton (three-state navigation), LogisticsTable (sortable/filterable/paginated/exportable), LogisticsCreationModal, LogisticsDetailsModal, ModalTriggerButton, file upload area, and export functionality. Cross-reference `docs-construct-ai/disciplines/01700_logistics/agent-data/01700_UI_UX_GUIDELINES.md` for existing UI patterns.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 5A | Create StateButton component (agents | upserts | workspace) | Three-state navigation working |
| 5B | Create LogisticsTable with sorting, filtering, pagination, bulk actions, CSV/PDF export | Table component operational |
| 5C | Create LogisticsCreationModal with auto-generated IDs (`01700-{YYYY}-{NNNNN}`) and validation | Modal form working |
| 5D | Create LogisticsDetailsModal with status badges, scrape button, role-based action table | Details modal working |
| 5E | Create file upload area with drag-and-drop, progress indicators, format validation | File upload working |
| 5F | Create export utility (CSV, Excel, PDF) | Export functions working |
| 5G | Write component tests for all 6 components | Tests pass |

## Acceptance Criteria

- [ ] StateButton renders 3 states and switches correctly
- [ ] LogisticsTable supports sort, filter, paginate, bulk select, export
- [ ] LogisticsCreationModal validates all fields and generates correct ID format
- [ ] LogisticsDetailsModal shows status badges and role-based actions
- [ ] File upload area supports drag-and-drop with progress indication
- [ ] Export generates CSV, Excel, and PDF formats
- [ ] All components have unit tests with >80% coverage
- [ ] Components follow PAGE-KNOWLEDGE UI patterns and 01900_procurement reference
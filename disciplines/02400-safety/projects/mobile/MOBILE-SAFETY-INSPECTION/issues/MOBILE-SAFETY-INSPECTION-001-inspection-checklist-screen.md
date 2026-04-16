---
id: MOBILE-SAFETY-INSPECTION-001
title: Create InspectionChecklistScreen with basic checklist UI
phase: 1 — Foundation
status: backlog
priority: high
assigneeAgentId: mobileforge-ai-mobile-developer
project: MOBILE-SAFETY-INSPECTION
---

# MOBILE-SAFETY-INSPECTION-001: Create InspectionChecklistScreen with Basic Checklist UI

## Description

Create the main InspectionChecklistScreen component for the mobile safety inspection app. This screen is the primary interface where field inspectors will complete their safety inspections using digital checklists.

**Context**: This is the foundational screen for the MOBILE-SAFETY-INSPECTION project. Without this screen, inspectors cannot perform digital inspections on mobile devices.

**Objectives**:
- Create InspectionChecklistScreen.tsx with mobile-optimized checklist UI
- Implement checklist item display with toggle/completion support
- Add notes field for inspector comments per item
- Include progress indicator showing completion status
- Support pull-to-refresh for latest checklist items

**Scope**:
- In Scope: Screen creation, checklist item components, progress tracking
- Out of Scope: Camera integration, GPS tagging, offline storage (Phase 2)

## Acceptance Criteria

- [ ] InspectionChecklistScreen.tsx created in `src/screens/safety/`
- [ ] Basic checklist UI with scrollable list of items
- [ ] Toggle/completion support for each checklist item
- [ ] Notes field for inspector comments
- [ ] Progress indicator (e.g., "3 of 10 completed")
- [ ] Screen navigation from InspectionScheduleScreen
- [ ] Loading state during data fetch
- [ ] Error state for failed data load
- [ ] Empty state when no items available

## Assigned Company & Agent

- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-mobile-developer

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
- **Target Files:**
  - `mobile/src/screens/safety/InspectionChecklistScreen.tsx`
  - `mobile/src/components/safety/ChecklistItem.tsx`

## Required Skills

- `mobile-development` (MobileForge AI)
- `react-native` (DevForge AI)
- `typescript` (DevForge AI)

## Dependencies

- BLOCKED BY: None
- BLOCKS: MOBILE-SAFETY-INSPECTION-002 (Data Model)

## Estimated Effort

- **Complexity**: medium
- **Estimated Hours**: 4-6 hours
- **Timeline**: Week 1 (Day 1-2)

## Technical Notes

1. Use React Native's FlatList for performant list rendering
2. Implement ChecklistItem as a reusable component
3. Mock data can be used for initial development
4. Follow existing mobile app patterns and styling

## Success Validation

**How to verify completion**:
1. Navigate to InspectionChecklistScreen from schedule
2. View list of checklist items
3. Toggle item completion status
4. Add notes to items
5. Verify progress indicator updates

**Expected Outcomes**:
- Checklist items display correctly
- Completion toggle works
- Notes can be added
- Progress updates in real-time

---

**Created**: 2026-04-14
**Updated**: 2026-04-14
**Status Changes**:
- 2026-04-14: backlog → todo (Ready for development)

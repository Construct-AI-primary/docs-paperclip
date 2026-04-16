---
id: MOBILE-SAFETY-INSPECTION-004
title: Add GPS location tagging for inspection verification
phase: 2 — Core Features
status: backlog
priority: high
assigneeAgentId: mobileforge-ai-mobile-developer
project: MOBILE-SAFETY-INSPECTION
---

# MOBILE-SAFETY-INSPECTION-004: Add GPS Location Tagging for Inspection Verification

## Description

Integrate expo-location to capture GPS coordinates for inspection verification. Location tagging ensures inspections are conducted at the correct sites and provides audit trail evidence.

**Context**: GPS verification is a key mobile advantage over desktop. It proves that inspections were conducted on-site and at specific locations. This aligns with the desktop audit trail requirements.

**Objectives**:
- Integrate expo-location for GPS tracking
- Capture location at inspection start
- Display location coordinates on inspection items
- Show accuracy indicator
- Provide manual location entry fallback
- Resolve GPS address for display

**Scope**:
- In Scope: Location capture, display, fallback
- Out of Scope: Backend location storage (Phase 3)

## Acceptance Criteria

- [ ] expo-location package integrated
- [ ] Location permissions requested and handled
- [ ] Location captured when inspection starts
- [ ] Location displayed on InspectionChecklistScreen header
- [ ] Accuracy indicator (high/medium/low)
- [ ] Manual location entry option when GPS unavailable
- [ ] Address resolution using reverse geocoding
- [ ] Location stored with inspection data

## Assigned Company & Agent

- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-mobile-developer

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
- **Target Files:**
  - `mobile/src/services/locationService.ts`
  - `mobile/src/components/safety/LocationTag.tsx`
  - `mobile/src/screens/safety/InspectionChecklistScreen.tsx` (updated)

## Required Skills

- `mobile-development` (MobileForge AI)
- `location-services` (MobileForge AI)
- `expo-location` (MobileForge AI)

## Dependencies

- BLOCKED BY: MOBILE-SAFETY-INSPECTION-003 (Camera)
- BLOCKS: MOBILE-SAFETY-INSPECTION-005 (Offline Storage)

## Estimated Effort

- **Complexity**: medium
- **Estimated Hours**: 3-5 hours
- **Timeline**: Week 2 (Day 3-4)

## Technical Notes

1. Use balanced accuracy by default for battery efficiency
2. Implement high accuracy mode as option
3. Handle indoor/low-GPS scenarios gracefully
4. Store both coordinates and address

## Success Validation

**How to verify completion**:
1. Start inspection and verify location captured
2. View location on screen header
3. Check accuracy indicator displays correctly
4. Test manual location entry fallback
5. Verify address resolution works

**Expected Outcomes**:
- Location coordinates captured
- Accuracy indicator shows appropriate level
- Manual fallback works when GPS unavailable
- Location stored with inspection

---

**Created**: 2026-04-14
**Updated**: 2026-04-14
**Status Changes**:
- 2026-04-14: backlog → todo (Ready for development)

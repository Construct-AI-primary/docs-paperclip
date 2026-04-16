---
id: MOBILE-SAFETY-INSPECTION-003
title: Integrate camera for photo evidence capture
phase: 2 — Core Features
status: backlog
priority: high
assigneeAgentId: mobileforge-ai-mobile-developer
project: MOBILE-SAFETY-INSPECTION
---

# MOBILE-SAFETY-INSPECTION-003: Integrate Camera for Photo Evidence Capture

## Description

Integrate expo-camera into the inspection workflow to enable inspectors to capture photo evidence of inspection findings, non-conformances, and general documentation.

**Context**: Photo evidence is critical for safety inspections. Inspectors need to document conditions, equipment status, and non-conformances with visual evidence. This aligns with the desktop system's evidence attachment capabilities.

**Objectives**:
- Integrate expo-camera for photo capture
- Implement camera permissions handling
- Create reusable CameraCapture component
- Add photo compression for bandwidth efficiency
- Attach photos to checklist items

**Scope**:
- In Scope: Camera integration, photo capture, compression
- Out of Scope: Photo upload to backend (Phase 3)

## Acceptance Criteria

- [ ] expo-camera package integrated
- [ ] Camera permissions requested and handled gracefully
- [ ] CameraCapture component created
- [ ] Photo capture from InspectionChecklistScreen
- [ ] Photo preview with retake option
- [ ] Photo attachment to checklist items
- [ ] Photo compression (max 1200px, 70% JPEG)
- [ ] Photo stored locally with inspection reference
- [ ] Error handling for camera failures

## Assigned Company & Agent

- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-mobile-developer

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
- **Target Files:**
  - `mobile/src/components/safety/CameraCapture.tsx`
  - `mobile/src/services/cameraService.ts`
  - `mobile/src/screens/safety/InspectionChecklistScreen.tsx` (updated)

## Required Skills

- `mobile-development` (MobileForge AI)
- `camera-integration` (DevForge AI)
- `expo-camera` (MobileForge AI)

## Dependencies

- BLOCKED BY: MOBILE-SAFETY-INSPECTION-002 (Data Model)
- BLOCKS: MOBILE-SAFETY-INSPECTION-004 (GPS Integration)

## Estimated Effort

- **Complexity**: medium
- **Estimated Hours**: 5-7 hours
- **Timeline**: Week 2 (Day 1-2)

## Technical Notes

1. Reuse patterns from MOBILE-SAFETY-INCIDENT camera integration
2. Use expo-image-manipulator for compression
3. Store photos in app's document directory
4. Include GPS metadata in photo storage

## Success Validation

**How to verify completion**:
1. Request camera permission
2. Capture photo from checklist item
3. Preview and optionally retake
4. Confirm photo attached to item
5. Verify photo stored locally

**Expected Outcomes**:
- Camera opens and captures photos
- Photos compressed before storage
- Photos attached to correct inspection items
- Local storage contains photos

---

**Created**: 2026-04-14
**Updated**: 2026-04-14
**Status Changes**:
- 2026-04-14: backlog → todo (Ready for development)

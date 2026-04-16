---
id: MOBILE-SAFETY-INCIDENT-001
title: Integrate Camera for Incident Photo Capture
phase: 1 — Camera Integration
status: open
priority: Critical
---

# MOBILE-SAFETY-INCIDENT-001: Integrate Camera for Incident Photo Capture

## Description

Integrate expo-camera into the IncidentReportScreen to enable photo capture for incident documentation, including camera permissions, photo preview, and evidence attachment to incident reports.

## Current State

IncidentReportScreen.tsx exists but has no camera integration. Users cannot capture photos of incident scenes, equipment damage, or safety violations.

## Acceptance Criteria

- [ ] expo-camera package installed and configured
- [ ] Camera permissions requested and handled
- [ ] Camera button added to IncidentReportScreen
- [ ] Photo capture functionality implemented
- [ ] Photo preview and annotation capabilities
- [ ] Photo attachment to incident reports
- [ ] Photo compression for mobile bandwidth
- [ ] Error handling for camera failures

## Assigned Company & Agent

- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - `mobile/src/screens/safety/IncidentReportScreen.tsx`
  - `mobile/src/components/safety/IncidentCamera.tsx`
  - `mobile/src/services/cameraService.ts`

## Required Skills

- `mobile-development` (MobileForge)
- `camera-integration` (DevForge)
- `typescript` (DevForge)
- `expo-camera` (MobileForge)

## Dependencies

- BLOCKED BY: None
- BLOCKS: MOBILE-SAFETY-INCIDENT-002, MOBILE-SAFETY-INCIDENT-003

## Paperclip Task Schema

```yaml
company: mobileforge-ai
agents:
  - mobileforge-ai-frontend-engineer
toolsets:
  - file_tools
  - code_execution
  - camera
max_iterations: 50
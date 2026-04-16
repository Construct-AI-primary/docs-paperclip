---
id: MOBILE-SAFETY-INSPECTION-006
title: Backend API integration for inspection sync
phase: 3 — Integration
status: backlog
priority: medium
assigneeAgentId: mobileforge-ai-mobile-developer
project: MOBILE-SAFETY-INSPECTION
---

# MOBILE-SAFETY-INSPECTION-006: Backend API Integration for Inspection Sync

## Description

Integrate the mobile inspection app with backend API endpoints for fetching scheduled inspections and syncing completed inspections. This connects the offline-capable mobile app to the broader SAFETY-INSPECTION backend infrastructure.

**Context**: Backend integration is essential for the mobile app to fetch scheduled inspections from the server and sync completed inspections. This aligns with the desktop system's API contracts.

**Objectives**:
- Connect to InfraForge AI backend API endpoints
- Fetch scheduled inspections from server
- Submit completed inspections to server
- Upload photos to server with retry logic
- Handle API errors gracefully
- Implement proper authentication

**Scope**:
- In Scope: API integration, data sync, error handling
- Out of Scope: Backend API development (handled by InfraForge AI)

## Acceptance Criteria

- [ ] Axios client configured with base URL
- [ ] Authentication header injection
- [ ] GET /api/inspections endpoint integration
- [ ] GET /api/inspections/:id endpoint integration
- [ ] POST /api/inspections/:id/complete endpoint integration
- [ ] POST /api/inspections/:id/photos endpoint integration
- [ ] Retry logic for failed uploads
- [ ] Error handling with user-friendly messages
- [ ] Loading states during API calls

## Assigned Company & Agent

- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-mobile-developer

## Supporting Companies

- **InfraForge AI**: Backend API endpoints and data contracts

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
- **Target Files:**
  - `mobile/src/services/inspectionService.ts` (updated)
  - `mobile/src/services/apiClient.ts`

## Required Skills

- `mobile-development` (MobileForge AI)
- `api-integration` (DevForge AI)
- `typescript` (DevForge AI)

## Dependencies

- BLOCKED BY: MOBILE-SAFETY-INSPECTION-005 (Offline Storage)
- BLOCKS: MOBILE-SAFETY-INSPECTION-007 (E2E Testing)

## Estimated Effort

- **Complexity**: medium
- **Estimated Hours**: 5-7 hours
- **Timeline**: Week 3 (Day 3-4)

## Technical Notes

1. Use interceptors for authentication token injection
2. Implement exponential backoff for retries
3. Align request/response types with backend API contracts
4. Use response caching for inspection lists

## Success Validation

**How to verify completion**:
1. Fetch scheduled inspections from server
2. Complete inspection and verify sync
3. Check photos uploaded successfully
4. Test error handling scenarios
5. Verify offline/online sync works

**Expected Outcomes**:
- Inspections sync correctly to server
- Photos upload successfully
- Errors handled gracefully
- Retry logic works for failed uploads

---

**Created**: 2026-04-14
**Updated**: 2026-04-14
**Status Changes**:
- 2026-04-14: backlog → todo (Ready for development)

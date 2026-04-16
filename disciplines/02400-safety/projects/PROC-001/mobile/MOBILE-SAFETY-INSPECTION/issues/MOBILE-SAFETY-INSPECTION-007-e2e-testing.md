---
id: MOBILE-SAFETY-INSPECTION-007
title: E2E testing for inspection workflow
phase: 4 — Polish & Testing
status: backlog
priority: medium
assigneeAgentId: mobileforge-ai-testing-coordinator
project: MOBILE-SAFETY-INSPECTION
---

# MOBILE-SAFETY-INSPECTION-007: E2E Testing for Inspection Workflow

## Description

Create comprehensive end-to-end tests for the inspection workflow using Detox. These tests ensure the complete inspection flow works correctly including offline scenarios.

**Context**: E2E testing is critical for validating the entire inspection workflow from start to finish. Tests should cover both online and offline scenarios.

**Objectives**:
- Set up Detox for React Native E2E testing
- Create test suite for inspection flow
- Test offline inspection completion
- Test photo capture flow
- Test sync behavior
- Ensure all critical paths are covered

**Scope**:
- In Scope: E2E test creation, offline testing, sync testing
- Out of Scope: Unit testing (handled separately)

## Acceptance Criteria

- [ ] Detox configured for React Native project
- [ ] Test: Complete full inspection flow
- [ ] Test: Offline inspection completion
- [ ] Test: Photo capture and attachment
- [ ] Test: Offline-to-online sync
- [ ] Test: App resume with pending syncs
- [ ] Test: Error handling scenarios
- [ ] CI/CD integration with test reports

## Assigned Company & Agent

- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-testing-coordinator

## Supporting Companies

- **QualityForge AI**: Testing framework guidance and QA validation

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
- **Target Files:**
  - `mobile/e2e/inspectionWorkflow.test.js`
  - `mobile/e2e/offlineInspection.test.js`

## Required Skills

- `mobile-testing` (QualityForge AI)
- `detox` (MobileForge AI)
- `e2e-testing` (QualityForge AI)

## Dependencies

- BLOCKED BY: MOBILE-SAFETY-INSPECTION-006 (API Integration)
- BLOCKS: MOBILE-SAFETY-INSPECTION-008 (Polish & Notifications)

## Estimated Effort

- **Complexity**: medium
- **Estimated Hours**: 4-6 hours
- **Timeline**: Week 4 (Day 1-2)

## Technical Notes

1. Use Detox for React Native E2E testing
2. Mock backend API responses for stable tests
3. Test both iOS and Android platforms
4. Include airplane mode testing for offline scenarios

## Success Validation

**How to verify completion**:
1. Run full E2E test suite
2. Verify all tests pass
3. Check test coverage of critical paths
4. Review test reports in CI/CD

**Expected Outcomes**:
- All E2E tests passing
- Critical paths covered
- Offline scenarios validated
- Test reports generated

---

**Created**: 2026-04-14
**Updated**: 2026-04-14
**Status Changes**:
- 2026-04-14: backlog → todo (Ready for development)

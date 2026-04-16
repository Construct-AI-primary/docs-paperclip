---
id: MOBILE-LOGISTICS-DASH-001
title: Connect Logistics Dashboard to Real API Endpoints
phase: 1 — API Integration & Data Layer
status: open
priority: Critical
---

# MOBILE-LOGISTICS-DASH-001: Connect Logistics Dashboard to Real API Endpoints

## Description

Replace the mock data in LogisticsDashboardScreen.tsx with real API calls to desktop logistics endpoints, enabling live shipment tracking and analytics data in the mobile dashboard.

## Current State

LogisticsDashboardScreen.tsx currently displays static mock data. The dashboard cannot show real-time shipment information, delivery status, or logistics KPIs to mobile users.

## Acceptance Criteria

- [ ] logisticsService.ts created with API client methods
- [ ] Dashboard loads real shipment data from APIs
- [ ] Loading states displayed during data fetching
- [ ] Error handling works for API failures
- [ ] Pull-to-refresh updates dashboard data
- [ ] Data caching reduces redundant API calls
- [ ] No mock data remaining in dashboard

## Assigned Company & Agent

- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-backend-engineer

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** `https://github.com/Construct-AI-primary/construct_ai.git`
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
  - **Documentation Repository:** `https://github.com/Construct-AI-primary/docs-paperclip.git`
  - **Construct AI Docs Repository:** `https://github.com/Construct-AI-primary/construct_ai_docs.git`
- **Target Files:**
  - `mobile/src/screens/logistics/LogisticsDashboardScreen.tsx`
  - `mobile/src/services/logisticsService.ts`
  - `mobile/src/store/slices/logisticsSlice.ts`

## Required Skills

- `mobile-development` (MobileForge)
- `api-integration` (InfraForge)
- `redux-async` (DevForge)
- `typescript` (DevForge)

## Dependencies

- BLOCKED BY: None
- BLOCKS: MOBILE-LOGISTICS-DASH-002, MOBILE-LOGISTICS-DASH-003

## Paperclip Task Schema

```yaml
company: mobileforge-ai
agents:
  - mobileforge-ai-backend-engineer
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 50
---
id: MOBILE-PROC-DASH-002
title: Connect Dashboard to Procurement API
phase: 1 — Foundation
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-backend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-DASHBOARD
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-DASH-001
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-DASH-002: Connect Dashboard to Procurement API

## Description

Replace mock data in procurement dashboard with real API calls to desktop procurement endpoints.

## Problem

LogisticsDashboardScreen uses mock data. Same pattern would repeat for procurement if not connected to real API.

## Required Changes

1. Create procurementService.ts with API client
2. Implement fetchOrders, fetchSpendSummary, fetchPendingApprovals
3. Replace mock data in dashboard with real API calls
4. Add error handling and retry logic
5. Add API response caching

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-backend-engineer

## Acceptance Criteria
- [ ] procurementService.ts created with API client
- [ ] Real orders displayed in dashboard
- [ ] Spend summary from real data
- [ ] Pending approvals from real data
- [ ] Error handling works for API failures
- [ ] Caching reduces duplicate API calls

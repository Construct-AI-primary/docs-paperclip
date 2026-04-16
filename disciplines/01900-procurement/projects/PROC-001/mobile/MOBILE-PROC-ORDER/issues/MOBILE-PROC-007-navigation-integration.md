---
id: MOBILE-PROC-007
title: Integrate Procurement Screens into App Navigation
phase: 3 — Integration & Testing
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-001
  - MOBILE-PROC-002
  - MOBILE-PROC-003
toolsets:
  - file_tools
  - code_execution
max_iterations: 30
---

# MOBILE-PROC-007: Integrate Procurement Screens into App Navigation

## Description

Register procurement screens in the app navigation stack so users can access procurement functionality.

## Problem

CivilEngineeringScreen.tsx and other screens are not registered in App.tsx navigation. Cannot be accessed by users.

## Required Changes

1. Add procurement navigation types to App.tsx
2. Create procurement tab in bottom navigation
3. Add route for PurchaseOrderScreen
4. Add route for SupplierListScreen
5. Add route for OrderHistoryScreen

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] Procurement tab visible in bottom navigation
- [ ] PurchaseOrderScreen accessible via navigation
- [ ] SupplierListScreen accessible via navigation
- [ ] OrderHistoryScreen accessible via navigation
- [ ] Navigation types properly typed in TypeScript

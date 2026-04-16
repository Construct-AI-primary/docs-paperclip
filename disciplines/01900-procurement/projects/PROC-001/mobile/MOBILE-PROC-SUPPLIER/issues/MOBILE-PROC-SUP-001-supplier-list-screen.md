---
id: MOBILE-PROC-SUP-001
title: Create SupplierListScreen with Search and Filter
phase: 1 — Foundation
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-SUPPLIER
platform: mobile
parent_issue: none
dependencies: []
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-SUP-001: Create SupplierListScreen with Search and Filter

## Description

Create supplier list screen with search, filter, and performance metrics display.

## Problem

No supplier list exists on mobile. Cannot select suppliers for orders or view supplier info.

## Required Changes

1. Create SupplierListScreen.tsx
2. Implement search with debouncing
3. Add filter by category, rating, status
4. Display supplier cards with key info
5. Add pull-to-refresh
6. Connect to supplier API

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] Supplier list displays all suppliers
- [ ] Search works with 300ms debounce
- [ ] Filters functional (category, rating, status)
- [ ] Supplier cards show key info
- [ ] Pull-to-refresh works
- [ ] Connected to real supplier API

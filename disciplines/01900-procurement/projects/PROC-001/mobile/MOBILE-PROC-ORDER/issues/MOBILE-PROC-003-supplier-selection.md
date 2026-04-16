---
id: MOBILE-PROC-003
title: Add Supplier Selection Dropdown with Search
phase: 1 — Foundation
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-mobile-developer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-001
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-003: Add Supplier Selection Dropdown with Search

## Description

Add supplier search and selection UI to PurchaseOrderScreen, integrating with the desktop supplier API and local SQLite cache.

## Problem

PurchaseOrderScreen has no supplier selection capability. The procurement workflow requires supplier identification for every order.

## Required Changes

1. Create SupplierSearchDropdown component
2. Integrate with desktop supplier API for search
3. Cache supplier results in SQLite for offline use
4. Add supplier selection to procurementSlice.ts
5. Add supplier info display in order form

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-mobile-developer

## Acceptance Criteria
- [ ] SupplierSearchDropdown component created
- [ ] Search connects to desktop supplier API
- [ ] Results cached in SQLite for offline
- [ ] Selected supplier stored in procurementSlice
- [ ] Supplier name/info displayed in order form
- [ ] Debounced search (300ms delay)

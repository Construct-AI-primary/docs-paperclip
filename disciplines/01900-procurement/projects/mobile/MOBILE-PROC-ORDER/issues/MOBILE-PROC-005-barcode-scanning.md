---
id: MOBILE-PROC-005
title: Add Barcode Scanning for Item Lookup
phase: 2 — Mobile-Only Features
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-002
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-005: Add Barcode Scanning for Item Lookup

## Description

Add barcode scanning capability to PurchaseOrderScreen for quick item lookup and order creation.

## Problem

No barcode scanning exists for procurement. Field users need quick item identification without manual entry.

## Required Changes

1. Integrate expo-barcode-scanner into PurchaseOrderScreen
2. Create ItemScannerSheet component
3. Connect scan results to item catalog API
4. Add scanned items to order automatically
5. Cache item catalog for offline scanning

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] Barcode scanner opens from order screen
- [ ] Scan results trigger item lookup
- [ ] Scanned items added to order
- [ ] Works offline with cached catalog
- [ ] Scanner has flashlight toggle

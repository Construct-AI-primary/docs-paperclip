---
id: MOBILE-PROC-002
title: Integrate PurchaseOrderScreen with SQLite Database
phase: 1 — Foundation
status: open
priority: Critical
company: mobileforge-ai
agent: mobileforge-ai-mobile-developer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies: ['MOBILE-PROC-001']
toolsets: ['file_tools', 'code_execution']
max_iterations: 50---

# MOBILE-PROC-002: Integrate PurchaseOrderScreen with SQLite Database

## Description

Replace in-memory state management in PurchaseOrderScreen.tsx with SQLite database integration for persistent local storage.

## Problem

PurchaseOrderScreen.tsx (589 lines) currently uses in-memory state. Orders are lost on app restart and offline operations are not supported.

## Required Changes

1. Create procurement tables in services/database.ts:
   - `purchase_orders` (id, order_number, supplier_id, items, status, created_at, updated_at)
   - `purchase_order_items` (id, order_id, item_name, quantity, unit_price, total)
2. Create CRUD operations in services/procurementService.ts
3. Replace useState/useReducer with redux-thunk integration using SQLite
4. Implement load/save operations
5. Add error handling for database operations

## Required Skills

- `mobile-development` (MobileForge)
- `database-integration` (InfraForge)
- `sqlite` (InfraForge)

## Acceptance Criteria

- [ ] purchase_orders table created in SQLite
- [ ] purchase_order_items table created in SQLite
- [ ] CRUD operations in procurementService.ts
- [ ] PurchaseOrderScreen loads from SQLite on mount
- [ ] PurchaseOrderScreen saves to SQLite on submit
- [ ] Error handling for all database operations
- [ ] No more in-memory state for orders

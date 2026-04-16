---
id: MOBILE-PROC-001
title: Create procurementSlice.ts for Redux State Management
phase: 1 — Foundation
status: open
priority: Critical
company: mobileforge-ai
agent: mobileforge-ai-mobile-developer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies: []
toolsets: ['file_tools', 'code_execution']
max_iterations: 50---

# MOBILE-PROC-001: Create procurementSlice.ts for Redux State Management

## Description

Create the Redux slice for procurement state management in the mobile app managing purchase orders, supplier selection, offline queue, and related procurement data.

## Problem

No procurement Redux slice exists. PurchaseOrderScreen.tsx uses in-memory state (useState, useReducer) which doesn't persist or support offline operations.

## Required Changes

Create `store/slices/procurementSlice.ts` with:
1. Purchase order state (orders, currentOrder, loading, error)
2. Supplier state (suppliers, selectedSupplier, supplierSearch)
3. Offline queue state (offlineQueue, isSyncing, lastSyncTime)
4. Reducers: createOrder, updateOrder, selectSupplier, loadSuppliers, addToOfflineQueue, syncOnline, clearError
5. Async thunks: fetchSuppliersAsync, saveOrderAsync, syncOfflineQueueAsync

## Testing Strategy

- Unit test all reducers
- Unit test async thunks with mocked API
- Integration test with SQLite database
- Test offline queue behavior

## Required Skills

- `mobile-development` (MobileForge)
- `redux-state-management` (MobileForge)
- `typescript` (DevForge)

## Acceptance Criteria

- [ ] procurementSlice.ts created with all state types
- [ ] All reducers implemented and typed
- [ ] Async thunks implemented for API/DB operations
- [ ] Offline queue reducer handles pending operations
- [ ] Unit tests pass for all reducers
- [ ] Slice exported from store/slices/index.ts

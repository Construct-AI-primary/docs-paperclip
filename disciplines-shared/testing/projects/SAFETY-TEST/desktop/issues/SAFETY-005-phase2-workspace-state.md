---
id: SAFETY-005
title: 02400 Workspace State — Fleet, Warehouse, Supplier Directory, Cross-Discipline, Vector Manager
description: Verify Workspace state buttons and all 5 modals (Fleet Management, Warehouse Management, Supplier Directory, Cross-Discipline Sharing, Vector Data Manager)
labels: ["testing", "safety", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["SAFETY-001", "SAFETY-002"]
para_section: testing/projects/SAFETY-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: todo
priority: High
story_points: 8
due_date: "2026-05-02"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-SAFETY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify all 5 Workspace modals across fleet, warehouse, supplier, cross-discipline, and vector operations."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02400 safety page production readiness"
  agent_goal: "As validator-qualityforge, verify Workspace state buttons and all 5 modals render and function correctly"
  task_goal: "Execute workspace modal testing with >95% pass rate"
---

# SAFETY-005: 02400 Workspace State — Fleet, Warehouse, Supplier Directory, Cross-Discipline, Vector Manager

## Executive Summary

This issue validates the Workspace state of the 02400 safety page. Five modal triggers (Fleet Management, Warehouse Management, Supplier Directory, Cross-Discipline Sharing, Vector Data Manager) must render correctly, open their respective modals, and perform their intended operations.

## Problem Statement / Scope

The Workspace state contains 5 modal buttons covering safety operations: Fleet Management (02400-FleetManagementModal), Warehouse Management (02400-WarehouseManagementModal), Supplier Directory (02400-SupplierDirectoryModal), Cross-Discipline Sharing (DisciplinePermissionMatrixModal), and Vector Data Manager (VectorDataManagerModal).

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 5A | Fleet Management modal | Modal opens with fleet CRUD, vehicle status, GPS map |
| 5B | Fleet Management CRUD | Fleet vehicle create/read/update/delete persists |
| 5C | Warehouse Management modal | Modal opens with inventory display |
| 5D | Warehouse stock update | Stock level updates persist |
| 5E | Supplier Directory modal | Modal opens with supplier CRUD |
| 5F | Supplier Directory CRUD | Supplier create/read/update/delete persists |
| 5G | Cross-Discipline Sharing modal | DisciplinePermissionMatrixModal opens |
| 5H | Vector Data Manager modal | VectorDataManagerModal opens |
| 5I | Vector insert+query | Vector insert succeeds; hnsw query returns results |

## Acceptance Criteria

- [ ] Fleet Management button renders in Workspace state
- [ ] 02400-FleetManagementModal opens with vehicle list
- [ ] Fleet vehicle CRUD operations persist to safety_fleet
- [ ] Vehicle status updates (active, maintenance, idle) work
- [ ] GPS coordinates display on map component
- [ ] Warehouse Management button renders in Workspace state
- [ ] 02400-WarehouseManagementModal opens with inventory
- [ ] Stock level updates persist
- [ ] Supplier Directory button renders in Workspace state
- [ ] 02400-SupplierDirectoryModal opens with supplier list
- [ ] Supplier CRUD operations persist to suppliers table
- [ ] Cross-Discipline Sharing button renders
- [ ] DisciplinePermissionMatrixModal opens
- [ ] Vector Data Manager button renders
- [ ] VectorDataManagerModal opens
- [ ] Vector insert succeeds
- [ ] hnsw query returns results

## Dependencies

- **Depends on:** SAFETY-001, SAFETY-002

## Estimated Duration

60 minutes

## Risk Level

High — largest state with 5 modals.

## QC Team Checks

- [ ] **Fleet Management:** CRUD on safety_fleet table verified
- [ ] **Fleet Management:** GPS coordinates pass validation (-90 to 90, -180 to 180)
- [ ] **Warehouse Management:** Stock fields show correct inventory
- [ ] **Supplier Directory:** Supplier data persists to suppliers table
- [ ] **Vector Manager:** hnsw query returns semantically similar results

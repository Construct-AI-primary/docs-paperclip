---
id: SAFETY-003
title: 02400 Agents State — Freight Booking & Customs Clearance
description: Verify Agents state buttons and modals (Freight Booking, Customs Clearance) render, validate forms, and persist data correctly
labels: ["testing", "safety", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["SAFETY-001", "SAFETY-002"]
para_section: testing/projects/SAFETY-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: todo
priority: High
story_points: 5
due_date: "2026-05-02"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-SAFETY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify all Agents state modals with form validation and data persistence checks."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 02400 safety page production readiness"
  agent_goal: "As validator-qualityforge, verify Agents state buttons and modals (Freight Booking, Customs Clearance) render, validate forms, and persist data correctly"
  task_goal: "Execute modal testing with >95% pass rate"
---

# SAFETY-003: 02400 Agents State — Freight Booking & Customs Clearance

## Executive Summary

This issue validates the Agents state of the 02400 safety page. Two modal triggers (Freight Booking, Customs Clearance) must render correctly, open their respective modals, validate form inputs, persist data to the correct Supabase tables, and close cleanly.

## Problem Statement / Scope

The Agents state contains 2 modal buttons: Freight Booking (02400-FreightBookingModal) and Customs Clearance (02400-CustomsClearanceModal). Each modal must display safety-specific forms, validate required fields, submit data to `safety_freight` or `safety_customs` tables respectively, handle errors gracefully, and close properly.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 3A | Agents state button | Clicking Agents button shows 2 modal triggers |
| 3B | Freight Booking modal | Modal opens with shipment form (origin, destination, carrier, mode, weight_kg) |
| 3C | Freight Booking validation | Required fields validated; invalid data rejected |
| 3D | Freight Booking submission | Data persists to safety_freight table |
| 3E | Customs Clearance modal | Modal opens with declaration form (declaration_id, shipment_id, clearance_status, duty_amount) |
| 3F | Customs Clearance validation | Required fields validated; document upload required |
| 3G | Customs Clearance submission | Data persists to safety_customs table |

## Acceptance Criteria

- [ ] Agents state button triggers state change to 'agents'
- [ ] Freight Booking modal trigger renders with correct id
- [ ] 02400-FreightBookingModal opens on click
- [ ] Shipment form fields match safety_freight schema
- [ ] Origin/destination validation (required, non-empty)
- [ ] Carrier selection works
- [ ] Mode selection (air, sea, land, rail) works
- [ ] Weight validation (positive number)
- [ ] Booking submission persists to safety_freight
- [ ] Customs Clearance modal trigger renders with correct id
- [ ] 02400-CustomsClearanceModal opens on click
- [ ] Declaration form fields match safety_customs schema
- [ ] Document upload accepts PDF and images
- [ ] Clearance submission persists to safety_customs
- [ ] Both modals close properly

## Dependencies

- **Depends on:** SAFETY-001, SAFETY-002

## Estimated Duration

45 minutes

## Risk Level

High — core interactive components.

## QC Team Checks

- [ ] **Freight Booking:** Form fields match safety_freight schema columns
- [ ] **Freight Booking:** Origin/destination required validation works
- [ ] **Freight Booking:** Weight must be positive number
- [ ] **Freight Booking:** Submission writes to safety_freight table
- [ ] **Customs Clearance:** Form fields match safety_customs schema
- [ ] **Customs Clearance:** Document upload validates file types
- [ ] **Customs Clearance:** Submission writes to safety_customs table

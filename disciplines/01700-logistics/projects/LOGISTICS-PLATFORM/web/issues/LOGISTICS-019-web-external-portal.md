---
id: LOGISTICS-019
title: 01700 Build external web portal for supplier and customer logistics access
description: Web-based portal for suppliers and customers to track shipments, submit customs documents, view delivery schedules, and manage logistics requests
labels: ["logistics", "web", "3 — Integration"]
blocked_by: []
depends_on: ["LOGISTICS-001", "LOGISTICS-002", "LOGISTICS-005", "LOGISTICS-008"]
para_section: logistics/projects/LOGISTICS-PLATFORM/web/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 8
due_date: "2026-06-20"
assignee: interface-devforge
company: devforge-ai
delegation:
  parent_goal_id: "LOGISTICS-ROOT-2026"
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver external web portal for supplier/customer logistics access"
  agent_goal: "As interface-devforge, build web portal for external stakeholders"
  task_goal: "Functional web portal with shipment tracking, document submission, and request management"
---

# LOGISTICS-019: 01700 Build external web portal for supplier and customer logistics access

## Executive Summary

This issue creates the external web portal for suppliers and customers to interact with the logistics platform. External stakeholders need visibility into shipment status, customs clearance progress, delivery schedules, and the ability to submit documents and manage logistics requests without requiring desktop app access.

## Problem Statement / Scope

Suppliers and customers need self-service access to logistics information. This issue covers: shipment tracking dashboard with real-time status, customs clearance progress view, delivery schedule viewer, document submission portal (commercial invoices, packing lists, certificates of origin), logistics request creation (new shipment requests, delivery rescheduling), notification preferences, and secure authentication via SSO/email link. Desktop UI is covered by LOGISTICS-006 through LOGISTICS-014 for internal users.

## Acceptance Criteria

- [ ] External portal accessible via web browser (responsive design)
- [ ] Shipment tracking dashboard shows real-time status for all active shipments
- [ ] Customs clearance progress view shows current stage and estimated completion
- [ ] Delivery schedule viewer shows upcoming and past deliveries
- [ ] Document submission portal accepts PDF, Excel, and image uploads
- [ ] Logistics request creation form with validation
- [ ] Notification preferences configurable per user
- [ ] SSO/email link authentication working
- [ ] Portal follows PAGE-KNOWLEDGE UI patterns
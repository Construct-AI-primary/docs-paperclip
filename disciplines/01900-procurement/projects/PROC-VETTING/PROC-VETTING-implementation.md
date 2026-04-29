---
title: "PROC-VETTING Implementation"
description: "Vendor Vetting & Pre-Qualification — complete implementation for CIDB/BBBEE/financial/safety vetting pipeline with 02400 Safety workflow integration"
gigabrain_tags: vetting, pre-qualification, supplier, cidb, bbbee, safety, procurement
status: planned
company: "DomainForge AI, InfraForge AI, Loopy AI"
issue_prefix: "VETTING"
phase_count: 3
total_hours: 18-28
completion_criteria:
  - CIDB verification returns accurate contractor grading
  - BBBEE level cache updates from source
  - Financial scoring engine evaluates D&B/credit check data
  - Safety vetting delegates to 02400 Contractor Vetting workflow
  - Supplier Database shared with 01900 Procurement Supplier Directory
  - Vetting dashboard shows pipeline status for procurement managers
  - Decline notification sent with structured feedback
---

# PROC-VETTING Implementation

## Overview

3-phase build of the Vendor Vetting & Pre-Qualification system, owned by 01900 Procurement discipline.

## Phases

| Phase | Name | Hours | Lead | Supporting |
|-------|------|-------|------|------------|
| 1 | Vetting Workflow Engine — CIDB, BBBEE, Financial, Safety | 6-10 | DomainForge AI | — |
| 2 | Supplier Database & Integration | 6-10 | InfraForge AI | DomainForge AI |
| 3 | Vetting UI & Notifications | 6-8 | Loopy AI | DomainForge AI |

## Related Documents

- UI/UX Spec: See `UI-UX-SPECIFICATION.md`
- Master Plan: See `plan.md`
- Project Metadata: See `project.md`
- Page Knowledge: See `knowledge/PAGE-KNOWLEDGE.md`

## Cross-Discipline References

| Reference | Workflow | Purpose |
|-----------|----------|---------|
| 02400 Safety | Contractor Vetting Workflow | Safety record evaluation |
| 01900 Procurement | Supplier Directory | Shared supplier data |
| BTND-PLATFORM | RFQ Pre-Qualification | Downstream consumer |
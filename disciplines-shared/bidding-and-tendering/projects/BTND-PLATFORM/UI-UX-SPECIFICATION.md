---
title: "BTND-PLATFORM — bidding-and-tendering UI/UX Specification (Override)"
description: "Override UI/UX specification for the BTND-PLATFORM project — extending bidding-and-tendering pattern"
version: "1.0"
date: "2026-04-29"
project_code: "BTND-PLATFORM"
discipline: "bidding-and-tendering"
gigabrain_tags: [bidding-and-tendering, ui-ux, specification, override]
related_docs:
  - docs-paperclip/disciplines-shared/bidding-and-tendering/UI-UX-SPECIFICATION.md
---

# BTND-PLATFORM — bidding-and-tendering UI/UX Specification

## Override: bidding-and-tendering Pattern

### 1. Override Summary

| Aspect | Value |
|--------|-------|
| **Project** | BTND-PLATFORM |
| **Discipline** | bidding-and-tendering |
| **Extends** | [bidding-and-tendering](UI-UX-SPECIFICATION.md) |
| **Spec Type** | Override — lean spec referencing parent pattern |
| **Issue Count** |        5 |
| **Color** | #1a237e / #5c6bc0 |

### 2. Scope

This project implements domain-specific workflow automation within the bidding-and-tendering domain.
All UX patterns, three-state button rules, mermaid flow diagrams, implementation standards,
screen specifications, AI model backend, and agent knowledge ownership rules follow the
bidding-and-tendering discipline-level UI-UX-SPECIFICATION.md, with the following project-specific overrides.

### 3. Workflow Overrides

```mermaid
flowchart TD
    Load[Page Load] --> Rights{Role Check}
    Rights -->|viewer+| Router[State Router - BTND-PLATFORM]
    Rights -->|denied| Denied[Access Denied]
    Router --> Upserts[Upserts - Records]
    Router --> Agents[Agents - Automation]
    Router --> Workspace[Workspace - HITL Review]
```

### 4. Entity / Data Sources

| Entity | Source | Description |
|--------|--------|-------------|
| Records | API | Domain records managed via Upserts |
| Agents | API | Automation agents for BTND-PLATFORM |
| Reviews | API | HITL review queue |

### 5. Role Gates

| Role | Gate | Access |
|------|------|--------|
| Viewer | `viewer` | View only |
| Editor | `editor` | Create / Edit / Import |
| Reviewer | `reviewer` | Approve / Reject |
| Governance | `governance` | Delete / Config |

### 6. Associated Issues


  - `_A_QA`
  - `of`
  - `BTND-001-foundation-database-api`
  - `_A_QA`
  - `of`
  - `BTND-002-bidding-system`
  - `_A_QA`
  - `of`
  - `BTND-003-tendering-system`
  - `_A_QA`
  - `of`
  - `BTND-004-external-portal`
  - `_A_QA`
  - `of`
  - `BTND-005-integration-testing`

### 7. Testing Checklist

- [ ] Upserts: Create, Edit, Delete workflows functional
- [ ] Agents: Agent status and configuration visible
- [ ] Workspace: HITL review queue operational
- [ ] Role gates: viewer, editor, reviewer, governance enforced
- [ ] Chatbot: stateAware chatbot integrated (z-index 1500)

---

**Version**: 1.0 | **Date**: 2026-04-29

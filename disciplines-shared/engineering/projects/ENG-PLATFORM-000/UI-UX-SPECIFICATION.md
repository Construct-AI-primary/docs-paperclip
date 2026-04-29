---
title: "ENG-PLATFORM-000 — engineering UI/UX Specification (Override)"
description: "Override UI/UX specification for the ENG-PLATFORM-000 project — extending engineering pattern"
version: "1.0"
date: "2026-04-29"
project_code: "ENG-PLATFORM-000"
discipline: "engineering"
gigabrain_tags: [engineering, ui-ux, specification, override]
related_docs:
  - docs-paperclip/disciplines-shared/engineering/UI-UX-SPECIFICATION.md
---

# ENG-PLATFORM-000 — engineering UI/UX Specification

## Override: engineering Pattern

### 1. Override Summary

| Aspect | Value |
|--------|-------|
| **Project** | ENG-PLATFORM-000 |
| **Discipline** | engineering |
| **Extends** | [engineering](UI-UX-SPECIFICATION.md) |
| **Spec Type** | Override — lean spec referencing parent pattern |
| **Issue Count** |       17 |
| **Color** | #1565C0 / #42A5F5 |

### 2. Scope

This project implements domain-specific workflow automation within the engineering domain.
All UX patterns, three-state button rules, mermaid flow diagrams, implementation standards,
screen specifications, AI model backend, and agent knowledge ownership rules follow the
engineering discipline-level UI-UX-SPECIFICATION.md, with the following project-specific overrides.

### 3. Workflow Overrides

```mermaid
flowchart TD
    Load[Page Load] --> Rights{Role Check}
    Rights -->|viewer+| Router[State Router - ENG-PLATFORM-000]
    Rights -->|denied| Denied[Access Denied]
    Router --> Upserts[Upserts - Records]
    Router --> Agents[Agents - Automation]
    Router --> Workspace[Workspace - HITL Review]
```

### 4. Entity / Data Sources

| Entity | Source | Description |
|--------|--------|-------------|
| Records | API | Domain records managed via Upserts |
| Agents | API | Automation agents for ENG-PLATFORM-000 |
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
  - `ENG-PLATFORM-001-shared-components`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-002-discipline-config`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-003-database-schema`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-004-knowledgeforge`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-005-learningforge`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-006-domainforge`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-007-multi-cad-framework`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-008-cad-agents`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-009-bim-360-sync`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-010-accordion-templates`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-011-shared-routing`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-012-civil-pilot`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-013-structural-pilot`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-014-mep-pilot`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-015-integration-testing`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-016-performance-testing`
  - `_A_QA`
  - `of`
  - `ENG-PLATFORM-017-uat`

### 7. Testing Checklist

- [ ] Upserts: Create, Edit, Delete workflows functional
- [ ] Agents: Agent status and configuration visible
- [ ] Workspace: HITL review queue operational
- [ ] Role gates: viewer, editor, reviewer, governance enforced
- [ ] Chatbot: stateAware chatbot integrated (z-index 1500)

---

**Version**: 1.0 | **Date**: 2026-04-29

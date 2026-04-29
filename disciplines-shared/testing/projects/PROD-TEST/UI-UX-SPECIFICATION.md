---
title: "PROD-TEST — testing UI/UX Specification (Override)"
description: "Override UI/UX specification for the PROD-TEST project — extending testing pattern"
version: "1.0"
date: "2026-04-29"
project_code: "PROD-TEST"
discipline: "testing"
gigabrain_tags: [testing, ui-ux, specification, override]
related_docs:
  - docs-paperclip/disciplines-shared/testing/UI-UX-SPECIFICATION.md
---

# PROD-TEST — testing UI/UX Specification

## Override: testing Pattern

### 1. Override Summary

| Aspect | Value |
|--------|-------|
| **Project** | PROD-TEST |
| **Discipline** | testing |
| **Extends** | [testing](UI-UX-SPECIFICATION.md) |
| **Spec Type** | Override — lean spec referencing parent pattern |
| **Issue Count** |       17 |
| **Color** | #E65100 / #FF9800 |

### 2. Scope

This project implements domain-specific workflow automation within the testing domain.
All UX patterns, three-state button rules, mermaid flow diagrams, implementation standards,
screen specifications, AI model backend, and agent knowledge ownership rules follow the
testing discipline-level UI-UX-SPECIFICATION.md, with the following project-specific overrides.

### 3. Workflow Overrides

```mermaid
flowchart TD
    Load[Page Load] --> Rights{Role Check}
    Rights -->|viewer+| Router[State Router - PROD-TEST]
    Rights -->|denied| Denied[Access Denied]
    Router --> Upserts[Upserts - Records]
    Router --> Agents[Agents - Automation]
    Router --> Workspace[Workspace - HITL Review]
```

### 4. Entity / Data Sources

| Entity | Source | Description |
|--------|--------|-------------|
| Records | API | Domain records managed via Upserts |
| Agents | API | Automation agents for PROD-TEST |
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
  - `ISSUE-GENERATION-STATUS`
  - `_A_QA`
  - `of`
  - `PROD-001-tier1-testing`
  - `_A_QA`
  - `of`
  - `PROD-002-login-testing`
  - `_A_QA`
  - `of`
  - `PROD-003-user-creation-testing`
  - `_A_QA`
  - `of`
  - `PROD-004-database-upsert-testing`
  - `_A_QA`
  - `of`
  - `PROD-005-accordion-production-testing`
  - `_A_QA`
  - `of`
  - `PROD-006-environment-switching-production-testing`
  - `_A_QA`
  - `of`
  - `PROD-007-tier2-testing`
  - `_A_QA`
  - `of`
  - `PROD-008-ui-settings-testing`
  - `_A_QA`
  - `of`
  - `PROD-009-non-discipline-pages-production-testing`
  - `_A_QA`
  - `of`
  - `PROD-010-discipline-testing`
  - `_A_QA`
  - `of`
  - `PROD-011-tier3-testing`
  - `_A_QA`
  - `of`
  - `PROD-012-chatbot-production-testing`
  - `_A_QA`
  - `of`
  - `PROD-013-tier4-testing`
  - `_A_QA`
  - `of`
  - `PROD-014-HITL_Production_Testing_Hermes_Agent`
  - `_A_QA`
  - `of`
  - `PROD-HITL-WORKFLOW`
  - `_A_QA`
  - `of`
  - `PROD-ISSUES-REVIEW`

### 7. Testing Checklist

- [ ] Upserts: Create, Edit, Delete workflows functional
- [ ] Agents: Agent status and configuration visible
- [ ] Workspace: HITL review queue operational
- [ ] Role gates: viewer, editor, reviewer, governance enforced
- [ ] Chatbot: stateAware chatbot integrated (z-index 1500)

---

**Version**: 1.0 | **Date**: 2026-04-29

---
title: 01700 Logistics - Code and Documentation Placement
---

# 01700 Logistics - Code and Documentation Placement

## Discipline Overview

This document defines the standardized location for all code and documentation within the 01700 Logistics discipline.

## Standard Structure

```
01700-logistics/
├── CODE-AND-DOC-PLACEMENT.md    ← This file
├── README.md                     ← Discipline overview
├── knowledge/                   ← Cross-project domain knowledge
│   └── PAGE-KNOWLEDGE.md
├── projects/                    ← All discipline projects
│   └── {PROJECT-CODE}/
│       ├── README.md
│       ├── plan.md
│       ├── AGENTS.md
│       ├── issues/
│       ├── desktop/
│       │   ├── issues/
│       │   ├── learning/
│       │   └── orchestration/
│       ├── mobile/
│       │   ├── issues/
│       │   ├── learning/
│       │   └── orchestration/
│       ├── web/
│       │   ├── issues/
│       │   ├── learning/
│       │   └── orchestration/
│       ├── shared/
│       │   ├── api/
│       │   ├── business-logic/
│       │   └── data-models/
│       └── knowledge/
├── trigger/
│   └── {AUTO-PROJECT}/issues/
├── procedures/
└── plans/
```

## Discipline-Specific Notes

- Logistics projects span desktop and mobile platforms
- Shared data-models for tracking and inventory systems
- API contracts for external system integrations

## Related Documents

- [Code and Documentation Placement Procedure](../../procedures/workflows/code-and-doc-placement-procedure.md)

---
title: Workflows Common - Code and Documentation Placement
author: PaperclipForge AI
date: 2026-04-16
version: 1.0
status: active
---

# Workflows Common - Code and Documentation Placement

## Overview

This document defines the standardized location for all code and documentation within the **workflows-common** discipline.

## Repository Rule

> ⚠️ **Never put implementation code in docs-paperclip**
> ⚠️ **Never put documentation in paperclip-render**

## Standard Discipline Structure

```
docs-paperclip/disciplines/workflows-common/
├── CODE-AND-DOC-PLACEMENT.md    ← This file
├── README.md                     ← Discipline overview
│
├── knowledge/                   ← Cross-project domain knowledge
│   └── PAGE-KNOWLEDGE.md        ← Master knowledge base
│
├── projects/                    ← All discipline projects
│   └── {PROJECT-CODE}/
│       ├── README.md            ← Project overview
│       ├── plan.md              ← Project plan
│       ├── AGENTS.md            ← Project-specific agent instructions
│       │
│       ├── trigger/             ← Project automation triggers
│       │   ├── README.md
│       │   └── {PROJECT}-000-project-automation.md
│       │
│       ├── {PROJECT}-workflows-list.md       ← Workflows catalog
│       ├── {PROJECT}-implementation.md       ← Implementation plan
│       ├── discipline_workflow_conversion_procedure.md
│       │
│       ├── research/            ← Research enhancement plans
│       │   └── {PROJECT}-research-enhancement-plan.md
│       │
│       ├── scripts/             ← Generator scripts
│       │   └── generate-issues.py
│       │
│       ├── issues/              ← Non-platform-specific issues
│       │   ├── {ISSUE-ID}.md
│       │   └── ISSUE-GENERATION-STATUS.md
│       │
│       ├── desktop/             ← Desktop platform
│       ├── mobile/              ← Mobile platform
│       ├── web/                 ← Web platform
│       │
│       ├── shared/              ← Shared across platforms
│       │   ├── api/
│       │   ├── business-logic/
│       │   └── data-models/
│       │
│       └── knowledge/           ← Project-specific knowledge
│           └── PAGE-KNOWLEDGE.md
│
├── trigger/                     ← Discipline automation triggers
│   ├── README.md
│   └── {AUTO-PROJECT}/
│       └── issues/
│           └── {AUTO-PROJECT}-000-discipline-automation.md
│
├── procedures/                  ← Discipline-specific procedures
│   └── *.md
│
└── plans/                       ← Automation plans
    └── YYYY-MM-DD-*-plan.md
```

## Placement by File Type

| File Type | Location |
|-----------|----------|
| Discipline README | `disciplines/workflows-common/README.md` |
| Placement Standards | `disciplines/workflows-common/CODE-AND-DOC-PLACEMENT.md` |
| Master Knowledge | `disciplines/workflows-common/knowledge/PAGE-KNOWLEDGE.md` |
| Project Knowledge | `disciplines/workflows-common/projects/{PROJECT}/knowledge/PAGE-KNOWLEDGE.md` |
| Discipline Automation Issues | `disciplines/workflows-common/trigger/{AUTO}/issues/` |
| Project Issues | `disciplines/workflows-common/projects/{PROJECT}/{platform}/issues/` |
| Automation Plans | `disciplines/workflows-common/plans/` |
| Discipline Procedures | `disciplines/workflows-common/procedures/` |
| Workflow Orchestration | `disciplines/workflows-common/projects/{PROJECT}/{platform}/orchestration/` |

## Workflows Common Specifics

### Purpose
The workflows-common discipline contains universal workflow templates and procedures that apply across multiple other disciplines.

### Project Types
- **UNIV-WORKFLOW**: Universal workflow templates and conversion procedures

### Platform Scope
Currently supporting: Desktop, Mobile, Web, and Shared platforms

---

**Document Version**: 1.0
**Last Updated**: 2026-04-16
**Author**: PaperclipForge AI

# Code and Documentation Placement Guide - 00900 Document Control

This document defines the standard structure and placement for all code and documentation within the Document Control discipline.

## Directory Structure

```
00900-document-control/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Document control procedures
│   ├── document-creation.md
│   ├── version-control.md
│   ├── document-distribution.md
│   └── records-management.md
├── plans/                       # Document management plans
│   └── document-governance-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── DOC-AUTO/               # Automated document workflows
│       └── issues/
│           └── DOC-AUTO-000-document-control-automation.md
├── knowledge/                   # Knowledge base
│   └── PAGE-KNOWLEDGE.md
└── projects/                    # Project implementations
    └── PROC-001/               # Standard Procurement Workflow
        ├── trigger/            # Project-level triggers
        ├── desktop/            # Desktop platform
        ├── mobile/             # Mobile platform
        ├── web/                # Web platform
        └── shared/             # Shared resources
```

## Trigger Placement

### Discipline-Level Triggers
Location: `trigger/DOC-AUTO/issues/`
- Covers automation for all document workflows
- Includes version tracking, distribution, and archiving

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific document automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Document control procedures:
- `document-creation.md` - Document creation standards
- `version-control.md` - Revision management
- `document-distribution.md` - Distribution protocols
- `records-management.md` - Archive and retention

### plans/
Document management plans:
- `document-governance-plan.md` - Overall document strategy

### knowledge/
Document control knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for document knowledge

### projects/PROC-001/
Document management for procurement:
- `trigger/` - Project document triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`

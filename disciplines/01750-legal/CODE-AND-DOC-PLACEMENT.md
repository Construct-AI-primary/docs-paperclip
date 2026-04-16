# Code and Documentation Placement Guide - 01750 Legal

This document defines the standard structure and placement for all code and documentation within the Legal discipline.

## Directory Structure

```
01750-legal/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Legal procedures
│   ├── contract-review.md
│   ├── dispute-resolution.md
│   ├── regulatory-compliance.md
│   └── ip-protection.md
├── plans/                       # Legal plans
│   └── legal-risk-management-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── LEGAL-AUTO/            # Automated legal workflows
│       └── issues/
│           └── LEGAL-AUTO-000-legal-automation.md
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
Location: `trigger/LEGAL-AUTO/issues/`
- Covers automation for legal processes
- Includes contract review scheduling, compliance tracking, and reporting

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific legal automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Legal procedures:
- `contract-review.md` - Contract review processes
- `dispute-resolution.md` - Dispute handling
- `regulatory-compliance.md` - Compliance procedures
- `ip-protection.md` - IP management

### plans/
Legal planning documents:
- `legal-risk-management-plan.md` - Risk mitigation strategy

### knowledge/
Legal knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for legal knowledge

### projects/PROC-001/
Legal for procurement:
- `trigger/` - Project legal triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`

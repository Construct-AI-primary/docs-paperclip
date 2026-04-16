# Code and Documentation Placement Guide - 01200 Finance

This document defines the standard structure and placement for all code and documentation within the Finance discipline.

## Directory Structure

```
01200-finance/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Financial operation procedures
│   ├── accounts-payable.md
│   ├── accounts-receivable.md
│   ├── invoice-processing.md
│   └── payroll.md
├── plans/                       # Financial operation plans
│   └── financial-operations-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── FINOPS-AUTO/           # Automated finance workflows
│       └── issues/
│           └── FINOPS-AUTO-000-finance-operations-automation.md
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
Location: `trigger/FINOPS-AUTO/issues/`
- Covers automation for all finance operations
- Includes invoice processing, payment scheduling, and reconciliation

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific finance automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Financial operation procedures:
- `accounts-payable.md` - AP processes
- `accounts-receivable.md` - AR management
- `invoice-processing.md` - Invoice handling
- `payroll.md` - Payroll procedures

### plans/
Financial operation plans:
- `financial-operations-plan.md` - Operations strategy

### knowledge/
Finance knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for finance knowledge

### projects/PROC-001/
Finance operations for procurement:
- `trigger/` - Project finance triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`

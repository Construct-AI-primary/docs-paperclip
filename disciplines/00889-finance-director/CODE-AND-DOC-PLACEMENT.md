# Code and Documentation Placement Guide - 00889 Finance Director

This document defines the standard structure and placement for all code and documentation within the Finance Director discipline.

## Directory Structure

```
00889-finance-director/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Financial procedures
│   ├── budget-management.md
│   ├── cost-control.md
│   ├── financial-reporting.md
│   └── payment-processing.md
├── plans/                       # Financial plans
│   └── annual-financial-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── FIN-AUTO/               # Automated finance workflows
│       └── issues/
│           └── FIN-AUTO-000-finance-automation.md
├── knowledge/                   # Knowledge base
│   └── PAGE-KNOWLEDGE.md
└── projects/                    # Project implementations
    └── PROC-001/                # Standard Procurement Workflow
        ├── trigger/            # Project-level triggers
        ├── desktop/            # Desktop platform
        ├── mobile/             # Mobile platform
        ├── web/                # Web platform
        └── shared/             # Shared resources
```

## Trigger Placement

### Discipline-Level Triggers
Location: `trigger/FIN-AUTO/issues/`
- Covers automation for all finance operations
- Includes budget tracking, invoice processing, and approval workflows

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific financial automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Financial procedures and guidelines:
- `budget-management.md` - Budget creation and tracking
- `cost-control.md` - Cost control methodologies
- `financial-reporting.md` - Reporting standards
- `payment-processing.md` - Payment procedures

### plans/
Financial planning documents:
- `annual-financial-plan.md` - Yearly financial strategy
- `capital-expenditure-plan.md` - CAPEX planning

### knowledge/
Finance knowledge base:
- `PAGE-KNOWLEDGE.md` - PARA index for finance knowledge

### projects/PROC-001/
Financial integration for procurement workflow:
- `trigger/` - Project financial triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`

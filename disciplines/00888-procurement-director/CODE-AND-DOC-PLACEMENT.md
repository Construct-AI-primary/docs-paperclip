# Code and Documentation Placement Guide - 00888 Procurement Director

This document defines the standard structure and placement for all code and documentation within the Procurement Director discipline.

## Directory Structure

```
00888-procurement-director/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Procurement procedures
│   ├── procurement-policy.md
│   ├── vendor-management.md
│   ├── sourcing-strategies.md
│   └── contract-negotiation.md
├── plans/                       # Strategic plans
│   └── annual-procurement-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── PROC-AUTO/              # Automated procurement workflows
│       └── issues/
│           └── PROC-AUTO-000-procurement-automation.md
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
Location: `trigger/PROC-AUTO/issues/`
- Covers automation for all procurement projects
- Includes vendor discovery, RFQ generation, and approval workflows

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Strategic and operational procurement procedures:
- `procurement-policy.md` - Core procurement policies
- `vendor-management.md` - Vendor selection and management
- `sourcing-strategies.md` - Strategic sourcing approaches
- `contract-negotiation.md` - Negotiation guidelines

### plans/
Procurement planning documents:
- `annual-procurement-plan.md` - Yearly procurement strategy
- `vendor-rationalization-plan.md` - Vendor consolidation strategy

### knowledge/
Procurement knowledge base:
- `PAGE-KNOWLEDGE.md` - PARA index for procurement knowledge

### projects/PROC-001/
Standard Procurement Workflow implementation:
- `trigger/` - Project automation triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`

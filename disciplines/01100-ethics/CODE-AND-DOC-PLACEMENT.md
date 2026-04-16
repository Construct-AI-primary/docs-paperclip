# Code and Documentation Placement Guide - 01100 Ethics

This document defines the standard structure and placement for all code and documentation within the Ethics discipline.

## Directory Structure

```
01100-ethics/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Ethics management procedures
│   ├── business-ethics.md
│   ├── anti-corruption.md
│   ├── conflict-of-interest.md
│   └── whistleblower.md
├── plans/                       # Ethics and compliance plans
│   └── ethics-management-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── ETH-AUTO/               # Automated ethics workflows
│       └── issues/
│           └── ETH-AUTO-000-ethics-automation.md
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
Location: `trigger/ETH-AUTO/issues/`
- Covers automation for ethics management
- Includes compliance tracking, training, and reporting

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific ethics automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Ethics management procedures:
- `business-ethics.md` - Code of ethics implementation
- `anti-corruption.md` - Anti-bribery procedures
- `conflict-of-interest.md` - COI management
- `whistleblower.md` - Whistleblower protection

### plans/
Ethics planning documents:
- `ethics-management-plan.md` - Overall ethics strategy

### knowledge/
Ethics knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for ethics knowledge

### projects/PROC-001/
Ethics integration for procurement:
- `trigger/` - Project ethics triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`

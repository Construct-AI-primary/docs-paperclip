---
title: "Voice Communication System — Procedure"
description: "Complete procedure for creating, implementing, and maintaining discipline-specific voice call overrides across all Paperclip companies and disciplines. Covers the shared core architecture, override contract, project scaffolding, issue generation, and maintenance lifecycle."
author: "PaperclipForge AI — Shared Services"
date: "2026-04-29"
version: "1.0"
status: "active"
gigabrain_tags: voice-call, procedures, ui-ux, override, communication, voiceforge, hitl
related_docs:
  - docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
  - docs-paperclip/disciplines-shared/voice-communication/projects/VOICE-COMM/desktop/issues/VOICE-COMM-001-core-voice-call-interface.md
  - docs-paperclip/disciplines-shared/voice-communication/projects/VOICE-COMM/desktop/issues/VOICE-COMM-002-hitl-approval-workflow.md
  - docs-paperclip/disciplines-shared/voice-communication/projects/VOICE-COMM/desktop/issues/VOICE-COMM-003-document-attachment-system.md
  - docs-paperclip/disciplines-shared/voice-communication/projects/VOICE-COMM/desktop/issues/VOICE-COMM-004-audit-logging-system.md
  - docs-paperclip/companies/voiceforge-ai/COMPANY.md
  - docs-paperclip/procedures/workflows/mermaid-diagram-template-system-procedure.md
---

# Voice Communication System — Procedure

## 1. Overview

The Voice Communication System is a **shared core + discipline-specific override** architecture that provides voice call capabilities across all Paperclip disciplines. This procedure defines how to create, implement, and maintain discipline-specific voice call overrides.

### 1.1 Architecture

```
SHARED CORE:              VOICE-COMM (disciplines-shared/voice-communication)
                              │
                              │ extends
                              ▼
OVERRIDE SPECS:           ┌─────────────────────────────────────────────┐
                          │  Each discipline defines ONLY what differs  │
                          │  - Entity ID source                         │
                          │  - Phone number tables                      │
                          │  - Document sources                         │
                          │  - Trigger workflow                         │
                          │  - Role gate                                │
                          │  - Accent colour / badge label              │
                          └─────────────────────────────────────────────┘
                              │
                              │ implemented via
                              ▼
DISCIPLINE PROJECTS:      Each {DISCIPLINE}/projects/{CODE}-VOICE/
                              │
                              │ consumed by
                              ▼
SYSTEM USERS:             Board UI → User clicks "Call" → Modal opens with discipline overrides
```

### 1.2 Key Principles

| Principle | Description |
|-----------|-------------|
| **Single Source of Truth** | All core behaviour lives in VOICE-COMM. Override specs only define what differs. |
| **Override Contract** | §F.2 in VOICE-COMM defines the 8 override points. Every override spec must address all 8. |
| **Project Structure** | Each discipline has its own `{PROJECT}/project.md` with issues, triggers, and knowledge. |
| **Discipline-Level Reference** | Even when multiple disciplines share one override (e.g., ENG-VOICE), each discipline must have its own `projects/{CODE}-VOICE/` folder. |
| **Colour Uniqueness** | Each override spec must use a unique accent colour not shared by any other override. |

---

## 2. Voice Communication System Map

### 2.1 Shared Core

| Project | Location | Description |
|---------|----------|-------------|
| VOICE-COMM | `disciplines-shared/voice-communication/` | Core modal, state machine, number engine, document attachment, colour scheme, VoiceForge integration |

### 2.2 Override Specs (8)

| Override | Discipline(s) | Accent | Badge |
|----------|---------------|--------|-------|
| PROC-VOICE | 01900 Procurement | `#00897B` Teal | Procurement |
| LOG-VOICE | 01700 Logistics | `#1565C0` Blue | Logistics |
| SAFE-VOICE | 02400 Safety | `#E65100` Orange | Safety |
| CON-VOICE | 00400 Contracts | `#283593` Indigo | Contracts |
| CPRE-VOICE | 00425 Pre-Award | `#4527A0` Deep Purple | Pre-Award |
| CPOST-VOICE | 00435 Post-Award | `#7B1FA2` Purple | Post-Award |
| QS-VOICE | 02025 QS | `#00838F` Cyan | Quantity Surveying |
| ENG-VOICE | 008xx + 01000 (10 disciplines) | `#2E7D32` Green | Dynamic per disciplineCode |

### 2.3 Discipline-Level Reference Projects (10)

Each of the 10 engineering disciplines has a lightweight reference project under its own `projects/` folder that references ENG-VOICE:

- ARCH-VOICE, CHEM-VOICE, CIVIL-VOICE, LAND-VOICE, GEO-VOICE, ELEC-VOICE, MECH-VOICE, PROCE-VOICE, STRUC-VOICE, ENV-VOICE

---

## 3. Prerequisites

Before creating a new voice call override, ensure:

- [ ] **VOICE-COMM Core** is implemented (issues VOICE-COMM-001 through VOICE-COMM-004)
- [ ] **Discipline directory** exists under `docs-paperclip/disciplines/{discipline-slug}/`
- [ ] **Discipline UI-UX spec** exists (or is being created alongside)
- [ ] **VoiceForge AI** company and Conversation Manager agent are available
- [ ] **Phone number source tables** have been identified or will be created
- [ ] **Trigger workflow** has been identified for the "Call" button placement
- [ ] **Role hierarchy** exists with clear permission levels
- [ ] **Unique accent colour** has been chosen (check existing colours in §F.1 of VOICE-COMM)

---

## 4. Step-by-Step: Creating a New Voice Call Override

### Step 1: Register in VOICE-COMM Core

**File**: `disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md`

1. Add the new discipline to the **Consumers** table in §E
2. Add the new accent colour to the **Accent Colour Reference** table in §F.1
3. Ensure the colour is unique across all consumers

```
Before:
| 8 | New Discipline | `#XXXXXX` | NEW-PROJECT | §[link] |

After (example):
| 9 | Logistics | `#1565C0` | LOG-VOICE | [§](../../../disciplines/01700-logistics/projects/LOG-VOICE/UI-UX-SPECIFICATION.md) |
```

**Validation**: Verify no two consumers share the same hex colour.

### Step 2: Create the Override Spec

**File**: `disciplines/{slug}/projects/{CODE}-VOICE/UI-UX-SPECIFICATION.md`

**Template** (use the most complete existing override as reference, e.g., PROC-VOICE or SAFE-VOICE):

```markdown
---
title: "{CODE}-VOICE — {Discipline Name} Voice Call Override Specification"
description: "{Discipline-specific description}"
version: 1.0
date: {YYYY-MM-DD}
project_code: {CODE}-VOICE
discipline: {slug}
extends: docs-paperclip/disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - voice-call
  - {discipline-tag}
  - override
---

# {CODE}-VOICE — {Discipline Name} Voice Call Override Specification

## Purpose

This document defines the **{slug} discipline overrides** for the shared Voice Communication system. All core behaviour is defined in:

> **[VOICE-COMM — Core Voice Communication UI/UX Specification](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)**

## 1. Override Summary

| Override | Value | § |
|----------|-------|---|
| `entityId` source | [Entity type] ID from [context] | §2 |
| `getPhoneNumbers()` | [Table.field, Table.field] | §2 |
| `getCallDocumentSources()` | [Doc types] | §3 |
| `triggerWorkflow` | [Workflow name] | §4 |
| `roleGate` | `user.role >= '{role}'` | §4 |
| `disciplineCode` | `"{code}"` | §5 |
| `accentColour` | `#XXXXXX` | §6 |
| `contextLabels` | ["Label1", "Label2", ...] | §3 |

## 2. Entity & Number Source

### 2.1 Entity ID Source

Triggered from the [Workflow] — passes [entity]Id:

```typescript
interface VoiceCallProps {
  entityId: string;
  entityName: string;
  workflowId: string;
  userId: string;
}
```

### 2.2 Phone Number Source (getPhoneNumbers)

| Source Table | Field | Indicator |
|-------------|-------|-----------|
| `[table1].phone` | [Description] | 📞 Primary Contact |
| `[table2].phone` | [Description] | 👤 Contact Person |

### 2.3 Number Format

Default country code: `+27`. Display: `(XXX) XXX-XXXX` with automatic masking.

## 3. Document Sources (getCallDocumentSources)

| Source | Description |
|--------|-------------|
| [Doc type 1] | [Description] |
| [Doc type 2] | [Description] |

### 3.1 Purpose Labels

| Label | Description |
|-------|-------------|
| "Label1" | [Description] |
| "Label2" | [Description] |

## 4. Trigger Workflow & Role Gate

### 4.1 Trigger

Launched from the **[Workflow Name]**.

### 4.2 Role Gate

```
gate = user.role >= '{role}'
```

### 4.3 Post-Call Integration

[Optional/mandatory] log-entry prompt to post outcome to [timeline].

## 5. Audit Log Discipline Code

All calls log with `discipline: "{code}"`.

## 6. Visual Override

| Element | Value |
|---------|-------|
| Discipline Accent | `#XXXXXX` |
| Header badge label | `"{Badge Label}"` |
| Context label | `"{Context Label}"` |

---

**Extends**: [VOICE-COMM Core](../../../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
```

**Required sections for every override:**
- §1: Override Summary table (all 8 points)
- §2: Entity & Number Source (with interface and phone table)
- §3: Document Sources (with table and purpose labels)
- §4: Trigger Workflow & Role Gate
- §5: Audit Log Discipline Code
- §6: Visual Override (accent, badge, context label)

### Step 3: Create Project Scaffold

**Directory structure** (27 files per standalone project):

```
{CODE}-VOICE/
├── UI-UX-SPECIFICATION.md          ← The override spec (Step 2)
├── project.md                       ← Project charter
├── README.md                        ← Project overview
├── desktop/issues/
│   ├── {CODE}-001.md               ← Core voice call interface
│   ├── {CODE}-002.md               ← Document attachment
│   ├── {CODE}-003.md               ← Workflow integration
│   ├── {CODE}-004.md               ← Post-call logging
│   └── ISSUE-GENERATION-STATUS.md
├── desktop/trigger/
│   ├── {CODE}-000-project-automation.md
│   └── README.md
├── desktop/learning/.gitkeep
├── desktop/orchestration/.gitkeep
├── mobile/issues/ISSUE-GENERATION-STATUS.md
├── mobile/learning/.gitkeep
├── mobile/orchestration/.gitkeep
├── web/issues/ISSUE-GENERATION-STATUS.md
├── web/learning/.gitkeep
├── web/orchestration/.gitkeep
├── knowledge/PAGE-KNOWLEDGE.md
├── learning/.gitkeep
├── research/.gitkeep
├── training/.gitkeep
├── scripts/.gitkeep
├── orchestration/OVERVIEW.md
├── shared/data-models/.gitkeep
├── shared/api/.gitkeep
└── shared/business-logic/.gitkeep
```

For **discipline-level reference projects** (engineering disciplines sharing ENG-VOICE), the structure is lighter (22 files):

```
{CODE}-VOICE/
├── README.md                        ← References ENG-VOICE instead of full spec
├── desktop/issues/
│   ├── {CODE}-001.md               ← Registration issue
│   ├── {CODE}-002.md               ← Code validation issue
│   └── ISSUE-GENERATION-STATUS.md
├── desktop/trigger/
│   └── {CODE}-000-project-automation.md
├── mobile/issues/ISSUE-GENERATION-STATUS.md
├── web/issues/ISSUE-GENERATION-STATUS.md
├── knowledge/PAGE-KNOWLEDGE.md
├── orchestration/OVERVIEW.md
├── ...(.gitkeep files for remaining dirs)
```

### Step 4: Create Issues (4 per Standalone Project)

| Issue | Title | Focus |
|-------|-------|-------|
| {CODE}-001 | Core voice call interface | Number selection from discipline tables |
| {CODE}-002 | Document attachment | Doc picker with discipline-specific sources |
| {CODE}-003 | Workflow integration | "Call" button + role gate |
| {CODE}-004 | Post-call logging | Outcome logging to timeline |

**Issue template:**

```markdown
---
title: "{CODE}-001 — Core voice call interface for {discipline}"
description: "Implement the VoiceCall modal integration for {discipline}, including number selection from discipline-specific tables"
project: {CODE}
discipline: {slug}
status: backlog
priority: medium
created: {YYYY-MM-DD}
---

# {CODE}-001 — {Title}

## Description

{Detailed description of what to implement}

## Acceptance Criteria

- [ ] VoiceCall modal correctly configured with {slug} overrides
- [ ] Phone numbers sourced from correct discipline tables
- [ ] Document picker shows correct discipline-specific sources
- [ ] Role gate enforces {role}+ access
- [ ] Audit logs tagged with correct discipline code
- [ ] Post-call integration works with discipline workflow

## Dependencies

- VOICE-COMM-001: Core voice call interface
- VOICE-COMM-003: Document attachment system
- VOICE-COMM-004: Audit logging system
```

### Step 5: Create Supporting Files

| File | Purpose |
|------|---------|
| `project.md` | Project charter with scope, objectives, team, risks |
| `README.md` | Quick reference table of project properties |
| `knowledge/PAGE-KNOWLEDGE.md` | Context for AI agents working on this project |
| `orchestration/OVERVIEW.md` | Architecture diagram and override points |
| `desktop/trigger/{CODE}-000-project-automation.md` | Automation trigger for project management |

---

## 5. Maintenance Lifecycle

### 5.1 When VOICE-COMM Core Changes

When the shared core spec is updated (e.g., new state machine state, new override point), each override spec must be reviewed and potentially updated.

**Trigger**: VOICE-COMM spec version bump

**Actions**:
1. Check all 8 override specs for required changes
2. Update `extends:` reference if core path changes
3. Propagate any new override points to all specs
4. Update README.md tables if properties changed

**Validation**: Run `grep -r "extends.*voice-communication" docs-paperclip/` to list all consumers.

### 5.2 When a New Discipline Needs Voice

**Trigger**: New discipline directory created or existing discipline requests voice capability

**Workflow**:
1. Follow Steps 1-5 above
2. If the new discipline shares an existing override pattern (e.g., all engineering share ENG-VOICE), add to that override instead of creating new standalone
3. Always register in VOICE-COMM §E Consumers table

### 5.3 When Accent Colours Conflict

**Trigger**: Two override specs use the same accent colour

**Check**: Review §F.1 in VOICE-COMM core for the complete colour table

**Resolution**: Choose a new unique colour for the conflicting spec. Preferred approach: use a different shade in the same hue family, or pick a hue not yet used.

### 5.4 Issue Status Management

Each project maintains `ISSUE-GENERATION-STATUS.md` files for desktop, mobile, and web platforms. These track:

| Status | Icon | Meaning |
|--------|------|---------|
| Not Started | 🔴 | Issue not yet assigned |
| In Progress | 🟡 | Issue being worked on |
| Complete | 🟢 | Issue completed |
| Blocked | ⛔ | Issue blocked by dependency |

---

## 6. Troubleshooting

### Common Issues

| Issue | Cause | Resolution |
|-------|-------|------------|
| Override not applying | VOICE-COMM core not updated with new consumer entry | Update §E Consumers table |
| Wrong phone numbers | Incorrect table/field references in getPhoneNumbers() | Verify database schema matches spec |
| Role gate not enforced | Missing role assignment in user model | Ensure role hierarchy includes the gate role |
| Duplicate accent colour | New colour matches existing consumer | Choose unique colour, update §F.1 |
| Discipline project missing | No `projects/{CODE}-VOICE/` directory | Create scaffold per Step 3 |
| ENG-VOICE reference broken | Engineering discipline has no individual project | Create discipline-level reference project |

### Validation Commands

```bash
# List all voice project directories
find docs-paperclip -type d -name "*-VOICE" | sort

# Count files per voice project
for dir in $(find docs-paperclip -type d -name "*-VOICE" | sort); do
  echo "$dir: $(find "$dir" -type f | wc -l) files"
done

# List all voice UI-UX specs
find docs-paperclip -path "*/UI-UX-SPECIFICATION.md" | grep -i voice | sort

# Check for duplicate accent colours
grep -h "Discipline Accent" $(find docs-paperclip -path "*/UI-UX-SPECIFICATION.md" | grep -i voice) | sort

# Verify all disciplines have projects
for d in $(grep "discipline:" $(find docs-paperclip -path "*/UI-UX-SPECIFICATION.md" | grep -i voice) | cut -d: -f2 | sort -u); do
  find docs-paperclip/disciplines/$d/projects -name "*-VOICE" -type d 2>/dev/null || echo "MISSING: $d"
done
```

---

## 7. Responsible Teams

| Role | Company | Responsibility |
|------|---------|----------------|
| Core Development | VoiceForge AI | VOICE-COMM core implementation, Conversation Manager integration |
| Override Implementation | DevForge AI | Per-discipline override specs and project scaffolds |
| Database | InfraForge AI | Phone number source tables, schema design |
| Quality | QualityForge AI | Conformance testing for overrides, validation |
| Knowledge | KnowledgeForge AI | Documentation, procedure maintenance |
| Discipline Owners | DomainForge AI | Discipline-specific context, workflow identification |

---

## Appendix A: Complete Override Point Reference

See §F.2 in [VOICE-COMM Core UI/UX Specification](../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md).

| # | Override Point | Type | Required | Description |
|---|---------------|------|----------|-------------|
| 1 | `entityId source` | Data | Yes | Source of the entity being called |
| 2 | `getPhoneNumbers()` | Function | Yes | Phone number source tables and fields |
| 3 | `getCallDocumentSources()` | Function | Yes | Document sources for call context |
| 4 | `triggerWorkflow` | Reference | Yes | Workflow that contains the "Call" button |
| 5 | `roleGate` | Expression | Yes | Minimum role level to initiate calls |
| 6 | `disciplineCode` | String | Yes | Audit log routing code |
| 7 | `accentColour` | Hex | Yes | Unique discipline accent colour |
| 8 | `contextLabels` | String[] | Yes | Purpose labels for document sources |

---

## Appendix B: Existing Override Specs Reference

| Spec | Lines | Sections | Accent | Role Gate | Entity Type |
|------|-------|----------|--------|-----------|-------------|
| PROC-VOICE v2.0 | ~220 | 6 | `#00897B` | editor+ | Supplier |
| LOG-VOICE v1.0 | ~180 | 6 | `#1565C0` | dispatcher+ | Carrier |
| SAFE-VOICE v1.0 | ~190 | 6 | `#E65100` | safety_officer+ | Contractor |
| CON-VOICE v1.0 | ~180 | 6 | `#283593` | contracts_officer+ | Contract party |
| CPRE-VOICE v1.0 | ~180 | 6 | `#4527A0` | evaluation_officer+ | Tenderer |
| CPOST-VOICE v1.0 | ~180 | 6 | `#7B1FA2` | contracts_officer+ | Contractor |
| QS-VOICE v1.0 | ~180 | 6 | `#00838F` | quantity_surveyor+ | Contractor |
| ENG-VOICE v1.0 | ~170 | 6 | `#2E7D32` | engineer+ | Consultant |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial voice communication system procedure |

---

**Related Documents**:
- [VOICE-COMM Core UI/UX Specification](../../disciplines-shared/voice-communication/UI-UX-SPECIFICATION.md)
- [Mermaid Diagram Template System Procedure](../workflows/mermaid-diagram-template-system-procedure.md)
- [VoiceForge AI Company](../../companies/voiceforge-ai/COMPANY.md)
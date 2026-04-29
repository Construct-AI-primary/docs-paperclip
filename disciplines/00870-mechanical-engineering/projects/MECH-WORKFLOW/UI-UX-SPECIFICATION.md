---
title: "MECH-WORKFLOW — Mechanical Engineering Workflow UI/UX Specification"
description: "Complete UI/UX specification for the MECH-WORKFLOW project — Template B three-state navigation for mechanical engineering workflows including HVAC system design"
version: "1.0"
date: "2026-04-29"
project_code: "MECH-WORKFLOW"
discipline: "00870-mechanical-engineering"
gigabrain_tags: [mechanical-engineering, workflow, ui-ux, specification, template-b, hvac, system-design]
related_docs:
  - docs-paperclip/disciplines/00870-mechanical-engineering/projects/MECH-WORKFLOW/desktop/issues/MECH-001-hvac-system-design-workflow.md
  - docs-construct-ai/other/0000_TEMPLATE_A_CSS_INVENTORY.md
  - docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md
  - docs-construct-ai/codebase/guides/styling/0000_CSS_STANDARDIZATION_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/0170_MODAL_DOCUMENTATION_MASTER_GUIDE.md
---

# MECH-WORKFLOW — Mechanical Engineering Workflow UI/UX Specification

## Table of Contents

1. [Part A: UX Patterns](#part-a-ux-patterns)
2. [Part B: Three-State Button & Modal Rules](#part-b-three-state-button--modal-rules)
3. [Part C: Mermaid UI Flow Diagrams](#part-c-mermaid-ui-flow-diagrams)
4. [Part D: Implementation Standards](#part-d-implementation-standards)
5. [Part E: Screen Specifications](#part-e-screen-specifications)
6. [Part F: AI Model Backend](#part-f-ai-model-backend)
7. [Part G: Agent Knowledge Ownership](#part-g-agent-knowledge-ownership)

---

## Part A: UX Patterns

### Page Classification

**Template Type**: **Template B** (Complex / Three-State)

**Why Template B**:
- **Multi-State Navigation**: Agents, Upserts, Workspace
- **Multi-Purpose Functionality**: HVAC design, load calculations, equipment selection, ductwork design
- **Complex Workflows**: Mechanical design lifecycle from load calculation through AHU selection
- **CSS Class Convention**: `A-MECH-*` prefix

### Information Architecture

**Accordion Section**: Mechanical Engineering (display_order: 870)
**Route**: `/mech-workflow`

### Color Scheme — Silver

```css
:root {
  --template-a-primary: #C0C0C0;
  --template-a-secondary: #708090;
  --template-a-accent: #A9A9A9;
  --template-a-bg-gradient: linear-gradient(135deg, #f0f0f0 0%, #dcdcdc 100%);
  --template-a-header-gradient: linear-gradient(135deg, #708090 0%, #C0C0C0 100%);
  --template-a-text-primary: #000000;
  --template-a-text-white: #ffffff;
  --template-a-shadow-lg: 0 8px 24px rgba(192, 192, 192, 0.3);
}
```

### HITL Integration

1. AI Agent performs HVAC calculations (load, duct sizing, equipment selection)
2. Work enters HITL Review Queue
3. Mechanical Engineer reviews: Approve / Reject with Feedback / Manual Override

---

## Part B: Three-State Button & Modal Rules

### Agents State

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| View Details | Always | AgentDetails | 98vw, agent metrics |

### Upserts State

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| Create New | editor | CreateRecord | 98vw, HVAC record form |
| Import | editor | Import | CSV/Excel |
| Edit | editor | EditRecord | Pre-populated |
| Delete | governance | Confirmation | Impact warning |

### Workspace State

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| Approve | reviewer | Approval | Confirm |
| Reject | reviewer | Rejection | Required feedback |
| Generate Report | Always | Export | Format selector |

---

## Part C: Mermaid UI Flow Diagrams

### HVAC Design Lifecycle

```mermaid
flowchart TD
    LOAD[Load Calculation] -->|CLTD/TFM| SYS[System Selection]
    SYS -->|all-air| AHU[AHU Sizing]
    SYS -->|air-water| FCU[Fan-Coil Selection]
    AHU --> DUCT[Ductwork Design]
    FCU --> DUCT
    DUCT -->|SMACNA| TERM[Terminal Unit Selection]
    TERM -->|VAV| CTRL[Controls Design]
    CTRL -->|HITL| REVIEW{HITL Review}
    REVIEW -->|approve| FINAL[Final Design Package]
    REVIEW -->|reject| LOAD
```

### HITL Review Workflow

```mermaid
flowchart TD
    AGENT[AI Mech Agent] --> QUEUE[HITL Queue]
    QUEUE -->|assign| REVIEWER[Senior Engineer]
    REVIEWER -->|review| DECISION{Decision}
    DECISION -->|approve| EXECUTE
    DECISION -->|revisions| REVISE[AI Revises]
    DECISION -->|reject| AGENT
    REVISE --> REVIEWER
    EXECUTE --> AUDIT[Audit Trail]
```

### Page State Flow

```mermaid
flowchart TD
    Load[Page Load] --> Rights{Role Check}
    Rights -->|viewer+| Router[State Router]
    Rights -->|denied| Denied
    Router --> Agents[Agents]
    Router --> Upserts[Upserts]
    Router --> Workspace[Workspace]
    Agents --> ViewAgent
    Upserts -->|editor+| CreateRecord
    Workspace -->|reviewer+| ReviewActions
```

---

## Part D: Implementation Standards

**CSS Import**: `@import "../../templates/template-a-standard.css";`
**Class Prefix**: `A-MECH-*`

### Components

| Component | CSS Class |
|-----------|-----------|
| StateButtons | `.A-MECH-state-btn` |
| NavContainer | `.A-MECH-nav-container` |
| LoadCalcForm | `.A-MECH-load-calc` |
| EquipmentSelector | `.A-MECH-equipment-selector` |

### Chatbot

```javascript
{ chatType: "agent", stateAware: true, zIndex: 1500, modelEndpoint: "/api/chat/mech" }
```

---

## Part E: Screen Specifications

### Wireframe: Agents State

```
┌─────────────────────────────────────────────┐
│ [Silver Header] MECH-WORKFLOW [Chatbot]      │
├─────────────────────────────────────────────┤
│ Agents | Upserts | Workspace                 │
│ ┌──────────┐ ┌──────────┐                    │
│ │ HVAC     │ │ Mech     │                    │
│ │ Engineer │ │ Analyst  │                    │
│ │ ● Active │ │ ● Active │                    │
│ └──────────┘ └──────────┘                    │
└─────────────────────────────────────────────┘
```

---

## Part F: AI Model Backend

**Base Model**: Qwen 2.5
**LoRA Adapter**: HVAC design, load calculations, ASHRAE standards
**Endpoint**: `/api/chat/mech`

---

## Part G: Agent Knowledge Ownership

| Company | Role |
|---------|------|
| DomainForge AI | Domain Validation |
| QualityForge AI | Testing |
| DevForge AI | Implementation |

---

**Version**: 1.0 | **Date**: 2026-04-29 | **Status**: Active

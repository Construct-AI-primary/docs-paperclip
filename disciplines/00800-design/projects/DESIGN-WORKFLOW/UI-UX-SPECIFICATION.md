---
title: "DESIGN-WORKFLOW — Design Coordination Workflow UI/UX Specification"
description: "Complete UI/UX specification for the DESIGN-WORKFLOW project — Template B three-state navigation for design coordination workflows including interface management, interdisciplinary review, design programme, architectural integration, engineering integration matrix, clash detection, team communication, and governance escalation"
version: "1.0"
date: "2026-04-29"
project_code: "DESIGN-WORKFLOW"
discipline: "00800-design"
gigabrain_tags: [design, workflow, ui-ux, specification, template-b, coordination, bim, clash-detection]
related_docs:
  - docs-paperclip/disciplines/00800-design/projects/DESIGN-WORKFLOW/desktop/issues/DESIGN-001-design-coordination-interface-management-workflow.md
  - docs-paperclip/disciplines/00800-design/projects/DESIGN-WORKFLOW/desktop/issues/DESIGN-002-interdisciplinary-design-review-workflow.md
  - docs-paperclip/disciplines/00800-design/projects/DESIGN-WORKFLOW/desktop/issues/DESIGN-003-design-programme-deliverables-workflow.md
  - docs-paperclip/disciplines/00800-design/projects/DESIGN-WORKFLOW/desktop/issues/DESIGN-004-architectural-design-integration-workflow.md
  - docs-paperclip/disciplines/00800-design/projects/DESIGN-WORKFLOW/desktop/issues/DESIGN-005-engineering-discipline-integration-matrix.md
  - docs-paperclip/disciplines/00800-design/projects/DESIGN-WORKFLOW/desktop/issues/DESIGN-006-multi-discipline-clash-detection-resolution-workflow.md
  - docs-paperclip/disciplines/00800-design/projects/DESIGN-WORKFLOW/desktop/issues/DESIGN-007-design-team-communication-collaboration-platform.md
  - docs-paperclip/disciplines/00800-design/projects/DESIGN-WORKFLOW/desktop/issues/DESIGN-008-governance-communication-escalation-workflow.md
  - docs-construct-ai/other/0000_TEMPLATE_A_CSS_INVENTORY.md
  - docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md
---

# DESIGN-WORKFLOW — Design Coordination Workflow UI/UX Specification

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
- Multi-State Navigation: Agents, Upserts, Workspace
- Multi-Purpose Functionality: Interface management, interdisciplinary review, design programme, architectural integration, engineering integration matrix, clash detection, team communication, governance escalation
- Complex Workflows: Design coordination lifecycle from interface identification through BIM clash resolution
- CSS Class Convention: `A-DES-*` prefix

### Information Architecture

**Accordion Section**: Design (display_order: 800)
**Route**: `/design-workflow`

### Color Scheme — Pink

```css
:root {
  --template-a-primary: #FF69B4;
  --template-a-secondary: #FFB6C1;
  --template-a-accent: #DB7093;
  --template-a-bg-gradient: linear-gradient(135deg, #fce4ec 0%, #f8bbd0 100%);
  --template-a-header-gradient: linear-gradient(135deg, #DB7093 0%, #FFB6C1 100%);
  --template-a-text-white: #ffffff;
  --template-a-shadow-lg: 0 8px 24px rgba(255, 105, 180, 0.3);
}
```

### HITL Integration

1. AI Agent performs design coordination actions (clash detection, interface matrix updates, review routing)
2. Work enters HITL Review Queue
3. Design Coordinator reviews: Approve / Reject with Feedback / Manual Override

---

## Part B: Three-State Button & Modal Rules

| State | Button | Gate | Modal |
|-------|--------|------|-------|
| Agents | View Details | Always | AgentDetails (98vw) |
| Upserts | Create New | editor | CreateRecord |
| Upserts | Import | editor | Import (BIM/IFC) |
| Upserts | Edit | editor | EditRecord |
| Upserts | Delete | governance | Confirmation |
| Workspace | Approve | reviewer | Approval |
| Workspace | Reject | reviewer | Rejection |
| Workspace | Generate Report | Always | Export |

---

## Part C: Mermaid UI Flow Diagrams

### Design Coordination Lifecycle

```mermaid
flowchart TD
    INTF[Interface Identification] -->|register| MATRIX[Interface Matrix]
    MATRIX -->|assign| REVIEW[Interdisciplinary Review]
    REVIEW -->|BIM| CLASH[Clash Detection]
    CLASH -->|Navisworks| RESOLVE[Clash Resolution]
    RESOLVE -->|HITL| APPROVE{Approve?}
    APPROVE -->|yes| DELIVER[Deliverable Package]
    APPROVE -->|no| RESOLVE
    REVIEW -->|programme| PROG[Design Programme Tracking]
    PROG -->|milestones| ESCALATE[Governance Escalation]
```

### Interface Management Flow

```mermaid
flowchart TD
    REGISTER[Register Interface] -->|disciplines| CLASSIFY[Classify Type]
    CLASSIFY -->|physical| PHYS[Physical Interface]
    CLASSIFY -->|functional| FUNC[Functional Interface]
    CLASSIFY -->|contractual| CONTR[Contractual Interface]
    PHYS --> MATRIX
    FUNC --> MATRIX
    CONTR --> MATRIX
    MATRIX[Interface Matrix] -->|assign owner| RESOLVE
    RESOLVE[Resolution Plan] -->|HITL| REVIEW{HITL}
    REVIEW -->|approve| CLOSE[Close Out]
    REVIEW -->|reject| RESOLVE
```

---

## Part D: Implementation Standards

**CSS Import**: `@import "../../templates/template-a-standard.css";`
**Class Prefix**: `A-DES-*`

**Chatbot**: `{ chatType: "agent", stateAware: true, zIndex: 1500, modelEndpoint: "/api/chat/design-workflow" }`

---

## Part E: Screen Specifications

```
┌──────────────────────────────────────────────┐
│ [Pink Header] DESIGN-WORKFLOW [Chatbot]       │
├──────────────────────────────────────────────┤
│ Agents | Upserts | Workspace                  │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│ │ Design   │ │ BIM      │ │ Interface│       │
│ │ Coord.   │ │ Manager  │ │ Analyst  │       │
│ │ ● Active │ │ ● Active │ │ ● Active │       │
│ └──────────┘ └──────────┘ └──────────┘       │
└──────────────────────────────────────────────┘
```

---

## Part F: AI Model Backend

**Base Model**: Qwen 2.5 | **LoRA**: BIM coordination, clash detection, interface management
**Endpoint**: `/api/chat/design-workflow`

---

## Part G: Agent Knowledge Ownership

| Company | Role |
|---------|------|
| DomainForge AI | Domain Validation |
| QualityForge AI | Testing |
| DevForge AI | Implementation |

---

**Version**: 1.0 | **Date**: 2026-04-29 | **Status**: Active

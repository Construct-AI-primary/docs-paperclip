---
title: "ENV-WORKFLOW — Environmental Workflow UI/UX Specification"
description: "Complete UI/UX specification for the ENV-WORKFLOW project — Template B three-state navigation for environmental workflows including site remediation design"
version: "1.0"
date: "2026-04-29"
project_code: "ENV-WORKFLOW"
discipline: "01000-environmental"
gigabrain_tags: [environmental, workflow, ui-ux, specification, template-b, site-remediation]
related_docs:
  - docs-paperclip/disciplines/01000-environmental/projects/ENV-WORKFLOW/desktop/issues/ENV-001-site-remediation-design-workflow.md
  - docs-construct-ai/other/0000_TEMPLATE_A_CSS_INVENTORY.md
  - docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md
---

# ENV-WORKFLOW — Environmental Workflow UI/UX Specification

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
- Multi-Purpose Functionality: Site remediation design, environmental assessment, remediation technology selection
- Complex Workflows: Environmental site assessment through remediation implementation
- CSS Class Convention: `A-ENV-*` prefix

### Color Scheme — Green

```css
:root {
  --template-a-primary: #228B22;
  --template-a-secondary: #32CD32;
  --template-a-accent: #006400;
  --template-a-bg-gradient: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
  --template-a-header-gradient: linear-gradient(135deg, #006400 0%, #32CD32 100%);
  --template-a-text-white: #ffffff;
  --template-a-shadow-lg: 0 8px 24px rgba(34, 139, 34, 0.3);
}
```

### HITL Integration

1. AI Agent performs environmental analysis (site assessment, remediation design)
2. Work enters HITL Review Queue
3. Environmental Engineer reviews: Approve / Reject with Feedback / Manual Override

---

## Part B: Three-State Button & Modal Rules

| State | Button | Gate | Modal |
|-------|--------|------|-------|
| Agents | View Details | Always | AgentDetails (98vw) |
| Upserts | Create New | editor | CreateRecord |
| Upserts | Import | editor | Import (lab data) |
| Upserts | Edit | editor | EditRecord |
| Upserts | Delete | governance | Confirmation |
| Workspace | Approve | reviewer | Approval |
| Workspace | Reject | reviewer | Rejection |
| Workspace | Generate Report | Always | Export |

---

## Part C: Mermaid UI Flow Diagrams

### Site Remediation Flow

```mermaid
flowchart TD
    ASSESS[Site Assessment] -->|sampling| CHAR[Site Characterization]
    CHAR -->|risk| RA[Risk Assessment]
    RA -->|remediation goals| TECH[Technology Selection]
    TECH -->|in-situ| INSITU[In-Situ Remediation]
    TECH -->|ex-situ| EXSITU[Ex-Situ Remediation]
    INSITU --> DESIGN[Remediation Design]
    EXSITU --> DESIGN
    DESIGN -->|HITL| REVIEW{HITL}
    REVIEW -->|approve| IMPLEMENT[Implementation Plan]
    REVIEW -->|reject| TECH
```

---

## Part D: Implementation Standards

**CSS Import**: `@import "../../templates/template-a-standard.css";`
**Class Prefix**: `A-ENV-*`
**Chatbot**: `{ chatType: "agent", stateAware: true, zIndex: 1500, modelEndpoint: "/api/chat/env-workflow" }`

---

## Part E: Screen Specifications

```
┌──────────────────────────────────────────────┐
│ [Green Header] ENV-WORKFLOW [Chatbot]         │
├──────────────────────────────────────────────┤
│ Agents | Upserts | Workspace                  │
│ ┌──────────┐                                   │
│ │ Environ. │                                   │
│ │ Engineer │                                   │
│ │ ● Active │                                   │
│ └──────────┘                                   │
└──────────────────────────────────────────────┘
```

---

## Part F: AI Model Backend

**Base Model**: Qwen 2.5 | **LoRA**: Environmental assessment, remediation design
**Endpoint**: `/api/chat/env-workflow`

---

## Part G: Agent Knowledge Ownership

| Company | Role |
|---------|------|
| DomainForge AI | Domain Validation |
| QualityForge AI | Testing |
| DevForge AI | Implementation |

---

**Version**: 1.0 | **Date**: 2026-04-29 | **Status**: Active

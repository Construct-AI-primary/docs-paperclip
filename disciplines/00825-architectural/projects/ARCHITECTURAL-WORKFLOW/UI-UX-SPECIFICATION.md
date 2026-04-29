---
title: "ARCHITECTURAL-WORKFLOW — Architectural Workflow UI/UX Specification"
description: "Complete UI/UX specification for the ARCHITECTURAL-WORKFLOW project — Template B three-state navigation for architectural workflows including building specifications, code compliance, and RFI management"
version: "1.0"
date: "2026-04-29"
project_code: "ARCHITECTURAL-WORKFLOW"
discipline: "00825-architectural"
gigabrain_tags: [architectural, workflow, ui-ux, specification, template-b, building-specs, code-compliance, rfi]
related_docs:
  - docs-paperclip/disciplines/00825-architectural/projects/ARCHITECTURAL-WORKFLOW/desktop/issues/ARCH-001-building-specification-development-workflow.md
  - docs-paperclip/disciplines/00825-architectural/projects/ARCHITECTURAL-WORKFLOW/desktop/issues/ARCH-007-building-code-compliance-workflow.md
  - docs-paperclip/disciplines/00825-architectural/projects/ARCHITECTURAL-WORKFLOW/desktop/issues/ARCH-013-rfi-management-workflow.md
  - docs-construct-ai/other/0000_TEMPLATE_A_CSS_INVENTORY.md
  - docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md
---

# ARCHITECTURAL-WORKFLOW — Architectural Workflow UI/UX Specification

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
- Multi-Purpose Functionality: Building specifications, code compliance, RFI/submittal management
- Complex Workflows: Architectural documentation from schematic design through construction admin
- CSS Class Convention: `A-ARCH-*` prefix

### Information Architecture

**Accordion Section**: Architectural (display_order: 825)
**Route**: `/architectural-workflow`

### Color Scheme — Steel Blue

```css
:root {
  --template-a-primary: #4682B4;
  --template-a-secondary: #5B9BD5;
  --template-a-accent: #2C5F8A;
  --template-a-bg-gradient: linear-gradient(135deg, #e8f0fe 0%, #d0e1f9 100%);
  --template-a-header-gradient: linear-gradient(135deg, #2C5F8A 0%, #5B9BD5 100%);
  --template-a-text-white: #ffffff;
  --template-a-shadow-lg: 0 8px 24px rgba(70, 130, 180, 0.3);
}
```

### HITL Integration

1. AI Agent performs specification drafting, code review, RFI response drafting
2. Work enters HITL Review Queue
3. Architect reviews: Approve / Reject with Feedback / Manual Override

---

## Part B: Three-State Button & Modal Rules

| State | Button | Gate | Modal |
|-------|--------|------|-------|
| Agents | View Details | Always | AgentDetails (98vw) |
| Upserts | Create New | editor | CreateRecord |
| Upserts | Import | editor | Import (CSV/DWG) |
| Upserts | Edit | editor | EditRecord |
| Upserts | Delete | governance | Confirmation |
| Workspace | Approve | reviewer | Approval |
| Workspace | Reject | reviewer | Rejection |
| Workspace | Generate Report | Always | Export |

---

## Part C: Mermaid UI Flow Diagrams

### Architectural Workflow Lifecycle

```mermaid
flowchart TD
    SD[Schematic Design] -->|specs| DD[Design Development]
    DD --> CD[Construction Documents]
    CD -->|code check| CODE[Code Compliance Review]
    CODE -->|pass| BID[Bidding Phase]
    CODE -->|fail| CD
    BID --> CA[Construction Administration]
    CA -->|submittals| RFI[RFI Management]
    RFI -->|HITL| REVIEW{HITL Review}
    REVIEW -->|approve| RESPOND[RFI Response]
    REVIEW -->|reject| RFI
    RESPOND --> FIELD[Field Implementation]
```

### Code Compliance Flow

```mermaid
flowchart TD
    DRAWINGS[Review Drawings] -->|IBC/IRC| CHECK[Code Checklist]
    CHECK -->|egress| EGRESS[Means of Egress]
    CHECK -->|structural| STRUCT[Structural Code]
    CHECK -->|accessibility| ADA[ADA Compliance]
    CHECK -->|energy| ENERGY[Energy Code]
    EGRESS --> REPORT[Compliance Report]
    STRUCT --> REPORT
    ADA --> REPORT
    ENERGY --> REPORT
    REPORT -->|HITL| REVIEW{HITL}
    REVIEW -->|approve| CERTIFY[Certify Compliance]
    REVIEW -->|reject| DRAWINGS
```

---

## Part D: Implementation Standards

**CSS Import**: `@import "../../templates/template-a-standard.css";`
**Class Prefix**: `A-ARCH-*`

**Chatbot**: `{ chatType: "agent", stateAware: true, zIndex: 1500, modelEndpoint: "/api/chat/arch" }`

---

## Part E: Screen Specifications

```
┌──────────────────────────────────────────────┐
│ [Steel Blue Header] ARCHITECTURAL-WORKFLOW    │
├──────────────────────────────────────────────┤
│ Agents | Upserts | Workspace                  │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│ │ Spec     │ │ Code     │ │ RFI      │       │
│ │ Writer   │ │ Reviewer │ │ Manager  │       │
│ │ ● Active │ │ ● Active │ │ ● Active │       │
│ └──────────┘ └──────────┘ └──────────┘       │
└──────────────────────────────────────────────┘
```

---

## Part F: AI Model Backend

**Base Model**: Qwen 2.5
**LoRA Adapter**: Building codes (IBC/IRC), specification writing, RFI response
**Endpoint**: `/api/chat/arch`

---

## Part G: Agent Knowledge Ownership

| Company | Role |
|---------|------|
| DomainForge AI | Domain Validation |
| QualityForge AI | Testing |
| DevForge AI | Implementation |

---

**Version**: 1.0 | **Date**: 2026-04-29 | **Status**: Active

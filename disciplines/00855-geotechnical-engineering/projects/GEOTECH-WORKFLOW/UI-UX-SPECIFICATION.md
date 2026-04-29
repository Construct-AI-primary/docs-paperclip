---
title: "GEOTECH-WORKFLOW — Geotechnical Engineering Workflow UI/UX Specification"
description: "Complete UI/UX specification for the GEOTECH-WORKFLOW project — Template B three-state navigation for geotechnical engineering workflows including foundation design"
version: "1.0"
date: "2026-04-29"
project_code: "GEOTECH-WORKFLOW"
discipline: "00855-geotechnical-engineering"
gigabrain_tags: [geotechnical-engineering, workflow, ui-ux, specification, template-b, foundation-design, soils]
related_docs:
  - docs-paperclip/disciplines/00855-geotechnical-engineering/projects/GEOTECH-WORKFLOW/desktop/issues/GEOTECH-001-foundation-design-workflow.md
  - docs-construct-ai/other/0000_TEMPLATE_A_CSS_INVENTORY.md
  - docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md
---

# GEOTECH-WORKFLOW — Geotechnical Engineering Workflow UI/UX Specification

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
- Multi-Purpose Functionality: Foundation design, soil investigation, bearing capacity analysis, settlement analysis
- Complex Workflows: Geotechnical site investigation through foundation recommendation
- CSS Class Convention: `A-GEO-*` prefix

### Information Architecture

**Accordion Section**: Geotechnical Engineering (display_order: 855)
**Route**: `/geotech-workflow`

### Color Scheme — Brown

```css
:root {
  --template-a-primary: #8B4513;
  --template-a-secondary: #A0522D;
  --template-a-accent: #6B3410;
  --template-a-bg-gradient: linear-gradient(135deg, #f5e6d3 0%, #e8d5c4 100%);
  --template-a-header-gradient: linear-gradient(135deg, #6B3410 0%, #A0522D 100%);
  --template-a-text-white: #ffffff;
  --template-a-shadow-lg: 0 8px 24px rgba(139, 69, 19, 0.3);
}
```

### HITL Integration

1. AI Agent performs geotechnical analysis (bearing capacity, settlement, slope stability)
2. Work enters HITL Review Queue
3. Geotechnical Engineer reviews: Approve / Reject with Feedback / Manual Override

---

## Part B: Three-State Button & Modal Rules

| State | Button | Gate | Modal |
|-------|--------|------|-------|
| Agents | View Details | Always | AgentDetails (98vw) |
| Upserts | Create New | editor | CreateRecord |
| Upserts | Import | editor | Import (CSV/logs) |
| Upserts | Edit | editor | EditRecord |
| Upserts | Delete | governance | Confirmation |
| Workspace | Approve | reviewer | Approval |
| Workspace | Reject | reviewer | Rejection |
| Workspace | Generate Report | Always | Export |

---

## Part C: Mermaid UI Flow Diagrams

### Foundation Design Flow

```mermaid
flowchart TD
    SITE[Site Investigation] -->|boreholes| SOIL[Soil Profile Development]
    SOIL -->|parameters| CAP[Bearing Capacity Analysis]
    CAP -->|Terzaghi| SHALLOW[Shallow Foundation Design]
    CAP -->|Pile formulas| DEEP[Deep Foundation Design]
    SHALLOW --> SETTLEMENT[Settlement Analysis]
    DEEP --> SETTLEMENT
    SETTLEMENT -->|consolidation| SLOPE[Slope Stability Check]
    SLOPE -->|HITL| REVIEW{HITL}
    REVIEW -->|approve| RECOMMEND[Foundation Recommendation]
    REVIEW -->|reject| CAP
```

---

## Part D: Implementation Standards

**CSS Import**: `@import "../../templates/template-a-standard.css";`
**Class Prefix**: `A-GEO-*`

**Chatbot**: `{ chatType: "agent", stateAware: true, zIndex: 1500, modelEndpoint: "/api/chat/geotech" }`

---

## Part E: Screen Specifications

```
┌──────────────────────────────────────────────┐
│ [Brown Header] GEOTECH-WORKFLOW [Chatbot]     │
├──────────────────────────────────────────────┤
│ Agents | Upserts | Workspace                  │
│ ┌──────────┐ ┌──────────┐                     │
│ │ Found.   │ │ Geotech  │                     │
│ │ Engineer │ │ Analyst  │                     │
│ │ ● Active │ │ ● Active │                     │
│ └──────────┘ └──────────┘                     │
└──────────────────────────────────────────────┘
```

---

## Part F: AI Model Backend

**Base Model**: Qwen 2.5 | **LoRA**: Foundation design, bearing capacity, soil mechanics
**Endpoint**: `/api/chat/geotech`

---

## Part G: Agent Knowledge Ownership

| Company | Role |
|---------|------|
| DomainForge AI | Domain Validation |
| QualityForge AI | Testing |
| DevForge AI | Implementation |

---

**Version**: 1.0 | **Date**: 2026-04-29 | **Status**: Active

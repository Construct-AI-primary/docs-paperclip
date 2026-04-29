---
name: ui-ux-design-coordination
description: >
  Use when generating UI-UX-SPECIFICATION.md documents for discipline pages, including
  Template A/B classification, Mermaid UI flow diagrams, three-state button mechanics,
  modal inventories, color palette specification, chatbot configuration,
  AI model backend configuration, and agent knowledge ownership matrices.
company: promptforge-ai
---

# UI/UX Design Coordination

## Overview

This skill provides comprehensive guidance for generating complete UI-UX-SPECIFICATION.md documents for discipline pages within the Paperclip ecosystem. It covers the full spec structure from UX patterns through Mermaid flow diagrams, implementation standards, screen specifications, AI model backend, and agent knowledge ownership. It is the cross-platform design coordination capability within the Discipline Automation Workflow.

## When to Use This Skill

- Generating UI-UX-SPECIFICATION.md for a discipline page
- Classifying pages as Template A (Standard) or Template B (Complex/Three-State)
- Defining color schemes and CSS architecture for discipline pages
- Creating Mermaid UI flow diagrams (state flows, lifecycle flows, HITL workflows, decision trees)
- Specifying three-state button mechanics (Agents, Upserts, Workspace)
- Defining modal inventories with visibility gates and actions
- Configuring state-aware chatbot behavior
- Specifying AI model backend (base models, LoRA adapters, deployment)
- Defining agent knowledge ownership matrices (who does what)
- Specifying platform adaptations (desktop, tablet, mobile)

## UI/UX Specification Structure

A complete UI-UX-SPECIFICATION.md must include these 7 parts:

| Part | Content | Coverage |
|------|---------|----------|
| Part A | UX Patterns (High-Level) | Template classification, IA, color scheme, HITL integration pattern |
| Part B | Three-State Button & Modal Rules | Agents, Upserts, Workspace states with button/modal tables |
| Part C | Mermaid UI Flow Diagrams | 8-9 comprehensive flow diagrams |
| Part D | Implementation Standards | CSS architecture, component inventory, dropdowns, modals, chatbot |
| Part E | Screen Specifications | Screen inventory, wireframes, platform adaptations |
| Part F | AI Model Backend | Base model, LoRA adapters, deployment, fallback |
| Part G | Agent Knowledge Ownership | Company/role assignments, testing ownership |

## Template Classification

### Classification Rules

```javascript
function classifyTemplate(discipline) {
  const hasMultiState = discipline.pages.some(p => p.states.length >= 3);
  const hasComplexWorkflows = discipline.workflows.length >= 3;
  const hasMultiPurpose = discipline.components.length >= 5;
  
  if (hasMultiState && (hasComplexWorkflows || hasMultiPurpose)) {
    return {
      template: 'Template B (Complex/Three-State)',
      css_reference: discipline.is_css_reference ? true : false,
      z_index_chatbot: 1500, // Template B uses higher z-index
      css_prefix: `A-${discipline.code}-`,
      state_nav: 'bottom-fixed-three-tab'
    };
  }
  
  return {
    template: 'Template A (Standard)',
    css_reference: discipline.is_css_reference ? true : false,
    z_index_chatbot: 1000,
    css_prefix: `A-${discipline.code}-`,
    state_nav: 'single-state'
  };
}
```

### Template A (Standard)
- Single-state page (content-only)
- Standard z-index (1000) for chatbot
- Gradient background (no background image - exceptions only)
- Simpler CSS architecture
- Example: Most discipline pages

### Template B (Complex/Three-State)
- Three-state navigation: **Agents**, **Upserts**, **Workspace**
- Higher z-index (1500) for chatbot
- May use background images (exception pages only)
- Complex CSS with state-aware behaviors
- State-aware chatbot with different behaviors per state
- Bottom-fixed nav container with `transform: translateX(-50%)`
- Example: 01900 Procurement

## Three-State Button Mechanics

### Standard State Definitions

| State | Purpose | Default Content | Chatbot Behavior |
|-------|---------|-----------------|------------------|
| **Agents** | Show AI agents for the discipline | Agent cards with status indicators | Answers questions about agent capabilities |
| **Upserts** | Create, edit, import records | Forms, tables, import tools | Assists with record creation, data entry |
| **Workspace** | Operations dashboard, HITL review | HITL queue, PO generation, reports | Explains AI recommendations, suggests approvals |

### Button Definition Table Format

For each state, define a button table:

```markdown
| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **View Details** | Always visible | Opens AgentDetails modal | `AgentDetails` — 98vw, agent metrics |
| **Create New** | `user.role >= 'editor'` | Opens CreateRecord modal | `CreateRecord` — 98vw, form |
| **Approve** | `user.role >= 'reviewer'` | Opens Approval modal | `Approval` — 98vw, confirm with note |
```

### Visibility Gate Values

| Gate | Description |
|------|-------------|
| `Always visible` | No access restriction |
| `user.role >= 'editor'` | Editor or above |
| `user.role >= 'reviewer'` | Reviewer or above |
| `user.role >= 'coordinator'` | Coordinator or above |
| `user.role === 'governance'` | Governance role only |

## Mermaid Diagram Generation

Generate 8-9 comprehensive Mermaid UI flow diagrams per UI-UX-SPECIFICATION.md:

### Required Diagrams

| # | Diagram | Focus | Type |
|---|---------|-------|------|
| 1 | **Three-State Navigation Flow** | Agents ↔ Upserts ↔ Workspace state transitions | `flowchart TD` |
| 2 | **HITL Review Workflow** | AI action → Review Queue → Approve/Reject/Override → Execute | `flowchart TD` |
| 3 | **Discipline Lifecycle Flow** | Need identification → Order → SOW → Appendices → Collaboration → HITL → Approval → Assembly | `flowchart TD` |
| 4 | **Order Creation with Inheritance** | Form → Template → Discipline Inheritance → Assignment → Tasks | `flowchart TD` |
| 5 | **SOW Generation & Appendix Routing** | SOW → 6 Appendices (A-F) → Discipline-specific routing → HITL per appendix | `flowchart TD` |
| 6 | **Template Complexity Decision Tree** | Simple/Standard/Complex/Emergency/Compliance branches with rules | `flowchart TD` |
| 7 | **Progressive Approval Matrix** | Value thresholds: <25K single, 25K-250K parallel, >250K sequential | `flowchart TD` |
| 8 | **Enhanced HITL Detail Flow** | 5-phase AI-to-human collaborative review with chatbot refinement | `flowchart TD` |
| 9 | **Page State with Modal Integration** | Load → Auth → State Router → All modals per state | `flowchart TD` |

### Diagram Style Guide

Every Mermaid diagram must include:

1. **Class definitions** with color semantic classes:
```mermaid
classDef start fill:#e3f2fd,stroke:#1976d2
classDef process fill:#f3e5f5,stroke:#7b1fa2
classDef decision fill:#fff3e0,stroke:#f57c00
classDef review fill:#ffebee,stroke:#d32f2f
classDef final fill:#e8f5e8,stroke:#388e3c
```

2. **Color semantics**:
   - Blue (`#e3f2fd`): Start/auth/input nodes
   - Purple (`#f3e5f5`): Process/generation nodes
   - Orange (`#fff3e0`): Decision/assignment nodes
   - Red (`#ffebee`): Review/HITL nodes
   - Green (`#e8f5e8`): Final/complete/success nodes

3. **Node labels** must be descriptive (e.g., `HITL[Human-in-the-Loop Review]` not just `HITL`)

## Color Scheme Specification

### Template A Orange Palette (Default Reference)

```css
:root {
  --template-a-primary: #FF8C00;
  --template-a-secondary: #FFA500;
  --template-a-accent: #FF6B35;
  --template-a-bg-gradient: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  --template-a-header-gradient: linear-gradient(135deg, #FF6B35 0%, #FF8C42 100%);
  --template-a-text-primary: #000000;
  --template-a-text-secondary: #6c757d;
  --template-a-text-white: #ffffff;
  --template-a-shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
  --template-a-shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
  --template-a-shadow-lg: 0 8px 24px rgba(255, 140, 0, 0.3);
}
```

### Custom Palette Rules

When a discipline requires a custom palette:
- Must define all `--template-a-*` variables (never partial)
- Must maintain accessibility contrast ratios (WCAG 2.1 AA minimum)
- Background image permitted only for exception pages

## CSS Architecture Specification

### Import Chain

```css
/* 1. Template A Standard (or custom template) */
@import "../../templates/template-a-standard.css";

/* 2. Page-Specific Styles */
@import "{discipline-code}-page-style.css";
```

### File Convention

```
client/src/common/css/pages/{discipline-code}/{discipline-code}-page-style.css
```

### CSS Class Convention

`A-{discipline-code}-*` for all page-level elements (e.g., `A-01900-state-btn`)

## Modal Specification

### Standard Modal Properties

| Property | Value |
|----------|-------|
| Width | 98vw |
| Border radius | Standard |
| Header | Orange gradient (or custom palette) |
| Close button | Top-right corner |
| Backdrop | Dismissible (click outside to close) |
| Animation | Fade + scale |

### Modal Inventory Table Format

| Modal | State | Purpose | Size |
|-------|-------|---------|------|
| CreateRecord | Upserts | Create new procurement record | 98vw |
| Approval | Workspace | Approve AI action | 98vw |
| Rejection | Workspace | Reject with feedback | 98vw |

## Chatbot Configuration

### Standard Template

```json
{
  "chatType": "agent",
  "stateAware": true,
  "currentState": "agents|upserts|workspace",
  "zIndex": 1500,
  "modelEndpoint": "/api/chat/{discipline-slug}"
}
```

### State-Aware Behavior Per State

| State | Chatbot Focus |
|-------|---------------|
| Agents | Answers questions about agent capabilities |
| Upserts | Assists with record creation, data drafting |
| Workspace | Explains AI recommendations, suggests approvals |

## Platform Adaptations

### Breakpoints

| Platform | Width | Layout Changes |
|----------|-------|----------------|
| Desktop | 1280px+ | Full three-state nav, agent grid: 3 columns |
| Tablet | 768px-1279px | Three-state nav collapses to dropdown, agent grid: 2 columns |
| Mobile | <768px | Three-state nav as bottom tab bar, agent grid: 1 column, touch targets: min 48dp |

## AI Model Backend Specification

### Standard Config Format

```markdown
## Model Infrastructure

**Base Model**: Qwen 2.5 (or similar)
- Fine-tuned on {discipline} domain data

**Domain Adapter**: LoRA fine-tuned per function
- **{Discipline} LoRA**: {function description}

**Deployment**: HuggingFace model serving
- Endpoint: `/api/chat/{discipline-slug}`
- Fallback: Base model
```

## Agent Knowledge Ownership

### Ownership Matrix Format

```markdown
| Company | Role | Action |
|---------|------|--------|
| **DomainForge AI** | Domain Validation | Validate {discipline} workflows |
| **QualityForge AI** | Testing | Execute test suite against spec |
| **DevForge AI** | Implementation | Build HTML/CSS/React pages |
| **KnowledgeForge AI** | Indexing | Index spec into institutional memory |
| **PromptForge AI** | Task Routing | Route UI tasks to DevForge |
```

## Quality Assurance

### Completeness Checklist

- [ ] Template classification (A or B) explicitly stated with rationale
- [ ] Color scheme defined with all CSS variables
- [ ] Three-state buttons defined (if Template B) with visibility gates
- [ ] All modals documented with state, purpose, and sizing
- [ ] 8-9 Mermaid diagrams generated with color-coded class definitions
- [ ] CSS architecture defined (import chain, file paths, class convention)
- [ ] Chatbot configuration with state-aware behavior
- [ ] Platform adaptations for desktop, tablet, mobile
- [ ] AI model backend specified (base model, LoRA, deployment)
- [ ] Agent knowledge ownership matrix complete
- [ ] Screen inventory covering Loading, Empty, Error, Populated states
- [ ] Wireframe diagram for primary state

## Related Skills

- `knowledge-synthesis-management` - Upstream: provides component knowledge
- `project-intelligence-analysis` - Upstream: provides project scope
- `element-styling-reference` - Shared: CSS styling patterns
- `state-based-button-display` - Shared: state button implementation
- `dropdown-implementation` - Shared: dropdown component patterns
- `chat-ui-workflow-interaction` - Shared: chatbot integration
- `ui-ux-guidelines` - Shared: general UI/UX standards
- `accessibility-standards` - Shared: accessibility compliance
- `mobile-code-impact-assessment` - Shared: mobile responsiveness

## Best Practices

1. **Classify template type upfront** — influences entire spec structure
2. **Generate all 9 Mermaid diagrams** — don't skip; each covers a distinct interaction
3. **Use consistent color semantics** — blue=start, purple=process, orange=decision, red=review, green=success
4. **Define visibility gates precisely** — avoid ambiguous role requirements
5. **State-aware chatbot is mandatory for Template B** — each state needs distinct behavior
6. **Document AI model fallback chain** — always include fallback strategy
7. **Wireframe the primary state** — use ASCII art for the initial/default state view
---
title: "01900 Procurement — UI/UX Specification"
description: "Complete UI/UX specification for the 01900 Procurement discipline page — the Template A foundation reference page with three-state navigation, procurement workflows, supplier management, and AI model backend"
author: "DomainForge AI — Procurement Domain"
date: "2026-04-28"
version: "1.0"
status: "active"
gigabrain_tags: procurement, ui-ux, specification, template-a, foundation-reference, supplier-management, tender
related_docs:
  - docs-construct-ai/other/0000_TEMPLATE_A_CSS_INVENTORY.md
  - docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md
  - docs-construct-ai/standards/0000_PAGE_ARCHITECTURE_GUIDE.md
  - docs-construct-ai/codebase/guides/styling/0000_CSS_STANDARDIZATION_GUIDE.md
  - docs-construct-ai/codebase/audits/0950_ACCORDION_MANAGEMENT_AUDIT.md
  - docs-construct-ai/codebase/guides/developer/0170_MODAL_DOCUMENTATION_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/0750_DROPDOWN_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/1300_PAGES_CHATBOT_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/1500_MERMAID_MASTER_GUIDE.md
  - docs-construct-ai/codebase/procedures/ai-ml/0000_HF_MODEL_INTEGRATION_PROCEDURE.md
  - docs-construct-ai/codebase/procedures/ai-ml/0000_LORA_ADAPTER_INTEGRATION_PROCEDURE.md
  - docs-construct-ai/codebase/procedures/ai-ml/0000_QWEN_FINETUNING_PROCEDURE.md
  - docs-paperclip/disciplines-shared/testing/projects/PROCURE-TEST/desktop/issues/PROCURE-001-phase1-foundation.md
  - docs-paperclip/disciplines-shared/testing/projects/PROCURE-TEST/knowledge/AGENT-DELEGATION-MAP.md
---

# 01900 Procurement — UI/UX Specification

## Table of Contents

1. [Part A: UX Patterns (High-Level)](#part-a-ux-patterns-high-level)
2. [Part B: Three-State Button & Modal Rules](#part-b-three-state-button--modal-rules)
3. [Part C: Mermaid UI Flow Diagrams](#part-c-mermaid-ui-flow-diagrams)
4. [Part D: Implementation Standards](#part-d-implementation-standards)
5. [Part E: Screen Specifications (Detailed)](#part-e-screen-specifications-detailed)
6. [Part F: AI Model Backend](#part-f-ai-model-backend)
7. [Part G: Agent Knowledge Ownership](#part-g-agent-knowledge-ownership)

---

## Part A: UX Patterns (High-Level)

### 1. Page Classification

**Template Type**: **Template B** (Complex / Three-State) — serves as the **Template A CSS Foundation Reference**

The 01900 Procurement page occupies a unique dual role:
1. **Template A CSS Foundation Reference**: Its CSS architecture (`@import template-a-standard.css`) is the blueprint all other Template A pages follow. The `0000_TEMPLATE_A_CSS_INVENTORY.md` lists 01900 as the reference implementation.
2. **Template B Behavior**: It has three-state navigation (Agents, Upserts, Workspace) and complex procurement workflows.

**Why Template B**:
- **Multi-State Navigation**: Three distinct operational states — Agents, Upserts, Workspace
- **Multi-Purpose Functionality**: Supplier management, tender evaluation, contract administration, purchase orders
- **Complex Workflows**: Procurement lifecycle, bid evaluation, supplier qualification
- **Higher z-index positioning** (1500) for the chatbot overlay
- **CSS Class Convention**: `A-01900-*` prefix for all page-level elements (per PROCURE-001 test)

### 2. Information Architecture

**Accordion Section**: Procurement (display_order: 1900)
**Accordion Subsection**: 01900 Procurement
**Icon**: Shopping cart / procurement icon
**Route**: `/procurement`

**AccordionProvider + AccordionComponent** is mandatory per the `0950_ACCORDION_MANAGEMENT_AUDIT.md` standard.

### 3. Color Scheme

**Template A Orange Palette** (this is the reference page — no custom palette):

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

**Background Image**: The 01900 page is one of the few Template A pages that uses a background image. Per `0000_VISUAL_DESIGN_STANDARDS.md`, this is an exception (only 00106 timesheet and 01900 procurement use background images). All other pages should use gradient backgrounds.

### 4. HITL Integration Pattern

1. **AI Agent** performs procurement actions (supplier evaluation, tender comparison, PO generation)
2. **Work enters HITL Review Queue** — visible in the Workspace state
3. **Procurement Manager** reviews:
   - **Approve**: Action proceeds (e.g., PO is issued, supplier is approved)
   - **Reject with Feedback**: Returns to AI agent with correction notes
   - **Manual Override**: Human takes over the action directly
4. **Audit Trail**: All procurement decisions logged with timestamps and approver identity

---

## Part B: Three-State Button & Modal Rules

### 5. State: Agents

The **Agents state** shows procurement AI agents for supplier management, tender evaluation, and contract administration.

**Buttons**:

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **View Details** | Always visible | Opens AgentDetails modal | `AgentDetails` — 98vw, procurement agent metrics |

**Mermaid Flow**:
```mermaid
flowchart TD
    AGENTS[Agents State] -->|click View| MODAL4[AgentDetails Modal]
    AGENTS -->|click nav tab| UPSERT[Upsert State]
    AGENTS -->|click nav tab| WORKSPACE[Workspace State]
```

### 6. State: Upserts

The **Upserts state** is where procurement records are created, edited, and imported.

**Buttons**:

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Create New** | `user.role >= 'editor'` | Opens CreateRecord modal | `CreateRecord` — 98vw, procurement form with supplier selector |
| **Import** | `user.role >= 'editor'` | Opens Import modal | `Import` — 98vw, CSV/Excel upload, column mapping |
| **Edit** (per record) | `user.role >= 'editor'` | Opens EditRecord modal | `EditRecord` — 98vw, pre-populated form, change tracking |
| **Delete** | `user.role === 'governance'` | Opens Confirmation modal | `Confirmation` — "Delete record?" with impact warning |
| **Clone** | `user.role >= 'editor'` | Inline clone | No modal |

**Mermaid Flow**:
```mermaid
flowchart TD
    UPSERT[Upserts State] -->|click Create New| MODAL1[CreateRecord Modal]
    UPSERT -->|click Import| MODAL2[Import Modal]
    UPSERT -->|click Edit| MODAL3[EditRecord Modal]
    UPSERT -->|click Delete| MODAL4[Confirmation Modal]
    UPSERT -->|click nav tab| AGENTS[Agents State]
    UPSERT -->|click nav tab| WORKSPACE[Workspace State]
```

### 7. State: Workspace

The **Workspace state** is the procurement operations dashboard.

**Buttons**:

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Approve** | `user.role >= 'reviewer'` | Opens Approval modal | `Approval` — 98vw, confirm with optional note |
| **Reject** | `user.role >= 'reviewer'` | Opens Rejection modal | `Rejection` — 98vw, required feedback |
| **Assign** | `user.role >= 'coordinator'` | Opens Assign modal | `Assign` — 98vw, user/agent selector |
| **Generate PO** | `user.role >= 'editor'` | Opens GeneratePO modal | `GeneratePO` — 98vw, PO template, supplier, line items |
| **Generate Report** | Always visible | Opens Export modal | `Export` — 98vw, format selector |
| **Comment/Discussion** | Always visible | Toggles chat panel | Inline toggle |

**HITL Workflow**:
```mermaid
flowchart TD
    AGENT[AI Procurement Agent] -->|completes action| QUEUE[HITL Review Queue]
    QUEUE -->|procurement manager| APPROVE[Approve]
    QUEUE -->|procurement manager| REJECT[Reject with Feedback]
    QUEUE -->|procurement manager| OVERRIDE[Manual Override]
    APPROVE --> EXECUTE[Execute Action - PO issued, Supplier approved]
    REJECT --> AGENT
    OVERRIDE --> EXECUTE
```

---

## Part C: Mermaid UI Flow Diagrams

### 8. Enhanced Procurement Lifecycle Flow

The full procurement lifecycle from need identification through payment, incorporating template complexity selection, AI agent orchestration, HITL review gates, and multi-discipline collaboration.

```mermaid
flowchart TD
    NEED[Identify Need] -->|create| ORDER[Order Creation]
    ORDER -->|select| TEMPLATE[Template Variation Selection]
    TEMPLATE -->|simple| SIMPLE[Simple: 2-3 disciplines]
    TEMPLATE -->|standard| STANDARD[Standard: 3-5 disciplines]
    TEMPLATE -->|complex| COMPLEX[Complex: 6-12 disciplines]
    TEMPLATE -->|emergency| EMERGENCY[Emergency: priority routing]
    TEMPLATE -->|compliance| COMPLIANCE[Compliance: audit required]
    SIMPLE --> DISCIPLINE[Discipline Inheritance]
    STANDARD --> DISCIPLINE
    COMPLEX --> DISCIPLINE
    EMERGENCY --> DISCIPLINE
    COMPLIANCE --> DISCIPLINE
    DISCIPLINE -->|auto-assign| SOW[SOW Generation]
    SOW -->|AI agent| APPENDIX[Appendix Generation A-F]
    APPENDIX -->|route by discipline| COLLAB[Multi-Discipline Collaboration]
    COLLAB -->|HITL gate| HITL{HITL Review Required?}
    HITL -->|yes| REVIEW[HITL Review Queue]
    HITL -->|no| APPROVAL[Approval Routing]
    REVIEW -->|approve| APPROVAL
    REVIEW -->|reject| SOW
    APPROVAL -->|progressive| ASSEMBLY[Document Assembly]
    ASSEMBLY -->|finalize| LOGISTICS[Logistics Processing]
    LOGISTICS -->|deliver| PAYMENT[Payment]

    classDef need fill:#e3f2fd,stroke:#1976d2
    classDef create fill:#f3e5f5,stroke:#7b1fa2
    classDef template fill:#fff3e0,stroke:#f57c00
    classDef work fill:#e8f5e8,stroke:#388e3c
    classDef review fill:#ffebee,stroke:#d32f2f
    classDef final fill:#fce4ec,stroke:#c2185b

    class NEED need
    class ORDER,TEMPLATE,SIMPLE,STANDARD,COMPLEX,EMERGENCY,COMPLIANCE create
    class DISCIPLINE,SOW,APPENDIX,COLLAB work
    class HITL,REVIEW review
    class APPROVAL,ASSEMBLY,LOGISTICS,PAYMENT final
```

### 9. Order Creation with Discipline Inheritance Flow

Detailed flow showing how template variation selection triggers automatic discipline inheritance from Document Ordering Management configuration, followed by user assignment and task generation.

```mermaid
flowchart TD
    START[Create Order] -->|enter details| FORM[Order Form: PO/SO/WO]
    FORM -->|select type| TEMPLATE[Template Variation]
    TEMPLATE -->|auto-detect| INHERIT[Discipline Inheritance]
    INHERIT -->|load config| DOM[Document Ordering Management]
    DOM -->|required| REQUIRED[Required Disciplines]
    DOM -->|recommended| RECOMMENDED[Recommended Disciplines]
    DOM -->|optional| OPTIONAL[Optional Disciplines]
    REQUIRED --> VALIDATE[Validate Coverage]
    RECOMMENDED --> VALIDATE
    OPTIONAL --> VALIDATE
    VALIDATE -->|pass| ASSIGN[User Assignment]
    VALIDATE -->|fail| OVERRIDE[Manual Override]
    OVERRIDE -->|add disciplines| ASSIGN
    ASSIGN -->|per discipline| TASKS[Task Generation]
    TASKS -->|SOW| SOW[SOW Generation Task]
    TASKS -->|appendices| APP[Appendix Tasks A-F]
    TASKS -->|approval| APPROVAL[Approval Workflow]
    SOW --> ACTIVATE[Activate Workflow]
    APP --> ACTIVATE
    APPROVAL --> ACTIVATE

    classDef start fill:#e3f2fd,stroke:#1976d2
    classDef config fill:#f3e5f5,stroke:#7b1fa2
    classDef assign fill:#fff3e0,stroke:#f57c00
    classDef task fill:#e8f5e8,stroke:#388e3c
    classDef final fill:#fce4ec,stroke:#c2185b

    class START,FORM,TEMPLATE start
    class INHERIT,DOM,REQUIRED,RECOMMENDED,OPTIONAL config
    class VALIDATE,OVERRIDE,ASSIGN assign
    class TASKS,SOW,APP,APPROVAL task
    class ACTIVATE final
```

### 10. SOW Generation and Appendix Routing Flow

AI-enhanced SOW creation with appendix generation, discipline-specific routing, and HITL review gates for each appendix type.

```mermaid
flowchart TD
    PRESELECT[Pre-selected Template] -->|load| SECTIONS[Auto-populated Sections]
    SECTIONS -->|AI agent| SOW[SOW Content Generation]
    SOW -->|validate| VALIDATE[Content Validation]
    VALIDATE -->|pass| APP_GEN[Appendix Generation]
    VALIDATE -->|fail| SOW

    APP_GEN --> APP_A[Appendix A: Product Specs]
    APP_GEN --> APP_B[Appendix B: Safety Data Sheets]
    APP_GEN --> APP_C[Appendix C: Delivery Schedule]
    APP_GEN --> APP_D[Appendix D: Training Materials]
    APP_GEN --> APP_E[Appendix E: Logistics Docs]
    APP_GEN --> APP_F[Appendix F: Packing Specs]

    APP_A -->|route| ENG[Engineering Team]
    APP_B -->|route| SAFETY[Safety Team]
    APP_C -->|route| PROCURE[Procurement Team]
    APP_D -->|route| TECH[Technical Team]
    APP_E -->|route| LOGISTICS[Logistics Team]
    APP_F -->|route| QUALITY[Quality Team]

    ENG -->|HITL| HITL_A{HITL Approve?}
    SAFETY -->|HITL| HITL_B{HITL Approve?}
    PROCURE -->|HITL| HITL_C{HITL Approve?}
    TECH -->|HITL| HITL_D{HITL Approve?}
    LOGISTICS -->|HITL| HITL_E{HITL Approve?}
    QUALITY -->|HITL| HITL_F{HITL Approve?}

    HITL_A -->|yes| ASSEMBLE[Document Assembly]
    HITL_B -->|yes| ASSEMBLE
    HITL_C -->|yes| ASSEMBLE
    HITL_D -->|yes| ASSEMBLE
    HITL_E -->|yes| ASSEMBLE
    HITL_F -->|yes| ASSEMBLE

    HITL_A -->|no| APP_A
    HITL_B -->|no| APP_B
    HITL_C -->|no| APP_C
    HITL_D -->|no| APP_D
    HITL_E -->|no| APP_E
    HITL_F -->|no| APP_F

    ASSEMBLE -->|finalize| PACKAGE[Final Procurement Package]

    classDef sow fill:#e3f2fd,stroke:#1976d2
    classDef appendix fill:#f3e5f5,stroke:#7b1fa2
    classDef route fill:#fff3e0,stroke:#f57c00
    classDef hitl fill:#ffebee,stroke:#d32f2f
    classDef final fill:#e8f5e8,stroke:#388e3c

    class PRESELECT,SECTIONS,SOW,VALIDATE sow
    class APP_A,APP_B,APP_C,APP_D,APP_E,APP_F appendix
    class ENG,SAFETY,PROCURE,TECH,LOGISTICS,QUALITY route
    class HITL_A,HITL_B,HITL_C,HITL_D,HITL_E,HITL_F hitl
    class ASSEMBLE,PACKAGE final
```

### 11. HITL Review Workflow

Human-in-the-Loop review process showing AI agent action completion, intelligent reviewer assignment, structured decision framework, and iterative refinement with chatbot collaboration.

```mermaid
flowchart TD
    AGENT[AI Procurement Agent] -->|completes action| QUEUE[HITL Review Queue]
    QUEUE -->|assess| ASSESS{Requires HITL?}
    ASSESS -->|confidence low| CREATE[Create HITL Task]
    ASSESS -->|complex content| CREATE
    ASSESS -->|regulatory need| CREATE
    ASSESS -->|stakeholder request| CREATE
    ASSESS -->|confidence high| AUTO[Auto-approve]

    CREATE -->|assign reviewer| ASSIGN[Reviewer Assignment Engine]
    ASSIGN -->|expertise match| REVIEWER[Assign to Expert]
    ASSIGN -->|availability| REVIEWER
    ASSIGN -->|performance history| REVIEWER

    REVIEWER -->|review| DECISION{Decision}
    DECISION -->|approve| EXECUTE[Execute Action]
    DECISION -->|minor revisions| REVISE[AI Revises Content]
    DECISION -->|major revisions| REJECT[Return to AI Agent]
    DECISION -->|manual override| OVERRIDE[Human Takes Over]

    REVISE -->|chatbot refine| CHAT[Chatbot Collaboration]
    CHAT -->|regenerate| REVIEWER
    REJECT -->|feedback| AGENT
    OVERRIDE --> EXECUTE

    EXECUTE -->|log| AUDIT[Audit Trail]
    AUDIT -->|complete| DONE[Action Complete]

    classDef agent fill:#e3f2fd,stroke:#1976d2
    classDef queue fill:#f3e5f5,stroke:#7b1fa2
    classDef assign fill:#fff3e0,stroke:#f57c00
    classDef review fill:#ffebee,stroke:#d32f2f
    classDef final fill:#e8f5e8,stroke:#388e3c

    class AGENT agent
    class QUEUE,ASSESS,CREATE,AUTO queue
    class ASSIGN,REVIEWER assign
    class DECISION,REVISE,REJECT,OVERIDE,CHAT review
    class EXECUTE,AUDIT,DONE final
```

### 12. Progressive Approval Matrix Flow

Risk-based approval routing with value thresholds determining single, parallel, or sequential approval chains, integrated with the existing 01300 Approval Matrix system.

```mermaid
flowchart TD
    ORDER[Procurement Order] -->|evaluate| EVAL[Approval Matrix Evaluation]
    EVAL -->|value under 25K| SINGLE[Single Approver]
    EVAL -->|value 25K to 250K| PARALLEL[Parallel Approvers]
    EVAL -->|value over 250K| SEQUENTIAL[Sequential Chain]

    SINGLE -->|procurement officer| LEVEL1[Level 1 Approval]
    LEVEL1 -->|approve| COMPLETE[Approval Complete]
    LEVEL1 -->|reject| RETURN[Return to Order]

    PARALLEL -->|officer + manager| LEVEL2A[Procurement Officer]
    PARALLEL -->|simultaneous| LEVEL2B[Department Head]
    LEVEL2A -->|both approve| COMPLETE
    LEVEL2B -->|both approve| COMPLETE
    LEVEL2A -->|reject| RETURN
    LEVEL2B -->|reject| RETURN

    SEQUENTIAL -->|level 1| L1[Procurement Officer]
    L1 -->|approve| L2[Procurement Manager]
    L1 -->|reject| RETURN
    L2 -->|approve| L3[Executive Approval]
    L2 -->|reject| RETURN
    L3 -->|approve| COMPLETE
    L3 -->|reject| RETURN

    COMPLETE -->|route| ACTIVATE[Activate Procurement Workflow]
    RETURN -->|revise| ORDER

    classDef order fill:#e3f2fd,stroke:#1976d2
    classDef eval fill:#f3e5f5,stroke:#7b1fa2
    classDef single fill:#e8f5e8,stroke:#388e3c
    classDef parallel fill:#fff3e0,stroke:#f57c00
    classDef sequential fill:#ffebee,stroke:#d32f2f
    classDef final fill:#fce4ec,stroke:#c2185b

    class ORDER order
    class EVAL eval
    class SINGLE,LEVEL1 single
    class PARALLEL,LEVEL2A,LEVEL2B parallel
    class SEQUENTIAL,L1,L2,L3 sequential
    class COMPLETE,RETURN,ACTIVATE final
```

### 13. Appendix B Safety Data Sheets HITL Detail Flow

Detailed HITL workflow for Appendix B showing the 5-phase AI-to-human collaborative review process with chatbot-driven iterative refinement.

```mermaid
flowchart TD
    PHASE1[Phase 1: AI Agent Processing] -->|generate| SDS[SDS 16-Section Content]
    SDS -->|flag hazards| FLAG[Flag for Human Review]
    FLAG -->|create task| PHASE2[Phase 2: HITL Task Creation]
    PHASE2 -->|assign to safety officer| ASSIGN[Task in MyTasksDashboard]
    ASSIGN -->|open review| PHASE3[Phase 3: Human-AI Review]
    PHASE3 -->|show confidence| INTERFACE[Review Interface]
    INTERFACE -->|section 1| S1[Section 1: Identification - 95% confidence]
    INTERFACE -->|section 2| S2[Section 2: Hazard ID - 78% confidence needs review]
    INTERFACE -->|section 8| S8[Section 8: PPE - needs review]

    S2 -->|chatbot| CHAT[Chatbot Collaboration]
    S8 -->|chatbot| CHAT
    CHAT -->|request revision| PHASE4[Phase 4: Iterative Refinement]
    PHASE4 -->|AI regenerates| UPDATE[Updated Content]
    UPDATE -->|re-review| INTERFACE
    UPDATE -->|approve| PHASE5[Phase 5: Final Approval]
    PHASE5 -->|mark complete| INTEGRATE[Integrate into Procurement Package]

    classDef phase1 fill:#e3f2fd,stroke:#1976d2
    classDef phase2 fill:#f3e5f5,stroke:#7b1fa2
    classDef phase3 fill:#fff3e0,stroke:#f57c00
    classDef phase4 fill:#e8f5e8,stroke:#388e3c
    classDef phase5 fill:#fce4ec,stroke:#c2185b

    class PHASE1,SDS,FLAG phase1
    class PHASE2,ASSIGN phase2
    class PHASE3,INTERFACE,S1,S2,S8,CHAT phase3
    class PHASE4,UPDATE phase4
    class PHASE5,INTEGRATE phase5
```

### 14. Template Complexity Decision Tree

Decision tree for template complexity selection showing how each complexity level determines discipline count, appendix requirements, approval levels, and business rules.

```mermaid
flowchart TD
    CREATE[Create Template] -->|select| COMPLEXITY{Complexity Level}
    COMPLEXITY -->|simple| SIMPLE[Simple Procurement]
    COMPLEXITY -->|standard| STANDARD[Standard Procurement]
    COMPLEXITY -->|complex| COMPLEX[Complex Procurement]
    COMPLEXITY -->|emergency| EMERGENCY[Emergency Procurement]
    COMPLEXITY -->|compliance| COMPLIANCE[Compliance Procurement]

    SIMPLE --> S_DISC[Disciplines: 01900 only]
    SIMPLE --> S_APP[Appendices: A, C]
    SIMPLE --> S_APPROVAL[Approval: 1 level]
    SIMPLE --> S_HITL[HITL: not required]

    STANDARD --> STD_DISC[Disciplines: 01900, 02400]
    STANDARD --> STD_APP[Appendices: A, B, C, E]
    STANDARD --> STD_APPROVAL[Approval: 2 levels]
    STANDARD --> STD_HITL[HITL: required]

    COMPLEX --> C_DISC[Disciplines: 6-12 disciplines]
    COMPLEX --> C_APP[Appendices: A, B, C, D, E, F]
    COMPLEX --> C_APPROVAL[Approval: 3 levels]
    COMPLEX --> C_HITL[HITL: required]

    EMERGENCY --> E_DISC[Disciplines: 01900, 02400]
    EMERGENCY --> E_APP[Appendices: A, B, C]
    EMERGENCY --> E_APPROVAL[Approval: 1 level]
    EMERGENCY --> E_HITL[HITL: not required priority]

    COMPLIANCE --> CO_DISC[Disciplines: 01900, 01300, 02400]
    COMPLIANCE --> CO_APP[Appendices: A, B, C, F]
    COMPLIANCE --> CO_APPROVAL[Approval: 3 levels audit]
    COMPLIANCE --> CO_HITL[HITL: required audit trail]

    classDef decision fill:#e3f2fd,stroke:#1976d2
    classDef simple fill:#e8f5e8,stroke:#388e3c
    classDef standard fill:#fff3e0,stroke:#f57c00
    classDef complex fill:#ffebee,stroke:#d32f2f
    classDef emergency fill:#fce4ec,stroke:#c2185b
    classDef compliance fill:#f3e5f5,stroke:#7b1fa2

    class CREATE,COMPLEXITY decision
    class SIMPLE,S_DISC,S_APP,S_APPROVAL,S_HITL simple
    class STANDARD,STD_DISC,STD_APP,STD_APPROVAL,STD_HITL standard
    class COMPLEX,C_DISC,C_APP,C_APPROVAL,C_HITL complex
    class EMERGENCY,E_DISC,E_APP,E_APPROVAL,E_HITL emergency
    class COMPLIANCE,CO_DISC,CO_APP,CO_APPROVAL,CO_HITL compliance
```

### 15. Page State Flow with Modal Integration

Enhanced page state flow showing three-state navigation with modal interactions, HITL queue sub-states, and Workspace-specific operations.

```mermaid
flowchart TD
    LOAD[Page Load] -->|check auth| AUTH{Auth Valid?}
    AUTH -->|no| LOGIN[Redirect to Login]
    AUTH -->|yes| STATE[State Router]
    STATE -->|default| AGENTS[Agents State]
    STATE -->|nav| UPSERT[Upserts State]
    STATE -->|nav| WORKSPACE[Workspace State]

    AGENTS -->|view details| AGENT_MODAL[AgentDetails Modal]
    AGENTS -->|nav tab| UPSERT
    AGENTS -->|nav tab| WORKSPACE

    UPSERT -->|create new| CREATE_MODAL[CreateRecord Modal]
    UPSERT -->|import| IMPORT_MODAL[Import Modal]
    UPSERT -->|edit| EDIT_MODAL[EditRecord Modal]
    UPSERT -->|delete| DELETE_MODAL[Confirmation Modal]
    UPSERT -->|nav tab| AGENTS
    UPSERT -->|nav tab| WORKSPACE

    WORKSPACE -->|review queue| HITL_QUEUE[HITL Review Queue]
    WORKSPACE -->|generate PO| PO_MODAL[GeneratePO Modal]
    WORKSPACE -->|generate report| EXPORT_MODAL[Export Modal]
    WORKSPACE -->|nav tab| AGENTS
    WORKSPACE -->|nav tab| UPSERT

    HITL_QUEUE -->|approve| APPROVE_MODAL[Approval Modal]
    HITL_QUEUE -->|reject| REJECT_MODAL[Rejection Modal]
    HITL_QUEUE -->|assign| ASSIGN_MODAL[Assign Modal]

    classDef auth fill:#e3f2fd,stroke:#1976d2
    classDef state fill:#f3e5f5,stroke:#7b1fa2
    classDef agents fill:#e8f5e8,stroke:#388e3c
    classDef upsert fill:#fff3e0,stroke:#f57c00
    classDef workspace fill:#ffebee,stroke:#d32f2f
    classDef modal fill:#fce4ec,stroke:#c2185b

    class LOAD,AUTH,LOGIN auth
    class STATE state
    class AGENTS,AGENT_MODAL agents
    class UPSERT,CREATE_MODAL,IMPORT_MODAL,EDIT_MODAL,DELETE_MODAL upsert
    class WORKSPACE,HITL_QUEUE,PO_MODAL,EXPORT_MODAL workspace
    class APPROVE_MODAL,REJECT_MODAL,ASSIGN_MODAL modal
```

---

### 16. Streamlined Workflow Architecture

The rationalized 4-layer architecture showing Configuration Layer through Phase 4 Intelligent Assembly, with color-coded phases and sequential flow.

```mermaid
flowchart TD
    subgraph CONFIG[Configuration Layer]
        DOM[Document Ordering Management]
    end

    subgraph P1[Phase 1: Intelligent Order Creation]
        ORDER[CreateOrderModal with Template Variation]
        ASSIGN[Smart User Assignment]
        TASKS[Parallel Task Generation]
    end

    subgraph P2[Phase 2: Automated SOW Generation]
        SOW[AI-Enhanced SOW Creation]
        SECTIONS[Auto-populated Sections]
        VALIDATE[Content Validation]
    end

    subgraph P3[Phase 3: Streamlined Collaboration]
        COLLAB[Smart Task Distribution]
        REVIEW[Automated Review Routing]
        APPROVE[Progressive Approval]
    end

    subgraph P4[Phase 4: Intelligent Assembly]
        ASSEMBLE[Auto-generated Package]
        DISTRIBUTE[Smart Distribution]
    end

    DOM --> ORDER
    ORDER --> ASSIGN
    ASSIGN --> TASKS
    TASKS --> SOW
    SOW --> SECTIONS
    SECTIONS --> VALIDATE
    VALIDATE --> COLLAB
    COLLAB --> REVIEW
    REVIEW --> APPROVE
    APPROVE --> ASSEMBLE
    ASSEMBLE --> DISTRIBUTE

    classDef config fill:#e3f2fd,stroke:#1976d2
    classDef phase1 fill:#f3e5f5,stroke:#7b1fa2
    classDef phase2 fill:#e8f5e8,stroke:#388e3c
    classDef phase3 fill:#fff3e0,stroke:#f57c00
    classDef phase4 fill:#ffebee,stroke:#d32f2f

    class DOM config
    class ORDER,ASSIGN,TASKS phase1
    class SOW,SECTIONS,VALIDATE phase2
    class COLLAB,REVIEW,APPROVE phase3
```

---

## Part D: Implementation Standards

### 10. CSS Architecture

**Import Chain**:
```css
/* 1. Template A Standard (this is the REFERENCE page) */
@import "../../templates/template-a-standard.css";

/* 2. Page-Specific Procurement Styles */
@import "01900-procurement-page-style.css";
```

**File**:
- `client/src/common/css/pages/01900-procurement/01900-procurement-page-style.css`

**CSS Class Convention**: `A-01900-*` for all page-level elements (per PROCURE-001 test requirement).

**State Button Pattern**:
```html
<nav class="bottom-fixed-nav">
  <button class="A-01900-state-btn active">Agents</button>
  <button class="A-01900-state-btn">Upserts</button>
  <button class="A-01900-state-btn">Workspace</button>
</nav>
```

**Key Principles**:
- Background image permitted (this is one of the exception pages)
- 98vw Modal Sizing
- Orange color scheme throughout
- `A-01900-*` class prefix

### 11. Component Inventory

| Component | File | Purpose | CSS Class Prefix |
|-----------|------|---------|-----------------|
| StateButtons | Page template | Three-state navigation | `.A-01900-state-btn` |
| NavContainer | Page template | Bottom-fixed nav | `.A-01900-nav-container` |
| LoginForm | Auth | Authentication | `.A-01900-login` |
| LogoutButton | Auth | Session termination | `.A-01900-logout` |
| SupplierTable | Data grid | Supplier management | `.A-01900-supplier-table` |
| TenderList | Data grid | Tender management | `.A-01900-tender-list` |
| POForm | Form | Purchase order creation | `.A-01900-po-form` |
| StandardsSelector | Form | Procurement standards | `.A-01900-standards-selector` |
| ConfirmationModal | Modal | Destructive actions | `.A-01900-confirmation-modal` |
| ApprovalModal | Modal | Approve workflow | `.A-01900-approval-modal` |

### 12. Dropdown Specifications

**Supplier Selector**:
```javascript
<select
  value={selectedSupplier}
  onChange={(e) => setSelectedSupplier(e.target.value)}
  style={{
    width: "100%",
    padding: "8px 12px",
    border: selectedSupplier
      ? "2px solid #28a745"  // Green when valid
      : "2px solid #dee2e6",  // Gray when empty
    borderRadius: "4px",
    fontSize: "0.875rem",
    backgroundColor: "#ffffff",
    cursor: "pointer",
  }}
>
  <option value="">Select supplier...</option>
  {suppliers.map((s) => (
    <option key={s.id} value={s.id}>{s.name}</option>
  ))}
</select>
```

### 13. Modal Specifications

All modals follow 98vw width with orange gradient headers.

**Modal Inventory**:
| Modal | State | Purpose |
|-------|-------|---------|
| CreateNewAgent | Agents | Create procurement agent |
| AgentConfig | Agents | Configure agent settings |
| CreateRecord | Upserts | New procurement record |
| Import | Upserts | Bulk import CSV/Excel |
| EditRecord | Upserts | Edit existing record |
| Approval | Workspace | Approve AI action |
| Rejection | Workspace | Reject with feedback |
| GeneratePO | Workspace | Create purchase order |
| Export | Workspace | Export report |

### 14. Chatbot Configuration

**Template Type**: Template B (State-Aware)

```javascript
{
  chatType: "agent",
  stateAware: true,
  currentState: "agents|upserts|workspace",
  zIndex: 1500,
  modelEndpoint: "/api/chat/procurement",
}
```

**State-Aware Behavior**:
- **Agents**: Chatbot answers questions about procurement agent capabilities
- **Upserts**: Chatbot assists with record creation, supplier selection, tender drafting
- **Workspace**: Chatbot explains AI procurement recommendations, suggests approvals

---

## Part E: Screen Specifications (Detailed)

### 15. Screen Inventory

| Screen | State | Loading | Empty | Error | Populated |
|--------|-------|---------|-------|-------|-----------|
| Agent List | Agents | Spinner + skeleton | "No agents" CTA | Red banner + retry | Agent cards |
| Record List | Upserts | Spinner + skeleton | "No records" CTA | Red banner + retry | Table with pagination |
| Record Form | Upserts | Spinner | Empty form | Field errors | Pre-populated form |
| HITL Queue | Workspace | Spinner + skeleton | "No items to review" | Red banner + retry | Queue with priority |

### 16. Wireframe: Agents State

```
┌──────────────────────────────────────────────────────────────┐
│  [Orange Header Gradient]                                     │
│  01900 Procurement │ [Chatbot]                                 │
├──────────────────────────────────────────────────────────────┤
│  [Tab Nav: Agents | Upserts | Workspace]                      │
│  ┌────────────────────────────────────────────────────────┐  │
│  │ Procurement Agents              [+ Add Agent]          │  │
│  ├────────────────────────────────────────────────────────┤  │
│  │ ┌──────────┐ ┌──────────┐ ┌──────────┐                │  │
│  │ │ Supplier │ │ Tender   │ │ Contract │                │  │
│  │ │ Analyst  │ │ Evaluator│ │ Admin    │                │  │
│  │ │ ● Active │ │ ● Active │ │ ● Active │                │  │
│  │ │ [Edit]   │ │ [Edit]   │ │ [Edit]   │                │  │
│  │ └──────────┘ └──────────┘ └──────────┘                │  │
│  └────────────────────────────────────────────────────────┘  │
├──────────────────────────────────────────────────────────────┤
│  [Bottom-Fixed Nav]                                           │
└──────────────────────────────────────────────────────────────┘
```

### 17. Platform Adaptations

**Desktop (1280px+)**:
- Full three-state navigation visible
- Bottom-fixed nav container centered with `transform: translateX(-50%)`
- Agent grid: 3 columns

**Tablet (768px - 1279px)**:
- Three-state nav collapses to dropdown
- Agent grid: 2 columns

**Mobile (< 768px)**:
- Three-state nav as bottom tab bar
- Agent grid: 1 column
- Touch targets: minimum 48dp

---

## Part F: AI Model Backend

### 18. Model Infrastructure

**Base Model**: Qwen 2.5 (or similar)
- See `0000_QWEN_FINETUNING_PROCEDURE.md`
- Fine-tuned on procurement domain data (RFQ templates, supplier evaluation criteria, contract terms)

**Domain Adapter**: LoRA fine-tuned per procurement function
- See `0000_LORA_ADAPTER_INTEGRATION_PROCEDURE.md`
- **Procurement LoRA**: Supplier evaluation, tender comparison

**Deployment**: HuggingFace model serving
- See `0000_HF_MODEL_INTEGRATION_PROCEDURE.md`
- Endpoint: `/api/chat/procurement`
- Fallback: Base Qwen model

---

## Part G: Agent Knowledge Ownership

### 19. Agent Ownership

| Company | Role | Action |
|---------|------|--------|
| **DomainForge AI** | Domain Validation | Validate procurement workflows are correct |
| **QualityForge AI** | Testing | Execute PROCURE-TEST suite against this spec |
| **DevForge AI** | Implementation | Build HTML/CSS/React pages per wireframes |
| **KnowledgeForge AI** | Indexing | Index spec into institutional memory |
| **PromptForge AI** | Task Routing | Route procurement UI tasks to DevForge |

### 20. QualityForge AI Testing

Per the PROCURE-TEST suite:
1. **Foundation (PROCURE-001)**: Auth, nav container, state buttons, logout, background image
2. **Modal Integration**: All 8+ modals open/close correctly
3. **State Transitions**: Agents ↔ Upserts ↔ Workspace flow correctly
4. **Form Validation**: Green/gray/red borders per 0750 standard

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.1 | 2026-04-29 | Expanded Part C with 9 comprehensive Mermaid UI flow diagrams extracted from procurement workflow documentation |
| 1.0 | 2026-04-28 | Initial UI/UX specification for 01900 Procurement reference page |

---

**Document Information**
- **Author**: DomainForge AI — Procurement Domain
- **Date**: 2026-04-29
- **Status**: Active

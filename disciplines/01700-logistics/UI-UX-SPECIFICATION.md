---
title: "01700 Logistics — UI/UX Specification"
description: "Complete UI/UX specification for the Logistics discipline page, covering Template B (Complex/Three-State) classification, Mermaid flow diagrams, three-state button mechanics, modal inventory, color palette, chatbot configuration, AI model backend, and agent knowledge ownership."
author: "PromptForge AI — Discipline Automation Agent"
date: "2026-04-29"
version: "1.0"
---

# 01700 Logistics — UI/UX Specification

## Part A: UX Patterns (High-Level)

### Template Classification

**Classification**: Template B (Complex/Three-State)

**Rationale**:
- Multi-state page with 3 distinct navigation states (Agents, Upserts, Workspace)
- Complex workflows: route optimization, customs clearance, delivery scheduling
- Multiple components: 8 logistics project areas (ContainerTracking, CustomsManagement, DailyDelivery, DocumentGeneration, InternationalShipping, SitePlanning, TrafficManagement, MaterialFlow)
- State-aware chatbot with different behaviors per state

### Color Scheme — Logistics Blue Palette

```css
:root {
  --template-a-primary: #1565C0;
  --template-a-secondary: #1976D2;
  --template-a-accent: #0D47A1;
  --template-a-bg-gradient: linear-gradient(135deg, #f0f4f8 0%, #e3edf7 100%);
  --template-a-header-gradient: linear-gradient(135deg, #0D47A1 0%, #1565C0 100%);
  --template-a-text-primary: #000000;
  --template-a-text-secondary: #546e7a;
  --template-a-text-white: #ffffff;
  --template-a-shadow-sm: 0 2px 4px rgba(21, 101, 192, 0.08);
  --template-a-shadow-md: 0 4px 6px rgba(21, 101, 192, 0.12);
  --template-a-shadow-lg: 0 8px 24px rgba(21, 101, 192, 0.25);
  --template-a-success: #2E7D32;
  --template-a-warning: #F57F17;
  --template-a-danger: #C62828;
}
```

### HITL Integration Pattern

AI generates logistics recommendations (route plans, customs docs, delivery schedules) → HITL review queue → Human approves/rejects/modifies → Execute.

---

## Part B: Three-State Button & Modal Rules

### State Definitions

| State | Purpose | Default Content | Chatbot Behavior |
|-------|---------|-----------------|------------------|
| **Agents** | Show AI agents for logistics | Agent cards with status indicators | Answers questions about logistics agent capabilities |
| **Upserts** | Create, edit, import logistics records | Forms, tables, import tools | Assists with record creation, data entry, document generation |
| **Workspace** | Operations dashboard, HITL review | HITL queue, route optimization, delivery tracking | Explains AI recommendations, suggests approvals |

### Agents State Buttons

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **View Details** | Always visible | Opens AgentDetails modal | `AgentDetails` — 98vw, agent metrics |
| **Assign Task** | `user.role >= 'editor'` | Opens TaskAssignment modal | `TaskAssignment` — 98vw, task form |
| **View History** | Always visible | Opens AgentHistory modal | `AgentHistory` — 98vw, timeline |

### Upserts State Buttons

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Create Record** | `user.role >= 'editor'` | Opens CreateRecord modal | `CreateRecord` — 98vw, logistics form |
| **Import Data** | `user.role >= 'editor'` | Opens ImportData modal | `ImportData` — 98vw, file upload |
| **Generate Document** | `user.role >= 'editor'` | Opens DocumentGenerator modal | `DocumentGenerator` — 98vw, template selector |
| **Edit** | `user.role >= 'editor'` | Opens EditRecord modal | `EditRecord` — 98vw, edit form |

### Workspace State Buttons

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Approve** | `user.role >= 'reviewer'` | Opens Approval modal | `Approval` — 98vw, confirm with note |
| **Reject** | `user.role >= 'reviewer'` | Opens Rejection modal | `Rejection` — 98vw, feedback form |
| **Override** | `user.role >= 'coordinator'` | Opens Override modal | `Override` — 98vw, override reason |
| **View Queue** | Always visible | Opens HITLQueue modal | `HITLQueue` — 98vw, queue table |
| **Export Report** | Always visible | Opens ExportOptions modal | `ExportOptions` — 98vw, format selector |

---

## Part C: Mermaid UI Flow Diagrams

### Diagram 1: Three-State Navigation Flow

```mermaid
flowchart TD
    classDef start fill:#e3f2fd,stroke:#1565C0
    classDef state fill:#e8eaf6,stroke:#283593
    classDef action fill:#f3e5f5,stroke:#7b1fa2
    classDef modal fill:#fff3e0,stroke:#f57c00

    Load[Page Load] --> Auth{Auth Check}
    Auth -->|Pass| Router[State Router]
    Auth -->|Fail| Login[Login Page]
    
    Router --> Agents[Agents State]
    Router --> Upserts[Upserts State]
    Router --> Workspace[Workspace State]
    
    Agents --> ViewAgent[View Agent Details]
    Agents --> AssignTask[Assign Task]
    Agents --> ViewHistory[View History]
    
    Upserts --> CreateRecord[Create Record]
    Upserts --> ImportData[Import Data]
    Upserts --> GenerateDoc[Generate Document]
    
    Workspace --> ReviewQueue[Review HITL Queue]
    Workspace --> ApproveAction[Approve Action]
    Workspace --> RejectAction[Reject Action]
    Workspace --> OverrideAction[Override Action]
    
    class Load,Login start
    class Agents,Upserts,Workspace state
    class ViewAgent,AssignTask,CreateRecord,ImportData,GenerateDoc,ReviewQueue action
    class ApproveAction,RejectAction,OverrideAction modal
```

### Diagram 2: HITL Review Workflow

```mermaid
flowchart TD
    classDef start fill:#e3f2fd,stroke:#1565C0
    classDef process fill:#f3e5f5,stroke:#7b1fa2
    classDef review fill:#ffebee,stroke:#d32f2f
    classDef final fill:#e8f5e8,stroke:#2E7D32

    AI[AI Generates Logistics Action] --> Queue[Review Queue]
    Queue --> HITL{Human Review}
    HITL -->|Approve| Execute[Execute Action]
    HITL -->|Reject| Feedback[Provide Feedback]
    HITL -->|Modify| Adjust[Adjust Parameters]
    HITL -->|Escalate| Supervisor[Supervisor Review]
    
    Execute --> Log[Log to Audit Trail]
    Feedback --> Improve[Update AI Model]
    Adjust --> Execute
    Supervisor -->|Approve| Execute
    Supervisor -->|Reject| Feedback
    
    class AI,Queue start
    class HITL,Supervisor review
    class Execute,Log final
    class Feedback,Improve,Adjust process
```

### Diagram 3: Logistics Lifecycle Flow

```mermaid
flowchart TD
    classDef start fill:#e3f2fd,stroke:#1565C0
    classDef process fill:#f3e5f5,stroke:#7b1fa2
    classDef decision fill:#fff3e0,stroke:#f57c00
    classDef review fill:#ffebee,stroke:#d32f2f
    classDef final fill:#e8f5e8,stroke:#2E7D32

    Need[Logistics Need Identified] --> Order[Create Logistics Order]
    Order --> Route[Route Planning]
    Route --> Customs{Customs Required?}
    Customs -->|Yes| Clearance[Customs Clearance]
    Customs -->|No| Schedule[Schedule Delivery]
    Clearance --> Schedule
    Schedule --> Dispatch[Dispatch & Track]
    Dispatch --> Delivery[Delivery Confirmation]
    Delivery --> HITL[HITL Review]
    HITL -->|Approve| Complete[Order Complete]
    HITL -->|Issue| Resolve[Resolve Exception]
    Resolve --> HITL
    
    class Need,Order start
    class Route,Clearance,Schedule,Dispatch,Delivery process
    class Customs decision
    class HITL,Resolve review
    class Complete final
```

### Diagram 4: Order Creation with Inheritance

```mermaid
flowchart TD
    classDef start fill:#e3f2fd,stroke:#1565C0
    classDef process fill:#f3e5f5,stroke:#7b1fa2
    classDef decision fill:#fff3e0,stroke:#f57c00
    classDef final fill:#e8f5e8,stroke:#2E7D32

    Form[Logistics Order Form] --> Template{Select Template}
    Template -->|Bill of Lading| BOL[BOL Template]
    Template -->|Packing List| PL[Packing List Template]
    Template -->|Customs Declaration| CD[Customs Declaration Template]
    
    BOL --> Inherit[Inherit Discipline Config]
    PL --> Inherit
    CD --> Inherit
    
    Inherit --> Assign[Assign to Logistics Agent]
    Assign --> Tasks[Generate Tasks]
    Tasks --> Submit[Submit for Processing]
    
    class Form,Template start
    class BOL,PL,CD,Inherit,Assign,Tasks process
    class Submit final
```

### Diagram 5: Document Generation & Routing

```mermaid
flowchart TD
    classDef start fill:#e3f2fd,stroke:#1565C0
    classDef process fill:#f3e5f5,stroke:#7b1fa2
    classDef decision fill:#fff3e0,stroke:#f57c00
    classDef review fill:#ffebee,stroke:#d32f2f
    classDef final fill:#e8f5e8,stroke:#2E7D32

    SOW[Logistics Order] --> Docs[Generate Documents]
    Docs --> BOL[Bill of Lading]
    Docs --> PL[Packing List]
    Docs --> CD[Customs Declaration]
    Docs --> CI[Commercial Invoice]
    Docs --> CO[Certificate of Origin]
    
    BOL --> RouteBOL{Route to Carrier?}
    RouteBOL -->|Yes| Carrier[Carrier Review]
    RouteBOL -->|No| Hold[On Hold]
    
    CD --> RouteCD{Route to Customs?}
    RouteCD -->|Yes| CustomsBroker[Customs Broker Review]
    RouteCD -->|No| Hold
    
    Carrier --> HITL[HITL per Document]
    CustomsBroker --> HITL
    HITL -->|All Approved| Ship[Ready to Ship]
    HITL -->|Any Rejected| Revise[Revise Document]
    Revise --> Docs
    
    class SOW,Docs start
    class BOL,PL,CD,CI,CO process
    class RouteBOL,RouteCD decision
    class Carrier,CustomsBroker,HITL,Revise review
    class Ship final
```

### Diagram 6: Template Complexity Decision Tree

```mermaid
flowchart TD
    classDef start fill:#e3f2fd,stroke:#1565C0
    classDef process fill:#f3e5f5,stroke:#7b1fa2
    classDef decision fill:#fff3e0,stroke:#f57c00
    classDef final fill:#e8f5e8,stroke:#2E7D32

    Order[Logistics Order] --> Type{Order Type}
    Type -->|Simple| Simple[Standard Template]
    Type -->|Complex| Complex[Multi-Modal Template]
    Type -->|Emergency| Emergency[Express Template]
    Type -->|International| Intl[International Template]
    
    Simple --> Single[Single Carrier]
    Complex --> Multi[Multiple Carriers]
    Emergency --> Priority[Priority Processing]
    Intl --> Customs[Customs + Insurance]
    
    Single --> Complete[Complete Order]
    Multi --> Complete
    Priority --> Complete
    Customs --> Complete
    
    class Order,Type start
    class Simple,Complex,Emergency,Intl decision
    class Single,Multi,Priority,Customs process
    class Complete final
```

### Diagram 7: Progressive Approval Matrix

```mermaid
flowchart TD
    classDef start fill:#e3f2fd,stroke:#1565C0
    classDef process fill:#f3e5f5,stroke:#7b1fa2
    classDef decision fill:#fff3e0,stroke:#f57c00
    classDef review fill:#ffebee,stroke:#d32f2f
    classDef final fill:#e8f5e8,stroke:#2E7D32

    Value[Order Value] --> Threshold{Value Threshold}
    Threshold -->|< $5K| Single[Single Approver]
    Threshold -->|$5K - $50K| Parallel[Parallel Approvers]
    Threshold -->|> $50K| Sequential[Sequential Approvers]
    
    Single --> Manager[Logistics Manager]
    Parallel --> Manager
    Parallel --> Finance[Finance Approver]
    Sequential --> Manager
    Sequential --> Director[Logistics Director]
    Sequential --> Exec[Executive Approval]
    
    Manager --> Approve[Approved]
    Finance --> Approve
    Director --> Approve
    Exec --> Approve
    
    class Value,Threshold start
    class Single,Parallel,Sequential decision
    class Manager,Finance,Director,Exec review
    class Approve final
```

### Diagram 8: Enhanced HITL Detail Flow

```mermaid
flowchart TD
    classDef start fill:#e3f2fd,stroke:#1565C0
    classDef process fill:#f3e5f5,stroke:#7b1fa2
    classDef decision fill:#fff3e0,stroke:#f57c00
    classDef review fill:#ffebee,stroke:#d32f2f
    classDef final fill:#e8f5e8,stroke:#2E7D32

    Phase1[Phase 1: AI Generates] --> Phase2[Phase 2: HITL Review]
    Phase2 --> Phase3{Phase 3: Decision}
    Phase3 -->|Approve| Phase4[Phase 4: Execute]
    Phase3 -->|Reject| Chatbot[Chatbot Refinement]
    Phase3 -->|Modify| Adjust[Human Adjusts]
    
    Chatbot --> Phase2
    Adjust --> Phase4
    
    Phase4 --> Phase5[Phase 5: Log & Learn]
    Phase5 --> Metrics[Update Metrics]
    Metrics --> Feedback[Feedback to AI]
    
    class Phase1,Phase2 start
    class Phase3 decision
    class Chatbot,Adjust,Phase5,Metrics,Feedback process
    class Phase4 final
```

### Diagram 9: Page State with Modal Integration

```mermaid
flowchart TD
    classDef start fill:#e3f2fd,stroke:#1565C0
    classDef state fill:#e8eaf6,stroke:#283593
    classDef modal fill:#fff3e0,stroke:#f57c00
    classDef final fill:#e8f5e8,stroke:#2E7D32

    Load[Page Load] --> Auth[Auth Check]
    Auth --> Router[State Router]
    
    Router -->|Agents| S1[Agents State]
    Router -->|Upserts| S2[Upserts State]
    Router -->|Workspace| S3[Workspace State]
    
    S1 --> M1[AgentDetails Modal]
    S1 --> M2[TaskAssignment Modal]
    S1 --> M3[AgentHistory Modal]
    
    S2 --> M4[CreateRecord Modal]
    S2 --> M5[ImportData Modal]
    S2 --> M6[DocumentGenerator Modal]
    S2 --> M7[EditRecord Modal]
    
    S3 --> M8[Approval Modal]
    S3 --> M9[Rejection Modal]
    S3 --> M10[Override Modal]
    S3 --> M11[HITLQueue Modal]
    S3 --> M12[ExportOptions Modal]
    
    class Load,Auth start
    class S1,S2,S3 state
    class M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 modal
    class Router final
```

---

## Part D: Implementation Standards

### CSS Architecture

```css
/* 1. Template B Standard */
@import "../../templates/template-b-standard.css";

/* 2. Logistics Page-Specific Styles */
@import "01700-logistics-page-style.css";
```

**File Convention**: `client/src/common/css/pages/01700-logistics/01700-logistics-page-style.css`

**CSS Class Convention**: `A-01700-*` for all page-level elements (e.g., `A-01700-state-btn`, `A-01700-container`)

### Modal Inventory

| Modal | State | Purpose | Size |
|-------|-------|---------|------|
| AgentDetails | Agents | View logistics agent details and metrics | 98vw |
| TaskAssignment | Agents | Assign task to logistics agent | 98vw |
| AgentHistory | Agents | View agent action history | 98vw |
| CreateRecord | Upserts | Create new logistics record | 98vw |
| ImportData | Upserts | Import logistics data from file | 98vw |
| DocumentGenerator | Upserts | Generate logistics documents | 98vw |
| EditRecord | Upserts | Edit existing logistics record | 98vw |
| Approval | Workspace | Approve AI-generated logistics action | 98vw |
| Rejection | Workspace | Reject with feedback | 98vw |
| Override | Workspace | Override AI recommendation | 98vw |
| HITLQueue | Workspace | View HITL review queue | 98vw |
| ExportOptions | Workspace | Export logistics report | 98vw |

### Chatbot Configuration

```json
{
  "chatType": "agent",
  "stateAware": true,
  "currentState": "agents|upserts|workspace",
  "zIndex": 1500,
  "modelEndpoint": "/api/chat/logistics"
}
```

| State | Chatbot Focus |
|-------|---------------|
| Agents | Answers questions about logistics agent capabilities and assignments |
| Upserts | Assists with logistics record creation, document generation, data import |
| Workspace | Explains AI route recommendations, suggests approvals, tracks deliveries |

---

## Part E: Screen Specifications

### Platform Adaptations

| Platform | Width | Layout Changes |
|----------|-------|----------------|
| Desktop | 1280px+ | Full three-state nav, agent grid: 3 columns, map view: full width |
| Tablet | 768px-1279px | Three-state nav collapses to dropdown, agent grid: 2 columns, map view: 50% |
| Mobile | <768px | Three-state nav as bottom tab bar, agent grid: 1 column, map view: hidden, touch targets: min 48dp |

### Screen States

| State | Description |
|-------|-------------|
| Loading | Skeleton loader with blue accent shimmer |
| Empty | "No logistics records yet" with Create Record CTA |
| Error | Error message with retry button, blue error banner |
| Populated | Full data view with all components |

---

## Part F: AI Model Backend

### Model Infrastructure

**Base Model**: Qwen 2.5
- Fine-tuned on logistics domain data (supply chain, customs, transportation)

**Domain Adapter**: LoRA fine-tuned per function
- **Logistics Route LoRA**: Route optimization and delivery scheduling
- **Customs Compliance LoRA**: Customs documentation and regulatory compliance
- **Document Generation LoRA**: Bill of Lading, Packing List, Customs Declaration generation

**Deployment**: HuggingFace model serving
- Endpoint: `/api/chat/logistics`
- Fallback: Base model

---

## Part G: Agent Knowledge Ownership

| Company | Role | Action |
|---------|------|--------|
| **DomainForge AI** | Domain Validation | Validate logistics workflows and domain rules |
| **QualityForge AI** | Testing | Execute test suite against logistics spec |
| **DevForge AI** | Implementation | Build HTML/CSS/React pages for logistics |
| **KnowledgeForge AI** | Indexing | Index logistics spec into institutional memory |
| **PromptForge AI** | Task Routing | Route logistics UI tasks to DevForge |
| **InfraForge AI** | Database | Create logistics database schema and migrations |
| **IntegrateForge AI** | Integration | Connect to TMS/WMS external systems |
---
title: "Bidding & Tendering — UI/UX Specification"
description: "Complete UI/UX specification for the Bidding & Tendering shared discipline page, covering dual-system Template B classification, mermaid flow diagrams, three-state button mechanics, modal inventory, color palette, chatbot configuration, AI model backend, and agent knowledge ownership"
author: "DomainForge AI — Procurement Domain"
date: "2026-04-29"
version: "1.0"
gigabrain_tags: bidding, tendering, ui-ux, specification, template-b, mermaid-templates, procurement-platform
related_docs:
  - docs-paperclip/procedures/workflows/mermaid-diagram-template-system-procedure.md
  - docs-paperclip/templates/mermaid/registry.yaml
  - docs-paperclip/scripts/render-mermaid.cjs
  - docs-paperclip/templates/mermaid/bidding-discovery-flow.yaml
  - docs-paperclip/templates/mermaid/tendering-rfq-flow.yaml
  - docs-paperclip/templates/mermaid/three-state-navigation.yaml
  - docs-paperclip/templates/mermaid/approval-matrix.yaml
  - docs-paperclip/templates/mermaid/hitl-review.yaml
  - docs-paperclip/templates/mermaid/page-state-flow.yaml
---

# Bidding & Tendering — UI/UX Specification

## Part A: UX Patterns (High-Level)

### Template Classification

**Classification**: Template B (Complex/Three-State)

**Rationale**:
- Dual-system platform with 3 distinct navigation states (Agents, Upserts, Workspace)
- Complex workflows: OCDS API ingestion, bid evaluation, RFQ lifecycle, award-to-contract
- Two complementary systems: **Bidding** (inbound) and **Tendering** (outbound)
- State-aware chatbot with different behaviors per state per system

### Color Scheme — Orange/Blue Dual-System Palette

```css
:root {
  /* Primary — Orange (Tendering) */
  --template-a-primary: #FF8C00;
  --template-a-secondary: #FFA500;
  --template-a-accent: #FF6B35;

  /* Bidding — Blue */
  --bidding-primary: #1565C0;
  --bidding-secondary: #1976D2;
  --bidding-accent: #0D47A1;

  /* Tendering — Orange */
  --tendering-primary: #FF8C00;
  --tendering-secondary: #FFA500;
  --tendering-accent: #E65100;

  /* Background Gradients */
  --template-a-bg-gradient: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  --bidding-header-gradient: linear-gradient(135deg, #0D47A1 0%, #1565C0 100%);
  --tendering-header-gradient: linear-gradient(135deg, #E65100 0%, #FF8C00 100%);

  /* Text Colors */
  --template-a-text-primary: #000000;
  --template-a-text-secondary: #6c757d;
  --template-a-text-white: #ffffff;

  /* Shadows */
  --template-a-shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
  --template-a-shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
  --bidding-shadow-lg: 0 8px 24px rgba(21, 101, 192, 0.25);
  --tendering-shadow-lg: 0 8px 24px rgba(255, 140, 0, 0.25);
}
```

**Dual-System Mode Toggle**:
```css
.bidding-mode {
  --component-primary: var(--bidding-primary);
  --component-header-gradient: var(--bidding-header-gradient);
}
.tendering-mode {
  --component-primary: var(--tendering-primary);
  --component-header-gradient: var(--tendering-header-gradient);
}
```

### HITL Integration Pattern

AI generates bidding/tendering actions → HITL review queue → Human approves/rejects/modifies → Execute.

| System | AI Output | HITL Reviewer |
|--------|-----------|---------------|
| Bidding | Bid opportunity scores, bid preparation | Bid Manager |
| Tendering | Evaluation scores, award recommendation | Tender Committee |

---

## Part B: Three-State Button & Modal Rules

### State Definitions

| State | Bidding Purpose | Tendering Purpose |
|-------|-----------------|-------------------|
| **Agents** | Show bid agents, market intelligence agents | Show tender agents, evaluation agents |
| **Upserts** | Create/edit bid opportunities, import OCDS data | Create/edit RFQs, manage tenders |
| **Workspace** | HITL review queue, bid evaluation dashboard | Evaluation engine, award pipeline |

### Agents State Buttons

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **View Details** | Always visible | Opens AgentDetails modal | `AgentDetails` — 98vw |

### Upserts State Buttons

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Create New** | `user.role >= 'editor'` | Opens CreateRecord modal | `CreateRecord` — 98vw |
| **Import Data** | `user.role >= 'editor'` | Opens ImportData modal | `ImportData` — 98vw |
| **Edit** | `user.role >= 'editor'` | Opens EditRecord modal | `EditRecord` — 98vw |
| **Download** | Always visible | Opens DownloadOptions modal | `DownloadOptions` — 98vw |

### Workspace State Buttons

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Evaluate** | `user.role >= 'evaluator'` | Opens Evaluation modal | `Evaluation` — 98vw |
| **Award** | `user.role >= 'manager'` | Opens Award modal | `Award` — 98vw |
| **Reject** | `user.role >= 'evaluator'` | Opens Rejection modal | `Rejection` — 98vw |
| **Override** | `user.role >= 'governance'` | Opens Override modal | `Override` — 98vw |
| **View Queue** | Always visible | Opens HITLQueue modal | `HITLQueue` — 98vw |

---

## Part C: Mermaid UI Flow Diagrams

### Diagram 1: Three-State Navigation Flow with Page-Level Access Rights (generated from `three-state-navigation` template v1.0)

```mermaid
flowchart TD
    classDef page fill:#E3F2FD,stroke:#1565C0
    classDef state fill:#E8EAF6,stroke:#283593
    classDef gate fill:#FFEBEE,stroke:#D32F2F
    classDef action fill:#FFF3E0,stroke:#E65100
    classDef modal fill:#F3E5F5,stroke:#7B1FA2

    Accordion[Page-Level Accordion] -->|Bidding / Tendering| SystemToggle{System Toggle}
    SystemToggle -->|Bidding| BiddingView[Bidding System View]
    SystemToggle -->|Tendering| TenderingView[Tendering System View]

    Load[Page Load] --> Rights{Role Check}
    Rights -->|role >= viewer| Router[State Router]
    Rights -->|role < viewer| Denied[Access Denied]

    Router --> Agents[Agents State]
    Router --> Upserts[Upserts State]
    Router --> Workspace[Workspace State]

    Agents -->|any authenticated| ViewAgent[View Agent Details]

    Upserts -->|role >= editor| RecordActions[Record Actions]
    RecordActions --> CreateRecord[Create Record]
    RecordActions --> ImportData[Import Data]
    RecordActions --> EditRecord[Edit Record]

    Workspace -->|role >= evaluator| EvalActions[Evaluation Actions]
    EvalActions --> ReviewQueue[Review HITL Queue]
    EvalActions --> EvaluateBids[Evaluate Bids]
    Workspace -->|role >= manager| AwardActions[Award Actions]
    AwardActions --> AwardContract[Award Contract]
    Workspace -->|role >= governance| OverrideActions[Governance Actions]

    class Load,Denied page
    class Accordion,SystemToggle,BiddingView,TenderingView page
    class Rights,Agents,Upserts,Workspace state
    class ViewAgent,RecordActions,EvalActions,AwardActions gate
    class CreateRecord,ImportData,EditRecord,ReviewQueue,EvaluateBids action
    class AwardContract,OverrideActions modal
```

### Diagram 2: Bidding Discovery Flow (generated from `bidding-discovery-flow` template v1.0)

```mermaid
flowchart TD
    classDef api fill:#E3F2FD,stroke:#1565C0
    classDef scrape fill:#FFF3E0,stroke:#E65100
    classDef map fill:#F3E5F5,stroke:#7B1FA2
    classDef score fill:#FFEBEE,stroke:#D32F2F
    classDef store fill:#E8F5E8,stroke:#388E3C

    OCDS[OCDS API - etenders.gov.za] -->|fetch notices| PARSE[Parse Tender Notices]
    OCDS -->|fetch failed| FALLBACK{API Available?}
    FALLBACK -->|no| SCRAPE[Web Scraper - Playwright]
    FALLBACK -->|yes| PARSE

    SCRAPE -->|extract| EXTRACT[Extract Structured Data]
    EXTRACT -->|normalize| MAP[Map Fields to Standard Schema]
    PARSE -->|normalize| MAP

    MAP -->|validate| SCORE[Score Opportunity]
    SCORE -->|match criteria| ROUTE{Route Decision}
    SCORE -->|no match| DISCARD[Discard / Log]

    ROUTE -->|high priority| PIPELINE[Bid Opportunity Pipeline]
    ROUTE -->|standard priority| PIPELINE
    ROUTE -->|low priority| ALERT[Alert Team by Email]

    PIPELINE -->|store| DB[(Bidding Database)]
    ALERT -->|notify| TEAM[Assign to Bid Team]

    class OCDS,PARSE api
    class FALLBACK,SCRAPE,EXTRACT scrape
    class MAP,SCORE,ROUTE map
    class DISCARD,ALERT,TEAM score
    class PIPELINE,DB store
```

### Diagram 3: RFQ Lifecycle Flow with Pre-Qualification Pipeline & Cross-Discipline Integration Points (generated from `tendering-rfq-flow` template v2.1 — showPrequal=true, showIntegrationPoints=true)

```mermaid
flowchart TD
    classDef create fill:#E3F2FD,stroke:#1565C0
    classDef publish fill:#FFF3E0,stroke:#E65100
    classDef prequal fill:#F3E5F5,stroke:#7B1FA2
    classDef db fill:#E8F5E8,stroke:#388E3C
    classDef collect fill:#F3E5F5,stroke:#7B1FA2
    classDef eval fill:#FFEBEE,stroke:#D32F2F
    classDef award fill:#E8F5E8,stroke:#388E3C
    classDef final fill:#FCE4EC,stroke:#C2185B
    classDef integration fill:#FFF8E1,stroke:#F9A825,stroke-dasharray:5 5

    CREATE[RFQ Creation] -->|define scope| DRAFT[Draft RFQ]
    DRAFT -->|approve by manager| PUBLISH[Publish to Vendor Portal]
    PUBLISH -->|open for expression of interest| PREQUAL[Pre-Qualification Phase]

    subgraph PQ[Pre-Qualification Pipeline]
        PREQUAL -->|prospective bidders register| EOI[Expression of Interest]
        EOI -->|submit credentials| VET[Vetting & Screening]
        VET -->|CIDB check| CIDB[CIDB Verification]
        VET -->|BBBEE check| BBBEE[BBBEE Level Check]
        VET -->|financial check| FIN[Financial Capacity Review]
        VET -->|safety record| SAFETY[Safety & Compliance Review]
        CIDB -->|score| QUAL{Qualified?}
        BBBEE -->|score| QUAL
        FIN -->|score| QUAL
        SAFETY -->|score| QUAL
        QUAL -->|pass all thresholds| DB[(Supplier Database)]
        QUAL -->|fail any threshold| DECLINE[Decline Notification]
    end

    SAFETY -.->|delegates to| VETTING[[02400 Safety Contractor Vetting]]
    VETTING -.->|HSSE evaluation template| SAFETY

    DB -.->|shared with| SUPPLIER_DIR[[01900 Procurement Supplier Directory]]
    DB -.->|supplier cards| SUPPLIER_SEL[[01900 Supplier Selection UI]]

    DB -->|shortlist from database| INVITE[Invite to Participate]
    DECLINE -->|feedback| CLOSED[Declined - Logged]

    INVITE -.->|via| OUTREACH[[01900 Supplier Outreach Workflow]]
    OUTREACH -.->|voice call if needed| VOICE[[01900 Voice Call Modal]]

    INVITE -->|vendors submit bids| COLLECT[Bid Collection Period - 14 days]
    COLLECT -->|deadline reached| EVAL[Evaluation & Scoring]

    EVAL -->|technical 40%| TECH[Technical Score]
    EVAL -->|commercial 40%| COMM[Commercial Score]
    EVAL -->|compliance 20%| COMP[Compliance Check]
    TECH -->|weighted| TOTAL[Total Weighted Score]
    COMM -->|weighted| TOTAL
    COMP -->|pass/fail| TOTAL

    TOTAL -->|highest score| AWARD[Award Decision]
    TOTAL -->|tie| TIE[Tender Committee Review]
    TIE -->|resolve by vote| AWARD

    AWARD -->|approve| LETTER[Generate Award Letter]
    AWARD -->|reject| NOTIFY[Notify Unsuccessful Bidders]
    LETTER -->|CEO sign-off| CONTRACT[Contract Conversion]
    CONTRACT -->|handover pack| CONTRACTS[Contracts Discipline]
    NOTIFY -->|debriefing| CLOSE[Close RFQ]

    class CREATE,DRAFT create
    class PUBLISH,PREQUAL publish
    class EOI,VET,CIDB,BBBEE,FIN,SAFETY,QUAL,DECLINE prequal
    class DB,INVITE db
    class COLLECT collect
    class EVAL,TECH,COMM,COMP,TOTAL eval
    class TIE,AWARD,LETTER award
    class NOTIFY,CONTRACT,CONTRACTS,CLOSE,CLOSED final
    class VETTING,SUPPLIER_DIR,SUPPLIER_SEL,OUTREACH,VOICE integration
```

### Diagram 4: Bid Evaluation Flow (generated from `hitl-review` template v1.0)

```mermaid
flowchart TD
    classDef agent fill:#E3F2FD,stroke:#1565C0
    classDef queue fill:#F3E5F5,stroke:#7B1FA2
    classDef assign fill:#FFF3E0,stroke:#E65100
    classDef review fill:#FFEBEE,stroke:#D32F2F
    classDef final fill:#E8F5E8,stroke:#388E3C

    AI[AI Evaluation Engine] -->|completes scoring| QUEUE[HITL Review Queue]
    QUEUE -->|assess| ASSESS{Requires HITL?}
    ASSESS -->|confidence low < 80%| CREATE[Create Evaluation Task]
    ASSESS -->|value > R250k| CREATE
    ASSESS -->|conflict detected| CREATE
    ASSESS -->|confidence high > 90%| AUTO[Auto-approve Low Value]

    CREATE -->|assign committee| ASSIGN[Evaluation Committee Assignment]
    ASSIGN -->|expertise match| REVIEWER[Assign to Tender Committee]
    ASSIGN -->|availability| REVIEWER

    REVIEWER -->|review| DECISION{Decision}
    DECISION -->|approve| EXECUTE[Recommend Award]
    DECISION -->|minor revisions| REVISE[AI Revises Scores]
    DECISION -->|major revisions| REJECT[Return to Evaluator]
    DECISION -->|manual override| OVERRIDE[Committee Chair Decides]

    REVISE -->|chatbot refine| CHAT[Chatbot Collaboration]
    CHAT -->|regenerate| REVIEWER
    REJECT -->|feedback| AI
    OVERRIDE --> EXECUTE

    EXECUTE -->|log| AUDIT[Audit Trail]
    AUDIT -->|complete| DONE[Evaluation Complete]

    class AI agent
    class QUEUE,ASSESS,CREATE,AUTO queue
    class ASSIGN,REVIEWER assign
    class DECISION,REVISE,REJECT,CHAT review
    class EXECUTE,AUDIT,DONE final
```

### Diagram 5: Award-to-Contract Flow (generated from `approval-matrix` template v1.0)

```mermaid
flowchart TD
    classDef value fill:#FFF3E0,stroke:#E65100
    classDef single fill:#E8F5E8,stroke:#388E3C
    classDef parallel fill:#E3F2FD,stroke:#1565C0
    classDef sequential fill:#FFEBEE,stroke:#D32F2F
    classDef final fill:#FCE4EC,stroke:#C2185B

    AWARD[Award Decision] -->|check value| THRESHOLD{Award Value}
    THRESHOLD -->|< R250k| SINGLE[Single Approver]
    THRESHOLD -->|R250k - R1M| PARALLEL[Parallel Approvers]
    THRESHOLD -->|> R1M| SEQUENTIAL[Sequential Chain]

    SINGLE -->|procurement manager| LEVEL1[Level 1 Approval]
    LEVEL1 -->|approve| LETTER[Generate Award Letter]
    LEVEL1 -->|reject| RETURN[Return to Tender Committee]

    PARALLEL -->|simultaneous| LEVEL2A[Procurement Manager]
    PARALLEL -->|simultaneous| LEVEL2B[Contracts Manager]
    LEVEL2A -->|both approve| LETTER
    LEVEL2B -->|both approve| LETTER
    LEVEL2A -->|reject| RETURN
    LEVEL2B -->|reject| RETURN

    SEQUENTIAL -->|level 1| L1[Procurement Manager]
    L1 -->|approve| L2[Contracts Director]
    L1 -->|reject| RETURN
    L2 -->|approve| L3[Executive - CEO]
    L2 -->|reject| RETURN
    L3 -->|approve| LETTER
    L3 -->|reject| RETURN

    LETTER -->|auto-generate| CONTRACT[Contract Document]
    CONTRACT -->|handover| CONTRACTS[Contracts Discipline]
    RETURN -->|revise| AWARD

    class AWARD,THRESHOLD value
    class SINGLE,LEVEL1 single
    class PARALLEL,LEVEL2A,LEVEL2B parallel
    class SEQUENTIAL,L1,L2,L3 sequential
    class LETTER,CONTRACT,CONTRACTS,RETURN final
```

### Diagram 6: Page State with Modal Integration & Role-Based Access Rights (generated from `page-state-flow` template v1.0)

```mermaid
flowchart TD
    classDef page fill:#E3F2FD,stroke:#1565C0
    classDef state fill:#E8EAF6,stroke:#283593
    classDef gate fill:#FFEBEE,stroke:#D32F2F
    classDef modal fill:#FFF3E0,stroke:#E65100
    classDef final fill:#E8F5E8,stroke:#388E3C

    Accordion[Page-Level Accordion] -->|Bidding / Tendering| ST[Switch System View]

    Load[Page Load] --> Rights{Role Check}
    Rights -->|role >= viewer| Router[State Router]
    Rights -->|role < viewer| Denied[Access Denied Page]

    Router -->|viewer+| S1[Agents State]
    Router -->|editor+| S2[Upserts State]
    Router -->|evaluator+| S3[Workspace State]

    S1 -->|any role| M1[AgentDetails Modal]

    S2 -->|editor+| M2[CreateRecord Modal]
    S2 -->|editor+| M3[ImportData Modal]
    S2 -->|editor+| M4[EditRecord Modal]
    S2 -->|any role| M5[DownloadOptions Modal]

    S3 -->|evaluator+| M6[Evaluation Modal]
    S3 -->|evaluator+| M8[Rejection Modal]
    S3 -->|evaluator+| M10[HITLQueue Modal]
    S3 -->|manager+| M7[Award Modal]
    S3 -->|governance+| M9[Override Modal]

    class Load,Denied,Accordion,ST page
    class Rights,Router,S1,S2,S3 state
    class M1,M2,M3,M4,M5,M6,M7,M8,M9,M10 modal
    class Router final
```

---

## Part D: Implementation Standards

### CSS Architecture

```css
/* 1. Template B Standard */
@import "../../templates/template-b-standard.css";

/* 2. Bidding & Tendering Page-Specific Styles */
@import "bidding-tendering-page-style.css";
```

**CSS Class Convention**: `A-BTND-*` for all page-level elements

### Modal Inventory

| Modal | State | Purpose | Size |
|-------|-------|---------|------|
| AgentDetails | Agents | View agent details and metrics | 98vw |
| CreateRecord | Upserts | Create new bid/tender record | 98vw |
| ImportData | Upserts | Import OCDS data or vendor data | 98vw |
| EditRecord | Upserts | Edit existing record | 98vw |
| DownloadOptions | Upserts | Download tender documents | 98vw |
| Evaluation | Workspace | Evaluate bids with weighted scoring | 98vw |
| Award | Workspace | Award tender to vendor | 98vw |
| Rejection | Workspace | Reject with feedback | 98vw |
| Override | Workspace | Override AI recommendation | 98vw |
| HITLQueue | Workspace | View HITL review queue | 98vw |

### Chatbot Configuration

```json
{
  "chatType": "agent",
  "stateAware": true,
  "currentState": "agents|upserts|workspace",
  "systemAware": true,
  "currentSystem": "bidding|tendering",
  "zIndex": 1500,
  "modelEndpoint": "/api/chat/bidding-tendering"
}
```

| State | Chatbot Focus |
|-------|---------------|
| Agents | Answers questions about agent capabilities, system functions |
| Upserts | Assists with record creation, data import, document management |
| Workspace | Explains evaluation scores, suggests approvals, monitors deadlines |

---

## Part E: Screen Specifications

### Platform Adaptations

| Platform | Width | Layout Changes |
|----------|-------|----------------|
| Desktop | 1280px+ | Full three-state nav, dual-system toggle, scoring table |
| Tablet | 768px-1279px | Three-state nav collapses to dropdown, system toggle as segment |
| Mobile | <768px | Three-state nav as bottom tab bar, system toggle as radio buttons |

### Screen States

| State | Description |
|-------|-------------|
| Loading | Skeleton loader with orange/blue shimmer |
| Empty | "No opportunities yet" with Create Record CTA |
| Error | Error message with retry button |
| Populated | Full data view with all components |

---

## Part F: AI Model Backend

**Base Model**: Qwen 2.5 — fine-tuned on procurement domain data

**Domain Adapters**:
- **Bidding LoRA**: Tender opportunity scoring, market intelligence, bid preparation
- **Evaluation LoRA**: Bid evaluation scoring, weighted analysis, compliance checking

**Deployment**: HuggingFace model serving — Endpoint: `/api/chat/bidding-tendering`

---

## Part G: Agent Knowledge Ownership

| Company | Role | Action |
|---------|------|--------|
| **DomainForge AI** | Domain Validation | Validate bidding/tendering workflows |
| **QualityForge AI** | Testing | Execute test suite against spec |
| **DevForge AI** | Implementation | Build HTML/CSS/React pages |
| **KnowledgeForge AI** | Indexing | Index spec into institutional memory |
| **InfraForge AI** | Database | Database schema, RLS policies, API routes |
| **Loopy AI** | Portal Frontend | External vendor portal pages |

---

## Part H: Mermaid Template System Integration

### Template Inventory

| Diagram | Template | Version | Render Command |
|---------|----------|---------|----------------|
| 1. Three-State Navigation | `three-state-navigation` | v2.0 | `--template three-state-navigation --discipline BTND --showAccordion true` |
| 2. Bidding Discovery | `bidding-discovery-flow` | v1.0 | `--template bidding-discovery-flow --discipline BTND --showScraping true` |
| 3. RFQ Lifecycle | `tendering-rfq-flow` | v2.1 | `--template tendering-rfq-flow --discipline BTND --showEvaluation true --showPrequal true --showIntegrationPoints true` |
| 4. Bid Evaluation | `hitl-review` | v1.0 | `--template hitl-review --discipline BTND --confidenceThreshold 85` |
| 5. Award-to-Contract | `approval-matrix` | v1.0 | `--template approval-matrix --discipline BTND` |
| 6. Page State | `page-state-flow` | v2.0 | `--template page-state-flow --discipline BTND --showAccordion true` |

### Full Render Command

```bash
node docs-paperclip/scripts/render-mermaid.cjs --discipline BTND --output-dir disciplines-shared/bidding-and-tendering/diagrams/
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial UI/UX specification for Bidding & Tendering |

---

**Document Information**
- **Author**: DomainForge AI — Procurement Domain
- **Date**: 2026-04-29
- **Status**: Active
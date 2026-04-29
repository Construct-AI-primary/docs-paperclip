# LOGISTICS-PLATFORM — Master Project Registry

> **Discipline**: 01700-logistics  
> **Platform**: LOGISTICS-PLATFORM  
> **Version**: 1.0  
> **Status**: Draft — Pending HITL Review

---

## 1. Project Area Inventory

The following 8 logistics domain areas are defined in the discipline README and form the scope of this platform:

| # | Area | Description | Priority |
|---|------|-------------|----------|
| 1 | ContainerTracking | End-to-end container movement tracking across supply chain | P0 |
| 2 | CustomsManagement | Customs documentation, duties, and clearance workflows | P0 |
| 3 | DailyDelivery | Last-mile delivery scheduling, routing, and confirmation | P0 |
| 4 | DocumentGeneration | Automated generation of shipping manifests, invoices, packing lists | P0 |
| 5 | InternationalShipping | Multi-leg international shipment coordination | P1 |
| 6 | SitePlanning | Logistics site layout, staging areas, and material laydown | P1 |
| 7 | TrafficManagement | Traffic flow management on construction/industrial sites | P1 |
| 8 | MaterialFlow | Material receipt, storage, issue, and replenishment tracking | P1 |

---

## 2. Standard Project Classification

Each platform project is classified into one of 6 standard project types. The mapping below shows which logistics areas are addressed by each project.

### P0 — Foundation & Schema (shared infrastructure)

| Project | Areas Covered | Source | Status | Red Flags |
|---------|--------------|--------|--------|-----------|
| LOGISTICS-PLATFORM-001 | All 8 areas (shared DB schemas, common data models, shared API contracts) | Discipline README + CODE-AND-DOC-PLACEMENT.md | **Not Started** | Schema complexity risk: 8+ domain entities must share cross-referencing foreign keys. RLS policies must support multi-org isolation. |

### P0 — Core Page Implementation (main UI)

| Project | Areas Covered | Source | Status | Red Flags |
|---------|--------------|--------|--------|-----------|
| LOGISTICS-PLATFORM-002 | ContainerTracking, CustomsManagement, DailyDelivery, DocumentGeneration, InternationalShipping, SitePlanning, TrafficManagement, MaterialFlow | Discipline README | **Not Started** | High UI surface area — 8 distinct domain views required. Mobile and desktop responsive design needed. Real-time tracking dashboards have significant state management complexity. |

### P0 — Domain Agent Configuration (agents)

| Project | Areas Covered | Source | Status | Red Flags |
|---------|--------------|--------|--------|-----------|
| LOGISTICS-PLATFORM-003 | ContainerTracking, CustomsManagement, DailyDelivery, DocumentGeneration, InternationalShipping, SitePlanning, TrafficManagement, MaterialFlow | Discipline README | **Not Started** | Each area requires its own agent; agent orchestration between areas (e.g., ContainerTracking → CustomsManagement handoff) is complex. Cross-agent dependency management not yet defined. |

### P1 — Integration Layer (TMS/WMS/CAD)

| Project | Areas Covered | Source | Status | Red Flags |
|---------|--------------|--------|--------|-----------|
| LOGISTICS-PLATFORM-004 | ContainerTracking (TMS), DailyDelivery (route optimization), InternationalShipping (multi-carrier), MaterialFlow (WMS) | Discipline README | **Not Started** | Integration with external TMS/WMS/CAD systems may require vendor-specific adapters. API contract stability is uncertain for third-party systems. |

### P1 — Testing & QA

| Project | Areas Covered | Source | Status | Red Flags |
|---------|--------------|--------|--------|-----------|
| LOGISTICS-PLATFORM-005 | All 8 areas | Discipline README | **Not Started** | Testing real-time tracking and multi-agent orchestration requires custom test harnesses. E2E testing across all 8 areas is high-effort. |

### P2 — Documentation & Knowledge

| Project | Areas Covered | Source | Status | Red Flags |
|---------|--------------|--------|--------|-----------|
| LOGISTICS-PLATFORM-006 | All 8 areas | Discipline README | **Not Started** | Documentation must cover desktop, mobile, and web platforms per CODE-AND-DOC-PLACEMENT.md. User guides need translation for international shipping contexts. |

---

## 3. Priority Overview

| Priority | Count | Projects |
|----------|-------|----------|
| P0 | 3 | Foundation & Schema, Core Page Implementation, Domain Agent Configuration |
| P1 | 2 | Integration Layer, Testing & QA |
| P2 | 1 | Documentation & Knowledge |

---

## 4. Early-Stage Issues (HITL Review)

These high-level issues are proposed for human-in-the-loop review before sprint planning.

### HITL-001: Confirm Domain Boundaries
**Question**: Should ContainerTracking and InternationalShipping be separate domains or unified under a single "Shipment Management" domain?

**Context**: These two areas share significant data models (vessels, carriers, ports, containers). Merging them could reduce schema complexity but may increase per-sprint scope.

**Suggested Resolution**: Unified schema layer with separate UI views. Keep agent boundaries as-is.

---

### HITL-002: Prioritize First Implementation Area
**Question**: Which logistics area should be implemented first in LOGISTICS-PLATFORM-002 (Core Page Implementation)?

**Options**:
1. **ContainerTracking** — Most visible to stakeholders; highest demonstration value
2. **DailyDelivery** — Quickest win; simpler data model
3. **DocumentGeneration** — Foundational for other areas; generates documents consumed by others

**Suggested Resolution**: DailyDelivery first (smallest scope), then ContainerTracking (highest value).

---

### HITL-003: Agent Configuration Strategy
**Question**: How should domain agents be configured for logistics?

**Options**:
1. **One agent per area** (8 agents total) — Maximum granularity, but high overhead
2. **One agent per priority level** (P0 agent + P1 agent) — Simpler orchestration, but less precise
3. **Monolithic logistics agent** — Simplest to manage, but reduces modularity

**Suggested Resolution**: One agent per area, but shared orchestrator agent for cross-area workflows (CustomsManagement → DocumentGeneration handoff).

---

### HITL-004: Integration Partner Confirmation
**Question**: Which TMS/WMS/CAD systems should be targeted for integration?

**Context**: Integration scope (LOGISTICS-PLATFORM-004) depends on customer ecosystem. Common systems include SAP TM, Oracle WMS, Descartes, and project-specific CAD tools for SitePlanning.

**Suggested Resolution**: Start with open API-based systems; add proprietary adapters in subsequent phases.

---

### HITL-005: Mobile vs Desktop First
**Question**: Should the initial implementation target desktop, mobile, or both simultaneously?

**Context**: CODE-AND-DOC-PLACEMENT.md specifies desktop, mobile, and web platforms. The implementation effort doubles if both platforms are built in parallel.

**Suggested Resolution**: Desktop-first with responsive web; mobile-specific features in Phase 3.

---

## 5. Next Steps

1. [ ] Review and resolve HITL-001 through HITL-005
2. [ ] Approve project classification and priority assignments
3. [ ] Begin Phase 1 implementation per `LOGISTICS-PLATFORM-implementation.md`
4. [ ] Assign agent companies to each project area

---

*This registry was auto-generated by the Discipline Automation Agent. Review by human logistics domain lead required before sprint execution.*

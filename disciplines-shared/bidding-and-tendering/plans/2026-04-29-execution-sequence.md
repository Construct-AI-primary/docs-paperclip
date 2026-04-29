---
title: "Execution Sequence — Bidding & Tendering"
description: "Step-by-step execution order, parallel execution opportunities, blocking dependencies, and critical path analysis"
gigabrain_tags: execution-sequence, critical-path, dependency-graph, parallel-execution, project-planning, bidding, tendering
last_updated: 2026-04-29
version: 1.0
---

# Execution Sequence — Bidding & Tendering

## 1. Step-by-Step Execution Order

```
Day 1                       Day 5                       Day 10
|                           |                           |
|- Phase 1 (Foundation) ----+                           |
|  1.1 DB Schema             |                           |
|  1.2 OCDS Integration      |                           |
|  1.3 API Routes           |                           |
|  1.4 Encryption           |                           |
|                           |                           |
|- Phase 2 (Bidding) --------+                           |
|  2.1 Discovery Engine      |                           |
|  2.2 Bid Pipeline          |                           |
|  2.3 Prep Suite            |                           |
|  2.4 Market Intel          |                           |
|                           |                           |
|- Phase 3 (Tendering) ------+                           |
|  3.1 Tender Mgmt           |                           |
|  3.2 Eval Engine          |                           |
|  3.3 Award Pipeline        |                           |
|  3.4 Vendor Pre-qual      |                           |
|  3.5 Quotation Collection  |                           |
|                           |                           |
+----------------- Phase 4 --+                           |
|  4.1 Vendor Portal         |                           |
|  4.2 Sync Engine           |                           |
|  4.3 Admin Dashboard       |                           |
|                           |                           |
+--------------------- Phase 5 --------------------------+
|  5.1 BUILDER-MEAS Int     |                           |
|  5.2 Cross-Project Test   |                           |
|  5.3 Security Audit       |                           |
|  5.4 Deployment           |                           |
```

## 2. Parallel Execution Opportunities

| Stream A | Stream B | Condition |
|----------|----------|-----------|
| Phase 2 (Bidding) | Phase 3 (Tendering) | Run simultaneously after Phase 1 |
| 3.1 Tender types (SUBCON, PO, SO, WO, HO) | Can be built in parallel by 2 agents | Each type is independent |
| 4.1 Vendor Portal (frontend) | 4.2 Sync Engine (backend) | Can be built simultaneously |
| 5.1 BUILDER-MEAS integration | 5.2 Cross-project test planning | Test cases can be written during integration |

## 3. Blocking Dependencies

```
Dependency Chain (critical path):
  1.1 - 1.2 - 2.1 - 2.2 - 2.3 - 2.4 (Bidding)
  1.1 - 1.2 - 1.3 - 3.1 - 3.2 - 3.3 (Tendering)
  3.3 - 4.1 - 4.2 (Portal)
  3.1 - 5.1 (BUILDER-MEAS)
  2.3 + 3.3 + 4.2 + 5.1 - 5.2 (Testing)
  5.2 - 5.3 - 5.4 (Deployment)

Non-blocking (can run alongside):
  - 1.4 Encryption (parallel with 1.2)
  - 3.4 Vendor Pre-qualification (parallel with 3.2)
  - 3.5 Quotation Collection (parallel with 3.3)
```

### Key Blockers

| Blocker | Blocks | Resolution |
|---------|--------|------------|
| Phase 1 complete | Everything | Fast-track with dedicated InfraForge sprint |
| 3.1 Tender lifecycle state machine | Portal (4.1), BUILDER-MEAS (5.1) | Hard dependency - state must be stable |
| 3.2 Evaluation engine | Award pipeline (3.3) | Sequential by workflow design |
| 4.2 Sync engine | Deployment (5.4) | Must be verified before go-live |

## 4. Critical Path Analysis

### Critical Path: Phase 1 - Phase 3 - Phase 4 - Phase 5

``'
1.1 DB Schema (2h) - 1.2 OCDS (2h) - 1.3 API Routes (1h)
  - 3.1 Tender Mgmt (4h) - 3.2 Evaluation (4h) - 3.3 Award (3h)
  - 4.1 Vendor Portal (5h) - 4.2 Sync Engine (2h)
  - 5.1 BUILDER-MEAS (3h) - 5.2 Testing (3h) - 5.3 Security (1h) - 5.4 Deploy (1h)
``'

**Critical path duration**: ~31 hours (of 46-64 total effort)
**Slack available**: 15-33 hours on non-critical path items (Phase 2 Bidding)

### Risk Points on Critical Path

| Point | Risk | Buffer |
|-------|------|--------|
| 3.1 Tender state machine | Complex - 5 tender types with different workflows | +2h buffer allocated |
| 3.2 Evaluation engine | Algorithm correctness is critical | +2h for unit testing |
| 4.1 Vendor portal | External-facing - UX, security, responsive design | +3h for polish |
| 5.1 BUILDER-MEAS | Cross-platform integration - may need coordination | +2h for edge cases |

### Recommendations

1. **Fast-track Phase 1** - Dedicate InfraForge AI full-time until Phase 1 gates pass
2. **Parallelise Phases 2 and 3** - DomainForge AI should split team capacity
3. **Start Phase 4 portal mockups during Phase 3** - Loopy AI can design UI before APIs are finalised
4. **Begin test planning in Phase 1** - QualityForge AI writes test cases from the specification, not the implementation
5. **Critical path items get daily standup attention** - Any slip on Phase 3 delays the entire project

---

**Version**: 1.0
**Last Updated**: 2026-04-29
**Related Documents**: `2026-04-29-bidding-tendering-plan.md`, `BIDDING-GOVT-INTEGRATION.md`, `TENDERING-VENDOR-INTEGRATION.md`, `BUILDER-MEAS-INTEGRATION.md`

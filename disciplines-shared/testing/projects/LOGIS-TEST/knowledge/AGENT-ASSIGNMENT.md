---
title: Agent Assignment Map — 01700 Logistics Testing
description: Cross-company agent hierarchy, delegation flow, and capability mapping for LOGIS-TEST
author: QualityForge AI / DomainForge AI
date: 2026-04-30
version: 1.0
---

# Agent Assignment Map — 01700 Logistics Testing

## Delegation Architecture

The LOGIS-TEST project follows Paperclip's standard delegation model:
1. **CEO** creates root goal → decomposes into sub-tasks
2. **Lead agent** (validator-qualityforge) receives assignment → further delegates to DomainForge specialists
3. **Domain experts** perform domain-specific checks → report results back up
4. **KnowledgeForge** provides metadata lookups on demand
5. **InfraForge** provides database/API support
6. **Results propagate upward** via status updates on `parentId` chain

## Agent Hierarchy

```
qualityforge-ceo (root goal owner)
├── validator-qualityforge (test execution lead)
│   ├── LOGIS-001: Page Foundation (solo)
│   ├── LOGIS-002: Database (delegates to database-infraforge)
│   ├── LOGIS-003: Agents State (solo)
│   ├── LOGIS-004: Upserts State (delegates DB checks)
│   ├── LOGIS-005: Workspace State (solo)
│   ├── LOGIS-006: Chatbot (solo)
│   ├── LOGIS-011: Integrations (delegates DB/API checks)
│   ├── LOGIS-012: UX/Compliance (solo)
│   ├── LOGIS-013a: Feedback Loop (solo)
│   └── LOGIS-014: Final Sign-off (aggregates all)
│
├── domainforge-ai-logisticsdirector (DomainForge CEO)
│   ├── logistics-domainforge-logistics
│   │   ├── LOGIS-007: Workflow Orchestrator
│   │   └── LOGIS-008: Templates
│   ├── logistics-domainforge-fleet
│   │   └── LOGIS-009: Fleet Tracking
│   └── logistics-domainforge-customs
│       └── LOGIS-010: Customs Compliance
│
├── database-infraforge (InfraForge)
│   └── Support: LOGIS-002, LOGIS-004, LOGIS-011
│
└── knowledge-manager (KnowledgeForge)
    └── Support: metadata extraction, schema validation
```

## Issue-to-Agent Mapping

| Issue | Primary Agent | Sub-Agents | Delegation Pattern |
|-------|--------------|------------|-------------------|
| LOGIS-001 | validator-qualityforge | — | Solo execution |
| LOGIS-002 | database-infraforge | — | Solo execution |
| LOGIS-003 | validator-qualityforge | — | Solo execution |
| LOGIS-004 | validator-qualityforge | database-infraforge | DB checks delegated |
| LOGIS-005 | validator-qualityforge | — | Solo execution (5 modals) |
| LOGIS-006 | validator-qualityforge | — | Solo execution |
| LOGIS-007 | logistics-domainforge-logistics | — | Domain expert solo |
| LOGIS-008 | logistics-domainforge-logistics | — | Domain expert solo |
| LOGIS-009 | logistics-domainforge-fleet | — | Domain expert solo |
| LOGIS-010 | logistics-domainforge-customs | — | Domain expert solo |
| LOGIS-011 | validator-qualityforge | database-infraforge | DB checks delegated |
| LOGIS-012 | validator-qualityforge | — | Solo execution |
| LOGIS-013 | domainforge-ai-logisticsdirector | All | CEO delegates to test delegation flow |
| LOGIS-013a | validator-qualityforge | All | Monitors all agents' activity |
| LOGIS-014 | validator-qualityforge | ALL | Aggregates results from all agents |

## Delegation RPC Flow

For each issue, the delegation flow follows:

```
1. CEO creates LOGIS-XXX with assigneeAgentId
2. Assignee's heartbeat loop detects new assignment
3. Assignee reads issue description (goals, delegation prompt, QC checklist)
4. If sub-delegation needed → create sub-task with parentId=LOGIS-XXX
5. Sub-agent executes → updates status on sub-task → status propagates to parent
6. Assignee aggregates sub-results → updates LOGIS-XXX status
7. Phase gate evaluation: pass rate + critical issues = gate decision
```

## Heartbeat Loop Configuration

Every agent involved in LOGIS-TEST should have:

```yaml
heartbeat:
  frequency: "15min"
  poll_endpoint: "GET /api/issues?assigneeAgentId={self}&status=in_progress"
  on_assignment:
    - "Read issue description and goals"
    - "Extract QC checklist from knowledge bundle"
    - "Begin execution with first checklist item"
  status_updates:
    - "Set issue status to 'in_progress'"
    - "Log activity via POST /api/companies/{companyId}/activity"
    - "On completion: set status to 'in_review' or 'done'"
```

## Risk: DomainForge Logistics Director

⚠ **Potential issue**: The `domainforge-ai-logisticsdirector` agent directory content should be verified to reflect a Logistics Director role with delegation capabilities before LOGIS-013 execution.

---

**Version**: 1.0
**Last Updated**: 2026-04-30

---
title: Agent Assignment Map — 02025 Quantity Surveying Testing
description: Cross-company agent hierarchy, delegation flow, and capability mapping for QS-TEST
author: QualityForge AI / DomainForge AI
date: 2026-04-30
version: 1.0
---

# Agent Assignment Map — 02025 Quantity Surveying Testing

## Delegation Architecture

The QS-TEST project follows Paperclip's standard delegation model:
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
│   ├── QS-001: Page Foundation (solo)
│   ├── QS-002: Database (delegates to database-infraforge)
│   ├── QS-003: Agents State (solo)
│   ├── QS-004: Upserts State (delegates DB checks)
│   ├── QS-005: Workspace State (solo)
│   ├── QS-006: Chatbot (solo)
│   ├── QS-011: Integrations (delegates DB/API checks)
│   ├── QS-012: UX/Compliance (solo)
│   ├── QS-013a: Feedback Loop (solo)
│   └── QS-014: Final Sign-off (aggregates all)
│
├── domainforge-ai-qsdirector (DomainForge CEO)
│   └── quantity-surveying-domainforge-qs
│       ├── QS-007: QS Workflow Orchestrator
│       ├── QS-008: Templates
│       ├── QS-009: Cost Analysis
│       └── QS-010: Measurement Validation
│
├── database-infraforge (InfraForge)
│   └── Support: QS-002, QS-004, QS-011
│
├── knowledge-curator-domainforge (KnowledgeForge)
│   └── Support: metadata extraction, schema validation
│
└── domainforge-ai-qsdirector (Delegation)
    └── QS-013: Agent delegation test
```

## Issue-to-Agent Mapping

| Issue | Primary Agent | Sub-Agents | Delegation Pattern |
|-------|--------------|------------|-------------------|
| QS-001 | validator-qualityforge | — | Solo execution |
| QS-002 | database-infraforge | — | Solo execution |
| QS-003 | validator-qualityforge | — | Solo execution |
| QS-004 | validator-qualityforge | database-infraforge | DB checks delegated |
| QS-005 | validator-qualityforge | — | Solo execution (4 modals) |
| QS-006 | validator-qualityforge | — | Solo execution |
| QS-007 | quantity-surveying-domainforge-qs | — | Domain expert solo |
| QS-008 | quantity-surveying-domainforge-qs | — | Domain expert solo |
| QS-009 | quantity-surveying-domainforge-qs | — | Domain expert solo |
| QS-010 | quantity-surveying-domainforge-qs | — | Domain expert solo |
| QS-011 | validator-qualityforge | database-infraforge | DB checks delegated |
| QS-012 | validator-qualityforge | — | Solo execution |
| QS-013 | domainforge-ai-qsdirector | All | CEO delegates to test delegation flow |
| QS-013a | validator-qualityforge | All | Monitors all agents' activity |
| QS-014 | validator-qualityforge | ALL | Aggregates results from all agents |

## Delegation RPC Flow

For each issue, the delegation flow follows:

```
1. CEO creates QS-XXX with assigneeAgentId
2. Assignee's heartbeat loop detects new assignment
3. Assignee reads issue description (goals, delegation prompt, QC checklist)
4. If sub-delegation needed → create sub-task with parentId=QS-XXX
5. Sub-agent executes → updates status on sub-task → status propagates to parent
6. Assignee aggregates sub-results → updates QS-XXX status
7. Phase gate evaluation: pass rate + critical issues = gate decision
```

## Heartbeat Loop Configuration

Every agent involved in QS-TEST should have:

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

## Risk: DomainForge QS Director

⚠ **Issue found**: The `domainforge-ai-qsdirector` agent content must be verified to ensure it reflects Quantity Surveying domain expertise. Verify before QS-013 is executed.

---

**Version**: 1.0
**Last Updated**: 2026-04-30

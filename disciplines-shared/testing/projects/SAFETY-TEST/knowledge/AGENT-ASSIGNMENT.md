---
title: Agent Assignment Map — 02400 Safety Testing
description: Cross-company agent hierarchy, delegation flow, and capability mapping for SAFETY-TEST
author: QualityForge AI / DomainForge AI
date: 2026-04-30
version: 1.0
---

# Agent Assignment Map — 02400 Safety Testing

## Delegation Architecture

The SAFETY-TEST project follows Paperclip's standard delegation model:
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
│   ├── SAFETY-001: Page Foundation (solo)
│   ├── SAFETY-002: Database (delegates to database-infraforge)
│   ├── SAFETY-003: Agents State (solo)
│   ├── SAFETY-004: Upserts State (delegates DB checks)
│   ├── SAFETY-005: Workspace State (solo)
│   ├── SAFETY-006: Chatbot (solo)
│   ├── SAFETY-011: Integrations (delegates DB/API checks)
│   ├── SAFETY-012: UX/Compliance (solo)
│   ├── SAFETY-013a: Feedback Loop (solo)
│   └── SAFETY-014: Final Sign-off (aggregates all)
│
├── domainforge-ai-safetydirector (DomainForge CEO)
│   ├── safety-domainforge-safety
│   │   ├── SAFETY-007: Workflow Orchestrator
│   │   └── SAFETY-008: Templates
│   ├── safety-domainforge-fleet
│   │   └── SAFETY-009: Fleet Tracking
│   └── safety-domainforge-customs
│       └── SAFETY-010: Customs Compliance
│
├── database-infraforge (InfraForge)
│   └── Support: SAFETY-002, SAFETY-004, SAFETY-011
│
└── knowledge-manager (KnowledgeForge)
    └── Support: metadata extraction, schema validation
```

## Issue-to-Agent Mapping

| Issue | Primary Agent | Sub-Agents | Delegation Pattern |
|-------|--------------|------------|-------------------|
| SAFETY-001 | validator-qualityforge | — | Solo execution |
| SAFETY-002 | database-infraforge | — | Solo execution |
| SAFETY-003 | validator-qualityforge | — | Solo execution |
| SAFETY-004 | validator-qualityforge | database-infraforge | DB checks delegated |
| SAFETY-005 | validator-qualityforge | — | Solo execution (5 modals) |
| SAFETY-006 | validator-qualityforge | — | Solo execution |
| SAFETY-007 | safety-domainforge-safety | — | Domain expert solo |
| SAFETY-008 | safety-domainforge-safety | — | Domain expert solo |
| SAFETY-009 | safety-domainforge-fleet | — | Domain expert solo |
| SAFETY-010 | safety-domainforge-customs | — | Domain expert solo |
| SAFETY-011 | validator-qualityforge | database-infraforge | DB checks delegated |
| SAFETY-012 | validator-qualityforge | — | Solo execution |
| SAFETY-013 | domainforge-ai-safetydirector | All | CEO delegates to test delegation flow |
| SAFETY-013a | validator-qualityforge | All | Monitors all agents' activity |
| SAFETY-014 | validator-qualityforge | ALL | Aggregates results from all agents |

## Delegation RPC Flow

For each issue, the delegation flow follows:

```
1. CEO creates SAFETY-XXX with assigneeAgentId
2. Assignee's heartbeat loop detects new assignment
3. Assignee reads issue description (goals, delegation prompt, QC checklist)
4. If sub-delegation needed → create sub-task with parentId=SAFETY-XXX
5. Sub-agent executes → updates status on sub-task → status propagates to parent
6. Assignee aggregates sub-results → updates SAFETY-XXX status
7. Phase gate evaluation: pass rate + critical issues = gate decision
```

## Heartbeat Loop Configuration

Every agent involved in SAFETY-TEST should have:

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

## Risk: DomainForge Safety Director

⚠ **Potential issue**: The `domainforge-ai-safetydirector` agent directory content should be verified to reflect a Safety Director role with delegation capabilities before SAFETY-013 execution.

---

**Version**: 1.0
**Last Updated**: 2026-04-30

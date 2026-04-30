---
title: Agent Assignment Map — 00860 Electrical Engineering Testing
description: Cross-company agent hierarchy, delegation flow, and capability mapping for ELEC-TEST
author: QualityForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
---

# Agent Assignment Map — 00860 Electrical Engineering Testing

## Delegation Architecture

The ELEC-TEST project follows Paperclip's standard delegation model:
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
│   ├── ELEC-001: Page Foundation (solo)
│   ├── ELEC-002: Database (delegates to database-infraforge)
│   ├── ELEC-003: Agents State (solo)
│   ├── ELEC-004: Upserts State (delegates DB checks)
│   ├── ELEC-005: Workspace State (solo)
│   ├── ELEC-006: Chatbot (solo)
│   ├── ELEC-011: Integrations (delegates DB/API checks)
│   ├── ELEC-012: UX/Compliance (solo)
│   ├── ELEC-013a: Feedback Loop (solo)
│   └── ELEC-014: Final Sign-off (aggregates all)
│
├── domainforge-ai-electricaldirector (DomainForge CEO)
│   ├── electrical-engineering-domainforge-electrical
│   │   ├── ELEC-007: Workflow Orchestrator
│   │   └── ELEC-008: Templates (SLD/Cable/Protection)
│   ├── electrical-engineering-domainforge-power-systems
│   │   └── ELEC-009: Load Flow Analysis
│   ├── electrical-engineering-domainforge-protection
│   │   └── ELEC-010: Protection Coordination
│   └── domainforge-ai-electricaldirector
│       └── ELEC-013: Agent delegation heartbeat (delegation test)
│
├── database-infraforge (InfraForge)
│   └── Support: ELEC-002, ELEC-004, ELEC-011
│
└── knowledge-curator-domainforge (KnowledgeForge)
    └── Support: metadata extraction, schema validation
```

## Issue-to-Agent Mapping

| Issue | Primary Agent | Sub-Agents | Delegation Pattern |
|-------|--------------|------------|-------------------|
| ELEC-001 | validator-qualityforge | — | Solo execution |
| ELEC-002 | database-infraforge | — | Solo execution |
| ELEC-003 | validator-qualityforge | — | Solo execution (3 modals) |
| ELEC-004 | validator-qualityforge | database-infraforge | DB checks delegated |
| ELEC-005 | validator-qualityforge | — | Solo execution (6 modals) |
| ELEC-006 | validator-qualityforge | — | Solo execution |
| ELEC-007 | electrical-engineering-domainforge-electrical | — | Domain expert solo |
| ELEC-008 | electrical-engineering-domainforge-electrical | — | Domain expert solo |
| ELEC-009 | electrical-engineering-domainforge-power-systems | — | Domain expert solo |
| ELEC-010 | electrical-engineering-domainforge-protection | — | Domain expert solo |
| ELEC-011 | validator-qualityforge | database-infraforge | DB checks delegated |
| ELEC-012 | validator-qualityforge | — | Solo execution |
| ELEC-013 | domainforge-ai-electricaldirector | All | CEO delegates to test delegation flow |
| ELEC-013a | validator-qualityforge | All | Monitors all agents' activity |
| ELEC-014 | validator-qualityforge | ALL | Aggregates results from all agents |

## Delegation RPC Flow

For each issue, the delegation flow follows:

```
1. CEO creates ELEC-XXX with assigneeAgentId
2. Assignee's heartbeat loop detects new assignment
3. Assignee reads issue description (goals, delegation prompt, QC checklist)
4. If sub-delegation needed → create sub-task with parentId=ELEC-XXX
5. Sub-agent executes → updates status on sub-task → status propagates to parent
6. Assignee aggregates sub-results → updates ELEC-XXX status
7. Phase gate evaluation: pass rate + critical issues = gate decision
```

## Heartbeat Loop Configuration

Every agent involved in ELEC-TEST should have:

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

## Risk: DomainForge Electrical Director

⚠ **Issue found**: The `domainforge-ai-electricaldirector` agent directory contains content referencing a "Dependency Manager" role, not an Electrical Director. This must be remediated before ELEC-013 is executed. Suggested fix: update agent content to reflect Electrical Director role with delegation capabilities.

---

**Version**: 1.0
**Last Updated**: 2026-04-28

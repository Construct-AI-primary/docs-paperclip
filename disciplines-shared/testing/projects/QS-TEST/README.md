---
title: QS-TEST Project
author: QualityForge AI / DomainForge AI
date: 2026-04-30
version: 1.0
status: active
project_code: QS-TEST
discipline: 02025 — Quantity Surveying
---

# QS-TEST Project

## Overview

The **QS-TEST** project delivers comprehensive quality assurance testing for the **02025 Quantity Surveying discipline page**. It validates all page components — state buttons, modals, chatbot, workflows, templates, cost analysis, measurement validation, integrations, and compliance — through a systematic 5-phase methodology with cross-company agent delegation.

## Project Structure

```
QS-TEST/
├── README.md                                    ← This file
├── plan.md                                      ← 5-phase test execution plan
├── project.md                                   ← Project charter
├── QS-TEST-implementation.md                   ← Full implementation document
│
├── desktop/                                     ← Desktop platform (primary)
│   ├── issues/                                  ← 15 issue files
│   │   ├── QS-001.md through QS-014.md
│   │   └── ISSUE-GENERATION-STATUS.md
│   └── ...
│
├── knowledge/                                   ← Project knowledge base
│   ├── PAGE-KNOWLEDGE.md
│   ├── AGENT-ASSIGNMENT.md
│   ├── CROSS-COMPANY-RACI.md
│   ├── HEARTBEAT-MONITORING-CONFIG.md
│   └── METADATA-BUNDLE.md
│
└── ...
```

## Scope

**In scope**: All 02025 quantity surveying page components:
- 3 state buttons (Agents, Upserts, Workspace)
- 9 modal triggers across all states
- QuantitySurveyingChatbot with HITL
- QuantitySurveyingWorkflowOrchestrator
- Template system (BOQ templates, cost estimation templates)
- Cost analysis and rate build-up
- Measurement validation with NRM compliance
- Vector DB, cross-discipline sharing, document retrieval
- CSS/EPCM compliance
- Agent delegation heartbeat loop

**Out of scope**: Other discipline pages, mobile/web platform variants, performance/load testing beyond standard validation, security penetration testing.

## Cross-Company Integration

| Company | Role | Agents Assigned |
|---------|------|----------------|
| **QualityForge AI** | Test execution lead | validator-qualityforge |
| **DomainForge AI** | Subject matter expertise | quantity-surveying-domainforge-qs, domainforge-ai-qsdirector, knowledge-curator-domainforge |
| **InfraForge AI** | Database/API support | database-infraforge |
| **KnowledgeForge AI** | Knowledge extraction | knowledge-curator-domainforge |

## Related Documentation

- [Discipline Page Testing Procedure](../../../procedures/discipline-page-testing-procedure.md)
- [Project and Issue Generation Procedure](../../procedures/projects/project-and-issue-generation-procedure.md)
- [02025 Page Documentation](../../../../docs-construct-ai/disciplines/02025_quantity_surveying/02025-quantity-surveying-page-documentation.md)

---

**Project Version**: 1.0
**Last Updated**: 2026-04-30
**Author**: Paperclip QA Team

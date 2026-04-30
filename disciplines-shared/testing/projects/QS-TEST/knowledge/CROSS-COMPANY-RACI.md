---
title: Cross-Company RACI Matrix — QS-TEST
description: Responsible, Accountable, Consulted, Informed matrix for all 5 testing phases
author: Paperclip QA Team
date: 2026-04-30
version: 1.0
---

# Cross-Company RACI Matrix — QS-TEST

## RACI Key

| Letter | Meaning | Description |
|--------|---------|-------------|
| **R** | Responsible | Does the work |
| **A** | Accountable | Answers for the outcome (one per row) |
| **C** | Consulted | Provides input/knowledge |
| **I** | Informed | Receives progress updates |

## Phase-Level RACI

| Phase | QualityForge AI | DomainForge AI | KnowledgeForge AI | InfraForge AI | CEO |
|-------|----------------|----------------|-------------------|---------------|-----|
| **Phase 1: Foundation** | R | C | C | A | I |
| **Phase 2: State/Modals** | R | C | I | C | I |
| **Phase 3: Integration** | C | R | I | C | I |
| **Phase 4: Advanced** | C | R | I | C | I |
| **Phase 5: Compliance** | A | C | C | I | R |

## Issue-Level RACI

| Issue | Primary Agent (Company) | Accountable | DomainForge | KnowledgeForge | InfraForge |
|-------|------------------------|-------------|-------------|----------------|------------|
| QS-001 | validator-qualityforge (QF) | QF | I | C | I |
| QS-002 | database-infraforge (IF) | IF | I | C | A |
| QS-003 | validator-qualityforge (QF) | QF | I | I | I |
| QS-004 | validator-qualityforge (QF) | QF | I | I | C |
| QS-005 | validator-qualityforge (QF) | QF | I | I | I |
| QS-006 | validator-qualityforge (QF) | QF | I | C | I |
| QS-007 | quantity-surveying-domainforge-qs (DF) | DF | A | I | I |
| QS-008 | quantity-surveying-domainforge-qs (DF) | DF | A | C | I |
| QS-009 | quantity-surveying-domainforge-qs (DF) | DF | A | I | I |
| QS-010 | quantity-surveying-domainforge-qs (DF) | DF | A | I | I |
| QS-011 | validator-qualityforge (QF) | QF | C | I | C |
| QS-012 | validator-qualityforge (QF) | QF | I | C | I |
| QS-013 | domainforge-ai-qsdirector (DF) | DF | A | I | I |
| QS-013a | validator-qualityforge (QF) | QF | C | C | I |
| QS-014 | validator-qualityforge (QF) | QF/DF | R | C | C |

**Key**: QF=QualityForge, DF=DomainForge, IF=InfraForge, KF=KnowledgeForge

## Escalation Path

```
Issue blocker → Primary Agent → Company Lead → Cross-Company CEO → Board
   15min        30min           1hr             4hrs            24hrs
```

- **Level 1** (15min): Agent tries alternate approach, consults knowledge bundle
- **Level 2** (30min): Escalate to company lead agent (validator-qualityforge)
- **Level 3** (1hr): Cross-company escalation (domainforge-ai-qsdirector)
- **Level 4** (4hrs): CEO escalation (qualityforge-ceo)
- **Level 5** (24hrs): Board-level decision needed

## Communication Channels

| Communication Type | Method | Frequency |
|-------------------|--------|-----------|
| Phase gate decisions | Issue status update | Per phase |
| Blocker escalation | Activity log + status change | As needed |
| Daily status | Aggregated activity report | Daily |
| Final sign-off | QS-014 issue close | End of project |

---

**Version**: 1.0
**Last Updated**: 2026-04-30

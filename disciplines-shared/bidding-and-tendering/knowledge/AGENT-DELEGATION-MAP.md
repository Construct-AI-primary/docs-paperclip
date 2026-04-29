---
title: "Agent Delegation Map — Bidding & Tendering"
description: "Agent delegation hierarchy and responsibility mapping across cross-company teams for both bidding and tendering systems"
author: "Platform Architecture Team"
date: 2026-04-29
version: 1.0
---

# Agent Delegation Map — Bidding & Tendering

## Delegation Hierarchy

```
┌─────────────────────────────────────────────────────────────────┐
│                    BID-TEND-ROOT-2026                           │
│              Bidding & Tendering Program Goal                   │
│                   measurement-ceo (A)                           │
└─────────────────────────────────────────────────────────────────┘
                                  │
         ┌────────────────────────┼────────────────────────┐
         │                        │                        │
         ▼                        ▼                        ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  SYSTEM 1:       │    │  SYSTEM 2:       │    │  SHARED          │
│  BIDDING         │    │  TENDERING        │    │  INFRASTRUCTURE   │
│  procurement-    │    │  procurement-     │    │  database-        │
│  strategy-       │    │  domainforge-     │    │  infraforge       │
│  domainforge     │    │  procurement-     │    │  (A)              │
│  (A)             │    │  contracts (A)    │    │                   │
└────────┬────────┘    └────────┬────────┘    └─────────────────┘
         │                       │
         │                       │
┌────────▼────────┐    ┌────────▼────────┐
│ Sub-Agents:     │    │ Sub-Agents:     │
│                 │    │                 │
│ loopy-ai        │    │ loopy-ai        │
│   (external     │    │   (vendor       │
│    bid portal)  │    │    portal)      │
│                 │    │                 │
│ database-       │    │ database-       │
│ infraforge      │    │ infraforge      │
│   (govt source  │    │   (tender DB    │
│    integration) │    │    schema)      │
│                 │    │                 │
│ guardian-       │    │ validator-      │
│ qualityforge    │    │ qualityforge    │
│   (bid QA)      │    │   (test coord)  │
└─────────────────┘    └─────────────────┘
```

## System 1: Bidding — Agent Assignments

| Issue Area | Primary Agent | Company | Delegation Prompt |
|-----------|--------------|---------|-------------------|
| Govt tender discovery | procurement-strategy-domainforge-procurement-strategy | DomainForge AI | Decompose OCDS API integration into source discovery, data transformation, and storage sub-tasks. Assign web scraping fallback to sub-agent. |
| Bid opportunity management | procurement-domainforge-procurement-contracts | DomainForge AI | Evaluate discovered opportunities against organizational capability matrix. Flag compliance requirements. |
| Bid preparation & submission | loopy-ai | Loopy AI | Handle external portal interactions for bid submission. Manage document upload workflows. |
| Market intelligence | procurement-strategy-domainforge-procurement-strategy | DomainForge AI | Aggregate and analyze procurement trends. Generate intelligence reports. |
| Win/loss tracking | procurement-domainforge-procurement-contracts | DomainForge AI | Track bid outcomes, analyze win/loss patterns, maintain competitive intelligence. |

## System 2: Tendering — Agent Assignments

| Issue Area | Primary Agent | Company | Delegation Prompt |
|-----------|--------------|---------|-------------------|
| Tender database schema | database-infraforge | InfraForge AI | Create parallel tables per MEASURE-TENDER Option B pattern. Apply RLS policies. Configure credential isolation. |
| API routes & auth | database-infraforge | InfraForge AI | Create RESTful endpoints with JWT auth, rate limiting, and error handling for all tender types. |
| RFQ integration service | procurement-domainforge-procurement-contracts | DomainForge AI | Build sync engine connecting portal sources to database. Implement health monitoring and retry logic. |
| UI dashboards | procurement-domainforge-procurement-contracts | DomainForge AI | Create React components for tender management, bid evaluation, and award processing. |
| External vendor portal | loopy-ai | Loopy AI | Build public tender listing, vendor registration, document download pages. Implement admin dashboard. |
| Workflow integration | procurement-domainforge-procurement-contracts | DomainForge AI | Connect BUILDER-MEAS-009..013 workflows to tender lifecycle. |
| QA & testing | validator-qualityforge | QualityForge AI | Validate all components against 01900 procurement page compliance standards. |

## Delegation Rules

1. **Single assignee model**: Each issue has exactly one primary agent
2. **Sub-delegation allowed**: Primary agents may delegate sub-tasks via `assigneeAgentId` and `parentId`
3. **Heartbeat required**: All active agents must emit heartbeats at configured intervals
4. **Escalation**: Blockers follow the 5-level escalation path defined in CROSS-COMPANY-RACI
5. **Completion signal**: Task is complete when `status: done` is set and QC checklist is satisfied

## Heartbeat Configuration

| Agent Role | Heartbeat Frequency | Stall Timeout | Escalation Contact |
|-----------|-------------------|---------------|-------------------|
| database-infraforge | 15 min | 30 min | infraforge-ceo |
| procurement-domainforge-procurement-contracts | 15 min | 30 min | domainforge-ai-procurementdirector |
| procurement-strategy-domainforge-procurement-strategy | 15 min | 30 min | domainforge-ai-procurementdirector |
| loopy-ai | 15 min | 30 min | loopy-ai-ceo |
| validator-qualityforge | 15 min | 30 min | qualityforge-ceo |

---

**Version**: 1.0
**Last Updated**: 2026-04-29
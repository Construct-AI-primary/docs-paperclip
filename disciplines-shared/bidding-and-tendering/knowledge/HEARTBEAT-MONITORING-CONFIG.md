---
title: "Heartbeat Monitoring Configuration — Bidding & Tendering"
description: "Agent heartbeat monitoring, stall detection, and escalation configuration for both bidding and tendering systems"
author: "Platform Architecture Team"
date: 2026-04-29
version: 1.0
---

# Heartbeat Monitoring Configuration — Bidding & Tendering

## Overview

Real-time agent monitoring ensures all agents working on the Bidding & Tendering platform are actively progressing. Heartbeat polling detects stalls and triggers escalation automatically.

## Agent Heartbeat Configuration

| Agent | System | Company | Heartbeat Interval | Stall Timeout | Max Stalls | Escalation Contact |
|-------|--------|---------|-------------------|---------------|------------|-------------------|
| procurement-strategy-domainforge-procurement-strategy | Bidding | DomainForge AI | 15 min | 30 min | 3 | domainforge-ai-procurementdirector |
| procurement-domainforge-procurement-contracts | Bidding + Tendering | DomainForge AI | 15 min | 30 min | 3 | domainforge-ai-procurementdirector |
| database-infraforge | Tendering + Shared | InfraForge AI | 15 min | 30 min | 3 | infraforge-ceo |
| loopy-ai | Both Portals | Loopy AI | 15 min | 30 min | 3 | loopy-ai-ceo |
| validator-qualityforge | Testing (Both) | QualityForge AI | 15 min | 30 min | 3 | qualityforge-ceo |

## Heartbeat API

The Paperclip activity log API at `/api/companies/{companyId}/activity` is used for heartbeat tracking.

### Heartbeat Payload Format

```json
{
  "agent_id": "procurement-domainforge-procurement-contracts",
  "company_id": "domainforge-ai",
  "activity_type": "heartbeat",
  "status": "active",
  "current_task": "MEASURE-TENDER-002",
  "task_progress": 65,
  "last_action": "Created subcontract-integration-service.js sync engine",
  "next_action": "Implement error handling and retry logic",
  "blockers": [],
  "timestamp": "2026-04-29T12:00:00Z"
}
```

### Stall Detection

A stall is detected when:
1. No heartbeat received within `stall_timeout` (30 min default)
2. Task progress unchanged for >2 consecutive heartbeats
3. Blocker reported without resolution for >1 hour

### Stall Response

```
Stall detected → Warning (15 min) → Escalation Level 1 (30 min) → Level 2 (1hr) → Level 3 (4hrs)
```

## Monitoring Dashboard

The Paperclip agent dashboard displays:
- Live heartbeat status (green/yellow/red)
- Task progress per agent
- Active blockers and resolution timeline
- Escalation status

---

**Version**: 1.0
**Last Updated**: 2026-04-29
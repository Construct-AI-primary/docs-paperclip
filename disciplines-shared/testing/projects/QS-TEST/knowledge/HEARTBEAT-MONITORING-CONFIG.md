---
title: Heartbeat Monitoring Configuration — QS-TEST Agent Feedback Loop
description: Configuration for real-time agent activity monitoring, stall detection, and escalation during QS-TEST execution
author: Paperclip QA Team
date: 2026-04-30
version: 1.0
---

# Heartbeat Monitoring Configuration — QS-TEST Agent Feedback Loop

## Overview

This document configures the agent feedback loop that enables real-time visibility into what agents are doing during QS-TEST execution. It leverages Paperclip's built-in ActivityEvent logging and heartbeat run tracking.

## Monitoring Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     QS-TEST Feedback Loop                        │
│                                                                  │
│  Poller (15min)                                                  │
│  ├── GET /api/companies/qualityforge-ai/activity                │
│  │   └── ?entityType=issue&entityId=QS-*                        │
│  │                                                              │
│  ├── Aggregate by agentId                                       │
│  │   ├── Last heartbeat timestamp                               │
│  │   ├── Current issue status                                   │
│  │   ├── Tool call count (from contextSnapshot)                 │
│  │   └── Sub-agent delegation count                             │
│  │                                                              │
│  ├── Stall detection                                            │
│  │   └── If no heartbeat >30min → escalate to CEO               │
│  │                                                              │
│  └── Generate status file                                       │
│      └── QS-TEST-FEEDBACK-LOOP.md                                │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Polling Configuration

```yaml
monitoring:
  poll_interval: "15min"
  endpoints:
    activity_log:
      url: "GET /api/companies/{companyId}/activity"
      params:
        entityType: "issue"
        entityId: "QS-*"
        limit: 100
    issue_status:
      url: "GET /api/companies/{companyId}/issues"
      params:
        ids: ["QS-001", "QS-002", ..., "QS-014"]
  output_file: "QS-TEST-FEEDBACK-LOOP.md"
  output_path: "desktop/learning/"
```

## Agent Status Dashboard Template

The poller generates a status dashboard that looks like this:

```markdown
# QS-TEST Agent Feedback Loop — {TIMESTAMP}

## Active Agents

| Agent | Issue | Status | Last Heartbeat | Tool Calls | Sub-Agents | Stall Risk |
|-------|-------|--------|----------------|------------|------------|------------|
| validator-qualityforge | QS-003 | in_progress | 2min ago | 14 | 0 | ✅ OK |
| quantity-surveying-domainforge-qs | QS-007 | in_review | 8min ago | 7 | 0 | ✅ OK |
| database-infraforge | QS-002 | done | 22min ago | 5 | 0 | ✅ OK |

## Stall Warnings

| Agent | Issue | Last Heartbeat | Elapsed | Action Required |
|-------|-------|----------------|---------|-----------------|
| _(none)_ | | | | |

## Phase Gate Status

| Gate | Phase | Pass Rate | Critical Issues | Decision |
|------|-------|-----------|-----------------|----------|
| Gate 1 | Phase 1 | 100% | 0 | ✅ PASSED |
| Gate 2 | Phase 2 | 0% (pending) | 0 | ⏳ IN PROGRESS |
```

## Stall Detection Rules

```yaml
stall_detection:
  thresholds:
    warning: "15min"       # Yellow flag
    critical: "30min"      # Red flag → escalate
    auto_escalate: "1hr"   # Auto-create escalation issue
  
  escalation_procedure:
    warning:
      action: "Flag agent in feedback dashboard"
      notify: "validator-qualityforge"
    critical:
      action: "Create escalation sub-task"
      assignee: "qualityforge-ceo"
      priority: "critical"
    timeout:
      action: "Create blocker issue"
      assignee: "domainforge-ai-qsdirector"
      priority: "critical"

  exempt_agents: []
  exempt_statuses: ["done", "cancelled"]
```

## Activity Log Query Examples

### Get all QS-TEST activity
```
GET /api/companies/qualityforge-ai/activity
  ?entityType=issue
  &entityId=QS-003
  &limit=50
```

### Get all runs for a specific issue
```
GET /api/companies/qualityforge-ai/activity/runs?entityId=QS-003
```

### Get all issues touched by a specific run
```
GET /api/companies/qualityforge-ai/activity/issues?runId={runId}
```

### Check agent's last heartbeat
```
GET /api/companies/qualityforge-ai/activity
  ?agentId=validator-qualityforge
  &limit=1
  &sort=createdAt:desc
```

## Feedback Propagation Flow

```
DomainForge agent completes domain check
  ↓
Updates sub-task status → status propagates to parent (QS-XXX)
  ↓
validator-qualityforge sees status update via heartbeat poll
  ↓
Updates QS-TEST-FEEDBACK-LOOP.md dashboard
  ↓
Phase gate evaluation triggered (if all sub-tasks done)
  ↓
Gate decision → proceed, review, or escalate
  ↓
CEO informed of phase completion
```

## Configuration Steps

### Before QS-TEST Execution

1. [ ] Ensure activity log API is accessible:
   ```bash
   curl http://localhost:3100/api/companies/qualityforge-ai/activity?limit=1
   ```
2. [ ] Verify QS-* issues exist in the system:
   ```bash
   curl http://localhost:3100/api/companies/qualityforge-ai/issues?search=QS
   ```
3. [ ] Configure heartbeat monitor script to poll every 15min
4. [ ] Create `QS-TEST-FEEDBACK-LOOP.md` initial file

### During QS-TEST Execution

5. [ ] Monitor feedback dashboard for stall warnings
6. [ ] Escalate stalled agents per escalation procedure
7. [ ] Document each phase gate decision in feedback dashboard

### After QS-TEST Completion

8. [ ] Archive feedback dashboard to `archive/`
9. [ ] Summarize agent activity metrics for post-mortem
10. [ ] Update learning tracker with feedback loop effectiveness

---

**Version**: 1.0
**Last Updated**: 2026-04-30

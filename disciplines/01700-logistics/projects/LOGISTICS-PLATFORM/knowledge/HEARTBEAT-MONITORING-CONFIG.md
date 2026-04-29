# Heartbeat Monitoring Configuration — LOGISTICS-PLATFORM

> **Platform:** LOGISTICS-PLATFORM  
> **Discipline:** Logistics (01700)  
> **Version:** 1.0.0  
> **Status:** Active  

---

## 1. Metrics

### 1.1 Issue Velocity

| Field | Value |
|---|---|
| **Metric ID** | `logistics.issue_velocity` |
| **Description** | Number of issues created, resolved, and net change per time window |
| **Unit** | Issues per hour / per day |
| **Collection Interval** | Every 5 minutes |
| **Retention** | 90 days raw, 365 days aggregated |
| **Source** | Paperclip issue tracking API |

### 1.2 Agent Responsiveness

| Field | Value |
|---|---|
| **Metric ID** | `logistics.agent_responsiveness` |
| **Description** | Time from issue assignment to first agent acknowledgement or action |
| **Unit** | Seconds |
| **Collection Interval** | Per-issue event (real-time) |
| **Retention** | 90 days |
| **Source** | Agent heartbeat events, issue lifecycle hooks |
| **Target** | < 30 seconds (P1/P2), < 120 seconds (P3/P4) |

### 1.3 Completion Rate

| Field | Value |
|---|---|
| **Metric ID** | `logistics.completion_rate` |
| **Description** | Percentage of assigned issues resolved within SLA time window |
| **Unit** | Percentage (%) |
| **Collection Interval** | Every 15 minutes |
| **Retention** | 90 days |
| **Source** | Paperclip issue tracking API |
| **Target** | >= 95% |

### 1.4 Error Rate

| Field | Value |
|---|---|
| **Metric ID** | `logistics.error_rate` |
| **Description** | Percentage of agent actions resulting in errors (failed API calls, invalid outputs, exceptions) |
| **Unit** | Percentage (%) |
| **Collection Interval** | Every 5 minutes |
| **Retention** | 90 days |
| **Source** | Agent execution logs, API error tracking |
| **Target** | < 2% |

### 1.5 Reassignment Rate

| Field | Value |
|---|---|
| **Metric ID** | `logistics.reassignment_rate` |
| **Description** | Percentage of issues reassigned from one agent to another (indicates misrouting or capacity issues) |
| **Unit** | Percentage (%) |
| **Collection Interval** | Every 15 minutes |
| **Retention** | 90 days |
| **Source** | Paperclip issue tracking API |
| **Target** | < 5% |

### 1.6 Human-in-the-Loop (HITL) Approval Rate

| Field | Value |
|---|---|
| **Metric ID** | `logistics.hitl_approval_rate` |
| **Description** | Percentage of HITL requests approved by human operators |
| **Unit** | Percentage (%) |
| **Collection Interval** | Every 15 minutes |
| **Retention** | 90 days |
| **Source** | HITL approval webhook events |
| **Target** | >= 80% |

---

## 2. Agent Health Checks

### 2.1 DevForge AI — Health Check Configuration

| Field | Value |
|---|---|
| **Agent ID** | `devforge-ai` |
| **Company Slug** | devforge-ai |
| **Check Interval** | 60 seconds |
| **Timeout** | 10 seconds |
| **Endpoint** | `https://api.devforge.ai/v1/health` |
| **Expected Status Code** | 200 |
| **Expected Response** | `{"status": "healthy", "version": "..."}` |
| **Grace Period** | 3 consecutive failures before alert |

#### Health Check Thresholds

| Metric | Warning | Critical |
|---|---|---|
| Response time | > 3s | > 8s |
| Error rate (5 min) | > 1% | > 5% |
| Queue depth | > 50 | > 200 |
| Memory usage | > 75% | > 90% |
| CPU usage | > 70% | > 85% |

### 2.2 KnowledgeForge AI — Health Check Configuration

| Field | Value |
|---|---|
| **Agent ID** | `knowledgeforge-ai` |
| **Company Slug** | knowledgeforge-ai |
| **Check Interval** | 120 seconds |
| **Timeout** | 15 seconds |
| **Endpoint** | `https://api.knowledgeforge.ai/v1/health` |
| **Expected Status Code** | 200 |
| **Expected Response** | `{"status": "healthy", "version": "..."}` |
| **Grace Period** | 3 consecutive failures before alert |

#### Health Check Thresholds

| Metric | Warning | Critical |
|---|---|---|
| Response time | > 5s | > 12s |
| Error rate (5 min) | > 1% | > 5% |
| Vector store query latency | > 500ms | > 2s |
| Graph DB query latency | > 1s | > 5s |
| Memory usage | > 75% | > 90% |

---

## 3. Alert Rules

### 3.1 Alert Severity Levels

| Level | Label | Response Time | Escalation |
|---|---|---|---|
| P0 | Critical | Immediate (≤ 5 min) | On-call engineer + Discipline Lead |
| P1 | High | ≤ 15 minutes | On-call engineer |
| P2 | Medium | ≤ 1 hour | Agent auto-remediation attempted |
| P3 | Low | ≤ 4 hours | Logged for daily review |

### 3.2 Alert Definitions

| Alert ID | Condition | Severity | Description | Escalation Path |
|---|---|---|---|---|
| `logistics.agent.dead` | 3 consecutive health check failures | P0 | Agent is unreachable | On-call → Discipline Lead → Platform Ops |
| `logistics.agent.slow` | Response time > threshold for 5 consecutive checks | P1 | Agent responding slowly | On-call → Agent auto-restart |
| `logistics.error_rate.high` | Error rate > 5% for 10 minutes | P1 | Agent error rate exceeds critical threshold | On-call → Agent log analysis |
| `logistics.completion_rate.low` | Completion rate < 90% for 30 minutes | P1 | Agent not completing tasks within SLA | On-call → Workload rebalancing |
| `logistics.reassignment.high` | Reassignment rate > 10% for 1 hour | P2 | Excessive reassignments indicating routing issues | Discipline Lead → Routing review |
| `logistics.hitl_approval.low` | HITL approval rate < 70% for 1 hour | P2 | Low human approval rate | Discipline Lead → Quality review |
| `logistics.issue_velocity.spike` | Issue creation rate > 3x baseline for 15 minutes | P2 | Sudden surge in issue volume | On-call → Capacity assessment |
| `logistics.issue_velocity.stall` | No issues resolved in 30 minutes | P2 | Possible agent stall or deadlock | On-call → Agent state inspection |

### 3.3 Escalation Paths

```
P0: Agent Dead
  └─ Immediate: Notify on-call engineer (PagerDuty)
  └─ 5 min: Escalate to Logistics Discipline Lead
  └─ 15 min: Escalate to Platform Operations Manager
  └─ 30 min: Escalate to VP of Engineering

P1: Performance Degradation
  └─ Immediate: Notify on-call engineer (Slack)
  └─ 15 min: Escalate to Logistics Discipline Lead
  └─ 1 hour: Escalate to Platform Operations Manager

P2: Anomaly Detected
  └─ Immediate: Log to #logistics-alerts Slack channel
  └─ 1 hour: Escalate to Logistics Discipline Lead (if auto-remediation fails)

P3: Informational
  └─ Log to #logistics-monitoring Slack channel
  └─ Included in daily digest
```

---

## 4. Health Check Intervals Summary

| Agent | Check Interval | Timeout | Grace Period | Effective Downtime Detection |
|---|---|---|---|---|
| DevForge AI | 60s | 10s | 3 failures | ~3 minutes |
| KnowledgeForge AI | 120s | 15s | 3 failures | ~6 minutes |
| Platform Gateway | 30s | 5s | 2 failures | ~1 minute |
| Customs Engine | 60s | 10s | 3 failures | ~3 minutes |
| Route Solver | 60s | 30s | 2 failures | ~2 minutes |

---

## 5. Dashboard Configuration

### 5.1 Grafana Dashboard

- **Dashboard UID:** `logistics-platform-health`
- **Refresh Interval:** 30 seconds
- **Panels:**
  1. Agent Health Status (grid of single-stat panels, green/red per agent)
  2. Issue Velocity (time series — created vs resolved)
  3. Agent Responsiveness (heatmap by hour/agent)
  4. Completion Rate (gauge per agent, target line at 95%)
  5. Error Rate (time series per agent, threshold lines at 2% / 5%)
  6. Reassignment Rate (time series, threshold line at 5%)
  7. HITL Approval Rate (time series, threshold line at 80%)
  8. Alert History (table of recent alerts)

### 5.2 PagerDuty Integration

- **Service Name:** `LOGISTICS-PLATFORM-Agents`
- **Escalation Policy:** `Logistics Platform On-Call`
- **Notification Channels:** Push (mobile app), SMS, Slack

### 5.3 Slack Integration

- **Channel:** `#logistics-alerts` (P0/P1), `#logistics-monitoring` (P2/P3)
- **Bot Name:** `Logistics Monitor`
- **Notification Format:** Alert ID, severity, agent, description, timestamp, link to dashboard

---

## 6. Related Documents

| Document | Location |
|---|---|
| Discipline Adaptation | `./discipline-adaptations/logistics-01700-adaptation.md` |
| DevForge AI Integration | `./ai-integrations/devforge-ai-integration.md` |
| KnowledgeForge AI Integration | `./ai-integrations/knowledgeforge-ai-integration.md` |
| Platform Overview | `./LOGISTICS-PLATFORM-OVERVIEW.md` |

---

*Document generated for Paperclip Discipline Automation — Logistics (01700)*

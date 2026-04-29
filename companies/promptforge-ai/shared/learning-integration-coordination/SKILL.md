---
name: learning-integration-coordination
description: >
  Use when setting up continuous improvement, feedback loops, performance analysis,
  HEARTBEAT-MONITORING-CONFIG.md generation, and post-execution learning capture
  for discipline automation workflows.
company: promptforge-ai
---

# Learning Integration Coordination

## Overview

This skill provides comprehensive guidance for integrating continuous learning and improvement into discipline automation workflows. It is Phase 8 of the Discipline Automation Workflow, covering feedback collection, performance analysis, HEARTBEAT-MONITORING-CONFIG.md generation, and optimization recommendations for future automation runs.

## When to Use This Skill

- Generating HEARTBEAT-MONITORING-CONFIG.md for project health tracking
- Setting up feedback loops between issue execution and future issue generation
- Capturing lessons learned from completed project phases
- Analyzing agent performance and accuracy metrics
- Generating optimization recommendations for future automation runs
- Configuring monitoring and alert thresholds
- Establishing continuous improvement cycles
- Tracking agent velocity and quality trends over time

## HEARTBEAT-MONITORING-CONFIG.md Generation

### Standard Template

```markdown
---
title: "{Project Name} — Heartbeat Monitoring Configuration"
description: "Monitoring configuration for heartbeat health checks, alert thresholds, and escalation rules"
author: "PromptForge AI — Discipline Automation Agent"
date: "{date}"
version: "1.0"
---

# {Project Name} — Heartbeat Monitoring Configuration

## Monitoring Scope

| Metric | Target | Warning | Critical | Check Interval |
|--------|--------|---------|----------|----------------|
| Issue Velocity | {n} issues/week | {n-2} issues/week | {n-4} issues/week | Daily |
| Agent Responsiveness | < 4h response | 4-8h response | > 8h response | Per issue |
| Completion Rate | > 80% | 60-80% | < 60% | Weekly |
| Error Rate | < 5% | 5-10% | > 10% | Per phase |
| Reassignment Rate | < 10% | 10-20% | > 20% | Weekly |
| HITL Approval Rate | > 80% | 70-80% | < 70% | Per batch |

## Agent Health Checks

### Per-Agent Configuration

| Agent | Expected Output | Check Frequency | Fallback |
|-------|----------------|-----------------|----------|
| {agent_slug_1} | {expected_output} | {frequency} | {fallback_agent} |
| {agent_slug_2} | {expected_output} | {frequency} | {fallback_agent} |

## Alert Rules

### Threshold Triggers

```json
{
  "alerts": [
    {
      "metric": "issue_velocity",
      "condition": "below_target",
      "threshold": "warning",
      "action": "notify_project_coordinator",
      "escalation": "notify_operations_director"
    },
    {
      "metric": "agent_availability",
      "condition": "unresponsive",
      "duration_minutes": 480,
      "action": "reassign_to_backup",
      "escalation": "notify_project_maestro"
    }
  ]
}
```

## Escalation Paths

| Level | Trigger | Action | Responsible |
|-------|---------|--------|-------------|
| Level 1 | Metric enters Warning | Notify project coordinator | Project Coordinator |
| Level 2 | Metric enters Critical | Escalate to operations director | Operations Director |
| Level 3 | Multiple Critical metrics | Escalate to Project Maestro | Project Maestro |
| Level 4 | System-level failure | Full pause + incident response | All stakeholders |

## Health Check API

```javascript
async function performHealthCheck(projectId) {
  const checks = {
    issueVelocity: await checkIssueVelocity(projectId),
    agentResponsiveness: await checkAgentResponsiveness(projectId),
    completionRate: await checkCompletionRate(projectId),
    errorRate: await checkErrorRate(projectId),
    reassignmentRate: await checkReassignmentRate(projectId),
  };
  
  const overallHealth = calculateOverallHealth(checks);
  
  return {
    projectId,
    timestamp: new Date().toISOString(),
    overall: overallHealth,
    checks,
    actions: generateActions(overallHealth),
  };
}
```

## Feedback Loop Architecture

### Feedback Types

| Type | Source | Frequency | Format | Consumer |
|------|--------|-----------|--------|----------|
| Issue Quality | HITL reviewer per batch | Per batch | Structured score (0-100) | Issue Generator |
| Agent Performance | Issue completion data | Per issue | Metrics + notes | Assignment Specialist |
| Workflow Efficiency | Phase completion data | Per phase | Time/cost analysis | Discipline Automation Agent |
| Knowledge Gaps | Missing documentation | Per discovery | Gap description | Knowledge Synthesis |
| User Satisfaction | HITL reviewer feedback | Per milestone | Qualitative + NPS | All agents |

### Feedback Processing Pipeline

```javascript
async function processFeedback(feedback) {
  // 1. Categorize feedback
  const categorized = categorizeFeedback(feedback);
  
  // 2. Route to appropriate agent/skill
  for (const item of categorized) {
    await routeToSkill(item.type, item);
  }
  
  // 3. Update performance metrics
  await updatePerformanceMetrics(categorized);
  
  // 4. Generate improvement recommendations
  const recommendations = generateRecommendations(categorized);
  
  // 5. If critical, trigger immediate action
  if (recommendations.some(r => r.severity === 'critical')) {
    await triggerImmediateImprovement(recommendations);
  }
  
  return { processed: categorized.length, recommendations };
}
```

## Performance Analysis

### Metrics Collection

```javascript
async function collectPerformanceMetrics(projectId) {
  return {
    projectId,
    period: {
      start: getPhaseStartDate(projectId),
      end: new Date()
    },
    issues: {
      total: await countIssues(projectId),
      completed: await countCompleted(projectId),
      inProgress: await countInProgress(projectId),
      blocked: await countBlocked(projectId),
      avgCompletionTime: await calculateAvgCompletionTime(projectId)
    },
    agents: {
      total: await countAssignedAgents(projectId),
      active: await countActiveAgents(projectId),
      avgResponsiveness: await calculateAvgResponsiveness(projectId)
    },
    quality: {
      hitlApprovalRate: await calculateHITLApprovalRate(projectId),
      reworkRate: await calculateReworkRate(projectId),
      testPassRate: await calculateTestPassRate(projectId)
    }
  };
}
```

### Trend Analysis

| Trend | Indicator | Action |
|-------|-----------|--------|
| Decreasing issue velocity | Agent overload | Rebalance workload, add agents |
| Increasing error rate | Knowledge gaps | Update PAGE-KNOWLEDGE.md |
| Decreasing HITL approval | Poor issue quality | Retrain Issue Generator |
| High reassignment rate | Skill mismatch | Update Assignment Specialist |
| Improving test pass rate | Quality improving | No action needed |

## Optimization Recommendations

### Recommendation Generation

```javascript
function generateOptimizationRecommendations(metrics, previousRun) {
  const recommendations = [];
  
  // Compare with previous run
  if (previousRun) {
    const velocityChange = metrics.issues.completed - previousRun.issues.completed;
    const qualityChange = metrics.quality.hitlApprovalRate - previousRun.quality.hitlApprovalRate;
    
    if (velocityChange < -0.2) {
      recommendations.push({
        type: 'velocity',
        severity: 'warning',
        description: 'Issue velocity decreased significantly',
        suggestedAction: 'Review agent assignments and workload balance',
        target: 'assignment-specialist'
      });
    }
    
    if (qualityChange < -0.1) {
      recommendations.push({
        type: 'quality',
        severity: 'warning',
        description: 'HITL approval rate declined',
        suggestedAction: 'Review issue generation quality and knowledge completeness',
        target: 'knowledge-synthesis-management'
      });
    }
  }
  
  return recommendations;
}
```

## Continuous Improvement Cycle

### Cycle Phases

```
┌─────────────────────────────────────────────────────────────────┐
│                    CONTINUOUS IMPROVEMENT CYCLE                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Phase 1: Collect                                                │
│  └─▶ Gather metrics, feedback, and performance data              │
│                                                                  │
│  Phase 2: Analyze                                                │
│  └─▶ Identify trends, patterns, and improvement opportunities    │
│                                                                  │
│  Phase 3: Recommend                                              │
│  └─▶ Generate actionable optimization recommendations            │
│                                                                  │
│  Phase 4: Implement                                              │
│  └─▶ Update skills, knowledge, and agent configurations          │
│                                                                  │
│  Phase 5: Verify                                                 │
│  └─▶ Confirm improvements produced expected results              │
│                                                                  │
│  Phase 6: Document                                               │
│  └─▶ Capture learnings for future automation runs                │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Automation Run Post-Mortem

After each full automation run, generate a post-mortem:

```markdown
# Automation Run Post-Mortem: {Project Name}

## Executive Summary
- **Completed Issues**: {n}/{total}
- **Duration**: {actual} vs {estimated}
- **Quality Score**: {score}/100
- **Budget Utilization**: {actual} vs {allocated}

## Key Findings
1. {Finding 1}
2. {Finding 2}
3. {Finding 3}

## Improvement Actions
| ID | Action | Owner | Priority | Target Run |
|----|--------|-------|----------|------------|
| IMP-001 | {action} | {agent} | High | Next run |
| IMP-002 | {action} | {agent} | Medium | Next run |

## Knowledge Captured
- {New skill or knowledge artifact created}
- {Template improvement made}
- {Agent configuration change}
```

## Quality Assurance

### Completeness Checklist

- [ ] HEARTBEAT-MONITORING-CONFIG.md generated with health check thresholds
- [ ] Alert rules defined with escalation paths
- [ ] Agent health checks configured for all assigned agents
- [ ] Feedback loop architecture documented with routing rules
- [ ] Performance metrics collection procedure defined
- [ ] Trend analysis indicators established
- [ ] Optimization recommendation generation logic documented
- [ ] Post-mortem template ready for run completion

## Related Skills

- `knowledge-capture` - Shared: captures learnings as durable knowledge
- `knowledge-transfer` - Shared: transfers learnings between runs
- `continuous-improvement` - Shared: CI methodology
- `feedback-integration` - Shared: feedback processing patterns
- `lessons-learned-synthesis` - Shared: lesson extraction
- `performance-benchmarking` - Shared: benchmark comparison
- `trend-monitoring` - Shared: trend detection
- `incident-response` - Shared: incident handling for critical metrics

## Best Practices

1. **Always generate HEARTBEAT-MONITORING-CONFIG.md** — without it, there's no health tracking
2. **Set realistic thresholds** — start with broader Warning ranges, narrow over time
3. **Close the feedback loop** — every piece of feedback should be routed to an action
4. **Compare against previous runs** — trend analysis is more valuable than absolute numbers
5. **Document all configuration changes** — maintain change history for the monitoring config
6. **Test alert rules during setup** — verify escalation paths work before issues start
7. **Archive post-mortems** — they become reference material for future project scoping
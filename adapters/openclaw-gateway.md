---
title: OpenClaw Gateway
summary: OpenClaw gateway adapter for AI orchestration with HITL capabilities
---

The `openclaw_gateway` adapter sends wake payloads to an OpenClaw gateway for AI orchestration. It supports session persistence, HITL (Human-In-The-Loop) workflows, and multi-agent coordination.

## Prerequisites

- **OpenClaw Gateway** running and accessible
- **Gateway URL** and authentication token
- **HITL configuration** (optional but recommended for knowledge enhancement)

## Configuration Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `gatewayUrl` | string | Yes | OpenClaw gateway endpoint URL |
| `apiToken` | string | Yes | Authentication token for gateway access |
| `hitlEnabled` | boolean | No | Enable human-in-the-loop workflows (default: false) |
| `domainExperts` | array | No | List of expert agent IDs for HITL approval |
| `approvalTimeoutHours` | number | No | Hours before auto-rejection (default: 48) |
| `workspacePath` | string | No | Agent workspace path override |
| `model` | object | No | Model configuration override |

## HITL Configuration

When `hitlEnabled` is true, the adapter routes knowledge enhancement tasks through human approval:

```json
{
  "adapterType": "openclaw_gateway",
  "adapterConfig": {
    "gatewayUrl": "http://localhost:18789",
    "apiToken": "your-gateway-token",
    "hitlEnabled": true,
    "domainExperts": [
      "civil-engineer-senior",
      "structural-engineer-lead",
      "quality-assurance-manager"
    ],
    "approvalTimeoutHours": 48
  }
}
```

## Knowledge Enhancement Workflow

### With HITL Approval
```
Agent Request → OpenClaw Gateway → Research Task → HITL Queue → Domain Expert Review → Approval → Knowledge Integration
```

### Without HITL
```
Agent Request → OpenClaw Gateway → Research Task → Direct Integration
```

## Session Persistence

The adapter maintains session continuity across heartbeats through OpenClaw's session management. Each agent gets a dedicated workspace and session context.

## Skills Integration

Skills are loaded via OpenClaw's skill management system. The adapter creates symlinks to Paperclip skills in the agent's workspace.

## Environment Test

The environment test verifies:
- Gateway connectivity and authentication
- HITL configuration (if enabled)
- Skill loading capability
- Session persistence

## Error Handling

- **Gateway Unavailable**: Automatic retry with exponential backoff
- **HITL Timeout**: Configurable timeout with escalation options
- **Authentication Failure**: Clear error messages with token validation
- **Skill Loading Failure**: Fallback to local skill loading

## Monitoring

The adapter provides metrics on:
- Task completion rates
- HITL approval times
- Gateway response times
- Session persistence success rates

## Integration with Paperclip

The OpenClaw gateway adapter seamlessly integrates with Paperclip's orchestration layer while providing advanced AI coordination capabilities and human oversight for critical knowledge enhancement tasks.
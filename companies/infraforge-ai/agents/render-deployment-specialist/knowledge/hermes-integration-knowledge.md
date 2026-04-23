---
title: Hermes Integration Knowledge Base
summary: Complete guide for integrating Hermes agent with Paperclip deployments
---

# Hermes Integration Knowledge Base

## Overview

This knowledge base provides comprehensive information for integrating the Hermes agent system with Paperclip deployments, enabling secure desktop communication and remote access capabilities.

## Hermes Architecture

### Core Components

**Hermes Agent System:**
- **CLI Interface**: Command-line interaction with AI models
- **Gateway System**: Multi-platform messaging integration (Telegram, Discord, etc.)
- **Tool System**: Extensible plugin architecture for custom tools
- **Session Management**: Persistent conversation state and context

**Key Features:**
- Multi-model support (Anthropic Claude, OpenAI GPT, etc.)
- Tool calling and function execution
- Session persistence and context management
- Secure credential management
- Cross-platform deployment support

## Environment Configuration

### Current Hermes Setup

Based on the provided environment variables:

```bash
# Hermes Configuration
HERMES_MODE=both              # Supports both CLI and gateway modes
HERMES_HOME=~/.hermes         # Default configuration directory

# AI Provider Integration
OPENROUTER_API_KEY=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

# GitHub Integration
GITHUB_TOKEN=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
```

### Hermes Mode Options

**CLI Mode (`HERMES_MODE=cli`):**
- Command-line interface only
- Local execution environment
- Direct tool access
- Best for: Development and local testing

**Gateway Mode (`HERMES_MODE=gateway`):**
- Multi-platform messaging integration
- Remote access via chat platforms
- Webhook-based communication
- Best for: Production deployment and team access

**Both Mode (`HERMES_MODE=both`):**
- Combined CLI and gateway functionality
- Flexible deployment options
- Unified configuration management
- Best for: Full-featured deployments

## Paperclip-Hermes Integration

### Communication Protocols

**API-Based Integration:**
```bash
# Hermes can communicate with Paperclip via REST API
curl -X POST https://your-paperclip-app.onrender.com/api/hermes/webhook \
  -H "Authorization: Bearer <hermes-api-key>" \
  -H "Content-Type: application/json" \
  -d '{
    "action": "execute_tool",
    "tool": "render_deployment_check",
    "parameters": {
      "service_id": "paperclip-app",
      "check_type": "health"
    }
  }'
```

**Webhook Configuration:**
```json
{
  "webhooks": {
    "paperclip_deployment": {
      "url": "https://your-paperclip-app.onrender.com/api/webhooks/hermes",
      "events": ["deployment_success", "deployment_failure", "health_check"],
      "secret": "webhook-secret-key"
    }
  }
}
```

### Tool Integration

**Hermes Tool Definition:**
```python
# Example Hermes tool for Paperclip integration
@registry.register
def paperclip_deployment_tool(service_id: str, action: str, **kwargs) -> str:
    """
    Interact with Paperclip deployment on Render

    Args:
        service_id: Render service identifier
        action: Action to perform (status, restart, logs, etc.)

    Returns:
        JSON response with deployment information
    """
    paperclip_api = PaperclipAPI(
        base_url=get_env_var("PAPERCLIP_API_URL"),
        api_key=get_env_var("PAPERCLIP_API_KEY")
    )

    if action == "status":
        return paperclip_api.get_deployment_status(service_id)
    elif action == "restart":
        return paperclip_api.restart_service(service_id)
    elif action == "logs":
        return paperclip_api.get_service_logs(service_id)
    else:
        return json.dumps({"error": f"Unknown action: {action}"})
```

## Network Tunneling Integration

### ngrok Integration

**Hermes-ngrok Setup:**
```bash
# Configure ngrok tunnel for Hermes gateway
ngrok http 3100 --subdomain=hermes-gateway

# Update Hermes configuration
export HERMES_PUBLIC_URL=https://hermes-gateway.ngrok.io
export HERMES_WEBHOOK_URL=https://hermes-gateway.ngrok.io/webhook
```

**Paperclip Webhook Configuration:**
```json
{
  "webhooks": {
    "hermes_notifications": {
      "url": "https://hermes-gateway.ngrok.io/api/paperclip/events",
      "events": ["deployment_update", "error_alert", "performance_metric"],
      "headers": {
        "X-Hermes-Secret": "shared-secret-key"
      }
    }
  }
}
```

### Tailscale Integration

**Zero-Trust Networking:**
```bash
# Join Tailscale network
sudo tailscale up --auth-key=<tailscale-auth-key>

# Get Tailscale IP
HERMES_TAILSCALE_IP=$(tailscale ip -4)

# Configure Paperclip to use Tailscale IP
export PAPERCLIP_HERMES_ENDPOINT=http://$HERMES_TAILSCALE_IP:3100
```

### Cloudflare Tunnel

**Secure Tunneling:**
```bash
# Create Cloudflare tunnel
cloudflared tunnel create hermes-tunnel

# Configure tunnel
cloudflared tunnel route dns hermes-tunnel hermes.yourdomain.com

# Run tunnel
cloudflared tunnel run hermes-tunnel --url http://localhost:3100
```

## Security Configuration

### API Key Management

**Hermes API Keys:**
```bash
# Generate secure API key for Paperclip integration
hermes key generate --name paperclip-integration --permissions "read,write,execute"

# Store in environment
export HERMES_API_KEY=pk_hermes_paperclip_$(openssl rand -hex 16)
```

**Paperclip-Hermes Authentication:**
```json
{
  "authentication": {
    "hermes": {
      "api_key": "pk_hermes_paperclip_...",
      "webhook_secret": "whsec_hermes_paperclip_...",
      "allowed_ips": ["tailscale-network", "cloudflare-tunnel"],
      "rate_limit": "100/hour"
    }
  }
}
```

### Secure Communication

**TLS Configuration:**
```bash
# Enable TLS for Hermes gateway
export HERMES_TLS_CERT=/path/to/cert.pem
export HERMES_TLS_KEY=/path/to/key.pem
export HERMES_TLS_MODE=strict
```

**Encryption at Rest:**
```bash
# Configure encryption for Hermes data
export HERMES_ENCRYPTION_KEY=$(openssl rand -hex 32)
export HERMES_ENCRYPTION_MODE=aes256
```

## Deployment Scenarios

### Local Development Setup

**Hermes + Local Paperclip:**
```bash
# Start local Paperclip instance
cd /path/to/paperclip
pnpm dev

# Start Hermes in CLI mode
hermes --mode cli --config hermes.local.yaml

# Test integration
hermes "Check Paperclip deployment status"
```

### Cloud Deployment Setup

**Hermes + Render Paperclip:**
```yaml
# render.yaml for Hermes service
services:
  - type: web
    name: hermes-gateway
    runtime: python
    buildCommand: "pip install -r requirements.txt"
    startCommand: "python -m hermes.gateway --port $PORT"
    envVars:
      - key: HERMES_MODE
        value: gateway
      - key: PAPERCLIP_API_URL
        fromSecret: paperclip_api_url
      - key: OPENROUTER_API_KEY
        fromSecret: openrouter_api_key
```

### Hybrid Setup

**Local Hermes + Cloud Paperclip:**
```bash
# Local Hermes configuration
export HERMES_MODE=both
export PAPERCLIP_API_URL=https://your-app.onrender.com
export PAPERCLIP_API_KEY=<api-key>

# Start local Hermes
hermes --mode both --public-url https://hermes-tunnel.ngrok.io
```

## Monitoring and Observability

### Health Checks

**Hermes Health Monitoring:**
```bash
# Check Hermes service health
curl https://hermes-gateway.onrender.com/health

# Check Paperclip connectivity
curl https://hermes-gateway.onrender.com/api/paperclip/status
```

### Logging Integration

**Centralized Logging:**
```json
{
  "logging": {
    "hermes": {
      "level": "INFO",
      "format": "json",
      "destinations": ["console", "paperclip-api"],
      "paperclip_endpoint": "https://your-app.onrender.com/api/logs"
    }
  }
}
```

### Performance Metrics

**Key Metrics to Monitor:**
- Response times for tool execution
- Webhook delivery success rates
- API rate limiting status
- Memory and CPU usage
- Network connectivity status

## Troubleshooting

### Common Issues

**Connection Failures:**
```
Error: Cannot connect to Paperclip API
Solution: Verify PAPERCLIP_API_URL and network connectivity
```

**Authentication Errors:**
```
Error: Invalid API key
Solution: Regenerate and update HERMES_API_KEY
```

**Webhook Failures:**
```
Error: Webhook delivery failed
Solution: Check webhook URLs and network policies
```

**Tool Execution Errors:**
```
Error: Tool execution timeout
Solution: Adjust HERMES_TIMEOUT settings and check tool implementation
```

## Best Practices

### Security
- Use strong, unique API keys for each integration
- Implement proper rate limiting
- Regularly rotate credentials
- Monitor access logs for suspicious activity

### Performance
- Configure appropriate timeouts for long-running operations
- Implement connection pooling for high-traffic scenarios
- Use caching for frequently accessed data
- Monitor resource usage and scale accordingly

### Reliability
- Implement proper error handling and retries
- Set up monitoring and alerting
- Maintain backup communication channels
- Document all integration points and dependencies

## Integration Examples

### Automated Deployment Monitoring

**Hermes Tool for Deployment Monitoring:**
```python
@registry.register
def monitor_paperclip_deployment(service_id: str, **kwargs) -> str:
    """Monitor Paperclip deployment status and alert on issues"""

    status = get_deployment_status(service_id)

    if status['state'] != 'healthy':
        # Send alert via configured channels
        send_alert(f"Paperclip deployment {service_id} is unhealthy: {status}")

    return json.dumps({
        "service_id": service_id,
        "status": status,
        "timestamp": datetime.now().isoformat(),
        "monitored_by": "hermes-agent"
    })
```

### Remote Management Commands

**Hermes Tool for Remote Management:**
```python
@registry.register
def manage_paperclip_service(service_id: str, action: str, **kwargs) -> str:
    """Manage Paperclip service remotely via Hermes"""

    actions = {
        'restart': restart_service,
        'scale': scale_service,
        'backup': create_backup,
        'logs': get_logs
    }

    if action not in actions:
        return json.dumps({"error": f"Unknown action: {action}"})

    result = actions[action](service_id)
    return json.dumps({
        "service_id": service_id,
        "action": action,
        "result": result,
        "executed_by": "hermes-agent",
        "timestamp": datetime.now().isoformat()
    })
```

This knowledge base provides the foundation for integrating Hermes with Paperclip deployments, enabling secure and efficient desktop communication and remote management capabilities.
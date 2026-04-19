---
title: Render Hermes Service Setup and Deployment
summary: Complete guide for deploying Hermes agent as a standalone service on Render
date: 2026-04-19
version: 1.0
status: active
---

# Render Hermes Service Setup and Deployment

## Overview

This document provides step-by-step instructions for deploying the Hermes agent as a standalone service on Render. The Hermes service will run the gateway server, providing an HTTP API endpoint that Paperclip agents can communicate with.

## Problem Context

Based on the task description, the current issue is:
- Agents are configured with HTTP adapters pointing to a hermes service
- The hermes service build is failing with "cd: hermes_agent: No such file or directory"
- The repository is cloned as `hermes-agent` (with hyphen), not `hermes_agent` (with underscore)

## Solution: Render Service Configuration

### Step 1: Create Render Service

1. **Navigate to Render Dashboard**: https://dashboard.render.com
2. **Create New Web Service**
3. **Connect Repository**: `https://github.com/NousResearch/hermes-agent`
4. **Service Name**: `hermes-service` (or your preferred name)
5. **Region**: Same as Paperclip service for low latency

### Step 2: Configure Build Settings

**Build Command**:
```bash
cd hermes-agent && pip install -e .
```

**Start Command**:
```bash
cd hermes-agent && python -m gateway.run
```

**Note**: The repository clones as `hermes-agent` (hyphen), not `hermes_agent` (underscore).

### Step 3: Environment Variables

Set the following environment variables in Render dashboard:

#### Required Variables

```bash
# LLM Provider
OPENROUTER_API_KEY=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

# Terminal Configuration
TERMINAL_BACKEND=local
TERMINAL_TIMEOUT=60
TERMINAL_LIFETIME_SECONDS=300

# Gateway Configuration (if needed for HTTP API)
HOST=0.0.0.0
PORT=3100

# Working Directory for Messaging
MESSAGING_CWD=/opt/render/project/src/hermes-agent
```

#### Optional Variables

```bash
# GitHub Integration (if agents need to create PRs)
# GITHUB_TOKEN=your_github_personal_access_token_here

# Additional Tool API Keys (as needed)
# EXA_API_KEY=
# PARALLEL_API_KEY=
# FIRECRAWL_API_KEY=
```

### Step 4: Health Check Configuration

**Health Check Path**: `/health` (if gateway provides one)
**Health Check Interval**: 30 seconds

If gateway doesn't provide a health endpoint, disable health checks or create a simple wrapper script.

### Step 5: Verify Deployment

After deployment, verify the service is running:

```bash
# Check service logs in Render dashboard
# Look for:
# - "Gateway started successfully"
# - "Listening on port 3100"
# - No import errors or missing dependencies
```

## Hermes Gateway Architecture

### Gateway vs CLI Mode

Hermes has two operational modes:

1. **CLI Mode** (`hermes`): Interactive terminal interface
2. **Gateway Mode** (`hermes gateway` or `python -m gateway.run`): Messaging platform integration

For Paperclip integration, we need **Gateway Mode** running as a service.

### Gateway Capabilities

The gateway provides:
- **Messaging Platform Integration**: Telegram, Discord, Slack, WhatsApp, Signal
- **HTTP API** (if configured): RESTful endpoints for agent communication
- **Session Management**: Persistent conversation state
- **Tool Execution**: All Hermes tools available via API

### Current Limitation

**Important**: The current Hermes gateway (`gateway/run.py`) is designed for messaging platforms (Telegram, Discord, etc.), **not** as an HTTP API server for Paperclip agents.

## Alternative Approaches

### Option 1: Create HTTP API Wrapper (Recommended)

Create a FastAPI wrapper around Hermes agent for HTTP communication:

```python
# hermes_api_server.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from run_agent import AIAgent
import os

app = FastAPI()

class ExecuteRequest(BaseModel):
    prompt: str
    agent_id: str
    session_id: str = None

class ExecuteResponse(BaseModel):
    response: str
    status: str

@app.post("/api/execute")
async def execute_task(request: ExecuteRequest):
    try:
        agent = AIAgent(
            model=os.getenv("LLM_MODEL", "anthropic/claude-opus-4.6"),
            platform="api",
            session_id=request.session_id or request.agent_id
        )
        
        response = agent.chat(request.prompt)
        
        return ExecuteResponse(
            response=response,
            status="success"
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=int(os.getenv("PORT", 3100)))
```

**Build Command**:
```bash
cd hermes-agent && pip install -e . && pip install fastapi uvicorn
```

**Start Command**:
```bash
cd hermes-agent && python hermes_api_server.py
```

### Option 2: Use Hermes ACP Adapter

Hermes includes an ACP (Agent Communication Protocol) adapter for IDE integration. This could potentially be adapted for Paperclip communication.

**Location**: `hermes-agent/acp_adapter/`

**Investigation Needed**: Review ACP adapter to see if it provides HTTP endpoints suitable for Paperclip.

### Option 3: Direct Process Execution (Not Recommended for Render)

Instead of HTTP communication, agents could execute Hermes as a subprocess. However, this requires:
- Hermes installed in the Paperclip service environment
- Proper PATH configuration
- Shared filesystem access

This approach is **not recommended** for cloud deployments due to complexity and resource overhead.

## Recommended Implementation Path

### Phase 1: Create HTTP API Wrapper

1. **Create `hermes_api_server.py`** in the hermes-agent repository
2. **Add FastAPI dependencies** to requirements
3. **Deploy to Render** with updated build/start commands
4. **Test endpoint** with curl/Postman

### Phase 2: Update Paperclip Agent Configuration

Update agent adapter configurations to point to the new HTTP API:

```sql
UPDATE agents
SET adapter_config = jsonb_set(
    adapter_config,
    '{url}',
    '"https://hermes-service.onrender.com/api/execute"'
)
WHERE adapter_config->>'type' = 'http'
AND adapter_config->>'url' LIKE '%hermes%';
```

### Phase 3: Test Integration

1. **Assign test issue** to an agent
2. **Trigger heartbeat** to invoke agent
3. **Monitor logs** in both Paperclip and Hermes services
4. **Verify response** is returned to Paperclip

## Troubleshooting

### Build Failures

**Error**: `cd: hermes_agent: No such file or directory`
**Solution**: Use `hermes-agent` (hyphen) instead of `hermes_agent` (underscore)

**Error**: `pip install -e . failed`
**Solution**: Check Python version (requires 3.11+), verify pyproject.toml exists

### Runtime Failures

**Error**: `ModuleNotFoundError: No module named 'gateway'`
**Solution**: Ensure working directory is `hermes-agent` before running Python

**Error**: `OPENROUTER_API_KEY not set`
**Solution**: Verify environment variable is set in Render dashboard

### Connection Failures

**Error**: Paperclip agents cannot reach Hermes service
**Solution**: 
- Verify Hermes service is running (check Render logs)
- Check service URL in agent configuration
- Ensure PORT environment variable matches start command
- Verify no firewall/network restrictions

## Monitoring and Maintenance

### Health Checks

Monitor service health:
- **Render Dashboard**: Service status, logs, metrics
- **HTTP Endpoint**: `GET /health` should return 200 OK
- **Log Analysis**: Check for errors, warnings, performance issues

### Performance Optimization

- **Resource Allocation**: Adjust Render instance size based on load
- **Caching**: Implement response caching for repeated queries
- **Rate Limiting**: Prevent abuse and manage API costs
- **Timeout Configuration**: Adjust based on typical task duration

### Security Considerations

- **API Authentication**: Add authentication to HTTP endpoints
- **Rate Limiting**: Implement per-agent rate limits
- **Input Validation**: Sanitize all incoming requests
- **Audit Logging**: Log all agent interactions for compliance

## Next Steps

1. **Immediate**: Fix build command to use `hermes-agent` directory
2. **Short-term**: Create HTTP API wrapper for Paperclip communication
3. **Medium-term**: Implement authentication and rate limiting
4. **Long-term**: Consider dedicated Hermes adapter in Paperclip codebase

## Related Documents

- [Paperclip + Hermes Integration Architecture](../../plans/system design/paperclip-hermes-github-integration-architecture.md)
- [Render Deployment - Hermes Adapter Fix](./render-deployment-hermes-adapter-fix.md)
- [Agent Adapter URL Migration](../adapters/adapter-url-migration-procedure.md)
- [Hermes Agent Documentation](../../../hermes_agent/README.md)

---

**Document Version**: 1.0
**Last Updated**: 2026-04-19
**Author**: Cline AI Assistant
**Review Cycle**: As needed

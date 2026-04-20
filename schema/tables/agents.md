# Agents Table Schema

## Overview
The `agents` table stores information about all AI agents in the Paperclip ecosystem, including their configuration, capabilities, and operational status.

## Table Structure

### Core Identification Fields
```sql
id UUID PRIMARY KEY DEFAULT gen_random_uuid()
company_id UUID NOT NULL REFERENCES companies(id)
name TEXT NOT NULL
role TEXT NOT NULL DEFAULT 'general'
title TEXT
icon TEXT
```

### Status and Lifecycle
```sql
status TEXT NOT NULL DEFAULT 'idle'  -- 'idle', 'active', 'paused', 'error'
reports_to UUID REFERENCES agents(id)  -- Hierarchical reporting structure
capabilities TEXT  -- Human-readable description of agent capabilities
```

### Adapter Configuration
```sql
adapter_type TEXT NOT NULL DEFAULT 'process'  -- 'process', 'api', 'webhook', etc.
adapter_config JSONB NOT NULL DEFAULT '{}'     -- Adapter-specific configuration
runtime_config JSONB NOT NULL DEFAULT '{}'     -- Runtime behavior settings
```

### Budget and Resource Management
```sql
budget_monthly_cents INTEGER NOT NULL DEFAULT 0
spent_monthly_cents INTEGER NOT NULL DEFAULT 0
pause_reason TEXT
paused_at TIMESTAMP WITH TIME ZONE
```

### Permissions and Security
```sql
permissions JSONB NOT NULL DEFAULT '{}'
```

### Operational Monitoring
```sql
last_heartbeat_at TIMESTAMP WITH TIME ZONE
metadata JSONB  -- Additional operational data
```

### Audit Fields
```sql
created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
```

## Indexes

### Performance Indexes
```sql
-- Company + Status queries
CREATE INDEX agents_company_status_idx ON agents(company_id, status);

-- Hierarchical reporting queries
CREATE INDEX agents_company_reports_to_idx ON agents(company_id, reports_to);
```

## Foreign Key Relationships

### Outbound References
- `company_id` → `companies.id` (CASCADE on delete)
- `reports_to` → `agents.id` (SET NULL on delete - allows hierarchical deletion)

### Inbound References
- `activity_log.agent_id` → `agents.id`
- `agent_api_keys.agent_id` → `agents.id`
- `agent_models.agent_id` → `agents.name` (references name, not id)
- `agents.reports_to` → `agents.id` (self-reference for hierarchy)

## Common Query Patterns

### Find Active Agents by Company
```sql
SELECT id, name, role, title, status
FROM agents
WHERE company_id = ? AND status = 'active'
ORDER BY name;
```

### Get Agent Hierarchy
```sql
WITH RECURSIVE agent_tree AS (
  -- Base case: top-level agents
  SELECT id, name, reports_to, 0 as level
  FROM agents
  WHERE reports_to IS NULL AND company_id = ?

  UNION ALL

  -- Recursive case: subordinates
  SELECT a.id, a.name, a.reports_to, at.level + 1
  FROM agents a
  JOIN agent_tree at ON a.reports_to = at.id
)
SELECT * FROM agent_tree ORDER BY level, name;
```

### Budget Monitoring
```sql
SELECT
  id, name, role,
  budget_monthly_cents,
  spent_monthly_cents,
  (budget_monthly_cents - spent_monthly_cents) as remaining_budget
FROM agents
WHERE company_id = ?
  AND budget_monthly_cents > 0
ORDER BY remaining_budget ASC;
```

## Data Validation Rules

### Status Values
- `idle`: Agent is available but not currently processing
- `active`: Agent is currently processing tasks
- `paused`: Agent is temporarily suspended
- `error`: Agent has encountered an error and needs attention

### Adapter Types
- `process`: Local process execution
- `api`: External API integration
- `webhook`: Event-driven webhook responses
- `stream`: Real-time streaming responses

### JSONB Schema Validation

#### adapter_config
```json
{
  "model": "string",           // AI model identifier
  "temperature": "number",     // 0.0 - 2.0
  "max_tokens": "number",      // Maximum response length
  "skills": ["string"],        // Array of skill identifiers
  "endpoints": {               // API endpoint configuration
    "primary": "string",
    "fallback": "string"
  }
}
```

#### runtime_config
```json
{
  "max_concurrent_tasks": "number",
  "timeout_seconds": "number",
  "retry_attempts": "number",
  "rate_limiting": {
    "requests_per_minute": "number",
    "burst_limit": "number"
  },
  "error_handling": {
    "auto_retry": "boolean",
    "escalation_enabled": "boolean"
  }
}
```

#### permissions
```json
{
  "execute": {
    "automation_engine": "string",
    "allowed_domains": ["string"]
  },
  "orchestrate": {
    "company_projects": ["string"],
    "max_parallel_workflows": "number"
  },
  "access": {
    "read_company_data": "boolean",
    "write_company_data": "boolean",
    "admin_functions": "boolean"
  }
}
```

## Migration Considerations

### Adding New Fields
- Use JSONB fields for flexible configuration (adapter_config, runtime_config, permissions)
- Add database defaults for backward compatibility
- Update indexes if new query patterns are introduced

### Schema Evolution
- Version control schema changes
- Test migrations on staging environment first
- Document breaking changes and migration paths
- Update application code to handle new fields gracefully

## Performance Considerations

### Index Strategy
- Primary key on `id` for fast lookups
- Compound indexes for common query patterns
- Partial indexes for status-based queries
- Consider covering indexes for metadata queries

### Partitioning Strategy (Future)
- Consider partitioning by `company_id` for large deployments
- Time-based partitioning for audit fields if retention is required
- Hash partitioning for even distribution of agent records

### Monitoring Queries
```sql
-- Agent health check
SELECT
  status,
  COUNT(*) as count,
  AVG(EXTRACT(EPOCH FROM (NOW() - last_heartbeat_at))) as avg_seconds_since_heartbeat
FROM agents
WHERE company_id = ?
GROUP BY status;

-- Budget utilization
SELECT
  SUM(budget_monthly_cents) as total_budget,
  SUM(spent_monthly_cents) as total_spent,
  ROUND(SUM(spent_monthly_cents)::numeric / NULLIF(SUM(budget_monthly_cents), 0) * 100, 2) as utilization_percent
FROM agents
WHERE company_id = ? AND budget_monthly_cents > 0;
```

---

**Schema Version**: 1.0
**Last Updated**: 2026-04-15
**Related Tables**: companies, agent_api_keys, agent_models, activity_log
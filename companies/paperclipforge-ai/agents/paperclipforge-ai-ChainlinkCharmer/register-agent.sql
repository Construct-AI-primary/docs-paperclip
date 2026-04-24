-- ============================================================
-- PaperclipForge AI - Chainlink Charmer Agent Registration
-- Created: 2026-04-21
-- Description: Registers the Chainlink Charmer agent for dependency management and critical path optimization
-- Prerequisites: Operations Director (paperclipforge-ai-operations-director) must exist
-- ============================================================

-- Check if Operations Director exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director') THEN
        RAISE EXCEPTION 'ERROR: Operations Director (paperclipforge-ai-operations-director) does not exist. Please create the Operations Director agent first.';
    END IF;
END $$;

-- Insert the Chainlink Charmer agent (idempotent - safe to run multiple times)
INSERT INTO agents (
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents
) SELECT
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI'),
  'paperclipforge-ai-chainlink-charmer',
  'specialist',
  'The Chainlink Charmer',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Expert dependency management specialist managing complex interdependencies, critical path analysis, and resource allocation optimization across engineering workflows. Master coordinator for workflow bottlenecks, risk assessment, and scheduling optimization.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.2,
    "max_tokens": 8192,
    "skills": [
      "dependency-management",
      "critical-path-analysis",
      "resource-allocation",
      "workflow-optimization",
      "risk-assessment",
      "scheduling-optimization",
      "bottleneck-identification",
      "dependency-mapping"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 5,
    "timeout_seconds": 3600,
    "retry_attempts": 3,
    "rate_limiting": {
      "requests_per_minute": 10,
      "burst_limit": 20
    },
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  '{
    "execute": {
      "automation_engine": "hermes_local",
      "allowed_domains": ["dependency-management", "critical-path", "resource-allocation", "workflow-optimization"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "domainforge-ai", "construct-ai", "infraforge-ai"],
      "max_parallel_workflows": 5
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": false
    }
  }'::jsonb,
  65000
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-chainlink-charmer'
);

-- Verification query
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'paperclipforge-ai-chainlink-charmer';

-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'paperclipforge-ai-chainlink-charmer';

-- ============================================================
-- Clean up: Uncomment to remove the agent
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-chainlink-charmer';
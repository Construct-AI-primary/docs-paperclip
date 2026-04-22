-- ============================================================
-- PaperclipForge AI - Wisdom Weaver Agent Registration
-- Created: 2026-04-21
-- Description: Registers the Wisdom Weaver agent for knowledge integration and insight synthesis
-- Prerequisites: Operations Director (paperclipforge-ai-operations-director) must exist
-- ============================================================

-- Check if Operations Director exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director') THEN
        RAISE EXCEPTION 'ERROR: Operations Director (paperclipforge-ai-operations-director) does not exist. Please create the Operations Director agent first.';
    END IF;
END $$;

-- Insert the Wisdom Weaver agent (idempotent - safe to run multiple times)
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
  'paperclipforge-ai-wisdom-weaver',
  'specialist',
  'The Wisdom Weaver',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Master knowledge integrator weaving disparate information sources into coherent, actionable insights and comprehensive knowledge frameworks for engineering excellence. Synthesizes complex information from multiple domains into unified wisdom that drives informed decision-making and innovation.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.1,
    "max_tokens": 8192,
    "skills": [
      "knowledge-integration",
      "information-synthesis",
      "insight-generation",
      "knowledge-frameworks",
      "cross-domain-analysis",
      "wisdom-extraction",
      "knowledge-mapping",
      "insight-validation"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 2,
    "timeout_seconds": 7200,
    "retry_attempts": 2,
    "rate_limiting": {
      "requests_per_minute": 3,
      "burst_limit": 5
    },
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  '{
    "execute": {
      "automation_engine": "hermes_local",
      "allowed_domains": ["knowledge-integration", "information-synthesis", "insight-generation", "knowledge-frameworks"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "knowledgeforge-ai", "construct-ai", "domainforge-ai"],
      "max_parallel_workflows": 1
    },
    "access": {
      "read_company_data": true,
      "write_company_data": false,
      "admin_functions": false
    }
  }'::jsonb,
  70000
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-wisdom-weaver'
);

-- Verification query
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'paperclipforge-ai-wisdom-weaver';

-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'paperclipforge-ai-wisdom-weaver';

-- ============================================================
-- Clean up: Uncomment to remove the agent
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-wisdom-weaver';
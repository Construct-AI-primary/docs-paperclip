-- ============================================================
-- PaperclipForge AI - Engineering UI Specialist Agent Registration
-- Created: 2026-04-21
-- Description: Registers the Engineering UI Specialist agent for enterprise engineering platform UI/UX development
-- Prerequisites: Operations Director (paperclipforge-ai-operations-director) must exist
-- ============================================================

-- Check if Operations Director exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director') THEN
        RAISE EXCEPTION 'ERROR: Operations Director (paperclipforge-ai-operations-director) does not exist. Please create the Operations Director agent first.';
    END IF;
END $$;

-- Insert the Engineering UI Specialist agent (idempotent - safe to run multiple times)
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
  'paperclipforge-ai-engineering-ui-specialist',
  'specialist',
  'UI Uma',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Engineering UI/UX design specialist focused on creating engineering-specific user interfaces, technical visualizations, and domain-adapted user experiences for complex engineering workflows. Expert in CAD/BIM integration, analysis result visualization, and cross-discipline interface design.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.7,
    "max_tokens": 4096,
    "skills": [
      "engineering-ui-design",
      "technical-visualization",
      "domain-adaptive-interfaces",
      "cad-ui-integration",
      "engineering-dashboard-design",
      "user-experience-engineering"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 5,
    "timeout_seconds": 1800,
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
      "allowed_domains": ["engineering-ui", "technical-visualization", "interface-design"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "devforge-ai", "construct-ai"],
      "max_parallel_workflows": 3
    },
    "access": {
      "read_company_data": true,
      "write_company_data": false,
      "admin_functions": false
    }
  }'::jsonb,
  50000
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-engineering-ui-specialist'
);

-- Verification query
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'paperclipforge-ai-engineering-ui-specialist';

-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'paperclipforge-ai-engineering-ui-specialist';

-- ============================================================
-- Clean up: Uncomment to remove the agent
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-engineering-ui-specialist';
-- ============================================================
-- PaperclipForge AI - Measurement Standards Specialist Agent Registration
-- Created: 2026-04-21
-- Description: Registers the Measurement Standards Specialist agent for standards management and compliance validation
-- Prerequisites: Operations Director (paperclipforge-ai-operations-director) must exist
-- ============================================================

-- Check if Operations Director exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director') THEN
        RAISE EXCEPTION 'ERROR: Operations Director (paperclipforge-ai-operations-director) does not exist. Please create the Operations Director agent first.';
    END IF;
END $$;

-- Insert the Measurement Standards Specialist agent (idempotent - safe to run multiple times)
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
  'paperclipforge-ai-measurement-standards-specialist',
  'specialist',
  'Standards Stella',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Measurement standards specialist managing compliance validation, regulatory requirements, and audit preparation across civil, electrical, mechanical, and structural engineering disciplines. Expert in multi-jurisdictional standards, compliance reporting, and regulatory tracking.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": [
      "standards-management",
      "compliance-validation",
      "regulatory-requirements",
      "audit-preparation",
      "jurisdictional-standards",
      "standards-documentation",
      "compliance-reporting",
      "regulatory-updates"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 4,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {
      "requests_per_minute": 8,
      "burst_limit": 15
    },
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  '{
    "execute": {
      "automation_engine": "hermes_local",
      "allowed_domains": ["standards-management", "compliance-validation", "regulatory-requirements", "audit-preparation"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "knowledgeforge-ai", "qualityforge-ai"],
      "max_parallel_workflows": 2
    },
    "access": {
      "read_company_data": true,
      "write_company_data": false,
      "admin_functions": false
    }
  }'::jsonb,
  55000
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-measurement-standards-specialist'
);

-- Verification query
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'paperclipforge-ai-measurement-standards-specialist';

-- ============================================================
-- Clean up: Uncomment to remove the agent
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-measurement-standards-specialist';
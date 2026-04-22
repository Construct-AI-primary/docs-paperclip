-- ============================================================
-- PaperclipForge AI - Measurement Validation Specialist Agent Registration
-- Created: 2026-04-21
-- Description: Registers the Measurement Validation Specialist agent for automated measurement validation and quality assurance
-- Prerequisites: Operations Director (paperclipforge-ai-operations-director) must exist
-- ============================================================

-- Check if Operations Director exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director') THEN
        RAISE EXCEPTION 'ERROR: Operations Director (paperclipforge-ai-operations-director) does not exist. Please create the Operations Director agent first.';
    END IF;
END $$;

-- Insert the Measurement Validation Specialist agent (idempotent - safe to run multiple times)
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
  'paperclipforge-ai-measurement-validation-specialist',
  'specialist',
  'Validation Vera',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Measurement validation specialist ensuring accuracy, compliance, and quality of measurements across civil, electrical, mechanical, and structural engineering disciplines. Expert in automated validation, tolerance checking, standards compliance, and error detection.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": [
      "measurement-validation",
      "standards-compliance",
      "error-detection",
      "quality-assurance",
      "tolerance-management",
      "validation-automation",
      "measurement-accuracy",
      "compliance-checking"
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
      "allowed_domains": ["measurement-validation", "standards-compliance", "quality-assurance", "cad-validation"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "integrateforge-ai", "knowledgeforge-ai"],
      "max_parallel_workflows": 3
    },
    "access": {
      "read_company_data": true,
      "write_company_data": false,
      "admin_functions": false
    }
  }'::jsonb,
  60000
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-measurement-validation-specialist'
);

-- Verification query
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'paperclipforge-ai-measurement-validation-specialist';

-- ============================================================
-- Clean up: Uncomment to remove the agent
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-measurement-validation-specialist';
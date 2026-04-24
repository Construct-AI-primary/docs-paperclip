-- ============================================================
-- PaperclipForge AI - Measurement Coordination Specialist Agent Registration
-- Created: 2026-04-21
-- Description: Registers the Measurement Coordination Specialist agent for cross-discipline measurement coordination
-- Prerequisites: Operations Director (paperclipforge-ai-operations-director) must exist
-- ============================================================

-- Check if Operations Director exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director') THEN
        RAISE EXCEPTION 'ERROR: Operations Director (paperclipforge-ai-operations-director) does not exist. Please create the Operations Director agent first.';
    END IF;
END $$;

-- Insert the Measurement Coordination Specialist agent (idempotent - safe to run multiple times)
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
  'paperclipforge-ai-measurement-coordination-specialist',
  'specialist',
  'Measurement Molly',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Measurement coordination specialist managing cross-discipline measurement workflows, interdisciplinary integration, workflow optimization, and conflict resolution across civil, electrical, mechanical, and structural engineering disciplines. Expert in stakeholder coordination and process optimization.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": [
      "measurement-coordination",
      "interdisciplinary-integration",
      "workflow-optimization",
      "conflict-resolution",
      "cross-discipline-communication",
      "measurement-workflow-management",
      "stakeholder-coordination",
      "process-optimization"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 6,
    "timeout_seconds": 2400,
    "retry_attempts": 3,
    "rate_limiting": {
      "requests_per_minute": 12,
      "burst_limit": 24
    },
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  '{
    "execute": {
      "automation_engine": "hermes_local",
      "allowed_domains": ["measurement-coordination", "interdisciplinary-integration", "workflow-optimization", "conflict-resolution"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "integrateforge-ai", "domainforge-ai"],
      "max_parallel_workflows": 4
    },
    "access": {
      "read_company_data": true,
      "write_company_data": false,
      "admin_functions": false
    }
  }'::jsonb,
  65000
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-measurement-coordination-specialist'
);

-- Verification query
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'paperclipforge-ai-measurement-coordination-specialist';

-- ============================================================
-- Clean up: Uncomment to remove the agent
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-measurement-coordination-specialist';
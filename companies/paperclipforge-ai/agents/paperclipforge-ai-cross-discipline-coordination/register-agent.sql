-- ============================================================
-- PaperclipForge AI - Cross-Discipline Coordination Agent Registration
-- Created: 2026-04-21
-- Description: Registers the Cross-Discipline Coordination agent for BIM coordination and interdisciplinary engineering management
-- Prerequisites: Operations Director (paperclipforge-ai-operations-director) must exist
-- ============================================================

-- Check if Operations Director exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director') THEN
        RAISE EXCEPTION 'ERROR: Operations Director (paperclipforge-ai-operations-director) does not exist. Please create the Operations Director agent first.';
    END IF;
END $$;

-- Insert the Cross-Discipline Coordination agent (idempotent - safe to run multiple times)
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
  'paperclipforge-ai-cross-discipline-coordination',
  'specialist',
  'Coordination Charlie',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Cross-discipline coordination specialist managing BIM coordination, clash detection, interdisciplinary design integration, and engineering change management for enterprise construction projects. Expert in federated model management and multi-disciplinary collaboration.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.5,
    "max_tokens": 6144,
    "skills": [
      "bim-coordination",
      "clash-detection",
      "interdisciplinary-integration",
      "engineering-change-management",
      "design-coordination",
      "conflict-resolution",
      "federated-model-management",
      "coordination-automation"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 4,
    "timeout_seconds": 2400,
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
      "allowed_domains": ["bim-coordination", "clash-detection", "interdisciplinary-integration", "change-management"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "construct-ai", "domainforge-ai", "integrateforge-ai"],
      "max_parallel_workflows": 4
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": false
    }
  }'::jsonb,
  60000
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-cross-discipline-coordination'
);

-- Verification query
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'paperclipforge-ai-cross-discipline-coordination';

-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'paperclipforge-ai-cross-discipline-coordination';

-- ============================================================
-- Clean up: Uncomment to remove the agent
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-cross-discipline-coordination';
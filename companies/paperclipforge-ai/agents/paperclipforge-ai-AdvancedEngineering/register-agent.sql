-- ============================================================
-- PaperclipForge AI - Advanced Engineering Analysis Agent Registration
-- Created: 2026-04-21
-- Description: Registers the Advanced Engineering Analysis agent for enterprise engineering simulation and analysis
-- Prerequisites: Operations Director (paperclipforge-ai-operations-director) must exist
-- ============================================================

-- Check if Operations Director exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director') THEN
        RAISE EXCEPTION 'ERROR: Operations Director (paperclipforge-ai-operations-director) does not exist. Please create the Operations Director agent first.';
    END IF;
END $$;

-- Insert the Advanced Engineering Analysis agent (idempotent - safe to run multiple times)
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
  'paperclipforge-ai-advanced-engineering-analysis',
  'specialist',
  'Analysis Andy',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Advanced engineering analysis specialist providing enterprise-grade FEA, CFD, thermal analysis, and multi-physics simulations. Expert in structural analysis, fluid dynamics, thermal management, and engineering optimization for critical decision-making.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.3,
    "max_tokens": 8192,
    "skills": [
      "finite-element-analysis",
      "computational-fluid-dynamics",
      "thermal-analysis",
      "structural-analysis",
      "multi-physics-simulation",
      "engineering-optimization",
      "analysis-automation",
      "results-interpretation"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 3,
    "timeout_seconds": 3600,
    "retry_attempts": 2,
    "rate_limiting": {
      "requests_per_minute": 5,
      "burst_limit": 10
    },
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  '{
    "execute": {
      "automation_engine": "hermes_local",
      "allowed_domains": ["engineering-analysis", "simulation", "fea", "cfd", "thermal-analysis"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "domainforge-ai", "construct-ai"],
      "max_parallel_workflows": 2
    },
    "access": {
      "read_company_data": true,
      "write_company_data": false,
      "admin_functions": false
    }
  }'::jsonb,
  75000
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-advanced-engineering-analysis'
);

-- Verification query
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'paperclipforge-ai-advanced-engineering-analysis';

-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'paperclipforge-ai-advanced-engineering-analysis';

-- ============================================================
-- Clean up: Uncomment to remove the agent
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-advanced-engineering-analysis';
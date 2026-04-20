-- ============================================================
-- Agent Registration: operations-director (Chief Operations Officer)
-- Company: PaperclipForge AI
-- Date: 2026-04-20
-- Purpose: Register the Operations Director agent
-- ============================================================

-- Step 1: Get PaperclipForge AI company ID
-- SELECT id, name FROM companies WHERE name LIKE '%PaperclipForge%';

-- ============================================================
-- IMPORTANT: Schema constraints for this table:
-- - agents table has NO unique constraint on 'name'
-- - Model config is stored in adapter_config JSONB field
-- - There is NO agent_models table in this schema
-- ============================================================

-- ============================================================
-- AGENT REGISTRATION (Idempotent - uses NOT EXISTS check)
-- ============================================================
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  icon,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  budget_monthly_cents,
  spent_monthly_cents,
  permissions,
  metadata,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI'),
  'paperclipforge-ai-operations-director',
  'executive',
  'Chief Operations Officer',
  '👔',
  'idle',
  NULL,  -- Reports to Project Maestro (CEO) - set to NULL until CEO is registered
  'Operational leadership and execution oversight; Issue orchestration and workflow management; Operational performance monitoring and optimization; Team coordination and resource management; Operational risk management and mitigation.',
  'process',
  '{
    "model": "z-ai/glm-4-flash",
    "temperature": 0.7,
    "max_tokens": 8192,
    "skills": ["operations-management", "issue-orchestration", "workflow-optimization", "performance-monitoring", "team-leadership"]
  }'::jsonb,
  '{
    "max_concurrent_tasks": 5,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  750000,  -- $7500 monthly budget in cents
  0,
  '{
    "execute": {
      "automation_engine": "workflow_ops",
      "allowed_domains": ["docs-paperclip"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai"],
      "max_parallel_workflows": 10
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": true
    }
  }'::jsonb,
  '{
    "human_name": "Operations Director",
    "specialization": "operations-leadership",
    "created_via": "ATLAS-001",
    "department": "executive"
  }'::jsonb,
  NOW(),
  NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director'
);

-- ============================================================
-- MODEL CONFIGURATION
-- ============================================================
-- NOTE: Model configuration is stored in adapter_config JSONB field
-- The model "z-ai/glm-4-flash" is configured in the adapter_config above.
-- There is NO separate agent_models table in this schema.

-- ============================================================
-- SKILL LINKING
-- ============================================================
-- Note: Skills are linked via the skill definition files in the filesystem
-- The agent references skills by name in adapter_config.skills
-- Skills are: operations-management, issue-orchestration, workflow-optimization, performance-monitoring, team-leadership

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check agent was created
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'paperclipforge-ai-operations-director';

-- Full agent details with company
-- SELECT a.name, a.title, c.name as company, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'paperclipforge-ai-operations-director';

-- ============================================================
-- ROLLBACK (if needed)
-- ============================================================
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-operations-director';
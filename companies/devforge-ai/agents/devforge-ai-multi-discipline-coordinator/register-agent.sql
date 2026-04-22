-- ============================================================
-- Agent Registration: multi-discipline-coordinator
-- Company: DevForge AI
-- Date: 2026-04-21
-- Purpose: Register the Multi-Discipline Coordinator agent
-- ============================================================

-- Step 1: Get DevForge AI company ID
-- SELECT id, name FROM companies WHERE name LIKE '%DevForge%';

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
  (SELECT id FROM companies WHERE name = 'DevForge AI'),
  'devforge-ai-multi-discipline-coordinator',
  'specialist',
  'Multi-Discipline Coordinator',
  '🔗',
  'idle',
  (SELECT id FROM agents WHERE name = 'forge-devforge-system-architecture' LIMIT 1),
  'Cross-discipline task routing and workflow orchestration; Dependency resolution and critical path analysis; Inter-team synchronization and communication facilitation; Conflict mediation and resource allocation coordination; Progress tracking and milestone management; Automated scheduling and conflict detection.',
  'hermes_local',
  '{
    "model": "anthropic/claude-sonnet-4.5",
    "temperature": 0.6,
    "max_tokens": 8192,
    "skills": ["cross-discipline-task-routing", "dependency-resolution", "inter-team-synchronization", "workflow-orchestration", "conflict-mediation", "progress-tracking", "resource-allocation-coordination", "milestone-management"]
  }'::jsonb,
  '{
    "max_concurrent_tasks": 8,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  500000,  -- $5000 monthly budget in cents
  0,
  '{
    "execute": {
      "automation_engine": "coordination_ops",
      "allowed_domains": ["docs-paperclip"]
    },
    "orchestrate": {
      "company_projects": ["devforge-ai"],
      "max_parallel_workflows": 8
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": false
    }
  }'::jsonb,
  '{
    "human_name": "Multi-Discipline Coordinator",
    "specialization": "cross-discipline-coordination",
    "created_via": "atlas-agent-creator",
    "department": "operations"
  }'::jsonb,
  NOW(),
  NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'devforge-ai-multi-discipline-coordinator'
);

-- ============================================================
-- MODEL CONFIGURATION
-- ============================================================
-- NOTE: Model configuration is stored in adapter_config JSONB field
-- The model "anthropic/claude-sonnet-4.5" is configured in the adapter_config above.
-- Moderate temperature (0.6) for coordination work balancing creativity with consistency.
-- There is NO separate agent_models table in this schema.

-- ============================================================
-- SKILL LINKING
-- ============================================================
-- Note: Skills are linked via the skill definition files in the filesystem
-- The agent references skills by name in adapter_config.skills
-- Skills: cross-discipline-task-routing, dependency-resolution,
--   inter-team-synchronization, workflow-orchestration, conflict-mediation,
--   progress-tracking, resource-allocation-coordination, milestone-management

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check agent was created
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'devforge-ai-multi-discipline-coordinator';

-- Full agent details with company
-- SELECT a.name, a.title, c.name as company, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'devforge-ai-multi-discipline-coordinator';

-- ============================================================
-- ROLLBACK (if needed)
-- ============================================================
-- DELETE FROM agents WHERE name = 'devforge-ai-multi-discipline-coordinator';

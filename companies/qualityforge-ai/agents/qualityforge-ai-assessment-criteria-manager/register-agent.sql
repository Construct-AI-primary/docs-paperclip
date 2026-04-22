-- ============================================================
-- Agent Registration: assessment-criteria-manager
-- Company: QualityForge AI
-- Date: 2026-04-21
-- Purpose: Register the Assessment Criteria Manager agent
-- ============================================================

-- Step 1: Get QualityForge AI company ID
-- SELECT id, name FROM companies WHERE name LIKE '%QualityForge%';

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
  (SELECT id FROM companies WHERE name = 'QualityForge AI'),
  'qualityforge-ai-assessment-criteria-manager',
  'specialist',
  'Assessment Criteria Manager',
  '📊',
  'idle',
  (SELECT id FROM agents WHERE name = 'governor-qualityforge-quality-director' LIMIT 1),
  'Assessment criteria definition and management; Scoring rubric development and validation; Evaluation framework design and composition; Criteria versioning and change management; Quality metrics standardization; Cross-company criteria alignment and harmonization.',
  'hermes_local',
  '{
    "model": "anthropic/claude-sonnet-4.5",
    "temperature": 0.6,
    "max_tokens": 8192,
    "skills": ["assessment-criteria-definition", "scoring-rubric-development", "evaluation-framework-design", "criteria-versioning-management", "quality-metrics-standardization", "cross-company-criteria-alignment"]
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
  500000,  -- $5000 monthly budget in cents
  0,
  '{
    "execute": {
      "automation_engine": "criteria_ops",
      "allowed_domains": ["docs-paperclip"]
    },
    "orchestrate": {
      "company_projects": ["qualityforge-ai"],
      "max_parallel_workflows": 5
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": false
    }
  }'::jsonb,
  '{
    "human_name": "Assessment Criteria Manager",
    "specialization": "assessment-criteria-management",
    "created_via": "ATLAS-001",
    "department": "quality"
  }'::jsonb,
  NOW(),
  NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'qualityforge-ai-assessment-criteria-manager'
);

-- ============================================================
-- MODEL CONFIGURATION
-- ============================================================
-- NOTE: Model configuration is stored in adapter_config JSONB field
-- The model "anthropic/claude-sonnet-4.5" is configured in the adapter_config above.
-- There is NO separate agent_models table in this schema.

-- ============================================================
-- SKILL LINKING
-- ============================================================
-- Note: Skills are linked via the skill definition files in the filesystem
-- The agent references skills by name in adapter_config.skills
-- Skills are: assessment-criteria-definition, scoring-rubric-development,
--   evaluation-framework-design, criteria-versioning-management,
--   quality-metrics-standardization, cross-company-criteria-alignment

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check agent was created
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'qualityforge-ai-assessment-criteria-manager';

-- Full agent details with company
-- SELECT a.name, a.title, c.name as company, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'qualityforge-ai-assessment-criteria-manager';

-- ============================================================
-- ROLLBACK (if needed)
-- ============================================================
-- DELETE FROM agents WHERE name = 'qualityforge-ai-assessment-criteria-manager';

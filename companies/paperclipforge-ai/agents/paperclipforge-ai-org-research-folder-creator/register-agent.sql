-- ============================================================
-- Agent Registration: org-research-folder-creator (Scout)
-- Company: PaperclipForge AI
-- Date: 2026-04-20
-- Purpose: Register the Org Research Folder Creator agent
-- ============================================================

-- Step 1: Get PaperclipForge AI company ID
-- SELECT id, name FROM companies WHERE name LIKE '%PaperclipForge%';

-- Step 2: Get Operations Director ID (for reports_to)
-- SELECT id, name FROM agents WHERE name LIKE '%operations-director%';

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
  'paperclipforge-ai-org-research-folder-creator',
  'specialist',
  'Scout - Organisation Research & Documentation Specialist',
  '🔍',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'AI-powered organisation research, automated folder structure creation, intelligent project/issue generation from research findings. Capabilities: Web research, documentation generation, folder structure automation, project generation, issue creation, cross-reference management.',
  'process',
  '{
    "model": "z-ai/glm-4-flash",
    "temperature": 0.7,
    "max_tokens": 8192,
    "skills": ["org-research-folder-creator", "issue-generator", "workflow-automator", "knowledge-integrator"]
  }'::jsonb,
  '{
    "max_concurrent_tasks": 3,
    "timeout_seconds": 3600,
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
      "automation_engine": "file_ops",
      "allowed_domains": ["docs-paperclip"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai"],
      "max_parallel_workflows": 3
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": false
    }
  }'::jsonb,
  '{
    "human_name": "Scout",
    "specialization": "organisation-research",
    "created_via": "ATLAS-001",
    "folder_template": "organisation-knowledge/{slug}/"
  }'::jsonb,
  NOW(),
  NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-org-research-folder-creator'
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
-- Skills are: org-research-folder-creator, issue-generator, workflow-automator, knowledge-integrator

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check agent was created
-- SELECT id, name, role, title, status, adapter_config->>'model' as model 
-- FROM agents WHERE name = 'paperclipforge-ai-org-research-folder-creator';

-- Full agent details with company
-- SELECT a.name, a.title, c.name as company, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'paperclipforge-ai-org-research-folder-creator';

-- ============================================================
-- ROLLBACK (if needed)
-- ============================================================
-- DELETE FROM agents WHERE name = 'paperclipforge-ai-org-research-folder-creator';

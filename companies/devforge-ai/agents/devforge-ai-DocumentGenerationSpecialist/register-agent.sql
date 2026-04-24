-- ============================================================
-- Agent Registration: document-generation-specialist
-- Company: DevForge AI
-- Date: 2026-04-21
-- Purpose: Register the Document Generation Specialist agent
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
  'devforge-ai-document-generation-specialist',
  'specialist',
  'Document Generation Specialist',
  '📝',
  'idle',
  (SELECT id FROM agents WHERE name = 'archivist-devforge-knowledge-architecture' LIMIT 1),
  'Automated document generation and content assembly; Template management and version control; Multi-format production (PDF, HTML, Markdown, DOCX); Technical documentation and API reference generation; Compliance document generation and audit documentation; Brand compliance enforcement and accessibility compliance.',
  'hermes_local',
  '{
    "model": "anthropic/claude-sonnet-4.5",
    "temperature": 0.5,
    "max_tokens": 8192,
    "skills": ["automated-document-generation", "template-management", "multi-format-production", "technical-documentation", "api-documentation", "compliance-document-generation", "brand-compliance-enforcement", "document-version-control"]
  }'::jsonb,
  '{
    "max_concurrent_tasks": 8,
    "timeout_seconds": 2400,
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
      "automation_engine": "docgen_ops",
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
    "human_name": "Document Generation Specialist",
    "specialization": "document-generation",
    "created_via": "atlas-agent-creator",
    "department": "documentation"
  }'::jsonb,
  NOW(),
  NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'devforge-ai-document-generation-specialist'
);

-- ============================================================
-- MODEL CONFIGURATION
-- ============================================================
-- NOTE: Model configuration is stored in adapter_config JSONB field
-- The model "anthropic/claude-sonnet-4.5" is configured in the adapter_config above.
-- Moderate temperature (0.5) for document generation balancing creativity with precision.
-- Higher max_concurrent_tasks (8) and timeout (2400s) for batch document production.
-- There is NO separate agent_models table in this schema.

-- ============================================================
-- SKILL LINKING
-- ============================================================
-- Note: Skills are linked via the skill definition files in the filesystem
-- The agent references skills by name in adapter_config.skills
-- Skills: automated-document-generation, template-management,
--   multi-format-production, technical-documentation, api-documentation,
--   compliance-document-generation, brand-compliance-enforcement,
--   document-version-control

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check agent was created
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'devforge-ai-document-generation-specialist';

-- Full agent details with company
-- SELECT a.name, a.title, c.name as company, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'devforge-ai-document-generation-specialist';

-- ============================================================
-- ROLLBACK (if needed)
-- ============================================================
-- DELETE FROM agents WHERE name = 'devforge-ai-document-generation-specialist';

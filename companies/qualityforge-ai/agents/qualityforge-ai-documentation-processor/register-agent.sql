-- ============================================================
-- Agent Registration: documentation-processor
-- Company: QualityForge AI
-- Date: 2026-04-21
-- Purpose: Register the Documentation Processor agent
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
  'qualityforge-ai-documentation-processor',
  'specialist',
  'Documentation Processor',
  '📄',
  'idle',
  (SELECT id FROM agents WHERE name = 'governor-qualityforge-quality-director' LIMIT 1),
  'Document ingestion and multi-format parsing; Format transformation and cross-format conversion; Content extraction, analysis, and summarization; Documentation quality assurance and validation; Metadata management and taxonomy application; Document lifecycle management and version tracking.',
  'hermes_local',
  '{
    "model": "z-ai/glm-4-flash",
    "temperature": 0.6,
    "max_tokens": 8192,
    "skills": ["document-ingestion-parsing", "format-transformation", "content-extraction-analysis", "documentation-quality-assurance", "metadata-management", "document-lifecycle-management"]
  }'::jsonb,
  '{
    "max_concurrent_tasks": 8,
    "timeout_seconds": 1200,
    "retry_attempts": 3,
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  350000,  -- $3500 monthly budget in cents
  0,
  '{
    "execute": {
      "automation_engine": "doc_ops",
      "allowed_domains": ["docs-paperclip"]
    },
    "orchestrate": {
      "company_projects": ["qualityforge-ai"],
      "max_parallel_workflows": 8
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": false
    }
  }'::jsonb,
  '{
    "human_name": "Documentation Processor",
    "specialization": "documentation-processing",
    "created_via": "ATLAS-001",
    "department": "quality"
  }'::jsonb,
  NOW(),
  NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'qualityforge-ai-documentation-processor'
);

-- ============================================================
-- MODEL CONFIGURATION
-- ============================================================
-- NOTE: Model configuration is stored in adapter_config JSONB field
-- The model "z-ai/glm-4-flash" is configured in the adapter_config above.
-- Documentation processing is high-throughput but lower-complexity, suitable for
-- a faster, cost-efficient model. Higher max_concurrent_tasks (8) reflects
-- the pipeline-parallel nature of document processing.
-- There is NO separate agent_models table in this schema.

-- ============================================================
-- SKILL LINKING
-- ============================================================
-- Note: Skills are linked via the skill definition files in the filesystem
-- The agent references skills by name in adapter_config.skills
-- Skills are: document-ingestion-parsing, format-transformation,
--   content-extraction-analysis, documentation-quality-assurance,
--   metadata-management, document-lifecycle-management

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check agent was created
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'qualityforge-ai-documentation-processor';

-- Full agent details with company
-- SELECT a.name, a.title, c.name as company, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'qualityforge-ai-documentation-processor';

-- ============================================================
-- ROLLBACK (if needed)
-- ============================================================
-- DELETE FROM agents WHERE name = 'qualityforge-ai-documentation-processor';

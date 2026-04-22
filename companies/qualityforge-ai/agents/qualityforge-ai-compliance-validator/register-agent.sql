-- ============================================================
-- Agent Registration: compliance-validator
-- Company: QualityForge AI
-- Date: 2026-04-21
-- Purpose: Register the Compliance Validator agent
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
  'qualityforge-ai-compliance-validator',
  'specialist',
  'Compliance Validator',
  '✅',
  'idle',
  (SELECT id FROM agents WHERE name = 'governor-qualityforge-quality-director' LIMIT 1),
  'Regulatory compliance validation and monitoring; Industry standards verification and conformance testing; Policy conformance checking and gap detection; Compliance gap analysis and remediation planning; Audit evidence collection and organization; Compliance reporting and dashboard generation; Risk assessment integration and mitigation tracking.',
  'hermes_local',
  '{
    "model": "anthropic/claude-sonnet-4.5",
    "temperature": 0.5,
    "max_tokens": 8192,
    "skills": ["regulatory-compliance-validation", "industry-standards-verification", "policy-conformance-checking", "compliance-gap-analysis", "audit-evidence-collection", "compliance-reporting", "risk-assessment-integration"]
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
      "automation_engine": "compliance_ops",
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
    "human_name": "Compliance Validator",
    "specialization": "compliance-validation",
    "created_via": "ATLAS-001",
    "department": "quality"
  }'::jsonb,
  NOW(),
  NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'qualityforge-ai-compliance-validator'
);

-- ============================================================
-- MODEL CONFIGURATION
-- ============================================================
-- NOTE: Model configuration is stored in adapter_config JSONB field
-- The model "anthropic/claude-sonnet-4.5" is configured in the adapter_config above.
-- Lower temperature (0.5) for compliance work requiring precision and consistency.
-- There is NO separate agent_models table in this schema.

-- ============================================================
-- SKILL LINKING
-- ============================================================
-- Note: Skills are linked via the skill definition files in the filesystem
-- The agent references skills by name in adapter_config.skills
-- Skills are: regulatory-compliance-validation, industry-standards-verification,
--   policy-conformance-checking, compliance-gap-analysis,
--   audit-evidence-collection, compliance-reporting, risk-assessment-integration

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check agent was created
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'qualityforge-ai-compliance-validator';

-- Full agent details with company
-- SELECT a.name, a.title, c.name as company, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'qualityforge-ai-compliance-validator';

-- ============================================================
-- ROLLBACK (if needed)
-- ============================================================
-- DELETE FROM agents WHERE name = 'qualityforge-ai-compliance-validator';

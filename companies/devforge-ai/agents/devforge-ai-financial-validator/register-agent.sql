-- ============================================================
-- Agent Registration: financial-validator
-- Company: DevForge AI
-- Date: 2026-04-21
-- Purpose: Register the Financial Validator agent
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
  'devforge-ai-financial-validator',
  'specialist',
  'Financial Validator',
  '✅',
  'idle',
  (SELECT id FROM agents WHERE name = 'auditor-devforge-security-compliance' LIMIT 1),
  'Financial data validation and integrity verification; Budget compliance monitoring and variance analysis; Fiscal policy adherence and approval verification; Transaction integrity verification and settlement checking; Cost estimation validation and benchmark comparison; Financial anomaly detection and regulatory compliance.',
  'hermes_local',
  '{
    "model": "anthropic/claude-sonnet-4.5",
    "temperature": 0.4,
    "max_tokens": 8192,
    "skills": ["financial-data-validation", "budget-compliance-monitoring", "fiscal-policy-adherence", "transaction-integrity-verification", "cost-estimation-validation", "financial-anomaly-detection", "regulatory-financial-compliance", "financial-reporting"]
  }'::jsonb,
  '{
    "max_concurrent_tasks": 6,
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
      "automation_engine": "finance_ops",
      "allowed_domains": ["docs-paperclip"]
    },
    "orchestrate": {
      "company_projects": ["devforge-ai"],
      "max_parallel_workflows": 6
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": false,
      "financial_data": true
    }
  }'::jsonb,
  '{
    "human_name": "Financial Validator",
    "specialization": "financial-validation",
    "created_via": "atlas-agent-creator",
    "department": "finance"
  }'::jsonb,
  NOW(),
  NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'devforge-ai-financial-validator'
);

-- ============================================================
-- MODEL CONFIGURATION
-- ============================================================
-- NOTE: Model configuration is stored in adapter_config JSONB field
-- The model "anthropic/claude-sonnet-4.5" is configured in the adapter_config above.
-- Low temperature (0.4) for financial validation requiring high precision and consistency.
-- There is NO separate agent_models table in this schema.

-- ============================================================
-- SKILL LINKING
-- ============================================================
-- Note: Skills are linked via the skill definition files in the filesystem
-- The agent references skills by name in adapter_config.skills
-- Skills: financial-data-validation, budget-compliance-monitoring,
--   fiscal-policy-adherence, transaction-integrity-verification,
--   cost-estimation-validation, financial-anomaly-detection,
--   regulatory-financial-compliance, financial-reporting

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check agent was created
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'devforge-ai-financial-validator';

-- Full agent details with company
-- SELECT a.name, a.title, c.name as company, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'devforge-ai-financial-validator';

-- ============================================================
-- ROLLBACK (if needed)
-- ============================================================
-- DELETE FROM agents WHERE name = 'devforge-ai-financial-validator';

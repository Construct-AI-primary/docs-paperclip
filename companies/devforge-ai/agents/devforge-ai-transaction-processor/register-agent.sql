-- ============================================================
-- Agent Registration: transaction-processor
-- Company: DevForge AI
-- Date: 2026-04-21
-- Purpose: Register the Transaction Processor agent
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
  'devforge-ai-transaction-processor',
  'specialist',
  'Transaction Processor',
  '💳',
  'idle',
  (SELECT id FROM agents WHERE name = 'merchant-devforge-commerce-operations' LIMIT 1),
  'Transaction lifecycle management and state tracking; Payment processing with multi-currency support; Order fulfillment coordination and exception handling; Subscription management and billing cycle execution; Transaction validation, fraud screening, and idempotency control; Audit trail generation and reconciliation processing.',
  'hermes_local',
  '{
    "model": "anthropic/claude-sonnet-4.5",
    "temperature": 0.3,
    "max_tokens": 8192,
    "skills": ["transaction-lifecycle-management", "payment-processing", "order-fulfillment", "subscription-management", "transaction-validation", "audit-trail-generation", "idempotency-control", "reconciliation-processing"]
  }'::jsonb,
  '{
    "max_concurrent_tasks": 10,
    "timeout_seconds": 1200,
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
      "automation_engine": "commerce_ops",
      "allowed_domains": ["docs-paperclip", "payment-gateways"]
    },
    "orchestrate": {
      "company_projects": ["devforge-ai"],
      "max_parallel_workflows": 10
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": false,
      "payment_processing": true
    }
  }'::jsonb,
  '{
    "human_name": "Transaction Processor",
    "specialization": "transaction-processing",
    "created_via": "atlas-agent-creator",
    "department": "commerce"
  }'::jsonb,
  NOW(),
  NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM agents WHERE name = 'devforge-ai-transaction-processor'
);

-- ============================================================
-- MODEL CONFIGURATION
-- ============================================================
-- NOTE: Model configuration is stored in adapter_config JSONB field
-- The model "anthropic/claude-sonnet-4.5" is configured in the adapter_config above.
-- Low temperature (0.3) for transaction processing requiring high precision and consistency.
-- There is NO separate agent_models table in this schema.

-- ============================================================
-- SKILL LINKING
-- ============================================================
-- Note: Skills are linked via the skill definition files in the filesystem
-- The agent references skills by name in adapter_config.skills
-- Skills: transaction-lifecycle-management, payment-processing,
--   order-fulfillment, subscription-management, transaction-validation,
--   audit-trail-generation, idempotency-control, reconciliation-processing

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check agent was created
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'devforge-ai-transaction-processor';

-- Full agent details with company
-- SELECT a.name, a.title, c.name as company, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name = 'devforge-ai-transaction-processor';

-- ============================================================
-- ROLLBACK (if needed)
-- ============================================================
-- DELETE FROM agents WHERE name = 'devforge-ai-transaction-processor';

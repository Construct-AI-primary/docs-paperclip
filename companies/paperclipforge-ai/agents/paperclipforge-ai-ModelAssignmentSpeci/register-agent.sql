-- ============================================================
-- PAPERCLIPFORGE AI - MODEL ASSIGNMENT SPECIALIST REGISTRATION
-- Generated: 2026-04-26
-- Agent: paperclipforge-ai-model-assignment-specialist (SparkAssign)
-- Role: Model Assignment Specialist
-- ============================================================

-- Register the Model Assignment Specialist (SparkAssign) agent
INSERT INTO agents (
  id,
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
  metadata,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  c.id,
  'SparkAssign',
  'specialist',
  'paperclipforge-ai-model-assignment-specialist',
  'active',
  (SELECT id FROM agents WHERE title = 'paperclipforge-ai-atlas-agent-creator' AND company_id = c.id),
  '[
    "Capability-based model tier selection (Pro vs Flash)",
    "Per-agent parameter configuration (temperature, max_tokens, reasoning depth)",
    "agent_models table CRUD operations with FK integrity",
    "Phase-routing strategy: Pro planning → Flash execution",
    "Token budget assignment, enforcement, and monitoring",
    "Skill change detection and capability reassessment pipeline",
    "Fallback model management during provider outages",
    "Prompt compression via Defluffer (45% token savings) and LLMLingua",
    "Issue template validation and context pre-summarization",
    "Cost-optimization analysis and tier-switching recommendations",
    "Model assignment audit trail and compliance logging",
    "Bulk model reassignment for company-wide migrations"
  ]'::jsonb,
  'hermes_local',
  '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash", "temperature": 0.4, "max_tokens": 8192}'::jsonb,
  '{
    "config": {
      "default_fallback_model": "deepseek/deepseek-v3.2",
      "pro_tier_limit_pct": 30,
      "flash_tier_limit_pct": 80,
      "reassessment_interval_hours": 24,
      "budget_hard_stop": true
    }
  }'::jsonb,
  '{
    "canCreateAgents": false,
    "canAssignModels": true,
    "canOverrideBudgets": false
  }'::jsonb,
  '{
    "specialization": "model_assignment",
    "routing_strategy": "phase_based",
    "supported_providers": ["deepseek", "openai", "openrouter"],
    "supported_tiers": ["pro", "flash", "budget"],
    "agent_alias": "SparkAssign"
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = 'PaperclipForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.title = 'paperclipforge-ai-model-assignment-specialist'
      AND a.company_id = c.id
  );

-- Verify the agent was created successfully
SELECT
  a.name,
  a.role,
  a.title,
  a.status,
  c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.title = 'paperclipforge-ai-model-assignment-specialist'
  AND c.name = 'PaperclipForge AI';

-- ============================================================
-- REGISTRATION COMPLETE
-- ============================================================
-- Register paperclipforge-ai-reconciler agent
-- Company: PaperclipForge AI
-- Company ID: 550e8400-e29b-41d4-a716-446655440013

BEGIN;

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
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'Reconciler',
  'operations',
  'Agent Reconciliation Specialist',
  'active',
  NULL, -- reports to CEO
  'Agent reconciliation between filesystem and database; Naming convention validation; Skill file audits; Hierarchy verification; Reconciliation reporting',
  'http',
  '{"url": "https://placeholder.webhook", "model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}',
  NOW(),
  NOW()
);

COMMIT;

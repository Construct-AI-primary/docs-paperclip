-- ============================================================
-- PAPERCLIPFORGE AI - ATLAS AGENT CREATOR REGISTRATION
-- Generated: 2026-04-22
-- Agent: atlas-agent-creator
-- Role: Agent Creator and Manager
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
  adapter_config,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  c.id,
  'atlas-agent-creator',
  'Agent Creator and Manager',
  'Agent Creator and Manager',
  '🤖',
  'idle',
  'operations-director',
  '["task_execution", "communication", "analysis"]',
  '{
    "adapter": "hermes_local",
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.7,
    "max_tokens": 4096
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = 'PaperclipForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'atlas-agent-creator'
      AND a.company_id = c.id
  );

-- ============================================================
-- VERIFICATION QUERY
-- ============================================================

-- Verify the agent was created successfully
SELECT
  a.name,
  a.role,
  a.title,
  a.status,
  a.reports_to,
  c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name = 'atlas-agent-creator'
  AND c.name = 'PaperclipForge AI';

-- ============================================================
-- ATLAS AGENT CREATOR REGISTRATION COMPLETE
-- ============================================================
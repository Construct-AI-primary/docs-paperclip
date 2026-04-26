-- ============================================================
-- PAPERCLIPFORGE AI - DATABASE CRUD ORCHESTRATOR REGISTRATION
-- Generated: 2026-04-26
-- Agent: database-crud-orchestrator
-- Role: Database CRUD Operations Specialist
-- ============================================================

-- Register the Database CRUD Orchestrator agent
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
  'CRUD Commander',
  'specialist',
  'paperclipforge-ai-database-crud-orchestrator',
  'active',
  (SELECT id FROM agents WHERE title = 'paperclipforge-ai-operations-director' AND company_id = c.id),
  '[
    "FK-aware CRUD operations across 237+ relationships",
    "Drizzle ORM type-safe template generation",
    "FK dependency graph analysis and resolution",
    "Bulk operation patterns with FK-safe ordering",
    "Transaction-wrapped insert/update/delete procedures",
    "Supabase visual FK editor integration",
    "Safe deletion sequences with CASCADE/SET NULL handling",
    "Repository pattern code generation",
    "Python supabase-py and TypeScript drizzle-orm template generation"
  ]'::jsonb,
  'hermes_local',
  '{
    "adapter": "hermes_local",
    "model": "deepseek/deepseek-v4-flash",
    "temperature": 0.3,
    "max_tokens": 8192
  }'::jsonb,
  '{
    "config": {
      "max_batch_size": 500,
      "default_delete_batch_size": 100,
      "fk_graph_refresh_hours": 24,
      "template_languages": ["typescript", "python"]
    }
  }'::jsonb,
  '{
    "canGenerateTemplates": true,
    "canAnalyzeSchema": true,
    "canExecuteReadOnly": false
  }'::jsonb,
  '{
    "specialization": "programmatic_crud",
    "fk_graph_version": 1,
    "schema_scope": "all_paperclip_tables",
    "supported_templates": ["ts_drizzle_orm", "py_supabase", "sql_raw"]
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = 'PaperclipForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.title = 'paperclipforge-ai-database-crud-orchestrator'
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
WHERE a.title = 'paperclipforge-ai-database-crud-orchestrator'
  AND c.name = 'PaperclipForge AI';

-- ============================================================
-- REGISTRATION COMPLETE
-- ============================================================
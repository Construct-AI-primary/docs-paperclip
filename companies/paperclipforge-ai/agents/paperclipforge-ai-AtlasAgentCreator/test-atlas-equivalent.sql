-- ATLAS EQUIVALENT: Generated SQL for GitHub Operations Specialist
-- This is what Atlas would generate from the command-line parameters
-- Compare with: register-agent.sql (the original SQL file)

-- Agent Record
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
  budget_monthly_cents,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
  'paperclipforge-ai-github-operations-specialist',
  'specialist',
  'GitHub Operations Specialist',
  'active',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director' LIMIT 1),
  'GitHub repository management, commit standards, pull request lifecycle, branch protection, CI/CD integration',
  'hermes_local',
  '{
    "model": "anthropic/claude-sonnet-4.5",
    "skills": [
      "github-commit-management",
      "github-branch-management",
      "github-pr-lifecycle",
      "github-repository-maintenance",
      "github-api-integration",
      "github-ci-cd-monitoring"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "automation_enabled": true,
    "max_concurrent_tasks": 5,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {
      "requests_per_minute": 10,
      "burst_limit": 20
    },
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  '{
    "github_api_access": true,
    "repository_management": true,
    "ci_cd_control": true,
    "webhook_management": true
  }'::jsonb,
  '{
    "specialization": "github_operations",
    "team": "operations",
    "skills_count": 6,
    "integration_points": ["devforge_ai", "qualityforge_ai", "paperclipforge_ai"],
    "github_features": [
      "commit_management",
      "branch_protection",
      "pr_lifecycle",
      "repository_maintenance",
      "api_integration",
      "ci_cd_monitoring"
    ],
    "created_by": "atlas-agent-creator",
    "created_at": "' || NOW()::text || '"
  }'::jsonb,
  50000,
  NOW(),
  NOW()
);

-- API Key Record
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-github-operations-specialist' ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
  'github_operations_primary_key',
  'pcak_' || encode(gen_random_uuid()::text::bytea, 'base64'),
  encode(digest('github_ops_' || gen_random_uuid()::text, 'sha256'), 'hex'),
  NOW()
);

-- Model Assignment
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_at,
  assigned_by,
  reason,
  is_active
) VALUES (
  'paperclipforge-ai-github-operations-specialist',
  'anthropic/claude-sonnet-4.5',
  'primary',
  1,
  0.7,
  8192,
  NOW(),
  'atlas-agent-creator',
  'Auto-assigned by Atlas for GitHub repository management, commit standards, pull request lifecycle, branch protection, CI/CD integration',
  true
);

-- Activity Log
INSERT INTO activity_log (
  id,
  company_id,
  actor_type,
  actor_id,
  action,
  entity_type,
  entity_id,
  agent_id,
  details,
  created_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
  'system',
  'atlas-agent-creator',
  'create',
  'agent',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-github-operations-specialist' ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-github-operations-specialist' ORDER BY created_at DESC LIMIT 1),
  '{
    "description": "Created specialist agent: GitHub Operations Specialist",
    "skills": [
      "github-commit-management",
      "github-branch-management",
      "github-pr-lifecycle",
      "github-repository-maintenance",
      "github-api-integration",
      "github-ci-cd-monitoring"
    ],
    "capabilities": "GitHub repository management, commit standards, pull request lifecycle, branch protection, CI/CD integration",
    "company": "PaperclipForge AI",
    "team": "operations",
    "reports_to": "paperclipforge-ai-operations-director",
    "model": "anthropic/claude-sonnet-4.5",
    "budget": 50000
  }'::jsonb,
  NOW()
);

-- Verification Query
SELECT
  a.id,
  a.name,
  a.role,
  a.title,
  a.status,
  c.name as company_name,
  r.name as reports_to_name,
  a.capabilities,
  a.adapter_config->>'model' as model,
  a.metadata->>'skills_count' as skills_count,
  a.created_at
FROM
  agents a
JOIN
  companies c ON a.company_id = c.id
LEFT JOIN
  agents r ON a.reports_to = r.id
WHERE
  a.name = 'paperclipforge-ai-github-operations-specialist'
ORDER BY
  a.created_at DESC
LIMIT 1;
-- GitHub Operations Specialist Agent Registration
-- Generated following Atlas Agent Creation procedure with schema inspection

-- Insert agent record
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
    ]
  }'::jsonb,
  '{
    "automation_enabled": true,
    "github_integration": true,
    "webhook_processing": true,
    "ci_cd_monitoring": true
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
    ]
  }'::jsonb,
  NOW(),
  NOW()
);

-- Insert API key record
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

-- Insert activity log entry
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
    "description": "Created GitHub Operations Specialist agent",
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
    "reports_to": "paperclipforge-ai-operations-director"
  }'::jsonb,
  NOW()
);

-- Verification query
SELECT
  a.id,
  a.name,
  a.role,
  a.title,
  a.status,
  c.name as company_name,
  r.name as reports_to_name,
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
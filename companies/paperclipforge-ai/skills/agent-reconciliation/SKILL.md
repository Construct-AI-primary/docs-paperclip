---
name: agent-reconciliation
description: >
  Audit filesystem agent definitions against database registrations
  (agents, agent_models, agent_api_keys tables). Identify missing
  registrations, invalid funky human names, and naming convention
  violations. Generate SQL fixes via collaboration with Database Druid
  and SQL experts.
triggers:
  - agent reconciliation request
  - filesystem database audit
  - missing agent detection
  - naming convention validation
  - funky human name check
  - agent table reconciliation
  - database agent integrity check
---

# Agent Reconciliation Skill

## Overview

This skill enables systematic reconciliation between the filesystem agent definitions (AGENTS.md files under `docs-paperclip/companies/*/agents/`) and the database tables that power the Paperclip control plane (`agents`, `agent_models`, `agent_api_keys`).

## Trigger Conditions

- User asks to "reconcile agents"
- User asks to "check agents against database"
- User asks to "verify agent registrations"
- User asks to "audit agent names" or "check funky human names"
- User asks to "validate naming conventions"
- User asks to "find missing agents" or "find extra agents"
- User asks to "generate agent fix SQL"

## Execution Workflow

### Step 1: Filesystem Discovery
1. Scan `docs-paperclip/companies/{company}/agents/**/AGENTS.md`
2. Parse YAML frontmatter for each agent
3. Extract: `name`, `slug`, `reportsTo`, `team`, `skills`
4. Record directory name for naming convention checks
5. Build filesystem agent index

### Step 2: Database Discovery
1. Query `companies` table → map slug to `id`
2. Query `agents` table → all rows with `id`, `name`, `company_id`, `role`, `title`, `reports_to`, `status`
3. Query `agent_models` table → active model assignments by `agent_id`
4. Query `agent_api_keys` table → API keys by `agent_id`
5. Build database agent index

### Step 3: Reconciliation Match
1. Match filesystem agents to database agents by `slug` ↔ `title` or `name` ↔ `name`
2. Identify **missing agents**: in filesystem, not in database
3. Identify **extra agents**: in database, not in filesystem
4. Identify **agents without API keys**
5. Identify **agents without model assignments**
6. Identify **invalid names**: `name` ≥23 characters or invalid characters
7. Identify **naming convention violations**: directory doesn't follow `{company-slug}-{AgentName}`

### Step 4: SQL Fix Generation
For each issue, generate SQL:

**Missing agent INSERT:**
```sql
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT gen_random_uuid(), (SELECT id FROM companies WHERE slug = '{company_slug}' LIMIT 1), '{funky_name}', 'general', '{slug}', 'idle', NULL, '["task_execution"]', 'hermes_local', '{"adapter":"hermes_local"}'::jsonb, '{}'::jsonb, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE title = '{slug}');
```

**Missing model INSERT:**
```sql
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT gen_random_uuid(), (SELECT id FROM agents WHERE title = '{slug}' LIMIT 1), 'anthropic/claude-opus-4.6', 'default', 0.7, 8192, true, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM agent_models WHERE agent_id = (SELECT id FROM agents WHERE title = '{slug}' LIMIT 1) AND is_active = true);
```

**Missing API key INSERT:**
```sql
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT gen_random_uuid(), (SELECT id FROM agents WHERE title = '{slug}' LIMIT 1), (SELECT company_id FROM agents WHERE title = '{slug}' LIMIT 1), 'default', 'pcp_{token}', NOW()
WHERE NOT EXISTS (SELECT 1 FROM agent_api_keys WHERE agent_id = (SELECT id FROM agents WHERE title = '{slug}' LIMIT 1));
```

**Name fix UPDATE:**
```sql
UPDATE agents SET name = '{compliant_name}' WHERE id = '{agent_id}';
```

### Step 5: Collaboration Delegation
- **Complex schema queries** → delegate to `paperclipforge-ai-database-druid`
- **Agent creation logic** → delegate to `paperclipforge-ai-atlas-agent-creator`
- **Model assignment logic** → delegate to `paperclipforge-ai-model-assignment-specialist`

### Step 6: Report Output
- Save SQL to `reconciliation_fixes.sql`
- Save JSON report to `reconciliation_report.json`
- Print summary with counts per company

## Naming Convention Rules

### Funky Human Name
- Must be <23 characters
- Allowed: `a-z`, `A-Z`, `0-9`, spaces, hyphens, underscores
- Should be human-readable (e.g., "Nexus", "Dataforge", "Recon")

### Directory Name
- Pattern: `{company-slug}-{AgentName}`
- Examples: `devforge-ai-Nexus`, `measureforge-ai-CadOrchestrator`
- Must match the company slug prefix

### File Name
- Always `AGENTS.md`
- Always inside the agent directory

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `companies_dir` | string | No | Path to companies directory (default: `docs-paperclip/companies`) |
| `output_sql_path` | string | No | Path for SQL output (default: `reconciliation_fixes.sql`) |
| `output_json_path` | string | No | Path for JSON report (default: `reconciliation_report.json`) |
| `dry_run` | boolean | No | If true, only report without generating SQL |

## Output Format

### Console Summary
```
COMPANIES:
  - In filesystem: 16
  - In database: 16
AGENTS:
  - In filesystem: 496
  - In database: 548
  - Missing in database: 344
  - Extra in database: 402
  - Without API keys: 84
  - Without models: 159
VALIDATION ISSUES:
  - Invalid names: 70
  - Naming convention issues: 0
```

### JSON Report Structure
```json
{
  "companies_in_filesystem": [...],
  "companies_in_database": [...],
  "missing_companies": [...],
  "missing_agents": [{"name": "...", "slug": "...", "company": "..."}],
  "extra_agents_in_database": [{"id": "...", "name": "..."}],
  "agents_without_api_keys": [{"id": "...", "name": "..."}],
  "agents_without_models": [{"id": "...", "name": "..."}],
  "invalid_names": [{"name": "...", "reason": "..."}],
  "naming_convention_issues": [...],
  "sql_count": 657
}
```

## Error Handling

- **Missing companies directory**: Report error and exit
- **Database connection failure**: Report error with connection details
- **Malformed AGENTS.md**: Log warning, skip file, continue
- **No database agents**: Report warning but continue with filesystem scan

---

**Skill Name**: agent-reconciliation
**Version**: 1.0
**Owner**: paperclipforge-ai-agent-reconciler
**Created**: 2026-04-24

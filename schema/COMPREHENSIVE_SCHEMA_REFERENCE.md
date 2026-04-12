# Comprehensive Paperclip Database Schema Reference
**Generated:** 2026-04-12
**Purpose:** Complete reference to avoid SQL constraint violations and foreign key errors

## Table of Contents
1. [Companies Table](#companies-table)
2. [Agents Table](#agents-table)
3. [Agent API Keys Table](#agent-api-keys-table)
4. [Goals Table](#goals-table)
5. [Projects Table](#projects-table)
6. [Issues Table](#issues-table)
7. [Common SQL Errors & Solutions](#common-sql-errors--solutions)
8. [Safe SQL Patterns](#safe-sql-patterns)

---

## Companies Table

### PostgreSQL Schema
```sql
CREATE TABLE "companies" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "name" text NOT NULL,
  "description" text,
  "status" text NOT NULL DEFAULT 'active',
  "pause_reason" text,
  "paused_at" timestamptz,
  "issue_prefix" text NOT NULL DEFAULT 'PAP',
  "issue_counter" integer NOT NULL DEFAULT 0,
  "budget_monthly_cents" integer NOT NULL DEFAULT 0,
  "spent_monthly_cents" integer NOT NULL DEFAULT 0,
  "require_board_approval_for_new_agents" boolean NOT NULL DEFAULT true,
  "brand_color" text,
  "created_at" timestamptz NOT NULL DEFAULT NOW(),
  "updated_at" timestamptz NOT NULL DEFAULT NOW(),
  "is_active" boolean DEFAULT true,
  "deleted_at" timestamptz
);
```

### Columns (REQUIRED for INSERT)
| Column | Type | Required | Default | Notes |
|--------|------|----------|---------|-------|
| id | uuid | YES | gen_random_uuid() | Primary key |
| name | text | YES | - | Company display name |
| description | text | NO | NULL | Optional description |
| status | text | YES | 'active' | 'active', 'paused', etc. |
| issue_prefix | text | YES | 'PAP' | 3-letter prefix |
| issue_counter | integer | YES | 0 | Auto-increment counter |
| budget_monthly_cents | integer | YES | 0 | Budget in cents |
| spent_monthly_cents | integer | YES | 0 | Spent amount in cents |
| require_board_approval_for_new_agents | boolean | YES | true | Approval required flag |
| created_at | timestamptz | YES | NOW() | Auto-generated |
| updated_at | timestamptz | YES | NOW() | Auto-generated |

### Optional Columns (can be NULL)
- `pause_reason`, `paused_at`, `brand_color`, `is_active`, `deleted_at`

---

## Agents Table

### PostgreSQL Schema
```sql
CREATE TABLE "agents" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "company_id" uuid NOT NULL REFERENCES "companies"("id"),
  "name" text NOT NULL,
  "role" text NOT NULL,
  "title" text,
  "status" text NOT NULL DEFAULT 'idle',
  "reports_to" uuid REFERENCES "agents"("id"),
  "capabilities" text,
  "adapter_type" text NOT NULL,
  "adapter_config" jsonb,
  "budget_monthly_cents" bigint NOT NULL DEFAULT 0,
  "spent_monthly_cents" bigint NOT NULL DEFAULT 0,
  "last_heartbeat_at" timestamptz,
  "metadata" jsonb,
  "created_at" timestamptz NOT NULL DEFAULT NOW(),
  "updated_at" timestamptz NOT NULL DEFAULT NOW(),
  "runtime_config" jsonb,
  "permissions" jsonb,
  "icon" text,
  "pause_reason" text,
  "paused_at" timestamptz,
  "model_config" jsonb,
  "device_config" jsonb,
  "deleted_at" timestamptz,
  "is_active" boolean NOT NULL DEFAULT true
);
```

### Columns (REQUIRED for INSERT)
| Column | Type | Required | Default | Notes |
|--------|------|----------|---------|-------|
| id | uuid | YES | gen_random_uuid() | Primary key |
| company_id | uuid | YES | - | FK to companies.id (MUST EXIST) |
| name | text | YES | - | Agent display name |
| role | text | YES | - | 'ceo', 'specialist', 'manager', etc. |
| status | text | YES | 'idle' | 'active', 'idle', 'paused', etc. |
| adapter_type | text | YES | - | 'http', 'openai', etc. |
| budget_monthly_cents | bigint | YES | 0 | Budget in cents |
| spent_monthly_cents | bigint | YES | 0 | Spent amount in cents |
| created_at | timestamptz | YES | NOW() | Auto-generated |
| updated_at | timestamptz | YES | NOW() | Auto-generated |
| is_active | boolean | YES | true | Active status |

### Optional Columns (can be NULL)
- `title`, `reports_to`, `capabilities`, `adapter_config`, `last_heartbeat_at`, `metadata`, `runtime_config`, `permissions`, `icon`, `pause_reason`, `paused_at`, `model_config`, `device_config`, `deleted_at`

---

## Agent API Keys Table

### PostgreSQL Schema
```sql
CREATE TABLE "agent_api_keys" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "agent_id" uuid NOT NULL REFERENCES "agents"("id"),
  "company_id" uuid NOT NULL REFERENCES "companies"("id"),
  "name" text NOT NULL,
  "key_hash" text NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT NOW(),
  "updated_at" timestamptz NOT NULL DEFAULT NOW(),
  "expires_at" timestamptz,
  "is_active" boolean NOT NULL DEFAULT true,
  "last_used_at" timestamptz,
  "usage_count" integer NOT NULL DEFAULT 0
);
```

### Columns (REQUIRED for INSERT)
| Column | Type | Required | Default | Notes |
|--------|------|----------|---------|-------|
| id | uuid | YES | gen_random_uuid() | Primary key |
| agent_id | uuid | YES | - | FK to agents.id (MUST EXIST) |
| company_id | uuid | YES | - | FK to companies.id (MUST EXIST) |
| name | text | YES | - | Key name/description |
| key_hash | text | YES | - | Hashed API key |
| created_at | timestamptz | YES | NOW() | Auto-generated |
| updated_at | timestamptz | YES | NOW() | Auto-generated |
| usage_count | integer | YES | 0 | Usage counter |

### Optional Columns (can be NULL)
- `expires_at`, `last_used_at`

---

## Goals Table

### PostgreSQL Schema
```sql
CREATE TABLE "goals" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "company_id" uuid NOT NULL REFERENCES "companies"("id"),
  "title" text NOT NULL,
  "description" text,
  "level" text NOT NULL DEFAULT 'task',
  "status" text NOT NULL DEFAULT 'planned',
  "parent_id" uuid REFERENCES "goals"("id"),
  "owner_agent_id" uuid REFERENCES "agents"("id"),
  "created_at" timestamptz NOT NULL DEFAULT NOW(),
  "updated_at" timestamptz NOT NULL DEFAULT NOW()
);
```

### Columns (REQUIRED for INSERT)
| Column | Type | Required | Default | Notes |
|--------|------|----------|---------|-------|
| id | uuid | YES | gen_random_uuid() | Primary key |
| company_id | uuid | YES | - | FK to companies.id (MUST EXIST) |
| title | text | YES | - | Goal title |
| level | text | YES | 'task' | 'company', 'team', 'task' |
| status | text | YES | 'planned' | 'planned', 'active', 'completed' |
| created_at | timestamptz | YES | NOW() | Auto-generated |
| updated_at | timestamptz | YES | NOW() | Auto-generated |

### Optional Columns (can be NULL)
- `description`, `parent_id`, `owner_agent_id`

---

## Projects Table

### PostgreSQL Schema
```sql
CREATE TABLE "projects" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "company_id" uuid NOT NULL REFERENCES "companies"("id"),
  "goal_id" uuid REFERENCES "goals"("id"),
  "lead_agent_id" uuid REFERENCES "agents"("id"),
  "name" text NOT NULL,
  "description" text,
  "status" text NOT NULL DEFAULT 'planning',
  "priority" text NOT NULL DEFAULT 'medium',
  "start_date" date,
  "end_date" date,
  "budget_cents" integer,
  "created_at" timestamptz NOT NULL DEFAULT NOW(),
  "updated_at" timestamptz NOT NULL DEFAULT NOW()
);
```

### Columns (REQUIRED for INSERT)
| Column | Type | Required | Default | Notes |
|--------|------|----------|---------|-------|
| id | uuid | YES | gen_random_uuid() | Primary key |
| company_id | uuid | YES | - | FK to companies.id (MUST EXIST) |
| name | text | YES | - | Project name |
| status | text | YES | 'planning' | 'planning', 'active', 'completed' |
| priority | text | YES | 'medium' | 'low', 'medium', 'high', 'critical' |
| created_at | timestamptz | YES | NOW() | Auto-generated |
| updated_at | timestamptz | YES | NOW() | Auto-generated |

### Optional Columns (can be NULL)
- `goal_id`, `lead_agent_id`, `description`, `start_date`, `end_date`, `budget_cents`

---

## Issues Table

### PostgreSQL Schema
```sql
CREATE TABLE "issues" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "company_id" uuid NOT NULL REFERENCES "companies"("id"),
  "project_id" uuid REFERENCES "projects"("id"),
  "goal_id" uuid REFERENCES "goals"("id"),
  "parent_id" uuid REFERENCES "issues"("id"),
  "assignee_agent_id" uuid REFERENCES "agents"("id"),
  "title" text NOT NULL,
  "description" text,
  "status" text NOT NULL DEFAULT 'backlog',
  "priority" text NOT NULL DEFAULT 'medium',
  "issue_number" integer NOT NULL,
  "estimated_hours" integer,
  "actual_hours" integer,
  "due_date" date,
  "created_at" timestamptz NOT NULL DEFAULT NOW(),
  "updated_at" timestamptz NOT NULL DEFAULT NOW()
);
```

### Columns (REQUIRED for INSERT)
| Column | Type | Required | Default | Notes |
|--------|------|----------|---------|-------|
| id | uuid | YES | gen_random_uuid() | Primary key |
| company_id | uuid | YES | - | FK to companies.id (MUST EXIST) |
| title | text | YES | - | Issue title |
| status | text | YES | 'backlog' | 'backlog', 'todo', 'in_progress', 'in_review', 'done' |
| priority | text | YES | 'medium' | 'low', 'medium', 'high', 'critical' |
| issue_number | integer | YES | - | Sequential issue number |
| created_at | timestamptz | YES | NOW() | Auto-generated |
| updated_at | timestamptz | YES | NOW() | Auto-generated |

### Optional Columns (can be NULL)
- `project_id`, `goal_id`, `parent_id`, `assignee_agent_id`, `description`, `estimated_hours`, `actual_hours`, `due_date`

---

## Common SQL Errors & Solutions

### Error 1: null value in column "company_id" violates not-null constraint
```
ERROR: 23502: null value in column "company_id" of relation "agents" violates not-null constraint
```
**Cause:** Company doesn't exist in database
**Solution:** Ensure company exists before inserting agents
```sql
-- Check if company exists
SELECT id, name FROM companies WHERE name = 'CompanyName';

-- If not exists, create it first
INSERT INTO companies (id, name, issue_prefix, issue_counter, budget_monthly_cents, spent_monthly_cents, require_board_approval_for_new_agents, created_at, updated_at)
VALUES ('uuid-here', 'CompanyName', 'PRE', 0, 0, 0, true, NOW(), NOW());
```

### Error 2: VALUES lists must all be the same length
```
ERROR: 42601: VALUES lists must all be the same length
```
**Cause:** Inconsistent column count in INSERT VALUES
**Solution:** Ensure all rows have same number of values as columns specified
```sql
-- WRONG - missing values in some rows
INSERT INTO agents (id, company_id, name, role, status, adapter_type, budget_monthly_cents, spent_monthly_cents, created_at, updated_at, is_active)
VALUES
('id1', 'comp1', 'Agent1', 'specialist', 'active', 'http', 0, 0, NOW(), NOW(), true),
('id2', 'comp1', 'Agent2', 'specialist', 'active', 'http', 0, 0, NOW(), NOW()); -- Missing is_active

-- CORRECT - all rows have same column count
INSERT INTO agents (id, company_id, name, role, status, adapter_type, budget_monthly_cents, spent_monthly_cents, created_at, updated_at, is_active)
VALUES
('id1', 'comp1', 'Agent1', 'specialist', 'active', 'http', 0, 0, NOW(), NOW(), true),
('id2', 'comp1', 'Agent2', 'specialist', 'active', 'http', 0, 0, NOW(), NOW(), true);
```

### Error 3: insert or update on table violates foreign key constraint
```
ERROR: 23503: insert or update on table violates foreign key constraint
```
**Cause:** Referenced record doesn't exist
**Solution:** Insert parent records first, or use subqueries that handle NULL cases
```sql
-- SAFE: Use subquery that returns NULL if not found
INSERT INTO agents (company_id, name, ...)
SELECT
    CASE WHEN c.id IS NOT NULL THEN c.id ELSE NULL END,
    'Agent Name', ...
FROM (SELECT 'CompanyName' as name) target
LEFT JOIN companies c ON c.name = target.name;
```

---

## Safe SQL Patterns

### 1. Company-Safe Agent Insert
```sql
-- Insert agent only if company exists
INSERT INTO agents (
    id, company_id, name, role, status, adapter_type,
    budget_monthly_cents, spent_monthly_cents, created_at, updated_at, is_active
)
SELECT
    'agent-uuid',
    c.id,
    'Agent Name',
    'specialist',
    'active',
    'http',
    0, 0, NOW(), NOW(), true
FROM companies c
WHERE c.name = 'CompanyName'
  AND c.id IS NOT NULL; -- Only insert if company exists
```

### 2. Safe API Key Insert
```sql
-- Insert API key only if agent exists
INSERT INTO agent_api_keys (
    id, agent_id, company_id, name, key_hash, created_at, updated_at, usage_count
)
SELECT
    gen_random_uuid(),
    a.id,
    a.company_id,
    'Primary Key',
    encode(sha256(random()::text::bytea), 'hex'),
    NOW(), NOW(), 0
FROM agents a
WHERE a.name = 'Agent Name'
  AND a.company_id = (SELECT id FROM companies WHERE name = 'CompanyName' LIMIT 1);
```

### 3. Pre-Flight Checks
```sql
-- Always run these before executing scripts
SELECT '=== COMPANIES CHECK ===' as check_type;
SELECT id, name, status FROM companies WHERE name IN ('Company1', 'Company2');

SELECT '=== AGENTS CHECK ===' as check_type;
SELECT a.name, c.name as company, a.status
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name IN ('Company1', 'Company2');

SELECT '=== API KEYS CHECK ===' as check_type;
SELECT COUNT(*) as total_keys, COUNT(DISTINCT agent_id) as agents_with_keys
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
JOIN companies c ON a.company_id = c.id
WHERE c.name IN ('Company1', 'Company2');
```

---

## Quick Reference: Required Columns by Table

### Companies (10 required)
```sql
INSERT INTO companies (
    id, name, status, issue_prefix, issue_counter,
    budget_monthly_cents, spent_monthly_cents, require_board_approval_for_new_agents,
    created_at, updated_at
) VALUES (...)
```

### Agents (11 required)
```sql
INSERT INTO agents (
    id, company_id, name, role, status, adapter_type,
    budget_monthly_cents, spent_monthly_cents, created_at, updated_at, is_active
) VALUES (...)
```

### Agent API Keys (8 required)
```sql
INSERT INTO agent_api_keys (
    id, agent_id, company_id, name, key_hash, created_at, updated_at, usage_count
) VALUES (...)
```

### Goals (7 required)
```sql
INSERT INTO goals (
    id, company_id, title, level, status, created_at, updated_at
) VALUES (...)
```

### Projects (7 required)
```sql
INSERT INTO projects (
    id, company_id, name, status, priority, created_at, updated_at
) VALUES (...)
```

### Issues (8 required)
```sql
INSERT INTO issues (
    id, company_id, title, status, priority, issue_number, created_at, updated_at
) VALUES (...)
```

---

**Last Updated:** 2026-04-12
**Version:** 1.0.0
**Purpose:** Eliminate SQL constraint violations through comprehensive schema reference
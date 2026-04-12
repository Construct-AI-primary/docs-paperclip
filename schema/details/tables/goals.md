# Goals Table

The `goals` table stores company goals and objectives that drive projects and issues.

## Schema

```sql
CREATE TABLE "goals" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    "company_id" uuid NOT NULL REFERENCES "public"."companies"("id"),
    "title" text NOT NULL,
    "description" text,
    "level" text NOT NULL DEFAULT 'task',
    "status" text NOT NULL DEFAULT 'planned',
    "parent_id" uuid REFERENCES "public"."goals"("id"),
    "owner_agent_id" uuid REFERENCES "public"."agents"("id"),
    "created_at" timestamp with time zone NOT NULL DEFAULT now(),
    "updated_at" timestamp with time zone NOT NULL DEFAULT now()
);
```

## Columns

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `id` | uuid | NO | gen_random_uuid() | Primary key |
| `company_id` | uuid | NO | - | **FK to companies.id** (required) |
| `title` | text | NO | - | Goal title (required) |
| `description` | text | YES | - | Goal description |
| `level` | text | NO | 'task' | Goal level: 'company', 'team', 'task' |
| `status` | text | NO | 'planned' | Status: 'planned', 'active', 'completed' |
| `parent_id` | uuid | YES | - | FK to goals.id (self-reference for hierarchy) |
| `owner_agent_id` | uuid | YES | - | FK to agents.id (optional owner) |
| `created_at` | timestamp | NO | now() | Creation timestamp |
| `updated_at` | timestamp | NO | now() | Last update timestamp |

## Indexes

- `goals_company_idx` on `company_id`

## Foreign Key References

**References:**
- `company_id` → `companies.id` (NOT NULL, required)
- `parent_id` → `goals.id` (nullable, self-reference for hierarchy)
- `owner_agent_id` → `agents.id` (nullable)

**Referenced By:**
- `projects.goal_id` (nullable)
- `issues.goal_id` (nullable)
- `cost_events.goal_id` (nullable)
- `finance_events.goal_id` (nullable)
- `project_goals.goal_id` (NOT NULL)

## Goal Levels

| Level | Description |
|-------|-------------|
| `company` | Top-level company goal (one per company typically) |
| `team` | Team-level objective supporting company goal |
| `task` | Individual task-level goal |

## Goal Status

| Status | Description |
|--------|-------------|
| `planned` | Goal is planned but not yet active |
| `active` | Goal is currently being pursued |
| `completed` | Goal has been completed |

## Key Notes

⚠️ **CRITICAL:** `company_id` is NOT NULL - the company must exist before inserting goals!

## Example Usage

```sql
-- Find all goals for a company
SELECT g.title, g.level, g.status, g.description
FROM goals g
JOIN companies c ON g.company_id = c.id
WHERE c.name = 'ContentForge AI'
ORDER BY g.level, g.title;

-- Insert goal for a company (using SELECT-based insert)
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT 
    c.id,
    'Revolutionize Content Creation',
    'Provide AI-powered content automation',
    'company',
    'active',
    NOW(),
    NOW()
FROM companies c
WHERE c.name = 'ContentForge AI'
ON CONFLICT DO NOTHING;

-- Get goals with their projects
SELECT 
    g.title as goal,
    p.name as project,
    p.status as project_status
FROM goals g
LEFT JOIN projects p ON g.id = p.goal_id
WHERE g.company_id = (SELECT id FROM companies WHERE name = 'ContentForge AI')
ORDER BY g.title;

-- Count goals by level and status
SELECT 
    level,
    status,
    COUNT(*) as count
FROM goals
WHERE company_id = (SELECT id FROM companies WHERE name = 'ContentForge AI')
GROUP BY level, status
ORDER BY level, status;
```

## Related

- [companies.md](./companies.md) - Parent company entity
- [projects.md](./projects.md) - Projects linked to goals
- [issues.md](./issues.md) - Issues linked to goals
- [agents.md](./agents.md) - Agent owners

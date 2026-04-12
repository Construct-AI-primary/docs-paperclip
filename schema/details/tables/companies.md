# Companies Table

The `companies` table is the root entity that owns all other resources in Paperclip.

## Schema

```sql
CREATE TABLE "companies" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "status" text NOT NULL DEFAULT 'active',
    "pause_reason" text,
    "paused_at" timestamp with time zone,
    "issue_prefix" text NOT NULL DEFAULT 'PAP',
    "issue_counter" integer NOT NULL DEFAULT 0,
    "budget_monthly_cents" integer NOT NULL DEFAULT 0,
    "spent_monthly_cents" integer NOT NULL DEFAULT 0,
    "require_board_approval_for_new_agents" boolean NOT NULL DEFAULT true,
    "brand_color" text,
    "created_at" timestamp with time zone NOT NULL DEFAULT now(),
    "updated_at" timestamp with time zone NOT NULL DEFAULT now()
);
```

## Columns

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `id` | uuid | NO | gen_random_uuid() | Primary key |
| `name` | text | NO | - | **Company display name** (e.g., "ContentForge AI") |
| `description` | text | YES | - | Company description |
| `status` | text | NO | 'active' | Status: 'active', 'paused' |
| `pause_reason` | text | YES | - | Reason for pause if status='paused' |
| `paused_at` | timestamp | YES | - | When company was paused |
| `issue_prefix` | text | NO | 'PAP' | 3-letter issue prefix code (e.g., "CONTENT") |
| `issue_counter` | integer | NO | 0 | Auto-incrementing issue number |
| `budget_monthly_cents` | integer | NO | 0 | Monthly budget in cents |
| `spent_monthly_cents` | integer | NO | 0 | Monthly spending in cents |
| `require_board_approval_for_new_agents` | boolean | NO | true | Require board approval for new agents |
| `brand_color` | text | YES | - | Brand color hex code |
| `created_at` | timestamp | NO | now() | Creation timestamp |
| `updated_at` | timestamp | NO | now() | Last update timestamp |

## Indexes

- `companies_issue_prefix_idx` UNIQUE on `issue_prefix`

## Foreign Key References

This table is referenced by:
- `agents.company_id` (NOT NULL)
- `goals.company_id` (NOT NULL)
- `projects.company_id` (NOT NULL)
- `issues.company_id` (NOT NULL)
- And 30+ other tables

## Key Notes

⚠️ **IMPORTANT:** The database uses `name` column, NOT `slug`:
```sql
-- WRONG - will fail with "column slug does not exist"
SELECT * FROM companies WHERE slug = 'contentforge-ai';

-- CORRECT - use name column
SELECT * FROM companies WHERE name = 'ContentForge AI';
```

## Example Usage

```sql
-- Find company by name
SELECT id, name, issue_prefix FROM companies WHERE name = 'ContentForge AI';

-- Insert goals for a company (using SELECT-based insert)
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT 
    c.id,
    'Revolutionize Content Creation',
    'Description here',
    'company',
    'active',
    NOW(),
    NOW()
FROM companies c
WHERE c.name = 'ContentForge AI'
ON CONFLICT DO NOTHING;

-- Check company budget status
SELECT name, budget_monthly_cents, spent_monthly_cents,
       (spent_monthly_cents::float / NULLIF(budget_monthly_cents, 0) * 100) as percent_used
FROM companies;
```

## Related

- [agents.md](./agents.md) - Agents belonging to companies
- [goals.md](./goals.md) - Goals owned by companies
- [projects.md](./projects.md) - Projects owned by companies
- [issues.md](./issues.md) - Issues owned by companies

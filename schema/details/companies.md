# companies Table

AI agent companies/organizations in the Paperclip ecosystem.

## Actual Supabase Schema

```sql
CREATE TABLE public.companies (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text NULL,
  status text NOT NULL DEFAULT 'active'::text,
  budget_monthly_cents integer NOT NULL DEFAULT 0,
  spent_monthly_cents integer NOT NULL DEFAULT 0,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  issue_prefix text NOT NULL DEFAULT 'PAP'::text,
  issue_counter integer NOT NULL DEFAULT 0,
  require_board_approval_for_new_agents boolean NOT NULL DEFAULT true,
  brand_color text NULL,
  pause_reason text NULL,
  paused_at timestamp with time zone NULL,
  deleted_at timestamp without time zone NULL,
  is_active boolean NULL DEFAULT true,
  CONSTRAINT companies_pkey PRIMARY KEY (id)
);

CREATE UNIQUE INDEX companies_issue_prefix_idx ON public.companies USING btree (issue_prefix);
CREATE INDEX idx_companies_deleted_at ON public.companies USING btree (deleted_at);
CREATE INDEX idx_companies_is_active ON public.companies USING btree (is_active);
```

## Columns

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK, DEFAULT gen_random_uuid() | Unique company identifier |
| name | text | NOT NULL | Company display name |
| description | text | NULL | Company description |
| status | text | NOT NULL, DEFAULT 'active' | active, paused, archived |
| budget_monthly_cents | integer | NOT NULL, DEFAULT 0 | Monthly budget in cents |
| spent_monthly_cents | integer | NOT NULL, DEFAULT 0 | Current month spend |
| created_at | timestamptz | NOT NULL, DEFAULT NOW() | Creation timestamp |
| updated_at | timestamptz | NOT NULL, DEFAULT NOW() | Last update timestamp |
| issue_prefix | text | NOT NULL, UNIQUE | Issue ID prefix (e.g., "LFA", "DEV") |
| issue_counter | integer | NOT NULL, DEFAULT 0 | Auto-incrementing counter for issues |
| require_board_approval_for_new_agents | boolean | NOT NULL, DEFAULT true | Agent creation approval gate |
| brand_color | text | NULL | Hex color code (e.g., "#9333ea") |
| pause_reason | text | NULL | Why company was paused |
| paused_at | timestamptz | NULL | When paused |
| deleted_at | timestamp | NULL | Soft delete timestamp |
| is_active | boolean | DEFAULT true | Active flag |

## Known Companies

| Company | Prefix | ID |
|---------|--------|-----|
| PaperclipForge AI | PFA | 550e8400-e29b-41d4-a716-446655440000 |
| DevForge AI | DEV | 550e8400-e29b-41d4-a716-446655440001 |
| InfraForge AI | INF | 550e8400-e29b-41d4-a716-446655440002 |
| KnowledgeForge AI | KFA | 550e8400-e29b-41d4-a716-446655440003 |
| QualityForge AI | QFA | 550e8400-e29b-41d4-a716-446655440004 |
| PromptForge AI | PFG | 550e8400-e29b-41d4-a716-446655440005 |
| DomainForge AI | DFA | 550e8400-e29b-41d4-a716-446655440006 |
| ContentForge AI | CFA | 550e8400-e29b-41d4-a716-446655440008 |
| MobileForge AI | MFA | 550e8400-e29b-41d4-a716-446655440009 |
| ExecForge AI | EXF | 550e8400-e29b-41d4-a716-446655440010 |
| SaaSForge AI | SAS | 550e8400-e29b-41d4-a716-446655440011 |
| VoiceForge AI | VFA | 550e8400-e29b-41d4-a716-446655440012 |
| LearningForge AI | LFA | 550e8400-e29b-41d4-a716-446655440013 |

## Usage

```sql
-- Get all active companies
SELECT name, issue_prefix, budget_monthly_cents FROM companies WHERE is_active = true;

-- Get company with agent count
SELECT c.*, COUNT(a.id) as agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
WHERE c.id = '550e8400-e29b-41d4-a716-446655440013'
GROUP BY c.id;

-- Check budget status
SELECT name, budget_monthly_cents, spent_monthly_cents,
       (budget_monthly_cents - spent_monthly_cents) as remaining
FROM companies;

-- Insert Learning Forge AI
INSERT INTO companies (
  id, name, description, status, budget_monthly_cents, spent_monthly_cents,
  created_at, updated_at, issue_prefix, issue_counter,
  require_board_approval_for_new_agents, brand_color, is_active
) VALUES (
  '550e8400-e29b-41d4-a716-446655440013',
  'Learning Forge AI',
  'AI Learning & Knowledge Management company specializing in construction domain learning',
  'active', 0, 0, NOW(), NOW(), 'LFA', 0, true, '#9333ea', true
);
```

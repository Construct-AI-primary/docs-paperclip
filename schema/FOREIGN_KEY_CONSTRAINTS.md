# Paperclip Database Foreign Key Constraints Reference

This document documents all foreign key constraints across Paperclip tables to ensure SQL scripts properly handle dependencies before inserting related data.

## CRITICAL FINDING: Schema vs Documentation Mismatch

**⚠️ IMPORTANT DISCOVERY:** The Paperclip codebase uses different identifiers in documentation vs. actual database schema:

| Documentation/URL Slug | Database Column | Example Value |
|------------------------|-----------------|---------------|
| `slug` (from COMPANY.md) | **NOT IN DATABASE** | N/A |
| `name` (from companies table) | **USE THIS** | "ContentForge AI" |
| `issue_prefix` (from companies table) | Available | "CONTENT" |

**This mismatch causes SQL errors when using `slug` - the database doesn't have this column!**

## Correct Company Identification

To identify companies in SQL, use the `name` column:

```sql
-- WRONG - will fail with "column slug does not exist"
SELECT * FROM companies WHERE slug = 'contentforge-ai';

-- CORRECT - use name column
SELECT * FROM companies WHERE name = 'ContentForge AI';
```

## Companies Table Schema (ACTUAL)

From `packages/db/src/schema/companies.ts`:

```typescript
export const companies = pgTable(
  "companies",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    name: text("name").notNull(),           // <-- Use this for company identification
    description: text("description"),
    status: text("status").notNull().default("active"),
    pauseReason: text("pause_reason"),
    pausedAt: timestamp("paused_at", { withTimezone: true }),
    issuePrefix: text("issue_prefix").notNull().default("PAP"),  // <-- 3-letter code
    issueCounter: integer("issue_counter").notNull().default(0),
    budgetMonthlyCents: integer("budget_monthly_cents").notNull().default(0),
    spentMonthlyCents: integer("spent_monthly_cents").notNull().default(0),
    requireBoardApprovalForNewAgents: boolean("require_board_approval_for_new_agents").notNull().default(true),
    brandColor: text("brand_color"),
    createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (table) => ({
    issuePrefixUniqueIdx: uniqueIndex("companies_issue_prefix_idx").on(table.issuePrefix),
  }),
);
```

### Companies Table Columns:
- `id` - UUID primary key
- `name` - Company display name (e.g., "ContentForge AI") 
- `description` - Company description
- `status` - "active", "paused", etc.
- `issue_prefix` - 3-letter issue prefix code
- Plus timestamps and budget fields

## Critical Rule: Company ID Must Exist First

**⚠️ IMPORTANT:** Before inserting any data into related tables, the corresponding `company_id` MUST already exist in the `companies` table. Foreign key constraints will fail if the company doesn't exist.

## Goals Table Schema (ACTUAL)

From `packages/db/src/schema/goals.ts`:

```typescript
export const goals = pgTable(
  "goals",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    companyId: uuid("company_id").notNull().references(() => companies.id),
    title: text("title").notNull(),
    description: text("description"),
    level: text("level").notNull().default("task"),  // "company", "team", "task"
    status: text("status").notNull().default("planned"),  // "planned", "active", "completed"
    parentId: uuid("parent_id").references((): AnyPgColumn => goals.id),
    ownerAgentId: uuid("owner_agent_id").references(() => agents.id),
    createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (table) => ({
    companyIdx: index("goals_company_idx").on(table.companyId),
  }),
);
```

### Goals Table Columns:
- `id` - UUID primary key
- `company_id` - FK to companies.id (NOT NULL)
- `title` - Goal title (NOT NULL)
- `description` - Goal description
- `level` - "company", "team", or "task"
- `status` - "planned", "active", "completed"
- `parent_id` - FK to goals.id (for hierarchy)
- `owner_agent_id` - FK to agents.id (optional owner)

## Complete Foreign Key Dependency Chain

| Table | Foreign Key | References | Required | Insertion Order |
|-------|-------------|------------|----------|-----------------|
| **goals** | company_id | companies.id | YES | 2 |
| | parent_id | goals.id | NO | 3 |
| | owner_agent_id | agents.id | NO | 3 |
| **projects** | company_id | companies.id | YES | 2 |
| | goal_id | goals.id | NO | 3 |
| | lead_agent_id | agents.id | NO | 3 |
| **issues** | company_id | companies.id | YES | 2 |
| | project_id | projects.id | NO | 4 |
| | goal_id | goals.id | NO | 3 |
| | parent_id | issues.id | NO | 5 |
| | assignee_agent_id | agents.id | NO | 3 |

## Insertion Order Summary

| Order | Table | Dependencies |
|-------|-------|--------------|
| 1 | auth_users | None (external auth) |
| 2 | **companies** | None |
| 3 | **goals** | companies, agents (optional) |
| 4 | **projects** | companies, goals (optional) |
| 5 | **issues** | companies, projects (optional), goals (optional) |

## Safe Script Template (CORRECTED)

When creating SQL scripts, always use the `name` column and SELECT-based inserts:

```sql
-- CORRECT: Use name column and SELECT-based insert
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT 
    c.id,
    'Your Goal Title',
    'Your Goal Description',
    'company',
    'active',
    NOW(),
    NOW()
FROM companies c
WHERE c.name = 'ContentForge AI'  -- Use name, NOT slug
ON CONFLICT DO NOTHING;

-- Pre-flight check
SELECT '=== Pre-Flight Check ===' as status;
SELECT id, name, issue_prefix, status FROM companies 
WHERE name IN ('ContentForge AI', 'ExecForge AI', 'LearningForge AI')
ORDER BY name;
```

## Common Errors and Solutions

### Error 1: "column slug does not exist"
```
ERROR: 42703: column "slug" does not exist
```
**Solution:** The database uses `name` column, not `slug`. Update your query.

### Error 2: Foreign Key Violation
```
ERROR: 23503: insert or update on table "goals" violates foreign key constraint
DETAIL: Key (company_id)=(UUID) is not present in table "companies".
```
**Solution:** The company doesn't exist yet. Either:
1. Insert the company first
2. Use the SELECT-based INSERT pattern
3. Only run the script after companies are confirmed to exist

## Validation Queries

Before running any insertion script, validate dependencies:

```sql
-- Check all required companies exist
SELECT 'Companies Check' as check_type;
SELECT id, name, issue_prefix, status FROM companies 
WHERE name IN ('ContentForge AI', 'ExecForge AI', 'LearningForge AI', 
                'PaperclipForge AI', 'SaaSForge AI', 'VoiceForge AI')
ORDER BY name;

-- Expected: One row per company if they exist
```

---

**Last Updated:** 2026-04-12
**Version:** 2.0.0
**Key Fix:** Changed from `slug` to `name` column for company identification

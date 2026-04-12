# agents Table

Individual AI agents belonging to companies.

## Drizzle Schema

```typescript
export const agents = pgTable(
  "agents",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    companyId: uuid("company_id").notNull().references(() => companies.id),
    name: text("name").notNull(),
    role: text("role").notNull(),
    title: text("title"),
    status: text("status").notNull().default("idle"),
    reportsTo: uuid("reports_to").references(() => agents.id),
    capabilities: text("capabilities"),
    adapterType: text("adapter_type").notNull(),
    adapterConfig: jsonb("adapter_config").$type<Record<string, unknown>>(),
    budgetMonthlyCents: bigint("budget_monthly_cents", { mode: "number" }).notNull().default(0),
    spentMonthlyCents: bigint("spent_monthly_cents", { mode: "number" }).notNull().default(0),
    lastHeartbeatAt: timestamp("last_heartbeat_at", { withTimezone: true }),
    metadata: jsonb("metadata").$type<Record<string, unknown>>(),
    createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
    runtimeConfig: jsonb("runtime_config").$type<Record<string, unknown>>(),
    permissions: jsonb("permissions").$type<Record<string, unknown>>(),
    icon: text("icon"),
    pauseReason: text("pause_reason"),
    pausedAt: timestamp("paused_at", { withTimezone: true }),
    modelConfig: jsonb("model_config").$type<Record<string, unknown>>(),
    deviceConfig: jsonb("device_config").$type<Record<string, unknown>>(),
    deletedAt: timestamp("deleted_at", { withTimezone: true }),
    isActive: boolean("is_active").notNull().default(true),
  },
  ...
);
```

## PostgreSQL

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

## Columns

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK | Unique agent identifier |
| company_id | uuid | NOT NULL, FK→companies | Parent company |
| name | text | NOT NULL | Agent display name |
| role | text | NOT NULL | ceo, division-lead, specialist, manager |
| title | text | NULL | Job title |
| status | text | NOT NULL, DEFAULT 'idle' | idle, busy, paused, error |
| reports_to | uuid | NULL, FK→agents | Manager agent |
| capabilities | text | NULL | Capability description |
| adapter_type | text | NOT NULL | http, hermes_local, claude-local, etc. |
| adapter_config | jsonb | NULL | Adapter-specific config |
| budget_monthly_cents | bigint | NOT NULL, DEFAULT 0 | Monthly budget |
| spent_monthly_cents | bigint | NOT NULL, DEFAULT 0 | Current spend |
| last_heartbeat_at | timestamptz | NULL | Last activity check |
| metadata | jsonb | NULL | Additional data |
| runtime_config | jsonb | NULL | Runtime settings |
| permissions | jsonb | NULL | Agent permissions |
| icon | text | NULL | Emoji icon |
| pause_reason | text | NULL | Why agent was paused |
| paused_at | timestamptz | NULL | When paused |
| model_config | jsonb | NULL | Model configuration |
| device_config | jsonb | NULL | Device settings |
| deleted_at | timestamptz | NULL | Soft delete timestamp |
| is_active | boolean | NOT NULL, DEFAULT true | Active flag |

## Agent Roles

| Role | Description |
|------|-------------|
| `ceo` | Chief Executive Officer - top level |
| `division-lead` | Division manager |
| `manager` | Team manager |
| `specialist` | Individual contributor |

## Agent Statuses

| Status | Description |
|--------|-------------|
| `idle` | Ready to accept tasks |
| `busy` | Currently working |
| `paused` | Manually paused |
| `error` | Error state |

## Usage

```sql
-- Get all active agents for a company
SELECT name, role, status FROM agents 
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013' 
AND is_active = true;

-- Get agent hierarchy (org chart)
WITH RECURSIVE hierarchy AS (
  SELECT id, name, role, reports_to, 0 as level
  FROM agents WHERE reports_to IS NULL
  UNION ALL
  SELECT a.id, a.name, a.role, a.reports_to, h.level + 1
  FROM agents a
  JOIN hierarchy h ON a.reports_to = h.id
)
SELECT * FROM hierarchy ORDER BY level;

-- Get agents with their company
SELECT a.name, c.name as company, a.role
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.is_active = true;
```

## JSONB Fields

### adapter_config Example

```json
{
  "url": "https://hermes-agent/webhook",
  "model": "openrouter/deepseek/deepseek-chat-v3-0324",
  "maxIterations": 50,
  "persistSession": true
}
```

### permissions Example

```json
{
  "canCreateAgents": true,
  "canApproveIssues": false,
  "canManageBudget": false
}
```

### metadata Example

```json
{
  "team": "Learning Forge AI",
  "division": "learning-curriculum",
  "source": "documentation"
}
```

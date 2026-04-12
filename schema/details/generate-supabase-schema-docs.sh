#!/bin/bash
# Generate individual schema documentation files from Drizzle migrations
# Output: docs-paperclip/schema/details/

OUTPUT_DIR="$(cd "$(dirname "$0")" && pwd)"
TABLES_DIR="${OUTPUT_DIR}/tables"
mkdir -p "$TABLES_DIR"

# Parse drizzle-schema-reference.ts to extract individual table schemas
INPUT_FILE="${OUTPUT_DIR}/../drizzle-schema-reference.ts"

echo "📋 Extracting schema from ${INPUT_FILE}..."

# Extract each table section
awk '/^--- / { filename=$2; sub(/\.ts ---$/,""); gsub(/[^a-z_]/,"_"); outfile="'"$TABLES_DIR"/"filename".md" }
     /^--- / { next }
     outfile { print > outfile }' "$INPUT_FILE"

# Generate index
echo "# Supabase Database Schema Tables" > "${OUTPUT_DIR}/README.md"
echo "" >> "${OUTPUT_DIR}/README.md"
echo "Generated from: drizzle-schema-reference.ts" >> "${OUTPUT_DIR}/README.md"
echo "" >> "${OUTPUT_DIR}/README.md"
echo "## Tables" >> "${OUTPUT_DIR}/README.md"
echo "" >> "${OUTPUT_DIR}/README.md"

for f in "$TABLES_DIR"/*.md; do
    name=$(basename "$f" .md)
    if [[ "$name" != "index" ]]; then
        echo "- [\`$name\`](/schema/details/tables/$name.md)" >> "${OUTPUT_DIR}/README.md"
    fi
done

# Generate agent_api_keys reference
cat > "${OUTPUT_DIR}/agent_api_keys.md" << 'EOF'
# agent_api_keys Table

## Drizzle Schema Definition

```typescript
export const agentApiKeys = pgTable(
  "agent_api_keys",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    agentId: uuid("agent_id").notNull().references(() => agents.id),
    companyId: uuid("company_id").notNull().references(() => companies.id),
    name: text("name").notNull(),
    keyHash: text("key_hash").notNull(),
    lastUsedAt: timestamp("last_used_at", { withTimezone: true }),
    revokedAt: timestamp("revoked_at", { withTimezone: true }),
    createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (table) => ({
    keyHashIdx: index("agent_api_keys_key_hash_idx").on(table.keyHash),
    companyAgentIdx: index("agent_api_keys_company_agent_idx").on(table.companyId, table.agentId),
  }),
);
```

## PostgreSQL Equivalent

```sql
CREATE TABLE "agent_api_keys" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "agent_id" uuid NOT NULL REFERENCES "agents"("id"),
  "company_id" uuid NOT NULL REFERENCES "companies"("id"),
  "name" text NOT NULL,
  "key_hash" text NOT NULL,
  "last_used_at" timestamptz,
  "revoked_at" timestamptz,
  "created_at" timestamptz NOT NULL DEFAULT NOW()
);

CREATE INDEX "agent_api_keys_key_hash_idx" ON "agent_api_keys" USING btree ("key_hash");
CREATE INDEX "agent_api_keys_company_agent_idx" ON "agent_api_keys" USING btree ("company_id", "agent_id");
```

## Columns

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier |
| agent_id | uuid | NOT NULL, REFERENCES agents(id) | Associated agent |
| company_id | uuid | NOT NULL, REFERENCES companies(id) | Associated company |
| name | text | NOT NULL | Human-readable key name |
| key_hash | text | NOT NULL | Hashed API key value |
| last_used_at | timestamptz | NULL | Last time key was used |
| revoked_at | timestamptz | NULL | When key was revoked |
| created_at | timestamptz | NOT NULL, DEFAULT NOW() | Creation timestamp |

## Indexes

1. `agent_api_keys_key_hash_idx` - For fast key lookups
2. `agent_api_keys_company_agent_idx` - For company/agent queries

## Usage Notes

- Keys are hashed at rest (key_hash stores hash, not plaintext)
- The `last_used_at` field tracks key activity for monitoring
- `revoked_at` indicates if key is no longer valid
EOF

# Generate companies reference  
cat > "${OUTPUT_DIR}/companies.md" << 'EOF'
# companies Table

## Drizzle Schema Definition

```typescript
export const companies = pgTable(
  "companies",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    name: text("name").notNull(),
    description: text("description"),
    status: text("status").notNull().default("active"),
    issuePrefix: text("issue_prefix").notNull().unique(),
    budgetMonthlyCents: bigint("budget_monthly_cents", { mode: "number" }).notNull().default(0),
    spentMonthlyCents: bigint("spent_monthly_cents", { mode: "number" }).notNull().default(0),
    requireBoardApprovalForNewAgents: boolean("require_board_approval_for_new_agents").notNull().default(false),
    brandColor: text("brand_color"),
    issueCounter: integer("issue_counter").notNull().default(0),
    createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  ...
);
```

## PostgreSQL Equivalent

```sql
CREATE TABLE "companies" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "name" text NOT NULL,
  "description" text,
  "status" text NOT NULL DEFAULT 'active',
  "issue_prefix" text NOT NULL UNIQUE,
  "issue_counter" integer NOT NULL DEFAULT 0,
  "budget_monthly_cents" bigint NOT NULL DEFAULT 0,
  "spent_monthly_cents" bigint NOT NULL DEFAULT 0,
  "require_board_approval_for_new_agents" boolean NOT NULL DEFAULT false,
  "brand_color" text,
  "created_at" timestamptz NOT NULL DEFAULT NOW(),
  "updated_at" timestamptz NOT NULL DEFAULT NOW()
);
```

## Columns

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY | Unique identifier |
| name | text | NOT NULL | Company name |
| description | text | NULL | Company description |
| status | text | NOT NULL, DEFAULT 'active' | Company status |
| issue_prefix | text | NOT NULL, UNIQUE | Issue ID prefix (e.g., "LFA") |
| issue_counter | integer | NOT NULL, DEFAULT 0 | Auto-incrementing issue counter |
| budget_monthly_cents | bigint | NOT NULL, DEFAULT 0 | Monthly budget in cents |
| spent_monthly_cents | bigint | NOT NULL, DEFAULT 0 | Monthly spent in cents |
| require_board_approval_for_new_agents | boolean | NOT NULL, DEFAULT false | Approval requirement |
| brand_color | text | NULL | Hex color code for UI |
| created_at | timestamptz | NOT NULL, DEFAULT NOW() | Creation timestamp |
| updated_at | timestamptz | NOT NULL, DEFAULT NOW() | Last update timestamp |
EOF

# Generate agents reference
cat > "${OUTPUT_DIR}/agents.md" << 'EOF'
# agents Table

## Drizzle Schema Definition

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

## PostgreSQL Equivalent

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
| id | uuid | PRIMARY KEY | Unique identifier |
| company_id | uuid | NOT NULL, FK→companies | Parent company |
| name | text | NOT NULL | Agent display name |
| role | text | NOT NULL | Agent role (ceo, specialist, etc.) |
| title | text | NULL | Job title |
| status | text | NOT NULL, DEFAULT 'idle' | Current status |
| reports_to | uuid | NULL, FK→agents | Manager agent |
| capabilities | text | NULL | Capability description |
| adapter_type | text | NOT NULL | Adapter type (http, hermes_local, etc.) |
| adapter_config | jsonb | NULL | Adapter configuration |
| budget_monthly_cents | bigint | NOT NULL, DEFAULT 0 | Monthly budget |
| spent_monthly_cents | bigint | NOT NULL, DEFAULT 0 | Monthly spent |
| last_heartbeat_at | timestamptz | NULL | Last activity |
| metadata | jsonb | NULL | Additional metadata |
| runtime_config | jsonb | NULL | Runtime configuration |
| permissions | jsonb | NULL | Agent permissions |
| icon | text | NULL | Emoji icon |
| is_active | boolean | NOT NULL, DEFAULT true | Soft delete flag |
EOF

echo ""
echo "✅ Schema documentation generated in: ${OUTPUT_DIR}/"
echo "   - README.md (index)"
echo "   - agent_api_keys.md"
echo "   - companies.md"
echo "   - agents.md"
echo "   - tables/ (individual table files)"
ls -la "$OUTPUT_DIR"

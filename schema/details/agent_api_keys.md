# agent_api_keys Table

API keys for authenticating agent access to the Paperclip API.

## Drizzle Schema

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

## PostgreSQL

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
| id | uuid | PK, DEFAULT gen_random_uuid() | Unique key identifier |
| agent_id | uuid | NOT NULL, FK→agents | Associated agent |
| company_id | uuid | NOT NULL, FK→companies | Associated company |
| name | text | NOT NULL | Human-readable key name |
| key_hash | text | NOT NULL | Hashed API key (plaintext never stored) |
| last_used_at | timestamptz | NULL | Last API usage timestamp |
| revoked_at | timestamptz | NULL | Revocation timestamp (NULL=active) |
| created_at | timestamptz | NOT NULL, DEFAULT NOW() | Creation timestamp |

## Usage

```sql
-- Insert new API key for an agent
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash, created_at)
VALUES (gen_random_uuid(), 'agent-uuid', 'company-uuid', 'Production Key', 'pk_hash...', NOW());

-- Get active keys for an agent
SELECT * FROM agent_api_keys 
WHERE agent_id = 'agent-uuid' AND revoked_at IS NULL;

-- Check key usage
UPDATE agent_api_keys SET last_used_at = NOW() WHERE key_hash = 'pk_hash...';
```

## Security Notes

- Keys are hashed using SHA-256 before storage
- Only the hash prefix (first 8 chars) is shown in UI
- Revoked keys can be permanently deleted after audit period
- Agent-specific keys follow naming convention: `pk_{company}_{agent}_{year}`

## Agent Key Examples

### Issue Batch Importer (PaperclipForge AI)
```sql
-- API key for bulk issue processing agent
INSERT INTO agent_api_keys (agent_id, company_id, name, key_hash)
VALUES (
  '550e8400-e29b-41d4-a716-446655440014', -- Issue Batch Importer
  '550e8400-e29b-41d4-a716-446655440013', -- PaperclipForge AI
  'Production Key',
  encode(sha256('pk_paperclipforge_issue_batch_importer_2026'::bytea), 'hex')
);
```

### Key Hash Generation
```sql
-- Generate SHA-256 hash for API key
SELECT encode(sha256('your-plaintext-key'::bytea), 'hex') as key_hash;
```

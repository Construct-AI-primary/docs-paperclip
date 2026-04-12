# Paperclip Database Schema Documentation

This directory contains detailed documentation for all Paperclip database tables.

## Table Index

### Core Entity Tables
| Table | File | Description |
|-------|------|-------------|
| **companies** | [companies.md](./companies.md) | Root entity owning all resources |
| **agents** | [agents.md](./agents.md) | AI agents belonging to companies |
| **goals** | [goals.md](./goals.md) | Company goals and objectives |
| **projects** | [projects.md](./projects.md) | Projects owned by companies |
| **issues** | [issues.md](./issues.md) | Issues/tasks within projects |

### Authentication & Authorization
| Table | File | Description |
|-------|------|-------------|
| **auth_users** | (see drizzle-schema-reference.ts) | User authentication |
| **board_api_keys** | (see drizzle-schema-reference.ts) | Board API keys |
| **company_memberships** | (see drizzle-schema-reference.ts) | Company memberships |

### Project & Issue Tracking
| Table | File | Description |
|-------|------|-------------|
| **project_workspaces** | (see drizzle-schema-reference.ts) | Project workspace definitions |
| **execution_workspaces** | (see drizzle-schema-reference.ts) | Runtime execution workspaces |
| **labels** | (see drizzle-schema-reference.ts) | Issue labels |
| **issue_comments** | (see drizzle-schema-reference.ts) | Issue comments |
| **issue_attachments** | (see drizzle-schema-reference.ts) | Issue attachments |

### Agent Runtime
| Table | File | Description |
|-------|------|-------------|
| **heartbeat_runs** | (see drizzle-schema-reference.ts) | Agent heartbeat execution records |
| **heartbeat_run_events** | (see drizzle-schema-reference.ts) | Heartbeat run event log |
| **agent_runtime_state** | (see drizzle-schema-reference.ts) | Agent runtime state |
| **agent_task_sessions** | (see drizzle-schema-reference.ts) | Agent task sessions |
| **agent_wakeup_requests** | (see drizzle-schema-reference.ts) | Agent wake-up requests |

### Finance & Cost Tracking
| Table | File | Description |
|-------|------|-------------|
| **cost_events** | (see drizzle-schema-reference.ts) | Cost tracking events |
| **finance_events** | (see drizzle-schema-reference.ts) | Financial events |
| **budget_policies** | (see drizzle-schema-reference.ts) | Budget policies |
| **budget_incidents** | (see drizzle-schema-reference.ts) | Budget incidents |

### Documents & Assets
| Table | File | Description |
|-------|------|-------------|
| **documents** | (see drizzle-schema-reference.ts) | Company documents |
| **document_revisions** | (see drizzle-schema-reference.ts) | Document version history |
| **assets** | (see drizzle-schema-reference.ts) | File assets |

### Workflow & Approvals
| Table | File | Description |
|-------|------|-------------|
| **approvals** | (see drizzle-schema-reference.ts) | Approval requests |
| **approval_comments** | (see drizzle-schema-reference.ts) | Approval comments |
| **routines** | (see drizzle-schema-reference.ts) | Scheduled routines |
| **routine_runs** | (see drizzle-schema-reference.ts) | Routine execution records |

### Activity & Logging
| Table | File | Description |
|-------|------|-------------|
| **activity_log** | (see drizzle-schema-reference.ts) | Activity audit log |

### Secrets & Configuration
| Table | File | Description |
|-------|------|-------------|
| **company_secrets** | (see drizzle-schema-reference.ts) | Company secrets |
| **company_skills** | (see drizzle-schema-reference.ts) | Company skills |
| **company_api_keys** | (see drizzle-schema-reference.ts) | Company API keys |

### Plugins
| Table | File | Description |
|-------|------|-------------|
| **plugins** | (see drizzle-schema-reference.ts) | Plugin registry |
| **plugin_config** | (see drizzle-schema-reference.ts) | Plugin configuration |
| **plugin_jobs** | (see drizzle-schema-reference.ts) | Plugin job queue |

## Key Concepts

### Company-First Architecture

All tables (except auth) are scoped to a company via `company_id`. This ensures data isolation between companies.

```
companies (root)
  └── agents
  └── goals
       └── projects
            └── issues
```

### Insertion Order

When creating SQL scripts, follow this order:

1. **companies** - Must exist first
2. **agents** - Requires company_id
3. **goals** - Requires company_id (optional: owner_agent_id)
4. **projects** - Requires company_id (optional: goal_id)
5. **issues** - Requires company_id (optional: project_id, goal_id)

### Critical Rule: Foreign Keys

⚠️ **ALWAYS** verify the company exists before inserting related data:

```sql
-- WRONG - will fail if company doesn't exist
INSERT INTO goals (company_id, ...) VALUES ('uuid-here', ...);

-- CORRECT - only inserts if company exists
INSERT INTO goals (company_id, title, ...)
SELECT c.id, 'Title', ...
FROM companies c
WHERE c.name = 'Company Name'
ON CONFLICT DO NOTHING;
```

## Quick Reference

### Find Company by Name
```sql
SELECT id, name FROM companies WHERE name = 'ContentForge AI';
```

### Count Records by Company
```sql
SELECT c.name, 
       COUNT(DISTINCT a.id) as agents,
       COUNT(DISTINCT g.id) as goals,
       COUNT(DISTINCT p.id) as projects,
       COUNT(DISTINCT i.id) as issues
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN goals g ON c.id = g.company_id
LEFT JOIN projects p ON c.id = p.company_id
LEFT JOIN issues i ON c.id = i.company_id
GROUP BY c.name;
```

## Source Files

- **Schema Source:** `packages/db/src/schema/`
- **Consolidated Reference:** `docs-paperclip/schema/drizzle-schema-reference.ts`
- **Foreign Key Docs:** `docs-paperclip/schema/FOREIGN_KEY_CONSTRAINTS.md`

## Generating This Documentation

Run the schema extraction script:
```bash
./docs-paperclip/schema/extract-schema.sh
```

---

**Last Updated:** 2026-04-12

# Supabase Database Schema Tables

Generated from: drizzle-schema-reference.ts

## Tables

- [agent_api_keys](agent_api_keys.md)
- [companies](companies.md)
- [agents](agents.md)

## Core Tables

| Table | Description |
|-------|-------------|
| `companies` | AI agent companies/organizations |
| `agents` | Individual AI agents belonging to companies |
| `agent_api_keys` | API keys for agent authentication |
| `issues` | Task/issue tracking |
| `skills` | Agent skill definitions |
| `agent_skills` | Many-to-many agent-skill relationships |
| `activity_log` | System activity auditing |

## Relationships

```
companies (1) ──────< agents (N)
    │                    │
    │                    │
    └────< agent_api_keys (N)
    │
    └────< issues (N)

agents (1) ──────< agent_skills (N) >───── skills (1)
agents (1) ──────< activity_log (N)
```

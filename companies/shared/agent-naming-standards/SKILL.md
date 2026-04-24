---
name: agent-naming-standards
slug: agent-naming-standards
para_section: pages/skills/agent-naming-standards
gigabrain_tags: agent-naming, naming-standards, constraints, documentation
openstinger_context: agent-naming-standards
last_updated: 2026-04-24
related_docs:
  - docs-paperclip/companies/knowledgeforge-ai/AGENT-NAMING-STANDARDS.md
---

# Agent Naming Standards

## Overview

This skill defines the **absolute naming constraints** for all Paperclip ecosystem agents. Every agent must have a **human-readable display name** that is unique within its company and does not exceed 23 characters. This applies to all companies: DevForge AI, QualityForge AI, InfraForge AI, PromptForge AI, KnowledgeForge AI, and every other company in the ecosystem.

---

## Hard Constraints

| Constraint | Rule | Enforcement |
|------------|------|-------------|
| **Uniqueness** | Agent display name must be unique within its company | Database `UNIQUE` constraint on `(company_id, name)` |
| **Length** | Maximum 23 characters | Validated at creation and on update |
| **Readability** | Must be human-readable (not a slug) | No kebab-case, no underscores, Title Case preferred |
| **No Slugs** | `name` field in AGENTS.md YAML is the **display name**, not the slug | Slug belongs in `slug:` frontmatter field |

---

## What Is a Display Name?

The `name` field in `AGENTS.md` frontmatter is the **human-facing identifier** used in the Paperclip UI, dashboards, and team cross-reference documentation.

### ✅ Good Display Names

| Name | Length | Company |
|------|--------|---------|
| `Governor` | 8 | QualityForge AI |
| `Guardian` | 8 | QualityForge AI |
| `Validator` | 9 | QualityForge AI |
| `Standards` | 9 | QualityForge AI |
| `Nexus` | 5 | DevForge AI |
| `Orion` | 5 | DomainForge AI |
| `Atlas` | 5 | DevForge AI |
| `Sage` | 4 | PromptForge AI |
| `Vision` | 6 | Loopy AI |

### ❌ Bad Display Names

| Name | Problem |
|------|---------|
| `governor-qualityforge-quality-director` | This is a **slug**, not a display name (38 chars) |
| `guardian-qualityforge-quality-guardian` | This is a **slug**, not a display name (38 chars) |
| `integration-Integration-testing` | Mixed slug + name pattern (31 chars) |
| `assessment-criteria-manager` | Too long (27 chars), kebab-case |
| `decision-support-specialist` | Too long (27 chars), kebab-case |

---

## AGENTS.md Frontmatter Specification

Every agent's `AGENTS.md` must have **two distinct fields**:

```yaml
---
name: Guardian          # ← Human display name (≤23 chars, unique)
slug: guardian-qualityforge-quality-guardian  # ← Machine identifier
reportsTo: governor-qualityforge-quality-director
skills:
  - guardian-qualityforge-quality-guardian
---
```

| Field | Purpose | Example |
|-------|---------|---------|
| `name` | Human display name shown in UI | `Guardian` |
| `slug` | Unique machine identifier (kebab-case) | `guardian-qualityforge-quality-guardian` |
| `reportsTo` | Slug of the agent this agent reports to | `governor-qualityforge-quality-director` |

---

## How to Fix Naming Violations

### Step 1: Identify the Human Name
Look at the agent's role or the database `name` field to find the proper short human name.

### Step 2: Update AGENTS.md
Replace the slug in the `name:` field with the proper display name:

```yaml
# BEFORE (wrong)
name: guardian-qualityforge-quality-guardian

# AFTER (correct)
name: Guardian
```

### Step 3: Ensure slug Field Exists
Make sure `slug:` contains the full kebab-case identifier:

```yaml
slug: guardian-qualityforge-quality-guardian
```

### Step 4: Validate Length
Count characters: `Guardian` = 8 chars ✅ (must be ≤23)

---

## Special Cases

### Compound Names
When a single word is insufficient, use **Title Case with spaces**:

| Role | Display Name | Length |
|------|-------------|--------|
| Quality Director | `Governor` | 8 |
| Quality Guardian | `Guardian` | 8 |
| Standards Enforcer | `Standards` | 9 |
| Quality Monitor | `Monitor` | 7 |
| Quality Reporter | `Reporter` | 8 |
| Quality Auditor | `Auditor` | 7 |
| Code Inspector | `Inspector` | 9 |
| Code Optimizer | `Optimizer` | 9 |
| Bug Fixer | `Fixer` | 5 |
| Issue Resolver | `Resolver` | 8 |

### Single-Word Domain Experts
Traditional roles can use a single word:
- `Buyer`
- `Engineer`
- `Electrician`
- `Architect`
- `Surveyor`

---

## Validation Checklist

Before registering or updating any agent, verify:

- [ ] Display name is **≤23 characters**
- [ ] Display name is **unique within the company**
- [ ] Display name is **human-readable** (not a slug)
- [ ] `slug:` field exists and contains the full kebab-case identifier
- [ ] `name:` field contains only the short display name
- [ ] No special characters in `name:` (letters and spaces only)

---

## Migration Priority

### High Priority (Fix Immediately)
1. All agents where `name` === `slug` (name is being used as a slug)
2. All agents with `name` >23 characters
3. All duplicate names within a company

### Medium Priority (Fix Soon)
1. Inconsistent naming patterns across teams
2. Agents with `reportsTo` pointing to a name instead of a slug

### Low Priority (Nice to Have)
1. Standardizing similar roles across companies
2. Updating historical documentation

---

## Related Standards

- [KnowledgeForge AI Agent Naming Standards](../knowledgeforge-ai/AGENT-NAMING-STANDARDS.md) — Broader naming philosophy
- [File Naming Standards](file-naming-standards/SKILL.md) — File and directory naming
- [Database Naming Standards](database-naming-standards/SKILL.md) — Schema naming conventions

---

**Document Version:** 1.0
**Effective Date:** 2026-04-24
**Owner:** Paperclip Ecosystem — QualityForge AI
**Enforced By:** Reconciliation scripts (`recon-*-ai.mjs`)

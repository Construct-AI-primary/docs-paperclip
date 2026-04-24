---
name: reconciler-paperclipforge
description: >
  Agent reconciliation between filesystem source-of-truth and Supabase database.
  Compares agent folders against database records, identifies discrepancies,
  and generates fix scripts. Use when asked to reconcile agents, audit agent data,
  or fix agent hierarchy issues.
version: 1.0
company: paperclipforge-ai
tags:
  - reconciliation
  - database
  - filesystem
  - audit
---

# Reconciler - Paperclip Agent Reconciliation Skill

## Overview

This skill enables systematic reconciliation of agent data between the filesystem source-of-truth and the Supabase database.

## When to Use

- "Reconcile [Company] AI agents"
- "Audit agent data for [Company]"
- "Fix agent hierarchy issues"
- "Check for missing agents in database"
- "Validate naming conventions"

## Reconciliation Steps

### Step 1: Identify Company

```bash
# Get company ID from companies.json
jq '.[] | select(.name == "{Company} AI") | {id, name}' supabase_backup_*/companies.json
```

### Step 2: List Filesystem Agents

```bash
# Count and list agent folders
ls -d docs-paperclip/companies/{slug}/agents/*/ | wc -l
ls docs-paperclip/companies/{slug}/agents/ | sort
```

### Step 3: Query Database Agents

```bash
# Get all agents for company
jq '.[] | select(.company_id == "{company_id}") | .name' supabase_backup_*/agents.json | sort
```

### Step 4: Compare and Identify Issues

1. **Missing in DB:** Folders exist but no DB record
2. **Missing in FS:** DB records but no folder
3. **Naming Issues:** Non-PascalCase folders
4. **Hierarchy Issues:** Incorrect `reports_to` values

### Step 5: Generate Fix Scripts

Create SQL scripts for:
- Missing agent registration
- Hierarchy corrections
- Naming fixes

Create shell scripts for:
- Folder renames

### Step 6: Document Findings

Generate reconciliation report with:
- Executive summary
- Discrepancy list
- Fix recommendations
- SQL scripts

## Naming Conventions

### Folder Naming
- Format: `{company-slug}-{PascalCaseName}`
- Example: `devforge-ai-Nexus`
- ❌ Bad: `devforge-ai-nexus`, `devforge-ai-NEXUS`

### Human Name Validation
- Title Case: "Nexus", "Atlas", "Oracle"
- Max 23 characters
- No slugs or acronyms as names
- No garbled text

### Hierarchy Rules
- Apex (CEO): `reports_to: null`
- Governors: Report to Apex
- Agents: Report to Governors

## Output Templates

### Reconciliation Report
```
docs-paperclip/reports/{company}-recon-YYYY-MM-DD.md
```

### SQL Fix Scripts
```
scripts/database-templates/_fix-{company}-missing-agents.sql
scripts/database-templates/_fix-{company}-hierarchy.sql
scripts/database-templates/_fix-{company}-human-names.sql
```

### Shell Scripts
```
scripts/database-templates/_fix-{company}-folder-renames.sh
```

## Related Skills

- auditor-paperclipforge (security compliance)
- guardian-paperclipforge (threat protection)
- bridge-builder-paperclipforge (cross-company coordination)

## Error Handling

- Missing company ID: Check companies.json
- Empty DB results: Verify company_id format
- Permission errors: Check file permissions
- SQL syntax errors: Validate UUID format

## Examples

### Reconcile DevForge AI
```bash
COMPANY_ID="f97b30e8-b022-4350-b4b0-30d43e2ebcf4"
jq ".[] | select(.company_id == \"$COMPANY_ID\")" agents.json
```

### Reconcile QualityForge AI
```bash
COMPANY_ID="f535f9bc-00be-4b6d-9f53-c53abfacacef"
jq ".[] | select(.company_id == \"$COMPANY_ID\")" agents.json
```

---

**Last Updated:** 2026-04-24

---
title: "MEASURE-TENDER-001: Database Schema & RLS Policies"
description: "Create 6 parallel database tables for subcontractor tender integration with clean RLS policies from day 1"
gigabrain_tags: issue, measurement, tender, database-schema, rls-policies, supabase, security
labels: ["measurement", "tender", "database", "critical"]
blocked_by: []
depends_on: []
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/issues
last_updated: 2026-04-25
status: backlog
priority: Critical
story_points: 13
due_date: "2026-05-01"
assigned_to: database-infraforge
company: infraforge-ai
team: database
---

# MEASURE-TENDER-001: Database Schema & RLS Policies

## Overview

Create the 6 parallel database tables for the Subcontract Tender Integration System (Option B architecture). This is a **security-first design** with RLS policies enforced from day 1 to prevent cross-contamination with the existing gov.za tender integration tables.

## Requirements

### Tables to Create

1. **`subcontract_portal_sources`** - Portal/source configuration
2. **`subcontract_rfq_sync_history`** - Sync audit trail
3. **`subcontract_rfq_error_logs`** - Error tracking
4. **`subcontract_rfqs`** - Main RFQ tender data
5. **`subcontractor_prequalification`** - Subcontractor prequal records
6. **`quotation_comparisons`** - Bid comparison matrix

### Technical Requirements

1. All tables must have proper `organization_id` foreign key
2. All tables must have `created_at` and `updated_at` timestamps
3. All tables must have UUID primary keys using `gen_random_uuid()`
4. All tables must have RLS enabled and proper policies
5. All foreign key relationships must be properly defined
6. Indexes for common query patterns (status, org_id, trade_category)

### RLS Policies Required

| Table | SELECT | INSERT | UPDATE | DELETE |
|-------|--------|--------|--------|--------|
| subcontract_portal_sources | org | org | org | org |
| subcontract_rfq_sync_history | org | system | - | - |
| subcontract_rfq_error_logs | org | system | - | - |
| subcontract_rfqs | org | org | org | org |
| subcontractor_prequalification | org | org | org | org |
| quotation_comparisons | org | org | org | org |

### Security Constraints

1. **No cross-tenant access**: All policies MUST check `organization_id = current_user_org()`
2. **No admin bypass**: RLS must be enforced even for service role
3. **Separate credentials**: `credentials_encrypted` field must be isolated per table
4. **Audit trail**: All sync operations logged with status and duration

## Acceptance Criteria

- [ ] All 6 tables created with correct schema
- [ ] All RLS policies created and tested
- [ ] Foreign key relationships verified
- [ ] Indexes created for query performance
- [ ] Test queries confirm no cross-tenant access
- [ ] Migration script generated and tested
- [ ] Rollback script generated

## Dependencies

- Requires existing `organizations(id)` table
- Requires existing `users(id)` table
- Must NOT depend on gov.za integration tables

## Files to Create

```
sql/
├── create_subcontract_tables.sql          # Main migration
├── create_subcontract_indexes.sql          # Performance indexes
└── rollback_subcontract_tables.sql         # Rollback if needed
```

## Notes

- Follow the exact schema defined in the project.md
- Use `ENABLE ROW LEVEL SECURITY` for all tables
- Test RLS with different organization contexts
- Ensure migration can be rolled back cleanly

---

**Issue Type**: Database Migration
**Estimated Hours**: 8-12 hours
**Agent Assignment**: database-infraforge (InfraForge AI)

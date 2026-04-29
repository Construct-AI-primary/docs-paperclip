---
id: "BTND-001"
title: "Phase 1: Foundation — Database Schema, API Routes, Government Integration"
status: "backlog"
priority: "critical"
estimate: "5-10 hours"
assignee: "database-infraforge"
company: "InfraForge AI"
team: "Infrastructure"
labels: ["phase-1", "database", "api", "integration", "btnd-platform"]
related_docs:
  - docs-paperclip/disciplines-shared/bidding-and-tendering/plans/2026-04-29-bidding-tendering-plan.md
  - docs-paperclip/disciplines-shared/bidding-and-tendering/DISCIPLINE-PLATFORM-STRUCTURE.md
  - docs-paperclip/disciplines-shared/bidding-and-tendering/knowledge/PAGE-KNOWLEDGE.md
  - docs-paperclip/disciplines-shared/bidding-and-tendering/UI-UX-SPECIFICATION.md
completion_criteria:
  - All tables created with RLS policies tested
  - OCDS API client authenticates and returns valid tender data
  - Web scraper fallback parses at least one portal page correctly
  - API routes return valid health check response
  - Encryption keys deployed and credential isolation verified
---

# BTND-001: Foundation — Database Schema, API Routes, Government Integration

## Scope

Phase 1 builds the infrastructure foundation for both the Bidding and Tendering systems.

## Tasks

### 1.1 Database Schema (3-4 hours)
- Create `govt_portal_sources` table
- Create `govt_tender_discovery` table
- Create `bid_opportunities` table
- Create `bid_submissions` table
- Create `tender_rfqs` table
- Create `vendor_prequalification` table
- Create `quotation_comparisons` table
- Create `tender_awards` table
- RLS policies on all tables
- Indexes + audit logging

### 1.2 ZA Govt OCDS Integration (2-3 hours)
- OCDS API client with rate limiting
- OCDS → `govt_tender_discovery` mapping
- Web scraper fallback (Playwright)
- Data deduplication logic

### 1.3 API Routes (1-2 hours)
- Bidding API prefix `/api/v1/bidding`
- Tendering API prefix `/api/v1/tendering`
- Shared health endpoint `/api/v1/shared/health`

### 1.4 Encryption & Security (1 hour)
- `KEY_GOVT_PORTAL` encryption setup
- `KEY_VENDOR_PORTAL` encryption setup

## Dependencies
- None (foundation phase)

## Gate Criteria
- [ ] All tables created with RLS policies tested
- [ ] OCDS API client authenticates
- [ ] Web scraper parses portal page correctly
- [ ] API routes return valid health check
- [ ] Encryption keys deployed and credential isolation verified
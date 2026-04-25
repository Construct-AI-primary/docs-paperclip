---
title: "MEASURE-TENDER-006b: External Portal - Admin Dashboard"
description: "Create internal admin dashboard for contracts pre-award team: tender management, evaluation, and award workflows"
gigabrain_tags: issue, measurement, tender, external-portal, admin-dashboard, contracts-pre-award, evaluation, awards
labels: ["measurement", "tender", "frontend", "web", "external", "admin"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001", "MEASURE-TENDER-003", "MEASURE-TENDER-006a"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/web/issues
last_updated: 2026-04-25
status: backlog
priority: High
story_points: 21
due_date: "2026-05-30"
assigned_to: loopy-ai
company: loopy-ai
team: ui
---

# MEASURE-TENDER-006b: External Portal - Admin Dashboard

## Overview

Create the **internal admin dashboard** for the contracts pre-award team. This issue focuses on authenticated internal user workflows: tender management, quotation evaluation, and award approvals.

## User Groups

| Role | Access | Capabilities |
|------|--------|--------------|
| Contracts Pre-Award Team | Full tender management | Create, publish, evaluate, award |
| Procurement Officers | Tender coordination | Manage RFQs, track quotations |
| QS/Measurement Team | BOQ linkage | Link BOQ to tender packages |
| Management | Approval workflows | Approve awards, view reports |

## Page Structure

```
tenders-admin.yourcompany.co.za/
├── /admin/tenders              # Manage all tenders
├── /admin/tenders/new          # Create new tender
├── /admin/tenders/[id]         # Edit/publish tender
├── /admin/evaluations          # Evaluation dashboard
├── /admin/quotations           # All quotations
├── /admin/vendors              # Vendor management
└── /admin/awards               # Award approvals
```

## Core Features

### 1. Tender Management

**Pages**: `/admin/tenders/*`

- **List View**: All tenders with status filters
- **Create**: New tender from BOQ or manual entry
- **Edit**: Update tender details, documents
- **Publish**: Publish to external portal
- **Timeline**: Extend closing dates, add addenda

**Tender Form**:
```typescript
interface TenderForm {
  title: string;
  description: string;
  trade_categories: string[];
  scope_of_works: string;
  specifications: string;
  cidb_grading_required: string;
  estimated_value: number;
  closing_date: Date;
  documents: Document[];
}
```

### 2. Contracts Pre-Award Dashboard

**Page**: `/admin/evaluations`

Dashboard showing:
- Active tenders with pending evaluations
- Recent quotation submissions
- Award recommendations pending approval
- Evaluation deadline reminders

**Dashboard Interface**:
```typescript
interface ContractsDashboard {
  active_tenders: Tender[];
  pending_evaluations: Evaluation[];
  recent_submissions: Quotation[];
  award_recommendations: Recommendation[];
  approval_queue: Approval[];
}
```

### 3. Quotation Evaluation

**Page**: `/admin/quotations/[rfqId]`

- Side-by-side quotation comparison
- Multi-criteria scoring matrix:
  - Technical compliance (40%)
  - Commercial competitiveness (40%)
  - B-BBEE contribution (20%)
- Scoring visualization (bar charts)
- Notes and comments per criterion
- Rank ordering
- Recommendation selection

**Evaluation Interface**:
```typescript
interface EvaluationCriteria {
  name: string;
  weight: number;  // percentage
  max_score: number;
}

interface QuotationEvaluation {
  quotation_id: string;
  criteria: {
    name: string;
    score: number;
    notes: string;
  }[];
  total_score: number;
  rank: number;
  recommendation: 'award' | 'shortlist' | 'reject';
}
```

### 4. Award Workflow

**Page**: `/admin/awards`

- Award recommendations list
- Management approval queue
- Award letter generation
- Notification to winning vendor
- Rejection notices to non-winning vendors

### 5. Vendor Management

**Page**: `/admin/vendors`

- List of registered vendors
- Prequalification status management
- Document verification
- Compliance tracking (CIDB, B-BBEE, Safety)
- Performance history

## Technology Stack

- **Framework**: Next.js 14 with App Router
- **UI**: React + Tailwind CSS
- **Auth**: NextAuth.js with SSO to ConstructAI
- **Database**: Shared with ConstructAI (Supabase)
- **Email**: Integration with 03010 Email system

## Design Requirements

### Branding
- Professional construction industry aesthetic
- Match existing ConstructAI branding
- Mobile-responsive for field access

### UX Considerations
- Efficient evaluation workflows
- Clear scoring visualization
- Quick award actions
- Audit trail visibility

### Security
- SSO with ConstructAI for internal users
- Role-based access control
- Audit logging for all actions
- Approval workflow enforcement

## Acceptance Criteria

- [ ] Internal admin dashboard for contracts team
- [ ] Tender create/edit/publish workflows
- [ ] Multi-criteria evaluation matrix
- [ ] Quotation comparison visualization
- [ ] Award workflow with approvals
- [ ] Vendor management interface
- [ ] Email notifications for all key events
- [ ] SSO with ConstructAI for internal users
- [ ] Audit trail for compliance

## Dependencies

- MEASURE-TENDER-001: Database Schema (RLS policies)
- MEASURE-TENDER-003: API Routes (admin endpoints)
- MEASURE-TENDER-006a: Public Portal (shared components)
- NextAuth.js configuration with SSO
- 03010 Email system integration

## Files to Create

```
tender-portal/src/
├── app/
│   ├── (admin)/
│   │   ├── admin/
│   │   │   └── page.tsx           # Admin dashboard
│   │   ├── tenders/
│   │   │   ├── page.tsx           # Tender list
│   │   │   ├── new/page.tsx       # Create tender
│   │   │   └── [id]/page.tsx      # Edit tender
│   │   ├── evaluations/
│   │   │   └── page.tsx           # Evaluation dashboard
│   │   ├── quotations/
│   │   │   └── [rfqId]/page.tsx   # Quotation evaluation
│   │   ├── vendors/
│   │   │   └── page.tsx           # Vendor management
│   │   └── awards/
│   │       └── page.tsx           # Award approvals
│   │
│   └── api/
│       ├── admin/tenders/route.ts
│       ├── admin/evaluations/route.ts
│       └── admin/awards/route.ts
│
├── components/
│   ├── admin/
│   │   ├── tender-form.tsx
│   │   ├── tender-list.tsx
│   │   └── vendor-card.tsx
│   ├── evaluation/
│   │   ├── evaluation-matrix.tsx
│   │   ├── quotation-comparison.tsx
│   │   └── scoring-panel.tsx
│   └── awards/
│       ├── award-list.tsx
│       └── approval-workflow.tsx
│
└── lib/
    ├── admin-auth.ts
    └── admin-api.ts
```

---

**Issue Type**: Frontend Web Application
**Estimated Hours**: 20-30 hours
**Agent Assignment**: loopy-ai (Loopy AI)

**Parent**: MEASURE-TENDER-006
**Sibling**: MEASURE-TENDER-006a (Public Pages)

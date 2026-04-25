---
title: "MEASURE-TENDER-006a: External Portal - Public Pages"
description: "Create public-facing pages for vendor registration, tender listings, and quotation submission"
gigabrain_tags: issue, measurement, tender, external-portal, public-pages, vendor-registration, quotation-submission
labels: ["measurement", "tender", "frontend", "web", "external", "public"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001", "MEASURE-TENDER-003"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/web/issues
last_updated: 2026-04-25
status: backlog
priority: High
story_points: 13
due_date: "2026-05-22"
assigned_to: loopy-ai
company: loopy-ai
team: ui
---

# MEASURE-TENDER-006a: External Portal - Public Pages

## Overview

Create the **public-facing pages** for the bespoke B2B tender portal. This issue focuses on external vendor user experience: registration, tender browsing, and quotation submission.

## User Groups

| Role | Access | Capabilities |
|------|--------|--------------|
| Sub-vendors | Own quotations only | View opportunities, submit quotes |
| Suppliers | Own quotations only | View opportunities, submit quotes |
| Public (optional) | Browse listings only | View published tenders (no quote) |

## Page Structure

```
tenders.yourcompany.co.za/
├── /                          # Landing page with active tenders
├── /tenders                   # Browse all published tenders
├── /tenders/[id]             # Tender detail page
├── /tenders/[id]/quote       # Submit quotation (login required)
├── /register                  # Vendor registration
├── /dashboard                 # Vendor dashboard (quotation status)
└── /login                     # Authentication
```

## Core Features

### 1. Public Tender Listings

**Page**: `/tenders`
- Display all published tenders
- Filter by trade category, value range, closing date
- Search functionality
- Pagination for large datasets

**Tender Card Component**:
```typescript
interface PublicTender {
  id: string;
  tender_number: string;
  title: string;
  description: string;
  trade_categories: string[];
  estimated_value: number;
  closing_date: Date;
  status: 'published' | 'closed' | 'awarded';
  documents: Document[];
}
```

### 2. Tender Detail Page

**Page**: `/tenders/[id]`
- Full tender information display
- Document download (tender documents, specifications)
- Login/register CTA for quotation submission
- Trade category badges
- CIDB grading requirements

### 3. Vendor Registration

**Page**: `/register`
- Company information form
- CIDB grade selection
- B-BBEE level declaration
- Trade categories selection (multi-select)
- Document upload:
  - CIDB certificate
  - B-BBEE certificate
  - Insurance certificate
  - Tax clearance
- Contact person details
- Email verification flow

**Registration Form**:
```typescript
interface VendorRegistration {
  company_name: string;
  registration_number: string;
  cidb_grade: string;
  bbbee_level: string;
  trade_categories: string[];
  contact_person: ContactInfo;
  documents: {
    cidb_certificate: File;
    bbbee_certificate: File;
    insurance_certificate: File;
    tax_clearance: File;
  };
}
```

### 4. Quotation Submission

**Page**: `/tenders/[id]/quote`
- Step-by-step wizard:
  1. Company details (pre-filled if registered)
  2. Quoted amount and currency
  3. Validity period
  4. Programme commitment
  5. Technical proposal
  6. Document attachments
  7. Review and submit
- Save as draft functionality
- Real-time validation

**Quotation Submission**:
```typescript
interface QuotationSubmission {
  tender_id: string;
  vendor_id: string;
  quoted_amount: number;
  currency: string;
  validity_period: number;
  programme_commitment: string;
  technical_proposal: Text;
  documents: Document[];
}
```

### 5. Vendor Dashboard

**Page**: `/dashboard`
- List of submitted quotations
- Status tracking (draft, submitted, under_review, awarded, rejected)
- Award/rejection notifications
- Company profile management

## Technology Stack

- **Framework**: Next.js 14 with App Router
- **UI**: React + Tailwind CSS
- **Auth**: NextAuth.js with email verification
- **Database**: Shared with ConstructAI (Supabase)
- **Email**: Integration with 03010 Email system

## Design Requirements

### Branding
- Professional construction industry aesthetic
- Match existing ConstructAI branding
- Mobile-responsive for field access

### UX Considerations
- Simple vendor registration flow (minimal friction)
- Clear tender document download
- Step-by-step quotation submission wizard
- Real-time status updates

### Security
- Email verification for vendor accounts
- Document upload validation (PDF, max size)
- Rate limiting on submission endpoints
- CSRF protection on all forms

## Acceptance Criteria

- [ ] Public tender listing page with filtering
- [ ] Tender detail page with document download
- [ ] Vendor self-registration with document upload
- [ ] Quotation submission wizard
- [ ] Vendor dashboard (submission status)
- [ ] Email notifications for registration confirmation
- [ ] Mobile-responsive design
- [ ] Sub-vendor email verification

## Dependencies

- MEASURE-TENDER-001: Database Schema (RLS policies for public access)
- MEASURE-TENDER-003: API Routes (public endpoints)
- NextAuth.js configuration
- 03010 Email system integration

## Files to Create

```
tender-portal/src/
├── app/
│   ├── (public)/
│   │   ├── page.tsx              # Landing
│   │   ├── tenders/
│   │   │   ├── page.tsx          # Tender listings
│   │   │   └── [id]/page.tsx     # Tender detail
│   │   ├── register/page.tsx     # Vendor registration
│   │   ├── dashboard/page.tsx    # Vendor dashboard
│   │   └── login/page.tsx        # Authentication
│   │
│   └── api/
│       ├── auth/[...nextauth]/route.ts
│       └── vendors/register/route.ts
│
├── components/
│   ├── tender-card.tsx
│   ├── tender-filters.tsx
│   ├── vendor-registration.tsx
│   ├── quotation-wizard/
│   │   ├── step-company.tsx
│   │   ├── step-amount.tsx
│   │   ├── step-documents.tsx
│   │   └── step-review.tsx
│   └── vendor-dashboard/
│       ├── quotation-list.tsx
│       └── quotation-status.tsx
│
└── lib/
    ├── auth.ts
    └── tender-api.ts
```

---

**Issue Type**: Frontend Web Application
**Estimated Hours**: 20-30 hours
**Agent Assignment**: loopy-ai (Loopy AI)

**Parent**: MEASURE-TENDER-006
**Sibling**: MEASURE-TENDER-006b (Admin Dashboard)

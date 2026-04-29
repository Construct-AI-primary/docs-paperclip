---
title: "Bidding & Tendering — Database Specification"
description: "Complete database specification for the Option B parallel table architecture supporting both bidding and tendering systems"
last_updated: 2026-04-29
version: 1.0
---

# Bidding & Tendering — Database Specification

## Design Principles

1. **Option B Parallel Tables**: Security-separated tables for bidding (govt integration) vs tendering (vendor management)
2. **Credential Isolation**: Government portal credentials encrypted separately from vendor portal credentials
3. **RLS by Organization**: Every table has organization-scoped Row-Level Security
4. **No Cross-Contamination**: Separate tables, separate metrics, separate logs
5. **Category-Separated Audit Logging**: Distinct log tables per system

## Table Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                     BIDDING & TENDERING DATABASE                      │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  SYSTEM 1: BIDDING TABLES                SYSTEM 2: TENDERING TABLES   │
│  ┌──────────────────────────────┐      ┌──────────────────────────┐ │
│  │ govt_portal_sources          │      │ tender_portal_sources    │ │
│  │ govt_tender_discovery       │      │ tender_sync_history      │ │
│  │ bid_opportunities            │      │ tender_error_logs        │ │
│  │ bid_submissions              │      │ tender_rfqs              │ │
│  │ bid_documents                │      │ vendor_prequalification  │ │
│  │ win_loss_tracking            │      │ quotation_comparisons    │ │
│  │ market_intelligence          │      │ tender_evaluation_scores │ │
│  └──────────────────────────────┘      │ tender_awards            │ │
│                                        │ award_to_contract        │ │
│                                        └──────────────────────────┘ │
│                                                                      │
│  SHARED INFRASTRUCTURE                                               │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │ activity_log (per system discriminator), notification_prefs  │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

## System 1: Bidding Tables

### govt_portal_sources
```sql
CREATE TABLE govt_portal_sources (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  source_id VARCHAR(50) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL,
  portal_type VARCHAR(20) NOT NULL,  -- 'ocds_api', 'web_scraping', 'csv_import'
  base_url TEXT,
  api_key_encrypted TEXT,  -- Encrypted with govt-scoped key
  api_secret_encrypted TEXT,
  sync_interval_minutes INT DEFAULT 60,
  rate_limit_per_minute INT DEFAULT 30,
  timeout_seconds INT DEFAULT 30,
  last_sync_at TIMESTAMP,
  last_sync_status VARCHAR(20),
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### govt_tender_discovery
```sql
CREATE TABLE govt_tender_discovery (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  source_id VARCHAR(50),
  external_id VARCHAR(100) UNIQUE,  -- OCDS release ID or portal reference
  tender_number VARCHAR(50),
  title TEXT NOT NULL,
  description TEXT,
  tender_type VARCHAR(50),  -- 'goods', 'services', 'works'
  procurement_method VARCHAR(50),
  estimated_value DECIMAL(15,2),
  currency VARCHAR(3) DEFAULT 'ZAR',
  issuing_organization TEXT,
  department TEXT,
  province VARCHAR(50),
  bid_submission_deadline TIMESTAMP,
  bid_validity_days INT,
  cidb_grading_required VARCHAR(10),
  bbbee_level_required VARCHAR(5),
  status VARCHAR(30) DEFAULT 'new',  -- 'new', 'evaluating', 'bidding', 'submitted', 'won', 'lost'
  discovery_date TIMESTAMP DEFAULT NOW(),
  source_data JSONB,  -- Raw OCDS response
  matched_keywords TEXT[],
  opportunity_score INT,
  assigned_to UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### bid_opportunities
```sql
CREATE TABLE bid_opportunities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  discovery_id UUID REFERENCES govt_tender_discovery(id),
  tender_number VARCHAR(50),
  title TEXT NOT NULL,
  estimated_value DECIMAL(15,2),
  submission_deadline TIMESTAMP,
  evaluation_status VARCHAR(30) DEFAULT 'pending',
  capability_match_score DECIMAL(5,2),
  resource_availability BOOLEAN,
  compliance_requirements TEXT,
  bid_manager UUID REFERENCES users(id),
  decision VARCHAR(20),  -- 'pursue', 'decline', 'undecided'
  decision_notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### bid_submissions
```sql
CREATE TABLE bid_submissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  opportunity_id UUID NOT NULL REFERENCES bid_opportunities(id),
  bid_reference VARCHAR(50) UNIQUE NOT NULL,
  submission_date TIMESTAMP NOT NULL,
  bid_amount DECIMAL(15,2),
  bond_amount DECIMAL(15,2),
  submission_method VARCHAR(50),  -- 'portal', 'email', 'physical'
  status VARCHAR(30) DEFAULT 'submitted',  -- 'submitted', 'shortlisted', 'awarded', 'rejected'
  result_date TIMESTAMP,
  award_amount DECIMAL(15,2),
  award_notes TEXT,
  documents JSONB DEFAULT '[]',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### win_loss_tracking
```sql
CREATE TABLE win_loss_tracking (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  submission_id UUID NOT NULL REFERENCES bid_submissions(id),
  outcome VARCHAR(10) NOT NULL,  -- 'won', 'lost', 'withdrawn'
  outcome_date TIMESTAMP NOT NULL,
  contract_value DECIMAL(15,2),
  loss_reason TEXT,
  winning_bidder TEXT,
  winning_amount DECIMAL(15,2),
  lessons_learned TEXT,
  competitive_intel TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
```

## System 2: Tendering Tables

### tender_rfqs
```sql
CREATE TABLE tender_rfqs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  rfq_number VARCHAR(50) UNIQUE NOT NULL,
  tender_type VARCHAR(20) NOT NULL,  -- 'subcontract', 'purchase_order', 'service_order', 'work_order', 'ho_purchase'
  title VARCHAR(255) NOT NULL,
  description TEXT,
  trade_category VARCHAR(50),
  scope_of_works TEXT,
  specifications TEXT,
  estimated_value DECIMAL(15,2),
  currency VARCHAR(3) DEFAULT 'ZAR',
  closing_date TIMESTAMP,
  validity_period_days INT DEFAULT 30,
  status VARCHAR(30) DEFAULT 'draft',  -- 'draft','published','accepting_bids','under_evaluation','awarded','contract','closed','cancelled'
  bids_received INT DEFAULT 0,
  best_bid_id UUID,
  procurement_officer_id UUID REFERENCES users(id),
  project_reference VARCHAR(100),
  boq_reference_id UUID,  -- Link to BUILDER-MEAS BOQ
  evaluation_criteria JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### vendor_prequalification
```sql
CREATE TABLE vendor_prequalification (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  vendor_name VARCHAR(200) NOT NULL,
  vendor_type VARCHAR(50),  -- 'subcontractor', 'supplier', 'service_provider'
  trade_categories TEXT[] NOT NULL,
  cidb_grading VARCHAR(10),
  bbbee_level VARCHAR(5),
  insurance_expiry DATE,
  safety_certification VARCHAR(50),
  tax_clearance VARCHAR(50),
  bank_details_encrypted TEXT,
  contact_email VARCHAR(255),
  contact_phone VARCHAR(50),
  status VARCHAR(20) DEFAULT 'pending',  -- 'pending','approved','suspended','rejected'
  approved_by UUID REFERENCES users(id),
  approved_at TIMESTAMP,
  expiry_date DATE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### quotation_comparisons
```sql
CREATE TABLE quotation_comparisons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  rfq_id UUID NOT NULL REFERENCES tender_rfqs(id),
  vendor_id UUID NOT NULL REFERENCES vendor_prequalification(id),
  quoted_amount DECIMAL(15,2),
  quoted_currency VARCHAR(3) DEFAULT 'ZAR',
  validity_period_days INT,
  programme_commitment TEXT,
  technical_score DECIMAL(5,2),
  commercial_score DECIMAL(5,2),
  overall_score DECIMAL(5,2),
  compliance_status VARCHAR(20),  -- 'compliant','non_compliant','partial'
  evaluation_notes TEXT,
  recommended_for_award BOOLEAN DEFAULT FALSE,
  evaluated_by UUID REFERENCES users(id),
  evaluated_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### tender_awards
```sql
CREATE TABLE tender_awards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  rfq_id UUID NOT NULL REFERENCES tender_rfqs(id),
  quotation_id UUID NOT NULL REFERENCES quotation_comparisons(id),
  vendor_id UUID NOT NULL REFERENCES vendor_prequalification(id),
  award_amount DECIMAL(15,2),
  award_date TIMESTAMP NOT NULL,
  acceptance_date TIMESTAMP,
  award_conditions TEXT,
  approved_by UUID REFERENCES users(id),
  contract_generated BOOLEAN DEFAULT FALSE,
  contract_id UUID,  -- Link to contracts system
  status VARCHAR(30) DEFAULT 'awarded',  -- 'awarded','accepted','contract_issued','completed','cancelled'
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

## RLS Policies

```sql
-- Enable RLS on ALL tables
ALTER TABLE govt_portal_sources ENABLE ROW LEVEL SECURITY;
ALTER TABLE govt_tender_discovery ENABLE ROW LEVEL SECURITY;
ALTER TABLE bid_opportunities ENABLE ROW LEVEL SECURITY;
ALTER TABLE bid_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE win_loss_tracking ENABLE ROW LEVEL SECURITY;
ALTER TABLE tender_portal_sources ENABLE ROW LEVEL SECURITY;
ALTER TABLE tender_rfqs ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendor_prequalification ENABLE ROW LEVEL SECURITY;
ALTER TABLE quotation_comparisons ENABLE ROW LEVEL SECURITY;
ALTER TABLE tender_awards ENABLE ROW LEVEL SECURITY;

-- Organization-scoped access for all tables
CREATE POLICY "Users can manage their organization's bidding sources"
  ON govt_portal_sources FOR ALL
  USING (organization_id = current_user_org());

CREATE POLICY "Users can view their organization's tender discoveries"
  ON govt_tender_discovery FOR SELECT
  USING (organization_id = current_user_org());

CREATE POLICY "Users can manage their organization's bid opportunities"
  ON bid_opportunities FOR ALL
  USING (organization_id = current_user_org());

CREATE POLICY "Users can view their organization's bid submissions"
  ON bid_submissions FOR SELECT
  USING (organization_id = current_user_org());

CREATE POLICY "Users can manage their organization's win/loss tracking"
  ON win_loss_tracking FOR ALL
  USING (organization_id = current_user_org());

CREATE POLICY "Users can manage their organization's RFQs"
  ON tender_rfqs FOR ALL
  USING (organization_id = current_user_org());

CREATE POLICY "Users can manage prequalified vendors"
  ON vendor_prequalification FOR ALL
  USING (organization_id = current_user_org());

CREATE POLICY "Users can view quotation comparisons"
  ON quotation_comparisons FOR SELECT
  USING (organization_id = current_user_org());

CREATE POLICY "Users can manage their organization's awards"
  ON tender_awards FOR ALL
  USING (organization_id = current_user_org());
```

## Indexes

```sql
-- Bidding indexes
CREATE INDEX idx_govt_sources_org ON govt_portal_sources(organization_id);
CREATE INDEX idx_govt_tenders_org ON govt_tender_discovery(organization_id);
CREATE INDEX idx_govt_tenders_status ON govt_tender_discovery(status);
CREATE INDEX idx_govt_tenders_deadline ON govt_tender_discovery(bid_submission_deadline);
CREATE INDEX idx_bid_opportunities_org ON bid_opportunities(organization_id);
CREATE INDEX idx_bid_submissions_org ON bid_submissions(organization_id);
CREATE INDEX idx_win_loss_org ON win_loss_tracking(organization_id);

-- Tendering indexes
CREATE INDEX idx_tender_rfqs_org ON tender_rfqs(organization_id);
CREATE INDEX idx_tender_rfqs_status ON tender_rfqs(status);
CREATE INDEX idx_tender_rfqs_type ON tender_rfqs(tender_type);
CREATE INDEX idx_vendor_prequal_org ON vendor_prequalification(organization_id);
CREATE INDEX idx_vendor_prequal_status ON vendor_prequalification(status);
CREATE INDEX idx_vendor_prequal_trades ON vendor_prequalification USING GIN(trade_categories);
CREATE INDEX idx_quotation_comparisons_rfq ON quotation_comparisons(rfq_id);
CREATE INDEX idx_tender_awards_rfq ON tender_awards(rfq_id);
```

## Security

- **Govt credentials**: Encrypted with key `KEY_GOVT_PORTAL` — scoped to bidding system only
- **Vendor credentials**: Encrypted with key `KEY_VENDOR_PORTAL` — scoped to tendering system only
- **PII fields**: Bank details in `vendor_prequalification` encrypted at rest
- **API tokens**: Never stored in plaintext

---

**Version**: 1.0
**Last Updated**: 2026-04-29
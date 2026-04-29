---
title: "Bidding & Tendering Platform Structure"
description: "Dual-system architecture overview"
last_updated: 2026-04-29
---

# Bidding & Tendering Platform Structure

## Overview — dual-system architecture serving Procurement, Contracts, Admin, Estimating

The Bidding & Tendering platform is organised as two complementary systems that together cover the full lifecycle of construction procurement — from identifying inbound bid opportunities through to issuing and awarding outbound tenders. The architecture serves four core disciplines: **Procurement**, **Contracts**, **Administration**, and **Estimating**.

- **Bidding (Inbound)** — the intake side, responsible for discovering, tracking, preparing, and analysing bids that the organisation responds to.
- **Tendering (Outbound)** — the issuance side, responsible for creating, managing, evaluating, and awarding tenders that the organisation sends to external vendors and subcontractors.

A shared infrastructure layer provides common data access, security, and isolation mechanisms across both systems.

---

## System 1: Bidding (Inbound)

The Bidding system manages the end-to-end lifecycle of incoming bid opportunities that the organisation evaluates and responds to.

### ZA Govt Tender Intelligence (OCDS API, web scraping)

- Ingests tender notices from South African government portals via the Open Contracting Data Standard (OCDS) API.
- Falls back to web scraping for portals that do not expose an OCDS feed.
- Normalises notices into a standardised opportunity record for downstream processing.

### Bid Opportunity Pipeline

- Central pipeline that receives, deduplicates, enriches, and routes bid opportunities.
- Stages: Discovery → Validation → Enrichment → Assignment → Tracking.
- Supports manual entry alongside automated ingestion.

### Bid Preparation Suite

- Collaborative workspace for bid teams to compile responses.
- Document generation, version control, compliance checklists, and deadline management.
- Integrates with Estimating for cost modelling and with Contracts for terms review.

### Market Intelligence

- Aggregates historical bid data, competitor analysis, and pricing trends.
- Dashboards and reports to inform go/no-go decisions and bid strategy.
- Sources include public records, industry publications, and internal win/loss data.

### Win/Loss Analytics

- Tracks bid outcomes and captures reasons for wins and losses.
- Provides win-rate analysis by sector, region, client, and bid value.
- Feeds back into Market Intelligence and bid strategy refinement.

---

## System 2: Tendering (Outbound)

The Tendering system manages the creation, issuance, evaluation, and award of tenders that the organisation sends to external parties.

### Multi-Type Tender Management (SUBCON, PO, SO, WO, HO)

- Supports multiple tender types, each with its own workflow and template set:
  - **SUBCON** — Subcontract tenders
  - **PO** — Purchase Order tenders
  - **SO** — Service Order tenders
  - **WO** — Work Order tenders
  - **HO** — Home Office / internal service tenders
- Each type enforces type-specific fields, approval chains, and document templates.

### RFQ Lifecycle

- Manages the Request for Quotation process from creation to award.
- Stages: Draft → Issue → Clarification → Receipt → Evaluation → Award.
- Supports multi-round RFQs and automatic reminders.

### Bid Evaluation Engine

- Configurable evaluation framework supporting price, quality, and weighted scoring models.
- Comparison views, automatic bid tabulation, and audit trails.
- Supports committee-based evaluation with sign-off workflows.

### Award-to-Contract Pipeline

- Manages the transition from tender award to formal contract creation.
- Generates award letters, contract documents, and handover packs.
- Integrates with the Contracts discipline for contract lifecycle management.

### External Vendor Portal

- Self-service portal for vendors and subcontractors to view tenders, submit responses, and track award status.
- Secure authentication, document upload, and Q&A functionality.
- Reduces administrative overhead for both the organisation and its vendors.

---

## Shared Infrastructure Layer

Both systems are built on a common infrastructure layer that provides:

| Capability | Description |
|---|---|
| **Option B parallel tables** | Multi-tenant data isolation using PostgreSQL schemas (one schema per tenant), ensuring data separation without per-tenant database instances. |
| **Row-Level Security (RLS)** | Fine-grained access control at the row level, enforcing discipline-based and role-based visibility within each tenant schema. |
| **Credential isolation** | Per-tenant database credentials and API keys, preventing cross-tenant data leakage. |
| **Audit logging** | Centralised audit trail capturing all data mutations across both systems, with tenant and user attribution. |
| **Shared service bus** | Asynchronous event bus for cross-system communication (e.g., a bid win triggers a tender creation). |

---

## Component Map

The following table maps each major component to its owning system and infrastructure layer.

| Component | System | Layer |
|---|---|---|
| ZA Govt Tender Intelligence | Bidding (Inbound) | Ingestion |
| Bid Opportunity Pipeline | Bidding (Inbound) | Pipeline |
| Bid Preparation Suite | Bidding (Inbound) | Application |
| Market Intelligence | Bidding (Inbound) | Analytics |
| Win/Loss Analytics | Bidding (Inbound) | Analytics |
| Multi-Type Tender Management | Tendering (Outbound) | Application |
| RFQ Lifecycle | Tendering (Outbound) | Pipeline |
| Bid Evaluation Engine | Tendering (Outbound) | Engine |
| Award-to-Contract Pipeline | Tendering (Outbound) | Pipeline |
| External Vendor Portal | Tendering (Outbound) | Portal |
| Tenant Schema Manager | Shared | Infrastructure |
| RLS Policy Engine | Shared | Infrastructure |
| Credential Vault | Shared | Infrastructure |
| Audit Logger | Shared | Infrastructure |
| Service Bus | Shared | Infrastructure |

---

## API Surface

The platform exposes two distinct API route prefixes, one for each system.

| System | Route Prefix | Purpose |
|---|---|---|
| Bidding (Inbound) | `/api/v1/bidding` | All inbound bid operations — opportunities, preparation, intelligence, analytics |
| Tendering (Outbound) | `/api/v1/tendering` | All outbound tender operations — tender management, RFQs, evaluation, vendor portal |
| Shared | `/api/v1/shared` | Cross-cutting concerns — tenant management, audit, health checks |

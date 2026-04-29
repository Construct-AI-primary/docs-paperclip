---
title: "PROC-INTEL — Supplier Intelligence & Market Analysis Override Specification"
description: "Procurement-specific overrides for the 01900 Supplier Intelligence & Market Analysis system. This document defines what's unique to PROC-INTEL — market trend analysis, supplier positioning, competitive intelligence, strategic sourcing, and risk assessment. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-INTEL
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - supplier-intelligence
  - market-analysis
  - competitive-intelligence
  - strategic-sourcing
  - risk-assessment
  - override
---

# PROC-INTEL — Supplier Intelligence & Market Analysis Override Specification

## Purpose

This document defines the **PROC-INTEL Supplier Intelligence overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `intelWorkflow` | Market Trend Analysis → Supplier Positioning → Competitive Intelligence → Strategic Sourcing → Risk Assessment | §2 |
| `roleGate` | `user.role >= 'viewer'` for intelligence reports; `>= 'editor'` for analysis | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `intelCategories` | Market Trends, Supplier Positioning, Competitive Intel, Strategic Sourcing, Risk | §2 |

---

## 2. Intelligence Workflow Overrides

### 2.1 Market Analysis Dashboard

| Dashboard Section | Widgets | Data Source |
|------------------|---------|-------------|
| Market Overview | Price trends, supply/demand indicators, key events | Market data feeds, industry reports |
| Supplier Map | Geographic supplier distribution, capability heatmap | Supplier directory, qualification data |
| Competitive Landscape | Market share analysis, competitor positioning | Industry analysis, tender data |
| Risk Monitor | Supplier risk scores, geopolitical alerts, financial health | Risk assessment engine |

### 2.2 Strategic Sourcing Recommendations

The AI agent generates sourcing recommendations based on:

| Factor | Weight | Data Source |
|--------|--------|-------------|
| Market Price Trend | 0.25 | Historical pricing data |
| Supplier Performance | 0.20 | Supplier quality scores |
| Supply Risk | 0.20 | Risk assessment engine |
| Lead Time | 0.15 | Historical delivery data |
| Innovation Capability | 0.10 | Supplier assessment |
| Sustainability Score | 0.10 | ESG compliance data |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Intelligence Agents

| Agent | Role | Description |
|-------|------|-------------|
| Market Analyst | Market trend analysis and reporting | Tracks price movements, supply/demand shifts |
| Supplier Intelligence Analyst | Supplier profiling and positioning | Evaluates supplier capabilities, financial health |
| Risk Analyst | Supply chain risk assessment | Identifies and scores supplier/geopolitical risks |

### 3.2 Upserts State — Intelligence Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Run Market Analysis** | `user.role >= 'editor'` | Opens MarketAnalysis modal | `MarketAnalysis` — 98vw |
| **Profile Supplier** | `user.role >= 'editor'` | Opens SupplierProfile modal | `SupplierProfile` — 98vw |
| **Assess Risk** | `user.role >= 'editor'` | Opens RiskAssessment modal | `RiskAssessment` — 98vw |

### 3.3 Workspace State — Intelligence Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Generate Intelligence Report** | `user.role >= 'viewer'` | Opens IntelReport modal | `IntelReport` — 98vw |
| **Export Market Data** | `user.role >= 'viewer'` | Opens DataExport modal | `DataExport` — 98vw |
| **Set Alerts** | `user.role >= 'editor'` | Opens AlertConfig modal | `AlertConfig` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Supplier Risk Scoring

| Risk Category | Factors | Weight |
|---------------|---------|--------|
| Financial Risk | Credit rating, D&B score, payment history | 0.30 |
| Operational Risk | Delivery performance, quality incidents, capacity | 0.25 |
| Geopolitical Risk | Country risk, regulatory environment | 0.20 |
| Compliance Risk | CIDB/BBBEE status, regulatory violations | 0.15 |
| Strategic Risk | Dependency level, substitution difficulty | 0.10 |

### 4.2 Intelligence Report Types

| Report Type | Content | Frequency |
|-------------|---------|-----------|
| Market Flash | Key price movements, urgent alerts | Daily |
| Supplier Brief | Single supplier deep-dive profile | On request |
| Category Analysis | Market trends for specific procurement category | Monthly |
| Risk Dashboard | Consolidated risk scores across supplier base | Real-time |
| Strategic Sourcing Review | Sourcing recommendations with rationale | Quarterly |

---

## 5. Testing Checklist (PROC-INTEL-specific)

- [ ] Market trend analysis engine correctly identifies price movements
- [ ] Supplier positioning map renders with correct geographic data
- [ ] Risk assessment calculates scores across all categories
- [ ] Strategic sourcing recommendations consider all weighted factors
- [ ] Intelligence reports generate in correct format (PDF, HTML)
- [ ] Alert system triggers on configured thresholds
- [ ] Role gates restrict analysis actions to authorized users

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-INTEL override specification |

---

**Document Information**
- **Project**: PROC-INTEL — Supplier Intelligence & Market Analysis
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)

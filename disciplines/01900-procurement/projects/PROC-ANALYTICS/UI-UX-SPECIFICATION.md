---
title: "PROC-ANALYTICS — Procurement Analytics & KPI Reporting Override Specification"
description: "Procurement-specific overrides for the 01900 Procurement Analytics & KPI Reporting system. This document defines what's unique to PROC-ANALYTICS — KPI management, trend analysis, dashboard visualization, and executive reporting. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-ANALYTICS
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - procurement-analytics
  - kpi-management
  - trend-analysis
  - dashboard
  - executive-reporting
  - override
---

# PROC-ANALYTICS — Procurement Analytics & KPI Reporting Override Specification

## Purpose

This document defines the **PROC-ANALYTICS Procurement Analytics overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `analyticsWorkflow` | KPI Calculation → Dashboard Rendering → Trend Analysis → Reporting | §2 |
| `roleGate` | `user.role >= 'viewer'` for dashboards; `>= 'editor'` for KPI configuration | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `kpiCategories` | Financial, Operational, Quality, Compliance, Supplier | §2 |

---

## 2. Analytics Workflow Overrides

### 2.1 KPI Categories (Procurement-specific)

| Category | Example KPIs | Refresh Rate |
|----------|-------------|--------------|
| Financial | Total spend, PO value, cost savings, budget variance | Daily |
| Operational | Order cycle time, approval turnaround, PO count | Real-time |
| Quality | NCR rate, defect percentage, supplier quality score | Weekly |
| Compliance | Audit pass rate, regulatory compliance score | Monthly |
| Supplier | Supplier performance score, on-time delivery rate | Weekly |

### 2.2 Dashboard Widget Types

| Widget Type | Visualization | Use Case |
|-------------|--------------|----------|
| KPI Card | Single metric with trend arrow | At-a-glance performance |
| Line Chart | Time series with forecast | Spend trends over time |
| Bar Chart | Category comparison | Supplier performance comparison |
| Pie Chart | Distribution breakdown | Spend by category |
| Gauge | Threshold indicator | Budget utilization |
| Heatmap | Grid with colour intensity | Supplier risk matrix |
| Trend Indicator | Up/down/stable arrow | Directional movement |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Analytics Agents

| Agent | Role | Capabilities |
|-------|------|-------------|
| KPI Analyst | KPI calculation and monitoring | Calculates all procurement KPIs, monitors thresholds |
| Trend Analyst | Trend detection and forecasting | Identifies patterns, generates forecasts |
| Report Generator | Executive report generation | Creates scheduled and ad-hoc reports |

### 3.2 Upserts State — Analytics Configuration

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Create Dashboard** | `user.role >= 'editor'` | Opens DashboardBuilder modal | `DashboardBuilder` — 98vw |
| **Configure KPI** | `user.role >= 'editor'` | Opens KPIConfig modal | `KPIConfig` — 98vw |
| **Upload Benchmark** | `user.role >= 'editor'` | Opens BenchmarkUpload modal | `BenchmarkUpload` — 98vw |

### 3.3 Workspace State — Analytics Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Generate Report** | `user.role >= 'editor'` | Opens ReportGenerator modal | `ReportGenerator` — 98vw |
| **Export Dashboard** | `user.role >= 'viewer'` | Opens Export modal | `Export` — 98vw, format selector |
| **Schedule Report** | `user.role >= 'editor'` | Opens ScheduleConfig modal | `ScheduleConfig` — 98vw |

---

## 4. Visualization Specifications

### 4.1 KPI Card Component
```
┌──────────────────────────────────┐
│  Total Spend (MTD)    ▲ 12.3%   │
│  ┌────────────────────────────┐  │
│  │     R 12,450,000.00       │  │
│  │     Budget: R 15M         │  │
│  │     ━━━━━━━━━━━━━━━━━ 83% │  │
│  └────────────────────────────┘  │
│  Updated: 2 min ago             │
└──────────────────────────────────┘
```

### 4.2 Trend Line Chart (Spend Over Time)
```
   R 15M ┤
   R 12M ┤       ╱╲      ╱╲
   R 10M ┤  ╱╲  ╱  ╲  ╱  ╲  ╱╲
   R  7M ┤ ╱  ╲╱    ╲╱    ╲╱  ╲
   R  5M ┤╱
         └─────────────────────────
           J   F   M   A   M   J
```

---

## 5. Report Generation Specifications

### 5.1 Report Types

| Type | Frequency | Content | Distribution |
|------|-----------|---------|--------------|
| Daily Flash | Daily | Key metrics, alerts | Dashboard, email |
| Weekly Summary | Weekly | All KPIs, trends, anomalies | Email, PDF |
| Monthly Report | Monthly | Executive summary, benchmarks | PDF, Excel |
| Quarterly Review | Quarterly | Strategic insights, forecasts | Board presentation |

### 5.2 Export Formats
- PDF (with branded template)
- Excel (with raw data + charts)
- HTML (interactive web report)

---

## 6. Testing Checklist (PROC-ANALYTICS-specific)

- [ ] KPI calculations produce correct values for all 5 categories
- [ ] Dashboard renders all widget types correctly
- [ ] Trend detection identifies increasing, decreasing, and stable patterns
- [ ] Forecast generation produces accurate predictions
- [ ] Benchmark comparison shows percentile positioning
- [ ] Report generation creates correct output in all formats
- [ ] Real-time dashboard updates via Supabase subscriptions

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-ANALYTICS override specification |

---

**Document Information**
- **Project**: PROC-ANALYTICS — Procurement Analytics & KPI Reporting
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)

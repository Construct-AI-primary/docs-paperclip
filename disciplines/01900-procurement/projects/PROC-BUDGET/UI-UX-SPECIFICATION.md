---
title: "PROC-BUDGET — Procurement Budget Management Override Specification"
description: "Procurement-specific overrides for the 01900 Procurement Budget Management system. This document defines what's unique to PROC-BUDGET — budget planning, spend monitoring, variance analysis, cost control, and budget reallocation. Core behaviours are inherited from the discipline-level spec."
version: 1.0
date: 2026-04-29
project_code: PROC-BUDGET
discipline: 01900-procurement
extends: docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - budget-management
  - spend-monitoring
  - variance-analysis
  - cost-control
  - budget-reallocation
  - override
---

# PROC-BUDGET — Procurement Budget Management Override Specification

## Purpose

This document defines the **PROC-BUDGET Budget Management overrides** for the 01900 Procurement discipline. All core behaviour (three-state navigation, modal sizing, colour scheme, chatbot config, HITL review gates) is defined in:

> **[01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

Only the project-specific customisations listed below differ from the discipline-level base.

---

## 1. Override Summary

| Override | Value | Where Defined |
|----------|-------|---------------|
| `budgetWorkflow` | Budget Planning → Spend Monitoring → Variance Analysis → Cost Control → Reallocation | §2 |
| `roleGate` | `user.role >= 'viewer'` for dashboards; `>= 'editor'` for budget actions | §3 |
| `disciplineCode` | `"01900"` | §4 |
| `accentColour` | `#FF8C00` (01900 Procurement standard orange) | §4 |
| `budgetCategories` | Labour, Materials, Equipment, Services, Contingency | §2 |

---

## 2. Budget Workflow Overrides

### 2.1 Budget Management Dashboard

| Dashboard Section | Widgets | Data Source |
|------------------|---------|-------------|
| Budget Overview | Total budget, spend to date, remaining, % utilized | Budget summary table |
| Category Breakdown | Spend by category bar chart, budget vs actual | Budget line items |
| Variance Alerts | Items exceeding threshold (red/yellow/green) | Variance calculation engine |
| Forecast | Projected spend vs remaining budget | Trend analysis engine |

### 2.2 Budget Reallocation Flow

| Step | Action | Required Role |
|------|--------|---------------|
| 1 | Select source budget line item with surplus | `user.role >= 'editor'` |
| 2 | Select target budget line item with deficit | `user.role >= 'editor'` |
| 3 | Enter amount and justification | `user.role >= 'editor'` |
| 4 | Submit for approval | `user.role >= 'editor'` |
| 5 | Approval routing based on amount | `user.role >= 'reviewer'` |

---

## 3. State-Specific Overrides

### 3.1 Agents State — Budget Agents

| Agent | Role | Description |
|-------|------|-------------|
| Budget Planner | Budget development and baseline setting | Creates project budgets, allocates contingency |
| Cost Controller | Real-time spend monitoring and variance tracking | Monitors spend against budget, flags variances |
| Reallocation Manager | Budget reallocation processing | Manages transfer requests between line items |

### 3.2 Upserts State — Budget Management

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **Create Budget** | `user.role >= 'editor'` | Opens BudgetCreation modal | `BudgetCreation` — 98vw |
| **Reallocate Funds** | `user.role >= 'editor'` | Opens Reallocation modal | `Reallocation` — 98vw |
| **Adjust Baseline** | `user.role >= 'manager'` | Opens BaselineAdjustment modal | `BaselineAdjustment` — 98vw |

### 3.3 Workspace State — Budget Dashboard

| Button | Visibility Gate | Action | Modal |
|--------|----------------|--------|-------|
| **View Variances** | `user.role >= 'viewer'` | Opens VarianceDetail modal | `VarianceDetail` — 98vw |
| **Run Forecast** | `user.role >= 'editor'` | Opens Forecast modal | `Forecast` — 98vw |
| **Export Report** | `user.role >= 'viewer'` | Opens Export modal | `Export` — 98vw |

---

## 4. Workflow-Specific Specifications

### 4.1 Variance Thresholds

| Variance % | Colour | Action Required |
|------------|--------|----------------|
| 0-5% | Green | Monitor |
| 5-10% | Yellow | Flag for review |
| 10-15% | Orange | Create variance report |
| > 15% | Red | Escalate to management |

### 4.2 Approval Levels for Reallocation

| Reallocation Amount | Approval Required |
|--------------------|------------------|
| < 25K | Budget Manager |
| 25K - 100K | Procurement Manager |
| > 100K | Executive Approval |

---

## 5. Testing Checklist (PROC-BUDGET-specific)

- [ ] Budget creation wizard correctly sets baseline with categories
- [ ] Spend monitoring dashboard shows real-time data
- [ ] Variance alerts trigger at correct thresholds
- [ ] Reallocation workflow routes to correct approvers
- [ ] Forecast projection uses historical trends accurately
- [ ] Export report includes all budget data in correct format
- [ ] Role gates enforce correct access to budget actions

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial PROC-BUDGET override specification |

---

**Document Information**
- **Project**: PROC-BUDGET — Procurement Budget Management
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01900 Procurement — UI/UX Specification](../../UI-UX-SPECIFICATION.md)

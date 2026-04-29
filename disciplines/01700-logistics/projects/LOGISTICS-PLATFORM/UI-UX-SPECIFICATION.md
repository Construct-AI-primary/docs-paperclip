---
title: "LOGISTICS-PLATFORM — Logistics Platform UI/UX Specification"
description: "Complete UI/UX specification for the LOGISTICS-PLATFORM project under 01700 Logistics. Extends the discipline-level 01700 Logistics specification with platform-specific customisations for customs management, logistics operations, and freight tracking workflows. Uses an Amber colour scheme and full platform architecture across desktop, mobile, shared, and web."
version: 1.0
date: 2026-04-29
project_code: LOGISTICS-PLATFORM
discipline: 01700-logistics
extends: docs-paperclip/disciplines/01700-logistics/UI-UX-SPECIFICATION.md
gigabrain_tags:
  - logistics
  - platform
  - ui-ux
  - customs-management
  - freight-tracking
  - operations
  - specification
---

# LOGISTICS-PLATFORM — Logistics Platform UI/UX Specification

## Purpose

This document defines the **LOGISTICS-PLATFORM** project — a full logistics platform under the 01700 Logistics discipline. It extends the discipline-level specification defined in:

> **[01700 Logistics — UI/UX Specification](../../UI-UX-SPECIFICATION.md)**

All standard behaviours (three-state navigation, modal patterns, chatbot configuration, AI model backend, agent ownership) are inherited from the parent discipline spec unless overridden below.

---

## 1. Platform Overview

### 1.1 Scope

LOGISTICS-PLATFORM is a comprehensive logistics operations platform covering three primary workflow domains:

| Domain | Description |
|--------|-------------|
| **Customs Management** | Customs declarations, clearance tracking, regulatory compliance, duty calculation |
| **Logistics Operations** | Order management, route planning, carrier coordination, delivery scheduling |
| **Freight Tracking** | Real-time tracking, container monitoring, shipment visibility, exception management |

### 1.2 Platform Surfaces

| Surface | Scope | Issues Prefix |
|---------|-------|---------------|
| Desktop | Full operations dashboard, management interfaces | LOGISTICS- |
| Mobile | Field operations, scanning, real-time updates | LOGISTICS-MOBILE- |
| Shared | Cross-cutting auth, data models, API layer | LOGISTICS-SHARED- |
| Web | External portal for carriers and customers | LOGISTICS-WEB- |

---

## 2. Override Summary vs Discipline Spec

| Override | 01700 Discipline Default | LOGISTICS-PLATFORM Override |
|----------|------------------------|----------------------------|
| Colour scheme | Blue palette (`#1565C0` primary) | Amber palette (`#FFBF00`, `#FFD700`) |
| Primary workflows | General logistics | Customs management, logistics operations, freight tracking |
| Entity sources | Generic logistics records | Customs declarations, shipping containers, freight shipments |
| Role model | viewer → admin | Enhanced with customs broker, freight coordinator roles |
| Accent colour | Blue (`#1565C0`) | Amber (`#FFBF00`) |
| Document types | Logistics docs | Customs docs (bills of lading, commercial invoices), freight docs |

---

## 3. Platform-Specific Color Scheme

### 3.1 Amber Palette

```css
:root {
  /* Primary Palette — Amber */
  --platform-primary: #FFBF00;
  --platform-secondary: #FFD700;
  --platform-accent: #FF8F00;
  --platform-dark: #E65100;

  /* Header Gradient */
  --platform-header-gradient: linear-gradient(135deg, #FF8F00 0%, #FFBF00 50%, #FFD700 100%);

  /* Backgrounds */
  --platform-bg-gradient: linear-gradient(135deg, #FFFDE7 0%, #FFF8E1 100%);
  --platform-card-bg: #FFFFFF;

  /* Text */
  --platform-text-primary: #1A1A1A;
  --platform-text-secondary: #5D4037;
  --platform-text-white: #FFFFFF;

  /* Status Colours */
  --platform-success: #2E7D32;
  --platform-warning: #F57F17;
  --platform-danger: #C62828;
  --platform-info: #1565C0;

  /* Shadows */
  --platform-shadow-sm: 0 2px 4px rgba(255, 191, 0, 0.12);
  --platform-shadow-md: 0 4px 8px rgba(255, 191, 0, 0.18);
  --platform-shadow-lg: 0 8px 24px rgba(255, 191, 0, 0.25);
}
```

### 3.2 Semantic Status Indicators

| Status | Colour | Hex Code | Usage |
|--------|--------|----------|-------|
| Cleared | Green | `#2E7D32` | Customs cleared, shipment delivered |
| In Progress | Amber | `#FFBF00` | Under review, in transit |
| On Hold | Orange | `#FF8F00` | Customs hold, inspection required |
| Rejected | Red | `#C62828` | Customs rejection, shipment exception |
| Information | Blue | `#1565C0` | Documentation required, info needed |

---

## 4. Platform-Specific Workflow Overrides

### 4.1 Customs Management Workflow

| Element | Description |
|---------|-------------|
| Entity source | Customs declarations, tariff classifications, duty calculations |
| Number sources | Customs broker contacts, regulatory agency hotlines |
| Document sources | Bills of lading, commercial invoices, packing lists, certificates of origin |
| Key actions | Submit declaration, track clearance, manage inspections, calculate duties |
| Role gate | `user.role >= 'customs_officer'` for declaration submission |
| Trigger | New shipment requiring customs clearance |

### 4.2 Logistics Operations Workflow

| Element | Description |
|---------|-------------|
| Entity source | Logistics orders, route plans, carrier assignments |
| Number sources | Carrier dispatch, warehouse supervisors, fleet managers |
| Document sources | Delivery orders, route manifests, pickup schedules |
| Key actions | Create order, assign carrier, optimise route, confirm delivery |
| Role gate | `user.role >= 'editor'` for order creation |
| Trigger | New logistics requirement or order |

### 4.3 Freight Tracking Workflow

| Element | Description |
|---------|-------------|
| Entity source | Shipping containers, freight shipments, tracking events |
| Number sources | Freight forwarders, terminal operators, shipping line contacts |
| Document sources | Booking confirmations, arrival notices, exception reports |
| Key actions | Track shipment, manage exceptions, update ETA, notify stakeholders |
| Role gate | `user.role >= 'viewer'` for tracking access |
| Trigger | Shipment booking or container assignment |

---

## 5. Entity & Data Sources

### 5.1 Entity ID Source

When any workflow modal is triggered, the relevant entity ID is passed:

```typescript
interface PlatformWorkflowProps {
  entityType: 'customs_declaration' | 'logistics_order' | 'freight_shipment';
  entityId: string;
  entityName: string;
  workflowId: string;
  userId: string;
}
```

### 5.2 Phone Number Sources

| Workflow | Primary Source | Secondary Source |
|----------|---------------|-----------------|
| Customs Management | `customs_brokers.phone` | `regulatory_agencies.phone` |
| Logistics Operations | `carrier_contacts.phone` | `warehouse_supervisors.phone` |
| Freight Tracking | `freight_forwarders.phone` | `terminal_operators.phone` |

---

## 6. Document Sources

### 6.1 Customs Management Documents

| Source | Description | Max Count |
|--------|-------------|-----------|
| Customs declarations | Submitted and draft declarations | All |
| Supporting documents | Invoices, packing lists, certificates | 20 |
| Regulatory correspondence | Communications with customs authority | 10 |

### 6.2 Logistics Operations Documents

| Source | Description | Max Count |
|--------|-------------|-----------|
| Delivery orders | Active and completed delivery orders | All |
| Route manifests | Driver route schedules and manifests | 10 |
| Proof of delivery | Signed delivery confirmations | 20 |

### 6.3 Freight Tracking Documents

| Source | Description | Max Count |
|--------|-------------|-----------|
| Booking confirmations | Carrier booking and confirmation docs | All |
| Arrival notices | Terminal arrival and notification docs | 10 |
| Exception reports | Damage, delay, and exception reports | 10 |

### 6.4 Platform-specific Purpose Labels

| Label | Workflow | Description |
|-------|----------|-------------|
| "Customs declaration" | Customs | The customs declaration being processed |
| "Bill of lading" | Customs/Freight | The bill of lading for the shipment |
| "Commercial invoice" | Customs | Commercial invoice for valuation |
| "Delivery order" | Operations | Delivery order for the consignment |
| "Route manifest" | Operations | Driver or carrier route manifest |
| "Booking confirmation" | Freight | Carrier booking confirmation |
| "Arrival notice" | Freight | Terminal arrival notification |
| "Exception report" | Freight | Damage, loss, or delay report |
| "Certificate of origin" | Customs | Country of origin certificate |
| "Packing list" | Customs/Freight | Packing list for the shipment |

---

## 7. Role Gates & Permissions

### 7.1 Platform Role Model

| Role | Level | Customs | Operations | Freight |
|------|-------|---------|------------|---------|
| `viewer` | 0 | View tracking | View orders | View tracking |
| `editor` | 1 | Edit declarations | Create/edit orders | Update tracking |
| `customs_officer` | 2 | Submit/approve | — | — |
| `freight_coordinator` | 2 | — | Route optimisation | Manage exceptions |
| `admin` | 3 | Full access | Full access | Full access |

### 7.2 Gate Expressions

| Action | Gate |
|--------|------|
| View shipment tracking | `user.role >= 'viewer'` |
| Create logistics order | `user.role >= 'editor'` |
| Submit customs declaration | `user.role >= 'customs_officer'` |
| Manage freight exceptions | `user.role >= 'freight_coordinator'` |
| Approve/reject actions | `user.role >= 'admin'` |
| System configuration | `user.role === 'admin'` |

---

## 8. Platform-Specific Integration Points

### 8.1 External System Integrations

| System | Workflow | Integration Type |
|--------|----------|-----------------|
| Customs authority portal | Customs | API submission + status polling |
| Carrier TMS | Operations | Order creation + tracking updates |
| Terminal operating system | Freight | Container status + gate events |
| Shipping line API | Freight | Booking + vessel schedule |

### 8.2 VoiceForge AI Integration

VoiceForge AI is used for automated call context in customs and freight workflows. When a call is placed from any workflow, the context payload includes:

```json
{
  "to": "{{selectedPhoneNumber.value}}",
  "from": "{{platformOutboundId}}",
  "context": {
    "entityId": "{{declarationId | orderId | shipmentId}}",
    "entityType": "customs_declaration | logistics_order | freight_shipment",
    "workflowId": "{{workflowId}}",
    "userId": "{{currentUserId}}",
    "discipline": "01700",
    "documents": []
  }
}
```

---

## 9. Mobile-Specific Adaptations

| Feature | Desktop | Mobile |
|---------|---------|--------|
| Navigation | Three-state nav (Agents/Upserts/Workspace) | Bottom tab bar |
| Customs dashboard | Full table with filters | Card-based summary |
| Tracking map | Full-screen map | Compact map with pinch-zoom |
| Document scanner | File upload | Camera capture + OCR |
| Notifications | Toast + sidebar | Push notifications |
| Touch targets | Standard | Minimum 48dp |

---

## 10. Testing Checklist (Platform-specific)

- [ ] Amber colour scheme applied correctly across all surfaces
- [ ] Customs management workflow: declaration submission, clearance tracking, duty calculation
- [ ] Logistics operations workflow: order creation, route optimisation, delivery confirmation
- [ ] Freight tracking workflow: real-time tracking, exception management, ETA updates
- [ ] Role gates enforced per §7.2
- [ ] Mobile adaptations per §9 render correctly
- [ ] Document attachments per §6 available in each workflow
- [ ] VoiceForge AI context payload includes correct entity type and workflow ID
- [ ] Audit log records `discipline: "01700"` with entity type
- [ ] Cross-workflow navigation maintains state

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial LOGISTICS-PLATFORM specification |

---

**Document Information**
- **Project**: LOGISTICS-PLATFORM
- **Discipline**: 01700 Logistics
- **Date**: 2026-04-29
- **Status**: Active
- **Extends**: [01700 Logistics — UI/UX Specification](../../UI-UX-SPECIFICATION.md)

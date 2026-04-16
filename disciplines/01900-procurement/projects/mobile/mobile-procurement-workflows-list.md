# Mobile Procurement Workflows List (01900)

**Date:** 2026-04-14
**Platform:** Mobile (MobileForge AI)
**Parent Discipline:** 01900 Procurement
**Source Document:** `../desktop/procurement-workflows-list.md`

---

## Overview

This document identifies which desktop procurement workflows can be enhanced by mobile capabilities, assesses current mobile app implementation status, and defines mobile-specific workflow requirements for MobileForge AI.

**Total Desktop Workflows:** 13
**Mobile-Enhanceable Workflows:** 10
**Mobile-Only Workflows:** 3
**Not Suitable for Mobile:** 0

---

## Section 1: Mobile Enhancement Assessment

### Workflow-by-Workflow Mobile Analysis

| # | Desktop Workflow | Mobile Enhancement Potential | Mobile Features | Existing Mobile Code | Gap |
|---|-----------------|---------------------------|-----------------|---------------------|-----|
| 1 | **Procurement Order Creation** (PROC-ORDER) | ✅ HIGH | Voice-to-order, GPS-tagged approvals, offline order creation, camera for document capture | ✅ PurchaseOrderScreen.tsx (589 lines) - voice recognition, GPS approval, item creation | ⚠️ Uses in-memory state, needs DB integration, no supplier selection |
| 2 | **Invoice Processing & 3-Way Match** (PROC-INV) | ✅ HIGH | Camera-based invoice capture, OCR processing, on-site 3-way match, push notifications for discrepancies | ❌ Not implemented | ❌ Full implementation needed |
| 3 | **Supplier Qualification** (PROC-SUPP) | ✅ HIGH | On-site supplier audits, photo documentation, GPS-verified site visits, offline assessment forms | ❌ Not implemented | ❌ Full implementation needed |
| 4 | **Order Tracking & Expediting** (PROC-TRACK) | ✅ HIGH | Real-time shipment tracking, GPS delivery confirmation, push notifications, barcode scanning | ❌ Not implemented | ❌ Full implementation needed |
| 5 | **Budget Monitoring** (PROC-BUDGET) | ⚠️ MEDIUM | Budget alerts, spend dashboard, approval on-the-go | ❌ Not implemented | ❌ Dashboard + alerts needed |
| 6 | **NCR & Quality Management** (PROC-NCR) | ✅ HIGH | Photo-based NCR capture, GPS location tagging, voice notes, offline NCR creation | ❌ Not implemented | ❌ Full implementation needed |
| 7 | **Contract Amendment** (PROC-AMEND) | ⚠️ MEDIUM | Amendment review, digital signatures, approval workflow | ❌ Not implemented | ❌ Review + approval UI needed |
| 8 | **Supplier Intelligence** (PROC-INTEL) | ⚠️ MEDIUM | Market alerts, supplier scorecards, competitive intelligence notifications | ❌ Not implemented | ❌ Dashboard + alerts needed |
| 9 | **Procurement Analytics** (PROC-ANALYTICS) | ⚠️ MEDIUM | KPI dashboards, trend charts, executive summaries | ❌ Not implemented | ❌ Mobile analytics UI needed |
| 10 | **Audit Trail & Compliance** (PROC-AUDIT) | ⚠️ MEDIUM | Audit checklist, photo evidence, GPS verification, offline audit forms | ❌ Not implemented | ❌ Audit UI needed |
| 11 | **Emergency Procurement** (PROC-EMERG) | ✅ HIGH | Emergency request submission, expedited approval, voice justification | ❌ Not implemented | ❌ Emergency workflow needed |
| 12 | **Service Order Management** (PROC-SERVICE) | ⚠️ MEDIUM | Service request creation, on-site verification, photo documentation | ❌ Not implemented | ❌ Service order UI needed |
| 13 | **Long-Lead Item Procurement** (PROC-LONG) | ⚠️ MEDIUM | Critical path alerts, milestone tracking, delivery notifications | ❌ Not implemented | ❌ Tracking UI needed |

---

## Section 2: Mobile-Only Workflows

These workflows are unique to mobile and have no desktop equivalent:

### MOBILE-PROC-VOICE: Voice-Driven Procurement
**Description:** Voice-first procurement workflow allowing hands-free order creation, approval, and status queries
**Mobile Features:**
- Voice-to-order: "Order 50 steel beams from Supplier X"
- Voice approval: "Approve purchase order PO-12345"
- Voice status queries: "What's the status of my orders?"
- Voice incident reporting for procurement issues
**Existing Mobile Code:** ✅ Voice service exists in `services/voiceService.ts`, voice buttons in PurchaseOrderScreen
**Gap:** Voice processing needs actual AI backend integration

### MOBILE-PROC-OFFLINE: Offline Procurement Operations
**Description:** Full offline capability for procurement operations in areas with no connectivity
**Mobile Features:**
- Offline order creation with local SQLite storage
- Offline approval queue with sync on reconnect
- Offline supplier catalog access
- Conflict resolution for concurrent edits
**Existing Mobile Code:** ✅ SQLite exists (`services/database.ts`), syncService scaffolded
**Gap:** Sync service needs full implementation, offline queue not built

### MOBILE-PROC-CAMERA: Camera-Based Procurement
**Description:** Camera-first procurement workflow for document capture, barcode scanning, and visual verification
**Mobile Features:**
- Invoice/document OCR via camera
- Barcode/QR code scanning for goods receipt
- Photo documentation for delivery verification
- Visual quality inspection capture
**Existing Mobile Code:** ✅ expo-camera, expo-barcode-scanner installed
**Gap:** No procurement-specific camera UI implemented

---

## Section 3: Mobile Procurement Project Structure

### Recommended Mobile Projects

| Project ID | Name | Priority | Status | Parent Desktop Workflow |
|------------|------|----------|--------|------------------------|
| MOBILE-PROC-ORDER | Mobile Purchase Order | HIGH | ⚠️ Partial | PROC-ORDER |
| MOBILE-PROC-DASHBOARD | Procurement Dashboard | HIGH | ❌ Missing | Multiple |
| MOBILE-PROC-SUPPLIER | Supplier Management | HIGH | ❌ Missing | PROC-SUPP |
| MOBILE-PROC-INVOICE | Invoice Processing | HIGH | ❌ Missing | PROC-INV |
| MOBILE-PROC-TRACKING | Order Tracking | HIGH | ❌ Missing | PROC-TRACK |
| MOBILE-PROC-VOICE | Voice Procurement | MEDIUM | ⚠️ Partial | Mobile-Only |
| MOBILE-PROC-OFFLINE | Offline Operations | MEDIUM | ⚠️ Partial | Mobile-Only |
| MOBILE-PROC-CAMERA | Camera Procurement | MEDIUM | ❌ Missing | Mobile-Only |
| MOBILE-PROC-NCR | Quality Management | MEDIUM | ❌ Missing | PROC-NCR |
| MOBILE-PROC-BUDGET | Budget Monitoring | LOW | ❌ Missing | PROC-BUDGET |
| MOBILE-PROC-EMERGENCY | Emergency Procurement | LOW | ❌ Missing | PROC-EMERG |
| MOBILE-PROC-ANALYTICS | Procurement Analytics | LOW | ❌ Missing | PROC-ANALYTICS |

---

## Section 4: Current Mobile Code Assessment

### Existing Procurement-Related Mobile Code

| File | Purpose | Status | Issues |
|------|---------|--------|--------|
| `screens/procurement/PurchaseOrderScreen.tsx` | Voice-to-order creation with GPS approval | ⚠️ Partial | In-memory state, no DB, no supplier selection |
| `services/voiceService.ts` | Voice recognition + TTS | ✅ Complete | Needs AI backend integration |
| `services/database.ts` | SQLite local storage | ✅ Complete | Not integrated with procurement |
| `services/syncService.ts` | Offline sync | ⚠️ Scaffolded | Not fully implemented |
| `store/slices/` | Redux state management | ⚠️ Partial | No procurement slice exists |
| `services/aiService.ts` | AI request processing | ✅ Complete | Needs procurement-specific prompts |

### Missing Mobile Components

| Component | Required For | Priority |
|-----------|-------------|----------|
| ProcurementDashboardScreen | Overview of all POs, quick actions | HIGH |
| SupplierListScreen | Supplier selection, qualification | HIGH |
| SupplierDetailScreen | Supplier info, performance history | HIGH |
| InvoiceCaptureScreen | Camera-based invoice capture | HIGH |
| OrderTrackingScreen | Shipment status, delivery tracking | HIGH |
| NCRCaptureScreen | Quality issue documentation | MEDIUM |
| BudgetDashboardScreen | Spend vs budget visualization | MEDIUM |
| EmergencyRequestScreen | Emergency procurement submission | LOW |
| AnalyticsScreen | KPI dashboards, trends | LOW |
| procurementSlice.ts | Redux state for procurement | HIGH |
| procurementService.ts | API + local data management | HIGH |

---

## Section 5: Mobile-Specific Requirements

### Mobile Enhancement Requirements per Workflow

#### MOBILE-PROC-ORDER (Priority: HIGH)
- [ ] Integrate PurchaseOrderScreen with SQLite database
- [ ] Add supplier selection dropdown with search
- [ ] Connect voice AI to actual backend processing
- [ ] Add barcode scanning for item lookup
- [ ] Implement offline order queue with sync
- [ ] Add push notifications for order status changes
- [ ] Create procurement Redux slice
- [ ] Add to navigation stack

#### MOBILE-PROC-DASHBOARD (Priority: HIGH)
- [ ] Create ProcurementDashboardScreen with PO list
- [ ] Add quick action buttons (new order, scan invoice, track order)
- [ ] Implement spend summary cards
- [ ] Add pending approvals list
- [ ] Connect to procurement API
- [ ] Add pull-to-refresh with loading states

#### MOBILE-PROC-SUPPLIER (Priority: HIGH)
- [ ] Create SupplierListScreen with search/filter
- [ ] Create SupplierDetailScreen with performance metrics
- [ ] Add on-site audit form with photo capture
- [ ] Implement GPS-verified site visit logging
- [ ] Add offline supplier catalog access
- [ ] Create supplier qualification workflow

#### MOBILE-PROC-INVOICE (Priority: HIGH)
- [ ] Create InvoiceCaptureScreen with camera integration
- [ ] Implement OCR for invoice data extraction
- [ ] Add 3-way match verification UI
- [ ] Create discrepancy resolution workflow
- [ ] Add push notifications for invoice status
- [ ] Implement offline invoice capture

#### MOBILE-PROC-TRACKING (Priority: HIGH)
- [ ] Create OrderTrackingScreen with shipment list
- [ ] Add real-time status updates via subscriptions
- [ ] Implement GPS delivery confirmation
- [ ] Add barcode scanning for goods receipt
- [ ] Create delay alerting and expediting UI
- [ ] Add push notifications for delivery events

---

## Section 6: Implementation Priority

### Phase 1: Foundation (Weeks 1-4)
1. **MOBILE-PROC-ORDER** — Complete existing PurchaseOrderScreen
2. **MOBILE-PROC-DASHBOARD** — Create procurement dashboard
3. **procurementSlice.ts** — Redux state management
4. **Navigation integration** — Add all screens to app navigation

### Phase 2: Core Workflows (Weeks 5-8)
5. **MOBILE-PROC-SUPPLIER** — Supplier management
6. **MOBILE-PROC-INVOICE** — Invoice capture and processing
7. **MOBILE-PROC-TRACKING** — Order tracking and delivery

### Phase 3: Mobile-Only Features (Weeks 9-12)
8. **MOBILE-PROC-VOICE** — Voice-first procurement
9. **MOBILE-PROC-OFFLINE** — Offline operations
10. **MOBILE-PROC-CAMERA** — Camera-based workflows

### Phase 4: Advanced Features (Weeks 13-16)
11. **MOBILE-PROC-NCR** — Quality management
12. **MOBILE-PROC-BUDGET** — Budget monitoring
13. **MOBILE-PROC-ANALYTICS** — Analytics dashboard

---

## Section 7: Dependencies

### Desktop Dependencies
- Desktop procurement API endpoints must be available
- Supplier database must be accessible via API
- Invoice processing backend must support mobile clients

### Mobile Dependencies
- MobileForge AI app foundation (navigation, state management, database)
- Voice service integration with AI backend
- Camera and barcode scanner permissions
- Push notification service setup
- Offline sync service completion

### Cross-Company Dependencies
- **InfraForge AI**: Mobile-optimized API endpoints, offline sync infrastructure
- **DevForge AI**: Shared procurement API, mobile UI components
- **QualityForge AI**: Mobile testing, NCR workflow validation

---

*This mobile procurement workflows list serves as the roadmap for MobileForge AI procurement implementation. Regular updates should be made as mobile features are developed and desktop workflows are enhanced.*
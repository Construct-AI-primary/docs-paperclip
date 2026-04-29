# Logistics Discipline Adaptation — 01700

> **Discipline Code:** 01700  
> **Discipline:** Logistics & Supply Chain Management  
> **Platform:** LOGISTICS-PLATFORM  
> **Version:** 1.0.0  
> **Status:** Active  

---

## 1. Applicable Standards

| Standard | Scope | Relevance |
|---|---|---|
| **ISO 28000** | Supply chain security management systems | Mandatory — risk assessment, security protocols, supply chain continuity |
| **TAPA FSR** | Freight Security Requirements (Trucking & Warehousing) | Mandatory — physical security, cargo handling, storage |
| **GS1 Standards** | Global trade item numbers (GTIN), SSCC, EDI messages | Mandatory — barcoding, electronic data interchange, traceability |

### 1.1 ISO 28000 — Supply Chain Security

- Risk assessment methodology for security threats across the supply chain.
- Security management system (SMS) documentation requirements.
- Incident reporting and business continuity planning.
- Audit and certification lifecycle (initial, surveillance, recertification).

### 1.2 TAPA FSR (Freight Security Requirements)

- Facility security levels (A, B, C) with corresponding controls.
- Cargo handling and storage security procedures.
- Access control, alarm systems, CCTV requirements.
- Transport security — driver verification, route monitoring, seal integrity.

### 1.3 GS1 Standards

- GTIN allocation and management for product identification.
- SSCC (Serial Shipping Container Code) for logistics units.
- EDI message types (DESADV, INVOIC, ORDERS, IFTMIN).
- Barcode symbologies (EAN-13, GS1-128, GS1 DataMatrix).

---

## 2. CAD / Planning Systems

| System | Purpose | Integration Point |
|---|---|---|
| **Supply Chain Mapping Tools** | Visualisation of supply chain nodes, routes, and dependencies | GIS data import/export, node attribute management |
| **Route Optimisation Systems** | Least-cost / shortest-path routing, multi-stop planning | API-based route calculation, constraint modelling |
| **Warehouse Management Systems (WMS)** | Inventory tracking, putaway, picking, shipping | WMS integration layer, real-time stock visibility |
| **Transport Management Systems (TMS)** | Carrier selection, freight booking, tracking | TMS API, rate shopping, shipment status webhooks |

---

## 3. Analysis Types

| Analysis | Description | Inputs | Outputs |
|---|---|---|---|
| **Route Analysis** | Evaluate cost, time, distance, and risk for planned routes | Origin/destination pairs, carrier rates, transit times | Route comparison matrix, recommended carrier/route |
| **Load Optimisation** | Maximise container/truck utilisation while respecting weight/volume constraints | Item dimensions, weights, container specs, stacking rules | Load plan, utilisation report, stowage diagram |
| **Customs Compliance** | Validate documentation and classification for cross-border shipments | HS codes, country of origin, commercial invoice, certificates of origin | Compliance score, missing document alerts, duty estimate |
| **Security Risk Assessment** | Identify vulnerabilities in the supply chain per ISO 28000 | Node locations, threat intelligence, security controls in place | Risk heat map, mitigation recommendations |
| **Carrier Performance** | Measure on-time delivery, damage rate, cost variance | Carrier scorecards, shipment tracking data | Performance dashboard, carrier ranking |

---

## 4. Document Templates

| Template | Description | Fields |
|---|---|---|
| **Bill of Lading (B/L)** | Contract of carriage between shipper and carrier | Shipper, consignee, vessel/voyage, port of loading/discharge, container numbers, seal numbers, description of goods, gross weight, measurement |
| **Packing List** | Itemised list of contents in each package | Package number, GTIN, description, quantity, net/gross weight, dimensions, marks & numbers |
| **Customs Declaration** | Official declaration for customs clearance | HS code, country of origin, declared value, currency, incoterms, exporter reference, consignee reference |
| **Commercial Invoice** | Seller's invoice for goods sold | Seller/buyer details, invoice number, date, itemised goods, unit price, total value, incoterms, payment terms |
| **Certificate of Origin** | Certifies the country of origin of goods | Exporter, consignee, origin criterion, goods description, certifying authority stamp |

---

## 5. Pilot Issue — LOGISTICS-PLATFORM-001

| Field | Value |
|---|---|
| **Issue ID** | LOGISTICS-PLATFORM-001 |
| **Title** | Multi-modal route optimisation with customs hold detection |
| **Description** | The platform must support route optimisation across multiple transport modes (ocean, air, road, rail) while detecting customs holds at border crossings and adjusting the route plan accordingly. |
| **Priority** | P1 — Critical |
| **Status** | In Progress |
| **Assigned Discipline** | Logistics (01700) |
| **Dependencies** | Customs compliance engine, real-time tracking data feed, route optimisation solver |
| **Success Criteria** | 1. Route engine returns multi-modal options ranked by cost/time. 2. Customs hold events trigger automatic re-routing. 3. Re-routing completes within 60 seconds of hold detection. |
| **Related Standards** | ISO 28000 (security continuity), GS1 EDI (shipment status messages) |

---

## 6. Discipline-Specific Configuration

### 6.1 Unit System

- **Distance:** kilometres (km) / nautical miles (nmi) for maritime
- **Weight:** kilograms (kg) / metric tonnes (t)
- **Volume:** cubic metres (m³)
- **Temperature:** Celsius (°C)
- **Currency:** USD (configurable per route)

### 6.2 Incoterms Support

The platform must support all 11 Incoterms 2020 rules:
EXW, FCA, FAS, FOB, CFR, CIF, CPT, CIP, DAP, DPU, DDP

### 6.3 HS Code Classification

- 6-digit international HS code (mandatory)
- Country-specific extensions (8–10 digits) where applicable
- Automated classification suggestions based on product description

---

## 7. Related Documents

| Document | Location |
|---|---|
| DevForge AI Integration | `../ai-integrations/devforge-ai-integration.md` |
| KnowledgeForge AI Integration | `../ai-integrations/knowledgeforge-ai-integration.md` |
| Heartbeat Monitoring Config | `../HEARTBEAT-MONITORING-CONFIG.md` |
| Platform Overview | `../LOGISTICS-PLATFORM-OVERVIEW.md` |

---

*Document generated for Paperclip Discipline Automation — Logistics (01700)*

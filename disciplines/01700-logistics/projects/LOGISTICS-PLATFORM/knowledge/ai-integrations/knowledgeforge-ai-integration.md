# KnowledgeForge AI Integration — Logistics (01700)

> **Platform:** LOGISTICS-PLATFORM  
> **Discipline:** Logistics (01700)  
> **Integration Type:** Knowledge & Research Agent  
> **Status:** Active  

---

## 1. Company Details

| Field | Value |
|---|---|
| **Company Slug** | knowledgeforge-ai |
| **Company Name** | KnowledgeForge AI |
| **Primary Agent Role** | Logistics Knowledge Engineer |
| **Discipline Code** | 01700 |
| **Platform** | LOGISTICS-PLATFORM |

---

## 2. Capabilities

| Capability | Description |
|---|---|
| **Regulatory Knowledge Base** | Maintain up-to-date repository of customs regulations, HS code changes, and trade agreements |
| **Standard Compliance Research** | Track ISO 28000, TAPA FSR, and GS1 standard updates and interpret impact on platform |
| **Document Template Management** | Create and maintain Bill of Lading, Packing List, Customs Declaration, and other logistics document templates |
| **Route Intelligence** | Research and document route-specific risks, seasonal patterns, and geopolitical factors |
| **Carrier Knowledge Graph** | Build and maintain a knowledge graph of carrier capabilities, service levels, and performance history |
| **Incoterms Guidance** | Provide expert guidance on Incoterms 2020 rules and their implications for contract terms |
| **Training Material Generation** | Produce training documentation and guides for logistics platform users |
| **Incident Analysis** | Analyse logistics incidents (delays, damages, customs holds) and produce root cause reports |

---

## 3. Integration Details

| Aspect | Specification |
|---|---|
| **Integration Type** | Knowledge-base agent with read/write access to document store |
| **Authentication** | API key-based authentication |
| **API Base URL** | `https://api.knowledgeforge.ai/v1` |
| **Webhook Endpoint** | `https://hooks.logistics-platform.internal/knowledgeforge-events` |
| **Rate Limit** | 500 requests/minute |
| **Data Residency** | US-East (primary), EU-West (read-only replica) |

### 3.1 Knowledge Store Access

- **Document Repos:** `logistics-platform/knowledge-base`, `logistics-platform/templates`, `logistics-platform/regulatory`
- **Vector Store:** Pinecone index `logistics-knowledge` (embeddings dimension: 1536)
- **Graph DB:** Neo4j instance `logistics-knowledge-graph`

### 3.2 Event Subscriptions

| Event | Action |
|---|---|
| `regulation.updated` | Review and summarise regulatory change |
| `template.version.requested` | Generate new version of document template |
| `incident.reported` | Produce root cause analysis report |
| `knowledge.query` | Answer ad-hoc logistics knowledge query |

---

## 4. Dependencies

| Dependency | Version | Purpose |
|---|---|---|
| Python | >= 3.11 | Primary development language |
| LangChain | >= 0.2 | LLM orchestration framework |
| OpenAI API | >= 1.0 | LLM inference |
| Pinecone | >= 3.0 | Vector storage for semantic search |
| Neo4j | >= 5.0 | Knowledge graph storage |
| PostgreSQL | >= 15 | Metadata and document store |
| Redis | >= 7.2 | Caching |

---

## 5. Related Documents

| Document | Location |
|---|---|
| Discipline Adaptation | `../discipline-adaptations/logistics-01700-adaptation.md` |
| DevForge AI Integration | `./devforge-ai-integration.md` |
| Heartbeat Monitoring Config | `../HEARTBEAT-MONITORING-CONFIG.md` |

---

*Document generated for Paperclip Discipline Automation — Logistics (01700)*

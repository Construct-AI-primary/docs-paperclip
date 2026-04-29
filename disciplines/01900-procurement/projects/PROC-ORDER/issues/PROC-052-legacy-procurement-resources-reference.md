---
id: PROC-052
title: Legacy Procurement Resources Cross-Reference
phase: "4 — Knowledge Management"
status: open
priority: Medium
---

# PROC-052: Legacy Procurement Resources Cross-Reference

## Description

This issue catalogs all existing procurement-related resources in the `docs-construct-ai` repository that should be referenced during PROC-ORDER execution. These legacy resources contain proven templates, workflows, prompts, domain knowledge, and API specs that the new Paperclip-based system should leverage.

All agents working on PROC-ORDER issues should consult these resources as needed.

## Resource Categories

### 1. Templates (21 files)

These are production-ready templates that the new system should consume:

| Resource | Path | Used By |
|----------|------|---------|
| **Purchase Order Template** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_PURCHASE_ORDER_TEMPLATE.MD` | PROC-002, PROC-010 |
| **Service Order Template** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_SERVICE_ORDER_TEMPLATE.MD` | PROC-002, PROC-010 |
| **Work Order Template** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_WORK_ORDER_TEMPLATE.MD` | PROC-002, PROC-010 |
| **Scope of Work Template** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_SCOPE_OF_WORK_TEMPLATE.MD` | PROC-002, PROC-032 |
| **Appendix A — Specifications** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_A_SPECIFICATIONS.MD` | PROC-032 |
| **Appendix B — Safety** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_B_SAFETY.MD` | PROC-032 |
| **Appendix C — Delivery** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_C_DELIVERY.MD` | PROC-032 |
| **Appendix D — Training** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_D_TRAINING.MD` | PROC-032 |
| **Appendix E — Logistics** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_E_LOGISTICS.MD` | PROC-032 |
| **Appendix F — Packing** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_APPENDIX_F_PACKING.MD` | PROC-032 |
| **Template System Architecture** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_PROCUREMENT-TEMPLATE-SYSTEM.MD` | All |
| **Template Migration Guide** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_PROCUREMENT-TEMPLATES-TO-UNIFIED-MIGRATION.MD` | All |
| **JSON Templates** | `docs-construct-ai/disciplines/01900_procurement/templates/1900_purchase_order_template.json` | PROC-010 |
|  | `docs-construct-ai/disciplines/01900_procurement/templates/1900_service_order_template.json` | PROC-010 |
|  | `docs-construct-ai/disciplines/01900_procurement/templates/1900_work_order_template.json` | PROC-010 |
| **Compliance Rules** | `docs-construct-ai/disciplines/01900_procurement/templates/compliance_rules.json` | PROC-021 |
| **Procurement Plan** | `docs-construct-ai/disciplines/01900_procurement/templates/procurement_plan.yaml` | PROC-020 |

### 2. Workflows

| Resource | Path | Used By |
|----------|------|---------|
| **Supplier Outreach Workflow** | `docs-construct-ai/disciplines/01900_procurement/workflow_docs/orders/1900_PROCUREMENT_SUPPLIER_OUTREACH_WORKFLOW.MD` | PROC-031 |

### 3. Prompt Templates

| Resource | Path | Used By |
|----------|------|---------|
| **Procurement Order Prompt** | `docs-construct-ai/disciplines/01900_procurement/agent-data/prompts/01900_PROCUREMENT_ORDER_PROMPT.md` | PROC-039 |
| **AI-Native Procurement Operations Prompt** | `docs-construct-ai/disciplines/01900_procurement/agent-data/prompts/01900_AI-NATIVE-PROCUREMENT-OPERATIONS-PROMPT.md` | PROC-012 |

### 4. Domain Knowledge

| Resource | Path | Used By |
|----------|------|---------|
| **Oil & Gas Project Typology** | `docs-construct-ai/disciplines/01900_procurement/agent-data/domain-knowledge/project-typologies/0010_OIL-AND-GAS.MD` | PROC-002 |
| **Deployment Guide** | `docs-construct-ai/disciplines/01900_procurement/agent-data/operations/1900_DEPLOYMENT.MD` | PROC-043 |
| **Security Guide** | `docs-construct-ai/disciplines/01900_procurement/agent-data/operations/1900_SECURITY.MD` | PROC-021 |

### 5. Agent Data & Registry

| Resource | Path | Used By |
|----------|------|---------|
| **Agent Skill Mapping** | `docs-construct-ai/disciplines/01900_procurement/agent-data/registry/01900_AGENT_SKILL_MAPPING.MD` | PROC-012 |
| **Agent Naming Map** | `docs-construct-ai/disciplines/01900_procurement/agent-data/registry/1900_AGENT-NAMING-MAP.MD` | PROC-051 |

### 6. API & Integration

| Resource | Path | Used By |
|----------|------|---------|
| **API Specification** | `docs-construct-ai/disciplines/01900_procurement/agent-data/1900_API_SPEC.MD` | PROC-010 |
| **Integrations** | `docs-construct-ai/disciplines/01900_procurement/agent-data/1900_INTEGRATIONS.MD` | PROC-013 |
| **Multi-Source Tender Integration System** | `docs-construct-ai/disciplines/01900_procurement/integration/1900_TENDER-INTEGRATION-SYSTEM.MD` | PROC-031 |

### 7. Tender Management (Related)

| Resource | Path | Used By |
|----------|------|---------|
| **Tender Management Documentation** | `docs-construct-ai/disciplines/01900_procurement/tenders/1900_TENDER-MANAGEMENT-DOCUMENTATION.MD` | PROC-031 |
| **Tender System Summary** | `docs-construct-ai/disciplines/01900_procurement/tenders/1900_TENDER-MANAGEMENT-SYSTEM-SUMMARY.MD` | Reference |
| **Supplier Selection Implementation** | `docs-construct-ai/disciplines/01900_procurement/plan/1900_UI_SUPPLIER_SELECTION_IMPLEMENTATION.MD` | PROC-031 |

### 8. Supplier Directory

| Resource | Path | Used By |
|----------|------|---------|
| **Consolidated Supplier Directory** | `docs-construct-ai/disciplines/01900_procurement/suppliers/1900_CONSOLIDATED-SUPPLIER-DIRECTORY-DOCUMENTATION.MD` | PROC-031 |

## Cross-Discipline Shared Resources

| Resource | Path | Used By |
|----------|------|---------|
| **Bidding & Tendering Platform** | `docs-paperclip/disciplines-shared/bidding-and-tendering/` | All |
| **Measurement Tender System** | `docs-paperclip/disciplines-shared/measurement/projects/MEASURE-TENDER/` | PROC-031 |
| **Procurement Testing Suite** | `docs-paperclip/disciplines-shared/testing/projects/PROCURE-TEST/` | PROC-020..023 |

## Acceptance Criteria

- [ ] All agents have access to the legacy resources listed above
- [ ] Template files are consulted during SOW generation (PROC-002, PROC-032)
- [ ] Prompt templates inform agent orchestration (PROC-012, PROC-039)
- [ ] Domain knowledge informs order type configuration (PROC-002)
- [ ] Supplier documentation informs portal integration (PROC-031)
- [ ] Integration specs inform database alignment (PROC-013)

## Assigned Company & Agent

- **Company:** KnowledgeForge AI / DomainForge AI
- **Agent:** documentation-knowledgeforge-document-specialist / procurement-domainforge-procurement-contracts

## Dependencies

- All existing procurement resources must remain in place (do not delete)
- No migration required — these are reference documents

## Notes

This issue does not require code changes. It is a knowledge management issue that cross-references existing resources for agent consumption during PROC-ORDER execution. Agents should treat this as their primary discovery index for legacy procurement assets.
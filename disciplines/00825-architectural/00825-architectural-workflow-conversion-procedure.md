---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/paperclip
gigabrain_tags: procedures, paperclip, architectural-workflows, workflow-implementation, schema-alignment
openstinger_context: architectural-workflow-procedures, paperclip-implementation
last_updated: 2026-04-08
related_docs:
  - docs_construct_ai/disciplines/00825-architectural/agent-data/domain-knowledge/00825_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/codebase/schema/paperclip/total_schema.csv
  - docs_construct_ai/codebase/agents/paperclip-teams/Paperclip_Teams_Cross_Reference.md
  - .clinerules/guide/project-implementation-workflow-guide.md
---

# Architectural Workflow Implementation Preparation Procedure

## Overview

This procedure outlines how to create project implementation workflow guides for each missing architectural workflow, ensuring alignment with the existing Supabase table structure and leveraging the full capabilities of the Paperclip agent ecosystem.

### Purpose
- Standardize architectural workflow implementation across the Paperclip ecosystem
- Ensure schema alignment with existing architectural-related Supabase tables
- Provide consistent team assignments and phase definitions
- Maintain audit trails and compliance requirements for architectural operations

### Scope
- 5 missing architectural workflows requiring implementation guides
- Schema alignment with existing architectural-related Supabase tables
- Integration with 9 Paperclip agent companies and their capabilities
- 5-phase implementation process per workflow

---

## Step 1: Schema Alignment Requirements

### Critical Architectural Tables to Align With

| Table | Purpose | Key Fields | Workflow Integration |
|-------|---------|------------|---------------------|
| **projects** | Core project management | id, organization_id, name, status, start_date, end_date | All architectural workflows must reference project context |
| **architectural_deliverables** | Deliverable tracking | id, project_id, deliverable_type, status, due_date, revision | Design development and documentation workflows |
| **building_codes** | Code compliance tracking | id, project_id, code_type, status, compliance_date, authority | Regulatory compliance workflows |
| **inspections** | Inspection management | id, project_id, inspection_type, status, inspector, date | Construction administration workflows |
| **bim_models** | BIM model management | id, project_id, model_type, version, status, last_updated | BIM and model management workflows |
| **as_built_documents** | As-built tracking | id, project_id, document_type, status, final_date, location | Handover and documentation workflows |
| **permits_approvals** | Permit tracking | id, project_id, permit_type, status, authority, approval_date | Regulatory compliance workflows |

### Schema-Aware Workflow Design Requirements

#### Database Integration Points
- **Primary Table**: Identify which table serves as the workflow's primary data store
- **Related Tables**: Map all foreign key relationships and dependent tables
- **Status Fields**: Align workflow states with table status enums
- **Audit Trail**: Ensure all changes are logged via existing audit mechanisms

#### RLS (Row Level Security) Compliance
- **Organization Scoping**: All queries must respect organization_id filtering
- **User Permissions**: Implement proper role-based access controls
- **Data Isolation**: Ensure multi-tenant data separation

#### API Integration Requirements
- **REST Endpoints**: Use existing architectural API endpoints
- **Real-time Updates**: Implement Supabase real-time subscriptions where needed
- **Error Handling**: Follow established error response patterns

---

## Step 2: Workflow Prioritization & Assignment

### Priority Order (based on architectural criticality)
1. **Design Development and Documentation Workflow (ARCH-DESIGN)** - Core architectural design process
2. **Regulatory Compliance and Code Management Workflow (ARCH-CODE)** - Legal and regulatory compliance
3. **Construction Administration and Inspection Workflow (ARCH-CONSTRUCTION)** - Construction quality assurance
4. **Handover and As-Built Documentation Workflow (ARCH-HANDOVER)** - Project completion and handover
5. **BIM and Model Management Workflow (ARCH-BIM)** - Digital design coordination

---

## Step 3: Directory Structure Setup

For each workflow, create a dedicated folder structure:

```
docs-paperclip/disciplines/00825-architectural/
├── design-development-workflow/     # ARCH-DESIGN
│   ├── project/
│   ├── issues/
│   └── README.md
├── regulatory-compliance-workflow/  # ARCH-CODE
│   ├── project/
│   ├── issues/
│   └── README.md
├── construction-administration-workflow/ # ARCH-CONSTRUCTION
│   ├── project/
│   ├── issues/
│   └── README.md
├── bim-management-workflow/         # ARCH-BIM
│   ├── project/
│   ├── issues/
│   └── README.md
└── handover-documentation-workflow/ # ARCH-HANDOVER
    ├── project/
    ├── issues/
    └── README.md
```

---

## Step 4: Template Adaptation for Each Workflow

**Base Template**: Use `.clinerules/guide/project-implementation-workflow-guide.md`

**For Each Workflow, customize these variables:**

### Core Project Variables
```
{PLAN_DOCUMENT_PATH} = docs-paperclip/disciplines/00825-architectural/[workflow-name]/project/2026-04-XX-[workflow-slug]-plan.md
{PROJECT_DOCUMENT_PATH} = docs-paperclip/disciplines/00825-architectural/[workflow-name]/project/2026-04-XX-[workflow-slug]-implementation.md
{CEO_AGENT} = nexus-devforge-ceo
{ISSUE_PREFIX} = ARCH-[CODE]
```

### Company and Team Assignments
```
{PRIMARY_COMPANY} = DevForge AI
{PRIMARY_TEAM} = Engineering
{PRIMARY_AGENTS} = interface-devforge, codesmith-devforge, devcore-devforge
{PRIMARY_SKILLS} = Architectural Workflow Development, Design Management, Building Codes

{INFRA_COMPANY} = InfraForge AI
{INFRA_TEAM} = Infrastructure
{INFRA_AGENTS} = database-infraforge
{INFRA_SKILLS} = Database Administration, System Integration

{QUALITY_COMPANY} = QualityForge AI
{QUALITY_TEAM} = Quality
{QUALITY_AGENTS} = guardian-qualityforge, validator-qualityforge
{QUALITY_SKILLS} = Testing, Validation, Quality Assurance

{KNOWLEDGE_COMPANY} = KnowledgeForge AI
{KNOWLEDGE_TEAM} = Documentation
{KNOWLEDGE_AGENTS} = doc-analyzer-knowledgeforge
{KNOWLEDGE_SKILLS} = Documentation, Knowledge Management

{DOMAIN_COMPANY} = DomainForge AI
{DOMAIN_TEAM} = Architectural
{DOMAIN_AGENTS} = architectural-domainforge
{DOMAIN_SKILLS} = Architectural Design, BIM Management
```

### Enhanced Template Variables for Schema Alignment
```
{PRIMARY_TABLE} = Main Supabase table for this workflow (e.g., architectural_deliverables, building_codes, inspections)
{RELATED_TABLES} = Comma-separated list of dependent tables
{SCHEMA_INTEGRATION_POINTS} = Key integration points with existing schema
{DATA_VALIDATION_RULES} = Schema-based validation requirements
{RLS_COMPLIANCE_REQUIREMENTS} = Row-level security implementation needs
{AUDIT_TRAIL_REQUIREMENTS} = Audit logging requirements for compliance
```

---

## Step 5: Schema-Aware Phase Definitions

**Standard 5-Phase Structure for Architectural Workflows:**

```
{PHASE_1_NAME} = Phase 1: Schema Analysis & Architectural Data Modeling (Weeks 1-2)
{PHASE_1_ISSUE_1} = Analyze existing architectural table relationships and constraints
{PHASE_1_AGENT_1} = database-infraforge
{PHASE_1_ISSUE_2} = Design workflow data flow aligned with architectural schema
{PHASE_1_AGENT_2} = codesmith-devforge
{PHASE_1_ISSUE_3} = Implement RLS policies for new architectural workflow components
{PHASE_1_AGENT_3} = database-infraforge

{PHASE_2_NAME} = Phase 2: API Integration & Backend Development (Weeks 3-4)
{PHASE_2_ISSUE_1} = Build CRUD operations for primary architectural workflow table
{PHASE_2_AGENT_1} = devcore-devforge
{PHASE_2_ISSUE_2} = Implement workflow state management with schema alignment
{PHASE_2_AGENT_2} = codesmith-devforge
{PHASE_2_ISSUE_3} = Integrate with existing architectural APIs and external providers
{PHASE_2_AGENT_3} = interface-devforge

{PHASE_3_NAME} = Phase 3: Integration & Testing (Weeks 5-6)
{PHASE_3_ISSUE_1} = Implement real-time architectural tracking and alert systems
{PHASE_3_AGENT_1} = devcore-devforge
{PHASE_3_ISSUE_2} = Create comprehensive test suite with architectural scenarios
{PHASE_3_AGENT_2} = validator-qualityforge
{PHASE_3_ISSUE_3} = Performance optimization and security review
{PHASE_3_AGENT_3} = guardian-qualityforge

{PHASE_4_NAME} = Phase 4: Documentation & Training (Weeks 7-8)
{PHASE_4_ISSUE_1} = Create user documentation and architectural operational guides
{PHASE_4_AGENT_1} = doc-analyzer-knowledgeforge
{PHASE_4_ISSUE_2} = Develop training materials for architectural workflows
{PHASE_4_AGENT_2} = doc-analyzer-knowledgeforge
{PHASE_4_ISSUE_3} = Knowledge base integration and cross-referencing
{PHASE_4_AGENT_3} = doc-analyzer-knowledgeforge

{PHASE_5_NAME} = Phase 5: Deployment & Go-Live (Weeks 9-10)
{PHASE_5_ISSUE_1} = Production deployment and architectural data migration
{PHASE_5_AGENT_1} = database-infraforge
{PHASE_5_ISSUE_2} = User acceptance testing and architectural team training
{PHASE_5_AGENT_2} = validator-qualityforge
{PHASE_5_ISSUE_3} = Go-live support and architectural performance monitoring
{PHASE_5_AGENT_3} = guardian-qualityforge
```

---

## Step 6: Schema-Specific Success Criteria

**Database Integration Success Criteria:**
```
{FUNCTIONAL_SUCCESS_CRITERIA_1} = All architectural workflow data properly stored in aligned Supabase architectural tables
{FUNCTIONAL_SUCCESS_CRITERIA_2} = RLS policies correctly implemented for architectural data security
{FUNCTIONAL_SUCCESS_CRITERIA_3} = Foreign key relationships maintained across architectural operations
{FUNCTIONAL_SUCCESS_CRITERIA_4} = Audit trails capture all architectural state changes and formal communications
{FUNCTIONAL_SUCCESS_CRITERIA_5} = Real-time updates work with existing architectural subscription patterns
```

**Schema Compliance Validation:**
```
{TECHNICAL_RISK_1} = Schema changes may break existing architectural functionality
{TECHNICAL_RISK_1_MITIGATION} = Comprehensive testing against existing workflows before deployment

{TECHNICAL_RISK_2} = RLS policy conflicts may prevent legitimate architectural data access
{TECHNICAL_RISK_2_MITIGATION} = Thorough testing of permission scenarios with existing roles

{TECHNICAL_RISK_3} = Performance impact on existing architectural queries and reporting
{TECHNICAL_RISK_3_MITIGATION} = Database query optimization and indexing strategy for architectural data
```

---

## Step 7: Workflow-Specific Schema Mapping

### Priority Workflow Schema Alignments

#### 1. Design Development and Documentation Workflow (ARCH-DESIGN)
- **Primary Table**: `architectural_deliverables`
- **Related Tables**: `projects`, `bim_models`, `building_codes`
- **Key Integration**: Design deliverable tracking and documentation management
- **Audit Requirements**: Design development and documentation tracking

#### 2. Regulatory Compliance and Code Management Workflow (ARCH-CODE)
- **Primary Table**: `building_codes`
- **Related Tables**: `projects`, `permits_approvals`, `inspections`
- **Key Integration**: Code compliance tracking and permit management
- **Audit Requirements**: Regulatory compliance and approval tracking

#### 3. Construction Administration and Inspection Workflow (ARCH-CONSTRUCTION)
- **Primary Table**: `inspections`
- **Related Tables**: `projects`, `architectural_deliverables`, `building_codes`
- **Key Integration**: Inspection coordination and construction quality tracking
- **Audit Requirements**: Inspection and quality control tracking

#### 4. BIM and Model Management Workflow (ARCH-BIM)
- **Primary Table**: `bim_models`
- **Related Tables**: `projects`, `architectural_deliverables`, `building_codes`
- **Key Integration**: BIM model management and coordination tracking
- **Audit Requirements**: Model development and coordination tracking

#### 5. Handover and As-Built Documentation Workflow (ARCH-HANDOVER)
- **Primary Table**: `as_built_documents`
- **Related Tables**: `projects`, `architectural_deliverables`, `inspections`
- **Key Integration**: As-built documentation and handover management
- **Audit Requirements**: Handover completion and documentation tracking

---

## Step 8: Implementation Execution

**For Each Workflow:**

1. **Create Project Folder Structure**
   ```bash
   mkdir -p docs-paperclip/disciplines/00825-architectural/[workflow-name]/project
   mkdir -p docs-paperclip/disciplines/00825-architectural/[workflow-name]/issues
   ```

2. **Copy and Customize Template**
   ```bash
   cp .clinerules/guide/project-implementation-workflow-guide.md \
      docs-paperclip/disciplines/00825-architectural/[workflow-name]/project/2026-04-XX-[workflow-slug]-implementation-guide.md
   ```

3. **Replace Variables** using systematic find-and-replace for all template variables

4. **Create Supporting Documents**
   - Project plan document
   - Issue templates for each phase
   - README.md with workflow overview

5. **Team Assignment** based on cross-reference:
   - **DevForge AI**: Core development (nexus-devforge-ceo, interface-devforge, codesmith-devforge, devcore-devforge)
   - **InfraForge AI**: Database and infrastructure (database-infraforge)
   - **QualityForge AI**: Testing and QA (guardian-qualityforge, validator-qualityforge)
   - **KnowledgeForge AI**: Documentation (doc-analyzer-knowledgeforge)
   - **DomainForge AI**: Architectural domain expertise (architectural-domainforge)

---

## Step 9: Quality Assurance

### Schema Compliance Checklist
- [ ] All new tables follow existing naming conventions
- [ ] Foreign key relationships properly defined
- [ ] RLS policies implemented for multi-tenant security
- [ ] Indexes created for performance-critical architectural queries
- [ ] Audit triggers configured for compliance tables
- [ ] Migration scripts tested against production data
- [ ] API endpoints documented with OpenAPI specs
- [ ] Database constraints validated for data integrity

### Integration Testing Requirements
- [ ] End-to-end workflow testing with real architectural schema data
- [ ] Performance testing against existing architectural query patterns
- [ ] Security testing for RLS policy effectiveness
- [ ] External API integration testing (BIM systems, code databases)
- [ ] Real-time architectural tracking and alert system validation
- [ ] Rollback procedures documented and tested

---

## Step 10: Success Metrics & Monitoring

### Implementation Success Metrics
- **Schema Alignment**: 100% of workflows integrate with existing architectural tables
- **RLS Compliance**: Zero security violations in production
- **Performance**: No degradation of existing architectural queries and reporting
- **Data Integrity**: 100% foreign key relationship maintenance
- **Audit Compliance**: Complete audit trails for all architectural actions
- **External Integration**: Successful API connectivity and data flow

### Continuous Improvement
- **Schema Evolution**: Regular review of architectural table utilization and optimization opportunities
- **Performance Monitoring**: Ongoing monitoring of architectural query performance and reporting systems
- **Security Audits**: Regular RLS policy reviews and updates for architectural data
- **API Reliability**: Monitoring of external architectural API performance and failover procedures
- **User Feedback**: Incorporation of architectural team feedback into workflow improvements

---

This procedure ensures that all architectural workflow implementations are fully aligned with the existing Supabase schema architecture, maintaining data integrity, security, and performance while extending the architectural capabilities systematically.
---
name: knowledge-synthesis-management
description: >
  Use when gathering, structuring, and synthesizing discipline knowledge into standardized
  documentation artifacts including PAGE-KNOWLEDGE.md (8-field metadata), METADATA-BUNDLE.md,
  discipline-adaptation docs, and AI-integration specs for downstream project generation.
company: promptforge-ai
---

# Knowledge Synthesis Management

## Overview

This skill provides comprehensive guidance for automated **research-driven** knowledge gathering and structuring from existing documentation into standardized artifacts. It is the foundational phase (Phase 1) of the Discipline Automation Workflow. Phase 1 includes an explicit **discipline research sub-phase** that proactively discovers essential projects, workflows, and gaps before structuring outputs. Outputs feed directly into `project-intelligence-analysis` for project identification.

## When to Use This Skill

- Generating PAGE-KNOWLEDGE.md with 8-field metadata for a discipline
- Compiling METADATA-BUNDLE.md for root issue upload
- Creating discipline-adaptation docs (per-discipline standards, CAD systems, analysis types)
- Creating AI-integration docs (per-company integration specifications)
- Generating standards-and-compliance documentation
- **Researching existing discipline documentation to discover essential projects and gaps**
- **Analyzing existing implementations to identify missing workflows**
- **Performing gap analysis between documented needs and actual coverage**
- Structuring extracted knowledge into standardized artifact formats

## Knowledge Artifact Specifications

### 1. PAGE-KNOWLEDGE.md (8-Field Metadata)

Each component in a PAGE-KNOWLEDGE.md must include the following 8-field metadata structure:

| Field | Type | Description | Required |
|-------|------|-------------|----------|
| `page_id` | string | Unique identifier for the page/platform | Yes |
| `discipline` | string | Discipline code or "all" for shared | Yes |
| `component` | string | Component name (PascalCase) | Yes |
| `template_score` | number | 0.00-1.00 reuse confidence score | Yes |
| `vector_store` | string | Supabase vector store path | Yes |
| `ui_buttons` | object | Button config: id, class, action, options | Yes |
| `supabase_schema` | object|null | DB table, columns, indexes | Yes |
| `qc_checklist` | array | 5 verification items | Yes |
| `last_updated` | date | ISO date of last update | Yes |

**Generation Procedure:**

```javascript
function generatePAGEKnowledge(discipline) {
  // 1. Extract discipline documentation from sources
  const sources = extractDocumentation(discipline);
  
  // 2. Identify all UI components and their properties
  const components = identifyComponents(sources);
  
  // 3. For each component, populate 8-field metadata
  const pageKnowledge = components.map(component => ({
    page_id: `${discipline.code}-platform`,
    discipline: component.isShared ? "all" : discipline.code,
    component: component.name,
    template_score: calculateTemplateScore(component),
    vector_store: `supabase_vectors/${discipline.slug}/`,
    ui_buttons: extractUIButtons(component),
    supabase_schema: extractDBSchema(component),
    qc_checklist: generateQCChecklist(component),
    last_updated: new Date().toISOString().split('T')[0]
  }));
  
  // 4. Generate YAML frontmatter
  return formatAsMarkdown(pageKnowledge);
}
```

### 2. METADATA-BUNDLE.md (JSON Bundle)

Compile ALL 8-field metadata into a single JSON document ready for root issue upload:

| Section | Contents |
|---------|----------|
| project | Root project ID (e.g., ENGINE-PLATFORM-000) |
| disciplines[] | Per-discipline: code, name, standards, cad_systems, analysis_types, pilot_status, pilot_issue |
| shared_components[] | Per-component: component_id, file_path, description, disciplines[], qc_checklist[] |
| cad_systems[] | Per-system: system_id, name, disciplines[], file_types[], integration_status |
| database_tables[] | Per-table: table name, columns[], indexes[] |
| summary | totals: components, disciplines, cad, phases, issues, companies, agents |

### 3. Discipline Adaptation Docs

Generate per-discipline markdown docs in `knowledge/discipline-adaptations/`:

```markdown
# {Discipline Name} — Platform Adaptation

## Discipline Configuration
- **Code**: {discipline_code}
- **Standards**: [{standards_list}]
- **CAD Systems**: [{cad_systems}]
- **Analysis Types**: [{analysis_types}]
- **Templates**: [{templates}]
- **Validation Rules**: {validation_rules}
- **Pilot Issue**: {pilot_issue}

## Component Overrides
{per-component overrides for this discipline}
```

### 4. AI Integration Docs

Generate per-company integration docs in `knowledge/ai-integrations/`:

```markdown
# {Company Name} — Platform Integration

## Integration Points
- **Company**: {company_slug}
- **Primary Agent**: {primary_agent_slug}
- **Capabilities**: [{capability_list}]
- **Integration Type**: {api | shared-component | event-driven}
- **Dependencies**: [{dependency_list}]
```

## Research Sub-Phase: Proactive Discovery of Essential Projects & Issues

Before producing standardized artifacts, a **dedicated research sub-phase** must be executed. This research proactively identifies essential projects and issues that the discipline requires, even if they are not yet documented.

### Research Methodology

```javascript
async function executeDisciplineResearch(disciplineCode) {
  const research = {
    discipline: disciplineCode,
    phase: 'pre-synthesis-research',
    activities: []
  };
  
  // 1. Audit existing discipline documentation
  const auditResult = await auditExistingDocs(disciplineCode);
  research.activities.push({ type: 'doc-audit', result: auditResult });
  
  // 2. Survey all existing project implementations for cross-discipline patterns
  const projectSurvey = await surveyExistingProjects();
  research.activities.push({ type: 'project-survey', result: projectSurvey });
  
  // 3. Analyze the Paperclip Teams Cross-Reference for agent capability mapping
  const agentCapabilities = await analyzeAgentCapabilities(disciplineCode);
  research.activities.push({ type: 'agent-capability-analysis', result: agentCapabilities });
  
  // 4. Research industry standards and regulatory requirements for the discipline
  const standardsResearch = await researchIndustryStandards(disciplineCode);
  research.activities.push({ type: 'standards-research', result: standardsResearch });
  
  // 5. Identify workflow gaps by comparing documented vs. expected discipline lifecycle
  const gapAnalysis = await performGapAnalysis(disciplineCode, auditResult, projectSurvey);
  research.activities.push({ type: 'gap-analysis', result: gapAnalysis });
  
  return research;
}
```

### Research Activities Breakdown

#### Activity 1: Documentation Audit

Scan ALL available sources for the discipline:

| Source Type | Location | What to Look For | Research Value |
|-------------|----------|------------------|----------------|
| Discipline docs | `docs-paperclip/disciplines/{code}/` | Workflows, procedures, standards | Essential projects, compliance needs |
| UI-UX specs | Existing spec files or templates | Page architecture, state requirements | UI/UX implementation issues |
| Plans directory | `docs-paperclip/disciplines-shared/*/plans/` | Previous planning documents | Phased implementation patterns |
| Knowledge directory | `docs-paperclip/disciplines-shared/*/knowledge/` | PAGE-KNOWLEDGE, METADATA-BUNDLE patterns | Component and metadata patterns |
| Issues directory | Existing issue patterns | Issue structure, assignment patterns | Issue template patterns |
| Agent skills | `docs-paperclip/companies/*/skills/` | Agent capability descriptions | Skill-to-issue mapping |
| Teams ref | `docs-paperclip/companies-teams/Paperclip_Teams_Cross_Reference.md` | Agent rosters, team structures, RACI | Assignment planning, company discovery |

#### Activity 2: Cross-Discipline Project Survey

Review projects from other disciplines to identify reusable patterns and essential project types:

```javascript
function surveyExistingProjects() {
  const projectTypes = [];
  
  // Foundation projects (always needed)
  projectTypes.push({
    type: 'foundation',
    essential: true,
    description: 'Database schema, shared components, base infrastructure',
    priority: 'critical'
  });
  
  // Core implementation projects
  projectTypes.push({
    type: 'core-implementation',
    essential: true,
    description: 'Main UI pages, primary workflows, agent configuration',
    priority: 'high'
  });
  
  // Integration projects
  projectTypes.push({
    type: 'integration',
    essential: true,
    description: 'Third-party system connections, API integrations, CAD interfaces',
    priority: 'high'
  });
  
  // Testing & quality projects
  projectTypes.push({
    type: 'quality-assurance',
    essential: true,
    description: 'Test suites, validation frameworks, compliance checking',
    priority: 'medium'
  });
  
  // Documentation & knowledge projects
  projectTypes.push({
    type: 'documentation',
    essential: true,
    description: 'PAGE-KNOWLEDGE, METADATA-BUNDLE, implementation docs',
    priority: 'medium'
  });
  
  // Enhancement projects
  projectTypes.push({
    type: 'enhancement',
    essential: false,
    description: 'Feature improvements, optimization, secondary workflows',
    priority: 'varies'
  });
  
  return projectTypes;
}
```

#### Activity 3: Gap Analysis

Compare what is documented against what should exist for a complete discipline implementation:

```javascript
function performGapAnalysis(disciplineCode, auditResult, projectSurvey) {
  const gaps = [];
  
  // Check each essential project type against audit findings
  for (const projectType of projectSurvey) {
    const existing = auditResult.find(
      d => d.type === projectType.type && d.discipline === disciplineCode
    );
    
    if (!existing) {
      gaps.push({
        type: 'missing_project',
        projectType: projectType.type,
        essential: projectType.essential,
        priority: projectType.priority,
        description: `No ${projectType.type} project found for ${disciplineCode}`,
        recommendedAction: `Create ${projectType.type} project for ${disciplineCode}`
      });
    } else if (existing.coverage < 0.7) {
      gaps.push({
        type: 'incomplete_coverage',
        projectType: projectType.type,
        essential: projectType.essential,
        priority: projectType.priority,
        coverage: existing.coverage,
        description: `${projectType.type} for ${disciplineCode} has only ${Math.round(existing.coverage * 100)}% coverage`,
        recommendedAction: `Expand ${projectType.type} project for ${disciplineCode}`
      });
    }
  }
  
  // Check for cross-cutting gaps
  const crossCuttingGaps = detectCrossCuttingGaps(disciplineCode, auditResult);
  gaps.push(...crossCuttingGaps);
  
  return { gaps, gapCount: gaps.length, essentialGapCount: gaps.filter(g => g.essential).length };
}
```

#### Activity 4: Essential Project & Issue Identification

From the research, produce a **discovery report** that lists ALL essential projects and their high-level issues:

```markdown
# Discipline Research Discovery Report: {discipline_code}

## Essential Projects Identified
| # | Project | Priority | Rationale | Est. Issues |
|---|---------|----------|-----------|-------------|
| 1 | Foundation & Schema | Critical | Every discipline needs database infrastructure | 3-5 |
| 2 | Core Page Implementation | Critical | Main UI for discipline workflows | 5-8 |
| 3 | Agent Configuration & Skills | Critical | Domain agents need discipline-specific skills | 3-6 |
| 4 | Integration | High | Connect to CAD systems, external tools | 4-6 |
| 5 | Testing & QA | High | Validate implementation correctness | 3-5 |
| 6 | Documentation & Knowledge | Medium | Institutional memory capture | 2-4 |

## Gap Analysis Summary
- **Missing Projects**: {count} essential projects with no implementation found
- **Incomplete Coverage**: {count} projects with < 70% coverage
- **Cross-Cutting Gaps**: {count} gaps affecting multiple disciplines

## High-Priority Issue Themes
1. {theme 1}
2. {theme 2}
3. {theme 3}

## Agent & Skill Discovery
- **Agents Required**: {list of agent slugs}
- **Skills Required**: {list of skill names}
- **Skill Gaps**: {list of missing skills}
```

## Knowledge Extraction Sources

| Source | Purpose | Extraction Priority |
|--------|---------|---------------------|
| `docs-paperclip/disciplines/{code}/` | Discipline-specific docs | High |
| `docs-paperclip/disciplines/{code}/UI-UX-SPECIFICATION.md` | UI/UX patterns, modals, state buttons | High |
| `docs-paperclip/disciplines-shared/` | Shared discipline knowledge | Medium |
| `docs-construct-ai/codebase/` | System architecture | Medium |
| Existing project implementations | Previous issue structure patterns | Low |

## Quality Assurance

### Completeness Checklist

#### Research Sub-Phase
- [ ] Documentation audit completed across all available sources
- [ ] Cross-discipline project survey identified reusable patterns
- [ ] Gap analysis performed comparing documented vs. expected coverage
- [ ] Agent capabilities analyzed against discipline requirements
- [ ] Discovery report generated with essential projects and high-priority issues
- [ ] Orphaned workflows flagged for human attention

#### Artifact Generation
- [ ] All disciplines have PAGE-KNOWLEDGE.md with 8-field metadata
- [ ] All components have complete UI button definitions
- [ ] Supabase schema includes table, columns, and indexes
- [ ] QC checklist has 5 actionable verification items
- [ ] Template score is calculated (0.00-1.00)
- [ ] METADATA-BUNDLE.md compiles all component metadata
- [ ] Discipline adaptation docs exist for each discipline
- [ ] AI integration docs exist for each involved company
- [ ] All dates use ISO format
- [ ] Vector store paths are consistent

### Validation Rules

```javascript
function validateKnowledgeArtifacts(artifacts) {
  const errors = [];
  
  // Validate 8-field metadata completeness
  for (const component of artifacts.components) {
    const requiredFields = ['page_id', 'discipline', 'component', 'template_score', 
                           'vector_store', 'ui_buttons', 'supabase_schema', 'qc_checklist'];
    for (const field of requiredFields) {
      if (component[field] === undefined || component[field] === null) {
        errors.push(`Missing field '${field}' in component '${component.name}'`);
      }
    }
  }
  
  return { valid: errors.length === 0, errors };
}
```

## Related Skills

- `project-intelligence-analysis` - Downstream: uses PAGE-KNOWLEDGE.md to identify projects
- `issue-generation-optimization` - Downstream: uses project intelligence to generate issues
- `documentation-quality-check` - Shared: validates doc quality
- `source-verification` - Shared: validates extracted knowledge
- `knowledge-retrieval` - Shared: retrieves existing knowledge

## Best Practices

1. **Always enumerate all components** before writing PAGE-KNOWLEDGE.md
2. **Calculate template scores empirically** based on reuse potential (0.85+ = high reuse)
3. **Keep METADATA-BUNDLE.md in sync** with individual PAGE-KNOWLEDGE.md files
4. **Cross-reference UI-UX-SPECIFICATION.md** for button definitions and modals
5. **Include all CAD systems** even those with "planned" status
6. **QC checklists must be actionable** — avoid vague items like "works correctly"
7. **Document integration status** accurately (planned/active/complete)
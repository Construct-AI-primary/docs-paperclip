---
name: project-intelligence-analysis
description: >
  Use when analyzing synthesized discipline knowledge (PAGE-KNOWLEDGE.md, METADATA-BUNDLE.md)
  to identify viable projects, assess feasibility, scope, and generate project proposals
  with discipline-specific issue decomposition recommendations.
company: promptforge-ai
---

# Project Intelligence Analysis

## Overview

This skill provides comprehensive guidance for AI-driven analysis of synthesized discipline knowledge to identify viable projects, assess their feasibility, scope them appropriately, and generate project proposals. It is Phase 2 of the Discipline Automation Workflow, consuming artifacts from `knowledge-synthesis-management` (Phase 1 — which includes the discovery report from its research sub-phase) and feeding into `issue-generation-optimization` (Phase 3).

Phase 2 includes its own dedicated **research cross-referencing sub-phase** that validates the discovery report from Phase 1, cross-references essential project requirements against existing implementations, and identifies any missed projects or issues by analyzing the full Paperclip ecosystem — not just the specific discipline's documentation.

## When to Use This Skill

- Analyzing PAGE-KNOWLEDGE.md to identify project opportunities
- Assessing project feasibility based on available knowledge artifacts
- Scoping projects with appropriate complexity levels
- Decomposing projects into phased implementation plans
- Generating project proposals with issue-level recommendations
- Estimating effort, timeline, and resource requirements
- Identifying cross-discipline integration opportunities
- Analyzing existing work vs. new work requirements
- **Cross-referencing Phase 1 discovery report against agent rosters and company capabilities**
- **Validating essential project requirements through independent ecosystem scan**
- **Identifying orphaned workflows — discipline needs with no implementing agent**

## Research Cross-Referencing Sub-Phase

Before running the project identification framework, this Phase 2 sub-phase **independently validates** the Phase 1 discovery report by cross-referencing against the full Paperclip ecosystem. This ensures no essential projects or issues are missed.

### Cross-Reference Activities

#### Activity 1: Discovery Report Validation

```javascript
async function validateDiscoveryReport(discoveryReport, phase1Artifacts) {
  const validations = [];
  
  // 1. Verify each essential project from the discovery report actually exists
  for (const project of discoveryReport.essentialProjects) {
    const artifact = phase1Artifacts.pages.find(
      p => p.component === project.component
    );
    if (!artifact) {
      validations.push({
        type: 'missing_artifact',
        project,
        severity: 'critical',
        recommendation: 'Regenerate PAGE-KNOWLEDGE.md for this component'
      });
    }
  }
  
  // 2. Check for projects the discovery report might have missed
  const missedProjects = detectMissedProjects(phase1Artifacts, discoveryReport);
  validations.push(...missedProjects);
  
  // 3. Verify agent capabilities match project requirements
  const agentMismatches = validateAgentCapabilities(phase1Artifacts);
  validations.push(...agentMismatches);
  
  return { validations, passed: validations.filter(v => v.severity === 'critical').length === 0 };
}
```

#### Activity 2: Independent Ecosystem Scan

Scan the **entire Paperclip ecosystem** — not just this discipline — to discover projects and issues that may be relevant:

```javascript
function independentEcosystemScan(disciplineCode) {
  const findings = [];
  const scanSources = {
    // All company skill directories — what skills exist that this discipline needs?
    skillDirectories: scanDirectory('docs-paperclip/companies/*/skills/'),
    
    // All shared skills — cross-cutting capabilities
    sharedSkills: scanDirectory('docs-paperclip/companies/*/shared/'),
    
    // Existing projects across ALL disciplines — reusable patterns
    allProjects: scanDirectory('docs-paperclip/disciplines/*/projects/'),
    
    // Shared discipline projects — cross-discipline platforms
    sharedProjects: scanDirectory('docs-paperclip/disciplines-shared/*/projects/'),
    
    // Agent rosters — which agents exist to implement projects
    teamsRef: readFile('docs-paperclip/companies-teams/Paperclip_Teams_Cross_Reference.md'),
    
    // Knowledge artifacts — existing PAGE-KNOWLEDGE, METADATA-BUNDLE patterns
    knowledgeDir: scanDirectory('docs-paperclip/disciplines-shared/*/knowledge/')
  };
  
  // Cross-reference: does this discipline have agents assigned?
  const companyAgents = extractAgentsForDiscipline(scanSources.teamsRef, disciplineCode);
  if (companyAgents.length === 0) {
    findings.push({
      type: 'no_agents_assigned',
      severity: 'critical',
      description: `No Paperclip agents found assigned to discipline ${disciplineCode}`,
      recommendation: 'Create assignment request in Paperclip Teams Cross-Reference'
    });
  }
  
  // Cross-reference: do skills exist that this discipline needs?
  const requiredSkills = inferRequiredSkills(disciplineCode);
  const missingSkills = requiredSkills.filter(
    s => !scanSources.skillDirectories.includes(s)
  );
  if (missingSkills.length > 0) {
    findings.push({
      type: 'missing_skills',
      severity: 'high',
      skills: missingSkills,
      description: `Skills missing for ${disciplineCode}: ${missingSkills.join(', ')}`,
      recommendation: 'Create missing SKILL.md files'
    });
  }
  
  // Cross-reference: what project patterns exist from other disciplines?
  const reusablePatterns = extractProjectPatterns(scanSources.allProjects);
  findings.push({
    type: 'reusable_patterns',
    patterns: reusablePatterns,
    description: `${reusablePatterns.length} reusable project patterns found from other disciplines`
  });
  
  return findings;
}
```

#### Activity 3: Essential Project Cross-Validation

Validate that the Phase 1 discovery report covers ALL mandatory project types for any discipline:

```javascript
function crossValidateEssentialProjects(discoveryReport, ecosystemFindings) {
  const mandatoryProjectTypes = [
    {
      type: 'shared-infrastructure',
      requiredFor: 'all',
      description: 'Database schema, shared components, base integrations',
      defaultIssues: ['PAGE-KNOWLEDGE generation', 'METADATA-BUNDLE compilation', 'Database schema creation']
    },
    {
      type: 'core-page-implementation',
      requiredFor: 'all',
      description: 'Primary UI page for the discipline with Three-State nav (Template B)',
      defaultIssues: ['UI-UX-SPECIFICATION generation', 'Page implementation', 'State routing']
    },
    {
      type: 'domain-agent-configuration',
      requiredFor: 'all',
      description: 'AI agents with discipline-specific skills and knowledge',
      defaultIssues: ['Agent creation', 'Skill file generation', 'Knowledge loading']
    },
    {
      type: 'integration-layer',
      requiredFor: 'disciplines_with_external_systems',
      description: 'CAD system, ERP, or other external system integration',
      defaultIssues: ['Adapter development', 'API contract definition', 'Integration testing']
    }
  ];
  
  const missing = [];
  for (const mandatory of mandatoryProjectTypes) {
    const exists = discoveryReport.essentialProjects.some(
      p => p.type === mandatory.type
    );
    if (!exists) {
      missing.push({
        projectType: mandatory,
        severity: 'critical',
        defaultIssues: mandatory.defaultIssues.map(
          (issue, i) => ({
            id: `DEFAULT-${discoveryReport.discipline}-${mandatory.type}-${i + 1}`,
            title: issue,
            description: `Auto-detected essential issue for ${discoveryReport.discipline} — ${mandatory.type}`
          })
        )
      });
    }
  }
  
  return missing;
}
```

#### Activity 4: Orphaned Workflow Detection

Identify workflows that are documented as discipline requirements but have no implementing agent, skill, or project:

```javascript
function detectOrphanedWorkflows(disciplineCode, phase1Artifacts, ecosystemFindings) {
  const orphaned = [];
  
  // Check each agent capability requirement against actual assigned agents
  const assignedAgents = ecosystemFindings.agents.filter(
    a => a.discipline === disciplineCode
  );
  
  for (const capability of phase1Artifacts.agentRequirements || []) {
    const hasImplementingAgent = assignedAgents.some(
      a => a.skills.includes(capability.requiredSkill)
    );
    
    if (!hasImplementingAgent) {
      orphaned.push({
        workflow: capability.name,
        requiredSkill: capability.requiredSkill,
        documentedIn: capability.source,
        status: 'orphaned',
        recommendation: `Create or assign agent with '${capability.requiredSkill}' skill for ${disciplineCode}`
      });
    }
  }
  
  // Check for projects without implementing company
  for (const project of phase1Artifacts.proposedProjects || []) {
    if (!project.assignedCompany) {
      orphaned.push({
        project: project.name,
        documentedIn: project.source,
        status: 'unassigned',
        recommendation: `Assign '${project.name}' to appropriate company`
      });
    }
  }
  
  return orphaned;
}
```

#### Activity 5: Master Project & Issue Registry

From all research activities, compile a **master project registry** that definitively lists every project and issue the discipline needs, with clear source attribution:

```markdown
# Discipline Project Registry: {discipline_code}

## Essential Projects

| Priority | Project | Issues | Source | Status |
|----------|---------|--------|--------|--------|
| P0 | Foundation & Schema | 3 | Cross-validation (auto-detected) | 🔴 Missing |
| P0 | Core Page Implementation | 5 | Discovery Report | ✅ Identified |
| P0 | Domain Agent Config | 3 | Cross-validation (auto-detected) | 🔴 Missing |
| P1 | Integration Layer | 4 | Ecosystem Scan | 🟡 Planned |
| P2 | Testing & QA | 3 | Ecosystem Scan | 🟡 Planned |
| P2 | Documentation | 2 | Discovery Report | ✅ Identified |

## Early-Stage Issues (pre-HITL review)

| Issue | Project | Est. Hours | Agent | Phase |
|-------|---------|------------|-------|-------|
| PAGE-KNOWLEDGE generation | Foundation | 4 | KnowledgeForge | 1 |
| UI-UX-SPECIFICATION | Core Page | 6 | PromptForge | 1 |
| Agent skill file creation | Domain Agent | 3 | PromptForge | 1 |
| CAD adapter development | Integration | 12 | DevForge | 2 |

## Red Flags 🚩
1. {issue requiring human attention}
2. {missing resource or agent}
3. {cross-cutting dependency that must be resolved first}
```

## Project Identification Framework

### Source Analysis

```javascript
function identifyProjects(pageKnowledge, metadataBundle) {
  const opportunities = [];
  
  // 1. Analyze components without implementation (template_score = 0)
  const unimplemented = metadataBundle.shared_components.filter(
    c => c.file_path.includes('planned')
  );
  
  // 2. Analyze disciplines without pilot issues
  const unpiloted = metadataBundle.disciplines.filter(
    d => d.pilot_status === 'pending'
  );
  
  // 3. Identify integration gaps
  const integrationGaps = metadataBundle.cad_systems.filter(
    c => c.integration_status === 'planned'
  );
  
  return { unimplemented, unpiloted, integrationGaps };
}
```

### Project Categories

| Category | Description | Example | Complexity |
|----------|-------------|---------|------------|
| **Foundation** | Shared infrastructure, base components | Shared CAD viewer, validation engine | High |
| **Pilot** | Single-discipline implementation | Civil engineering pilot | Medium |
| **Expansion** | Multi-discipline rollout | 8 additional disciplines | High |
| **Integration** | External system integration | CAD system connectors | Medium |
| **Enhancement** | Feature additions to existing components | Audit trail export | Low |

## Feasibility Assessment

### Assessment Criteria

| Criterion | Weight | Scoring (1-5) | Pass Threshold |
|-----------|--------|---------------|----------------|
| Knowledge Completeness | 25% | 1=No docs, 5=Full spec | 3+ |
| Resource Availability | 20% | 1=No agents, 5=Ready team | 3+ |
| Technical Complexity | 20% | 1=Impossible, 5=Trivial | 2+ |
| Business Value | 20% | 1=Low impact, 5=Critical | 3+ |
| Timeline Feasibility | 15% | 1=Unrealistic, 5=Easy | 3+ |

```javascript
function assessFeasibility(project) {
  const scores = {
    knowledgeCompleteness: assessKnowledge(project),
    resourceAvailability: assessResources(project),
    technicalComplexity: assessComplexity(project),
    businessValue: assessValue(project),
    timelineFeasibility: assessTimeline(project)
  };
  
  const totalScore = (
    scores.knowledgeCompleteness * 0.25 +
    scores.resourceAvailability * 0.20 +
    scores.technicalComplexity * 0.20 +
    scores.businessValue * 0.20 +
    scores.timelineFeasibility * 0.15
  );
  
  return {
    scores,
    totalScore,
    feasible: totalScore >= 3.0,
    confidence: calculateConfidence(scores)
  };
}
```

## Project Scoping

### Scope Definition Template

```json
{
  "project_id": "{DISCIPLINE-CODE}-PLATFORM-000",
  "name": "{Discipline Name} Platform",
  "disciplines": ["{code1}", "{code2}"],
  "phases": [
    {
      "phase": 1,
      "name": "Foundation",
      "description": "Core components and infrastructure",
      "issues": 5,
      "duration_weeks": 2
    },
    {
      "phase": 2,
      "name": "Core Development",
      "description": "Main feature implementation",
      "issues": 8,
      "duration_weeks": 3
    },
    {
      "phase": 3,
      "name": "Integration",
      "description": "CAD system integration and testing",
      "issues": 4,
      "duration_weeks": 2
    }
  ],
  "total_issues": 17,
  "total_duration_weeks": 7,
  "companies_involved": ["devforge-ai", "domainforge-ai", "knowledgeforge-ai", "qualityforge-ai"],
  "agents_required": 12,
  "complexity": "medium",
  "knowledge_based_on": "{PAGE-KNOWLEDGE.md path}"
}
```

### Complexity Classification

| Complexity | Discipline Count | Issue Count | Duration | CAD Systems | Agents |
|------------|-----------------|-------------|----------|-------------|--------|
| Simple | 1 | 3-5 | 1-2 weeks | 1-2 | 2-3 |
| Standard | 2-3 | 8-12 | 3-4 weeks | 2-4 | 4-6 |
| Complex | 4-6 | 15-25 | 5-8 weeks | 4-7 | 8-12 |
| Enterprise | 7+ | 25+ | 8-12 weeks | 7+ | 12+ |

## Issue Decomposition Recommendations

For each project phase, generate a recommended issue breakdown:

### Phase 1: Foundation Issues

| Issue | Description | Assignee | Estimated Hours |
|-------|-------------|----------|-----------------|
| PAGE-KNOWLEDGE | Component knowledge with 8-field metadata | `knowledgeforge-ai` | 4-8 |
| METADATA-BUNDLE | Full metadata bundle compilation | `knowledgeforge-ai` | 2-4 |
| Database Schema | Table creation, indexes, migrations | `infraforge-ai` | 4-6 |
| Shared Components | Base component implementation | `devforge-ai` | 8-12 |
| Tests | Foundation test suite | `qualityforge-ai` | 4-6 |

### Phase 2: Core Issues

| Issue | Description | Assignee | Estimated Hours |
|-------|-------------|----------|-----------------|
| Discipline Config | Per-discipline configuration | `domainforge-ai` | 4-8 |
| CAD Integration | Primary CAD system connector | `devforge-ai` | 8-16 |
| Standards Selector | Standards compliance UI | `devforge-ai` | 6-10 |
| Pilot Discipline | First discipline implementation | `devforge-ai` | 12-20 |

## Integration Pattern Detection

Detect integration patterns from the analyzed knowledge:

```javascript
function detectIntegrationPatterns(metadataBundle) {
  const patterns = [];
  
  // Multi-CAD pattern
  if (metadataBundle.cad_systems.length > 3) {
    patterns.push({
      type: 'multi-cad',
      adapter: 'abstract-cad-adapter',
      systems: metadataBundle.cad_systems.map(s => s.system_id)
    });
  }
  
  // Cross-discipline pattern
  const sharedComponents = metadataBundle.shared_components.filter(c => c.disciplines.length > 3);
  if (sharedComponents.length > 0) {
    patterns.push({
      type: 'cross-discipline',
      sharedComponents: sharedComponents.map(c => c.component_id),
      disciplines: metadataBundle.disciplines.map(d => d.discipline_code)
    });
  }
  
  return patterns;
}
```

## Quality Assurance

### Completeness Checklist

#### Research Cross-Referencing Sub-Phase
- [ ] Phase 1 discovery report validated against source artifacts
- [ ] Independent ecosystem scan completed (skills, projects, teams, agents)
- [ ] Essential project cross-validation performed for mandatory types
- [ ] Orphaned workflow detection completed — no undocumented workflows
- [ ] Master project registry compiled with priority, source, and status
- [ ] Red flags documented for human attention before proceeding

#### Project Identification
- [ ] All PAGE-KNOWLEDGE components analyzed for project opportunities
- [ ] Feasibility assessment completed for each candidate project
- [ ] Project scoping includes phases, issues, duration, resources
- [ ] Multi-company coordination identified and documented
- [ ] Integration patterns detected and documented
- [ ] Effort estimates provided in issue breakdowns
- [ ] Risk assessment completed for complex projects
- [ ] Existing work vs. new work clearly distinguished

## Related Skills

- `knowledge-synthesis-management` - Upstream: provides PAGE-KNOWLEDGE.md
- `issue-generation-optimization` - Downstream: uses project intelligence to generate issues
- `risk-assessment` - Shared: assesses project risks
- `capacity-planning` - Shared: assesses resource availability
- `multi-company-orchestration` - Shared: coordinates cross-company execution

## Best Practices

1. **Always assess knowledge completeness first** — no project without sufficient knowledge
2. **Pilot before scaling** — start with 1 discipline before rolling to all
3. **Identify integration patterns early** — multi-CAD, cross-discipline, shared components
4. **Scope conservatively** — add buffer for multi-company coordination overhead
5. **Document feasibility rationale** — always capture why a project is feasible or not
6. **Decompose issues with clear entry/exit criteria** — each issue should be independently actionable
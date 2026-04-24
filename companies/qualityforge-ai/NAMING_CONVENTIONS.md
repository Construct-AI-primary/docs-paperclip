# QualityForge AI - Naming Conventions

## 1. Agent Folder Naming

### Rule: PascalCase for All Agent Folders

All agent folders MUST follow the PascalCase naming convention:

```
{company-slug}-{PascalCaseAgentName}
```

### Correct Examples:
```
qualityforge-ai-Apex
qualityforge-ai-Accessibility
qualityforge-ai-AssessmentCriteriaManager
qualityforge-ai-CodeAnalyzer
qualityforge-ai-DecisionSupportSpecialist
```

### Incorrect Examples (DO NOT USE):
```
qualityforge-ai-apex           # lowercase
qualityforge-ai-accessibility   # kebab-case
qualityforge-ai-code-analyzer   # kebab-case
qualityforge-Apex               # missing company suffix
```

---

## 2. Human Name Standards (Database)

Human names in the database MUST follow these rules:

### Rule 1: Title Case
- **Correct:** "Code Analyzer", "Quality Director"
- **Incorrect:** "code analyzer", "CODE ANALYZER", "code-analyzer"

### Rule 2: Maximum 23 Characters
- "Decision Support" (17 chars) ✅
- "Decision Support Specialist" (29 chars) ❌ (too long)

### Rule 3: No Kebab-Case or Slugs
- **Correct:** "Code Analyzer"
- **Incorrect:** "code-analyzer", "loadtester-qualityforge-scalability-testing"

### Rule 4: Acronyms Are UPPERCASE
- **Correct:** "E2E", "API", "UI", "ID"
- **Incorrect:** "e2e", "E2e", "api"

### Rule 5: No Garbled Names
- **Correct:** "Documenter"
- **Incorrect:** "Doc don"

### Rule 6: Meaningful Names
- Names should clearly identify the agent's role
- Avoid truncated or abbreviated names
- Use full words when possible

---

## 3. Common Human Name Corrections

| Incorrect Name | Correct Name | Issue |
|----------------|-------------|--------|
| Doc don | Documenter | Garbled |
| E2e | E2E | Acronym case |
| Openclaw gateway agent | OpenClaw Gateway | Too long, wrong case |
| loadtester-qualityforge-scalability-testing | Loadtester | Slug as name |
| architect-qualityforge-system-architect | Architect | Slug as name |
| assessment-criteria-manager-qualityforge | Assessment Criteria Manager | Slug as name |

---

## 4. Agent File Structure

Each agent folder must contain:
- `AGENTS.md` - Agent metadata (name, slug, reportsTo, skills)

### AGENTS.md Template:
```markdown
---
name: AgentName
slug: company-agent-role
reportsTo: manager-slug
skills:
  - skill-name
---

# Agent Title

Agent description...
```

---

## 5. Reconciliation Validation Rules

The reconciliation script validates:

1. **Hierarchy**: All agents report to Governor (except Apex)
2. **Missing Agents**: Compare filesystem vs database
3. **Folder Naming**: All folders use PascalCase
4. **Human Names**: Validate Title Case, ≤23 chars, no slugs
5. **Skills**: All agents have corresponding skill files
6. **No Duplicates**: No duplicate agent names or slugs

---

## 6. Why These Standards Matter

1. **Consistency**: All agents follow the same naming patterns
2. **Readability**: Clear, human-readable names
3. **Automation**: Easier to parse and validate programmatically
4. **UI/UX**: Better display in dashboards and reports
5. **Search**: Easier to find agents by name

---

**Last Updated:** 2026-04-24

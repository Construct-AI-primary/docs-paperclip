---
title: 02500 Security Discipline - Code and Documentation Placement Standards
author: Discipline Automation Agent
date: 2026-04-15
version: 1.0
status: active
discipline: 02500-security
---

# 02500 Security Discipline - Code and Documentation Placement Standards

## Overview

This document defines the standardized location for all code and documentation generated within the 02500 Security discipline. Agents working on security projects should follow these placement guidelines to ensure consistent organization and easy discoverability.

---

## Repository Structure

The Paperclip ecosystem uses **two repositories**:

| Repository | URL | Purpose |
|------------|-----|---------|
| **paperclip-render** | `https://github.com/Construct-AI-primary/paperclip-render.git` | Implementation code, server, UI, packages |
| **docs-paperclip** | `https://github.com/Construct-AI-primary/docs-paperclip.git` | Documentation, plans, issues, procedures |

---

## 📂 docs-paperclip Repository - Discipline Structure

### Root: `/docs-paperclip/disciplines/02500-security/`

```
02500-security/
├── CODE-AND-DOC-PLACEMENT.md    ← This file - placement standards
├── README.md                     ← Discipline overview
│
├── knowledge/                   ← Cross-project domain knowledge
│   └── PAGE-KNOWLEDGE.md        ← Master knowledge base
│
├── projects/                    ← All security projects
│   └── {PROJECT-CODE}/
│       ├── README.md            ← Project overview
│       ├── plan.md              ← Project plan
│       ├── AGENTS.md            ← Project-specific agent instructions
│       │
│       ├── issues/              ← Issues (non-platform specific)
│       │   └── {ISSUE-ID}.md
│       │
│       ├── desktop/             ← Desktop-specific work
│       │   ├── issues/
│       │   │   └── {ISSUE-ID}.md
│       │   ├── learning/
│       │   ├── orchestration/
│       │   └── CODE-PLACEMENT.md
│       │
│       ├── mobile/              ← Mobile-specific work
│       │   ├── issues/
│       │   │   └── {ISSUE-ID}.md
│       │   ├── learning/
│       │   ├── orchestration/
│       │   └── CODE-PLACEMENT.md
│       │
│       ├── web/                ← Web-specific work
│       │   ├── issues/
│       │   ├── learning/
│       │   └── CODE-PLACEMENT.md
│       │
│       ├── shared/              ← Code shared across platforms
│       │   ├── api/
│       │   ├── business-logic/
│       │   ├── data-models/
│       │   └── AUTH.md          ← Auth implementation
│       │
│       └── knowledge/           ← Project-specific knowledge
│           └── PAGE-KNOWLEDGE.md
│
├── trigger/                     ← Automation triggers
│   ├── README.md
│   └── {AUTO-PROJECT}/
│       └── issues/
│           └── {AUTO-PROJECT}-000-discipline-automation.md
│
├── procedures/                  ← Discipline-specific procedures
│   ├── security-incident-response.md
│   ├── access-control-implementation.md
│   └── surveillance-system-setup.md
│
└── plans/                       ← Discipline automation plans
    └── YYYY-MM-DD-security-automation-plan.md
```

---

## 📂 paperclip-render Repository - Implementation Structure

### Root: `/paperclip-render/`

```
paperclip-render/
├── server/                      ← Backend API implementation
│   └── src/
│       ├── routes/
│       │   ├── auth-routes.ts
│       │   └── security-routes.ts
│       ├── services/
│       │   ├── auth-service.ts
│       │   └── security-service.ts
│       ├── middleware/
│       │   └── security-middleware.ts
│       └── types/
│           └── security-types.ts
│
├── ui/                         ← Frontend implementation
│   └── src/
│       ├── components/
│       │   ├── auth/
│       │   ├── security/
│       │   └── shared/
│       ├── pages/
│       │   ├── desktop/
│       │   └── mobile/
│       └── hooks/
│
├── packages/
│   ├── db/                     ← Database schemas
│   │   └── src/schema/
│   │       ├── auth.ts
│   │       └── security.ts
│   │
│   ├── shared/                 ← Shared types/constants
│   │   └── src/
│   │       ├── auth.ts
│   │       └── security.ts
│   │
│   └── adapters/               ← Agent adapters
│
└── tests/
    ├── unit/
    ├── integration/
    └── e2e/
```

---

## 📋 Documentation Placement by Type

### Issue Files → docs-paperclip

| Issue Type | Location |
|------------|----------|
| Discipline Automation | `disciplines/02500-security/trigger/{PROJECT}/issues/` |
| Desktop Project | `disciplines/02500-security/projects/{PROJECT}/desktop/issues/` |
| Mobile Project | `disciplines/02500-security/projects/{PROJECT}/mobile/issues/` |
| Shared/Infrastructure | `disciplines/02500-security/projects/{PROJECT}/issues/` |

### Knowledge Docs → docs-paperclip

| Knowledge Type | Location |
|---------------|----------|
| Discipline Knowledge | `disciplines/02500-security/knowledge/PAGE-KNOWLEDGE.md` |
| Project Knowledge | `disciplines/02500-security/projects/{PROJECT}/knowledge/PAGE-KNOWLEDGE.md` |

### Implementation Code → paperclip-render

| Code Type | Location |
|-----------|----------|
| Backend API | `paperclip-render/server/src/` |
| Frontend UI | `paperclip-render/ui/src/` |
| Database Schemas | `paperclip-render/packages/db/src/schema/` |
| Shared Types | `paperclip-render/packages/shared/src/` |
| Tests | `paperclip-render/tests/` |

### Plans & Procedures → docs-paperclip

| Document Type | Location |
|---------------|----------|
| Automation Plans | `disciplines/02500-security/plans/` |
| Procedures | `disciplines/02500-security/procedures/` |
| Workflow Docs | `disciplines/02500-security/projects/{PROJECT}/orchestration/` |

---

## 🔑 Key Placement Rules

### Rule 1: Documentation Stays in docs-paperclip
All documentation, issues, plans, and procedures go in the `docs-paperclip` repository under the discipline folder.

### Rule 2: Implementation Code Goes to paperclip-render
All actual code (server, UI, database schemas, tests) goes in the `paperclip-render` repository.

### Rule 3: Issues Reference Both Repositories
Each issue should have a "Working Directory & Repository" section that specifies:
- Which repository to work in
- Specific files/directories to create/modify

### Rule 4: Platform-Specific Gets Platform Folder
Desktop code → `desktop/` folder
Mobile code → `mobile/` folder
Shared code → `shared/` folder

### Rule 5: Security-Specific Paths
For 02500 Security discipline:
- Security API routes: `server/src/routes/security-routes.ts`
- Security services: `server/src/services/security-service.ts`
- Security components: `ui/src/components/security/`

---

## 📝 Example: Issue with Code Placement

```markdown
## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`

### Documentation (docs-paperclip)
- `docs-paperclip/disciplines/02500-security/projects/SECURITY-ASSET/mobile/issues/MOBILE-SECURITY-ASSET-001.md`

### Code Implementation (paperclip-render)
- `paperclip-render/server/src/services/security-service.ts`
- `paperclip-render/packages/db/src/schema/security.ts`
- `paperclip-render/ui/src/components/security/LoginScreen.tsx`
```

---

## 🔄 Cross-Platform Code Sharing

When code is shared across platforms, document the shared components:

| Shared Component | Location | Shared By |
|------------------|----------|-----------|
| API contracts | `disciplines/{PROJECT}/shared/api/` | desktop, mobile, web |
| Business logic | `disciplines/{PROJECT}/shared/business-logic/` | All platforms |
| Data models | `disciplines/{PROJECT}/shared/data-models/` | All platforms |
| Auth logic | `disciplines/{PROJECT}/shared/AUTH.md` | All platforms |

---

## ✅ Verification Checklist

Before completing any work, verify:

- [ ] Documentation created in correct docs-paperclip location
- [ ] Code created in correct paperclip-render location
- [ ] Issue references both repositories with specific paths
- [ ] Platform-specific files in correct platform folder
- [ ] Shared code documented in shared/ folder
- [ ] PAGE-KNOWLEDGE.md updated if knowledge was added

---

## 🚨 Common Mistakes to Avoid

1. **❌ Don't put code in docs-paperclip** → Code goes to paperclip-render
2. **❌ Don't put docs in paperclip-render** → Docs go to docs-paperclip
3. **❌ Don't mix platforms** → Use desktop/, mobile/, web/ folders
4. **❌ Don't forget shared/** → Document shared components separately

---

## 📞 Questions?

If unsure where something goes:
1. Check this document first
2. Check the discipline's PAGE-KNOWLEDGE.md
3. Check the project-specific AGENTS.md
4. Ask the Discipline Automation Agent

---

**Document Version**: 1.0
**Last Updated**: 2026-04-15
**Discipline**: 02500 Security
**Maintained By**: Discipline Automation Agent

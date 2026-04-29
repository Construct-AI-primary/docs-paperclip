---
id: LOGISTICS-004
title: 01700 Configure development environment, CI/CD, and deployment pipeline
description: Set up mono-repo structure with desktop/, mobile/, web/ directories, TypeScript, ESLint, Prettier, Vitest, and GitHub Actions CI/CD
labels: ["logistics", "devops", "1 — Foundation"]
blocked_by: []
depends_on: []
para_section: logistics/projects/LOGISTICS-PLATFORM/desktop/issues
phase: 1 — Foundation
status: todo
priority: High
story_points: 5
due_date: "2026-05-07"
assignee: devcore-devforge
company: devforge-ai
delegation:
  parent_goal_id: "LOGISTICS-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Establish consistent development environment for logistics platform"
  agent_goal: "As devcore-devforge, configure mono-repo structure and CI/CD pipeline"
  task_goal: "Working CI/CD pipeline with typecheck, lint, test, and build stages"
---

# LOGISTICS-004: 01700 Configure development environment, CI/CD, and deployment pipeline

## Executive Summary

This issue sets up the development environment and CI/CD pipeline for the logistics platform. Following CODE-AND-DOC-PLACEMENT.md conventions, the mono-repo structure includes desktop/, mobile/, and web/ directories. Configuration covers TypeScript, ESLint, Prettier, Vitest, and GitHub Actions for continuous integration and deployment.

## Problem Statement / Scope

Without a consistent development environment, multiple developers cannot collaborate efficiently. This issue covers: mono-repo directory structure, TypeScript configuration, ESLint/Prettier standards, Vitest test runner setup, GitHub Actions CI/CD pipeline (typecheck → lint → test → build → deploy), and staging/production Supabase project configuration. Cross-reference `docs-construct-ai/disciplines/01700_logistics/agent-data/01700_CODING_STANDARDS.md` for existing coding standards.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 4A | Create mono-repo structure: desktop/, mobile/, web/, shared/ | Directory structure created |
| 4B | Configure TypeScript (tsconfig.json), ESLint, Prettier | Linting and formatting pass |
| 4C | Set up Vitest with coverage reporting | Test suite operational |
| 4D | Create GitHub Actions CI pipeline (typecheck → lint → test → build) | CI passes on PR |
| 4E | Create GitHub Actions CD pipeline (deploy to staging) | CD deploys on main merge |
| 4F | Configure staging and production Supabase projects | Environments configured |

## Acceptance Criteria

- [ ] Mono-repo structure with desktop/, mobile/, web/, shared/ directories exists
- [ ] TypeScript compiles without errors
- [ ] ESLint passes with no errors (warnings allowed)
- [ ] Prettier format check passes
- [ ] Vitest runs with 0 failures
- [ ] GitHub Actions CI triggers on PR and push to main
- [ ] GitHub Actions CD deploys to staging on main merge
- [ ] Staging and production Supabase projects accessible
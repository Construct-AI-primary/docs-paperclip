---
id: MOBILE-CIVIL-SPEC-001
title: Implement Foundation Design Calculator
phase: 1 — Foundation & Calculations
status: open
priority: Critical
---

# MOBILE-CIVIL-SPEC-001: Implement Foundation Design Calculator

## Description

Replace the placeholder foundation design panel with a fully functional calculator that implements actual civil engineering formulas for foundation design, including bearing capacity calculations, settlement analysis, and structural requirements.

## Current State

CivilEngineeringScreen.tsx has a "Foundation Design" tab that shows static placeholder text "Foundation design calculations will be implemented here." No actual calculations or input fields exist.

## Acceptance Criteria

- [ ] Foundation Design Calculator component created with input fields for soil properties, loads, and foundation type
- [ ] Bearing capacity calculations implemented using standard engineering formulas
- [ ] Settlement analysis calculations for different foundation types
- [ ] Structural requirement checks (moment, shear, deflection)
- [ ] Input validation for engineering parameters
- [ ] Calculation results displayed with proper units and formatting
- [ ] Error handling for invalid inputs and edge cases
- [ ] Save/export functionality for calculation results

## Assigned Company & Agent

- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** `https://github.com/Construct-AI-primary/construct_ai.git`
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
  - **Documentation Repository:** `https://github.com/Construct-AI-primary/docs-paperclip.git`
  - **Construct AI Docs Repository:** `https://github.com/Construct-AI-primary/construct_ai_docs.git`
- **Target Files:**
  - `mobile/src/screens/civil-engineering/CivilEngineeringScreen.tsx`
  - `mobile/src/components/civil-engineering/FoundationDesignCalculator.tsx`
  - `mobile/src/utils/civilEngineeringCalculations.ts`

## Required Skills

- `mobile-development` (MobileForge)
- `civil-engineering` (DomainForge)
- `typescript` (DevForge)
- `engineering-calculations` (KnowledgeForge)

## Dependencies

- BLOCKED BY: None
- BLOCKS: MOBILE-CIVIL-SPEC-002, MOBILE-CIVIL-SPEC-003, MOBILE-CIVIL-SPEC-004

## Paperclip Task Schema

```yaml
company: mobileforge-ai
agents:
  - mobileforge-ai-frontend-engineer
toolsets:
  - file_tools
  - code_execution
  - calculator
max_iterations: 60
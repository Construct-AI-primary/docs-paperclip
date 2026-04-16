---
id: MOBILE-ELECTRICAL-CALC-001
title: Implement Load Calculation Engine
phase: 1 — Core Calculations
status: open
priority: Critical
---

# MOBILE-ELECTRICAL-CALC-001: Implement Load Calculation Engine

## Description

Replace the placeholder load calculation panel with a fully functional electrical load calculator that implements NEC Article 220 requirements for residential, commercial, and industrial load calculations, including demand factors and service calculations.

## Current State

ElectricalEngineeringScreen.tsx has a "Load Calculator" tab that shows static placeholder text "Load calculations will be implemented here." No actual electrical load calculations or input fields exist.

## Acceptance Criteria

- [ ] Load Calculator component created with comprehensive input fields for electrical loads
- [ ] NEC Article 220 residential load calculations implemented
- [ ] Commercial and industrial load calculation methods included
- [ ] Demand factor calculations for different load types
- [ ] Service entrance calculations with proper sizing
- [ ] Input validation for electrical parameters and ranges
- [ ] Calculation results displayed with proper electrical units
- [ ] Error handling for invalid inputs and edge cases
- [ ] Save/export functionality for load calculation results

## Assigned Company & Agent

- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - `mobile/src/screens/electrical-engineering/ElectricalEngineeringScreen.tsx`
  - `mobile/src/components/electrical-engineering/LoadCalculator.tsx`
  - `mobile/src/utils/electricalEngineeringCalculations.ts`

## Required Skills

- `mobile-development` (MobileForge)
- `electrical-engineering` (DomainForge)
- `typescript` (DevForge)
- `nec-compliance` (KnowledgeForge)

## Dependencies

- BLOCKED BY: None
- BLOCKS: MOBILE-ELECTRICAL-CALC-002, MOBILE-ELECTRICAL-CALC-003, MOBILE-ELECTRICAL-CALC-004

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
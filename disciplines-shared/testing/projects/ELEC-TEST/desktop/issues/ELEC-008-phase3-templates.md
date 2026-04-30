---
id: ELEC-008
title: 00860 Templates — SLD, Cable Schedule & Protection Studies Template Generation
description: Verify SLD viewer templates, cable schedule templates, and protection study templates populate and export correctly
labels: ["testing", "electrical-engineering", "3 — Integration"]
blocked_by: []
depends_on: ["ELEC-001", "ELEC-002", "ELEC-003"]
para_section: testing/projects/ELEC-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 5
due_date: "2026-05-03"
assignee: electrical-engineering-domainforge-electrical
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-ELECTRICAL-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify electrical template generation and population."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 00860 electrical engineering page production readiness"
  agent_goal: "As electrical-engineering-domainforge-electrical, verify SLD viewer templates, cable schedule templates, and protection study templates populate and export correctly"
  task_goal: "Execute template population, validation, and export for all 3 template types"
---

# ELEC-008: 00860 Templates — SLD, Cable Schedule & Protection Studies Template Generation

## Executive Summary

This issue validates the template generation system for the 00860 electrical engineering page. Three template types must be verified: Single Line Diagram (SLD) templates, Cable Schedule templates, and Protection Study templates. Each template must populate correctly with user data, validate required fields, and support export functionality.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 8A | SLD template | SLD template populates from electrical system data; diagram renders |
| 8B | Cable schedule template | Cable schedule populates with current rating and voltage drop data |
| 8C | Protection study template | Protection study template renders with fault current and clearing time data |
| 8D | Template export | Export to PDF/CSV generates valid document |

## Acceptance Criteria

- [ ] SLD template populates correctly from system data
- [ ] Cable schedule template populates with correct cable data
- [ ] Protection study template renders with correct study data
- [ ] Template field validation works for required fields
- [ ] Export generates valid PDF/CSV document
- [ ] Empty template shows appropriate placeholder<execute_command>
<command>cd "/Users/_Final UI testing/paperclip-render/docs-paperclip/disciplines-shared/testing/projects/ELEC-TEST/desktop/issues" && cat > ELEC-008-phase3-templates.md << 'ENDOFFILE'
---
id: ELEC-008
title: 00860 Templates — SLD, Cable Schedule & Protection Studies
description: Verify all electrical engineering templates (SLD, Cable Schedule, Protection Studies) populate, validate, and export correctly
labels: ["testing", "electrical-engineering", "3 — Integration"]
blocked_by: []
depends_on: ["ELEC-001", "ELEC-002"]
para_section: testing/projects/ELEC-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 5
due_date: "2026-05-03"
assignee: electrical-engineering-domainforge-electrical
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-ELECTRICAL-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify electrical template population accuracy end-to-end."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 00860 electrical engineering page production readiness"
  agent_goal: "As electrical-engineering-domainforge-electrical, verify all templates populate, validate, and export correctly"
  task_goal: "Execute template generation for SLD, cable schedule, and protection studies with >90% pass rate"
---

# ELEC-008: 00860 Templates — SLD, Cable Schedule & Protection Studies

## Executive Summary

This issue validates the electrical engineering template system which generates SLD (Single Line Diagram), Cable Schedule, and Protection Studies documents. Each template must populate correctly from database data, validate required fields, and support export. Template accuracy is critical for downstream engineering use.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 8A | SLD template | Template populates from cable_schedules data; diagram renders correctly |
| 8B | Cable schedule template | Template populates with all cable data; validation passes |
| 8C | Protection studies template | Template populates with protection study results | 
| 8D | Export functionality | Export to PDF/CSV generates valid file |

## Acceptance Criteria

- [ ] SLD template populates correctly
- [ ] Cable schedule template validates required fields
- [ ] Protection studies template renders data correctly
- [ ] Template export generates valid file
- [ ] Empty templates show appropriate empty state

## Dependencies

- **Depends on:** ELEC-001, ELEC-002

## Risk Level

High — templates are primary engineering output documents

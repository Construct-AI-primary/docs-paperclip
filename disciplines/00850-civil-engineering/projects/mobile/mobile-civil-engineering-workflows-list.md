# Mobile Civil Engineering Workflows List (00850)

**Date:** 2026-04-14
**Platform:** Mobile (MobileForge AI)
**Parent Discipline:** 00850 Civil Engineering
**Source Document:** `../desktop/00850-civil-engineering-workflows-list.md`

---

## Overview

This document identifies which desktop civil engineering workflows can be enhanced by mobile capabilities, assesses current mobile app implementation status, and defines mobile-specific workflow requirements for MobileForge AI.

**Total Desktop Workflows:** 7
**Mobile-Enhanceable Workflows:** 7
**Mobile-Only Workflows:** 3
**Not Suitable for Mobile:** 0

---

## Section 1: Mobile Enhancement Assessment

### Workflow-by-Workflow Mobile Analysis

| # | Desktop Workflow | Mobile Enhancement Potential | Mobile Features | Existing Mobile Code | Gap |
|---|-----------------|---------------------------|-----------------|---------------------|-----|
| 1 | **Civil Specification Development** (CIVIL-SPEC-DEV) | ✅ HIGH | On-site spec review, photo documentation, voice notes, offline access | ⚠️ CivilEngineeringScreen.tsx (286 lines) - placeholder panels only | ❌ All panels are stubs, no calculations |
| 2 | **Civil Infrastructure Specification** (CIVIL-INFRA-SPEC) | ✅ HIGH | On-site infrastructure review, GPS tagging, photo documentation | ❌ Not implemented | ❌ Full implementation needed |
| 3 | **Site Analysis & Planning** (CIVIL-SITE) | ✅ HIGH | GPS site survey, photo documentation, offline site notes, map integration | ❌ Not implemented | ❌ Full implementation needed |
| 4 | **Structural Design & Analysis** (CIVIL-STRUCTURAL) | ⚠️ MEDIUM | On-site structural inspection, photo documentation, voice notes | ❌ Not implemented | ❌ Inspection UI needed |
| 5 | **Transportation & Circulation** (CIVIL-TRANSPORT) | ⚠️ MEDIUM | Mobile traffic survey, GPS route mapping, photo documentation | ❌ Not implemented | ❌ Survey UI needed |
| 6 | **Utilities & Infrastructure Systems** (CIVIL-UTILITIES) | ✅ HIGH | Utility location mapping, GPS tagging, photo documentation, offline access | ❌ Not implemented | ❌ Utility mapping UI needed |
| 7 | **Construction Support & QA** (CIVIL-CONSTRUCTION) | ✅ HIGH | On-site inspection checklists, photo evidence, GPS verification, offline forms | ❌ Not implemented | ❌ Inspection UI needed |

---

## Section 2: Mobile-Only Workflows

### MOBILE-CIVIL-SURVEY: Mobile Site Survey
**Description:** GPS-enabled site survey and documentation workflow
**Mobile Features:**
- GPS coordinate capture for site features
- Photo documentation with location tagging
- Voice notes for site observations
- Offline survey form completion
**Existing Mobile Code:** ✅ expo-location, expo-camera installed
**Gap:** No civil-specific survey UI

### MOBILE-CIVIL-INSPECTION: On-Site Civil Inspection
**Description:** Mobile-first civil engineering inspection workflow
**Mobile Features:**
- Digital inspection checklists
- Photo evidence with annotation
- GPS-verified inspection locations
- Offline inspection forms with sync
- Voice-to-text inspection notes
**Existing Mobile Code:** ✅ Camera, location, voice services exist
**Gap:** No inspection-specific UI

### MOBILE-CIVIL-CALC: On-Site Engineering Calculators
**Description:** Mobile engineering calculators for field use
**Mobile Features:**
- Foundation design calculator
- Concrete mix calculator
- Earthwork volume calculator
- Drainage flow calculator
- Unit conversion tools
**Existing Mobile Code:** ❌ No calculators implemented
**Gap:** All calculator panels are placeholders

---

## Section 3: Mobile Civil Engineering Project Structure

### Recommended Mobile Projects

| Project ID | Name | Priority | Status | Parent Desktop Workflow |
|------------|------|----------|--------|------------------------|
| MOBILE-CIVIL-SPEC | Specification Development | HIGH | ❌ Placeholder | CIVIL-SPEC-DEV |
| MOBILE-CIVIL-INSPECTION | On-Site Inspection | HIGH | ❌ Missing | CIVIL-CONSTRUCTION |
| MOBILE-CIVIL-SURVEY | Site Survey | HIGH | ❌ Missing | CIVIL-SITE |
| MOBILE-CIVIL-CALC | Engineering Calculators | HIGH | ❌ Placeholder | Multiple |
| MOBILE-CIVIL-UTILITIES | Utility Mapping | MEDIUM | ❌ Missing | CIVIL-UTILITIES |
| MOBILE-CIVIL-STRUCTURAL | Structural Inspection | MEDIUM | ❌ Missing | CIVIL-STRUCTURAL |
| MOBILE-CIVIL-TRANSPORT | Traffic Survey | LOW | ❌ Missing | CIVIL-TRANSPORT |

---

## Section 4: Current Mobile Code Assessment

### Existing Civil Engineering Mobile Code

| File | Purpose | Status | Issues |
|------|---------|--------|--------|
| `screens/civil-engineering/CivilEngineeringScreen.tsx` | Civil engineering main screen | ⚠️ Placeholder | 4 tab panels all show static text only |
| `screens/civil-engineering/components/CivilEngineeringWorkflow.tsx` | Workflow component | ⚠️ Exists | Not integrated with calculations |
| `screens/civil-engineering/components/WorkflowCard.tsx` | Workflow card component | ⚠️ Exists | UI component only |
| `services/civilEngineeringService.ts` | Civil engineering service | ⚠️ Exists | No calculation implementations |
| Navigation | Not registered in App.tsx | ❌ Missing | Screen not accessible |

### Missing Mobile Components

| Component | Required For | Priority |
|-----------|-------------|----------|
| FoundationDesignCalculator | Foundation calculations | HIGH |
| ConcreteMixCalculator | Concrete calculations | HIGH |
| EarthworkCalculator | Earthwork calculations | HIGH |
| DrainageCalculator | Drainage calculations | HIGH |
| SiteSurveyScreen | GPS site survey | HIGH |
| InspectionChecklistScreen | On-site inspections | HIGH |
| UtilityMappingScreen | Utility location mapping | MEDIUM |
| StructuralInspectionScreen | Structural inspections | MEDIUM |
| TrafficSurveyScreen | Traffic surveys | LOW |
| civilEngineeringSlice.ts | Redux state | HIGH |

---

## Section 5: Mobile-Specific Requirements

### MOBILE-CIVIL-SPEC (Priority: HIGH)
- [ ] Implement actual calculation engines in all 4 panels
- [ ] Add to navigation stack
- [ ] Add offline spec document access
- [ ] Add photo documentation integration
- [ ] Add voice notes for spec observations

### MOBILE-CIVIL-CALC (Priority: HIGH)
- [ ] Implement Foundation Design Calculator
- [ ] Implement Concrete Mix Calculator
- [ ] Implement Earthwork Volume Calculator
- [ ] Implement Drainage Flow Calculator
- [ ] Add unit conversion tools
- [ ] Add calculation history and export

### MOBILE-CIVIL-INSPECTION (Priority: HIGH)
- [ ] Create InspectionChecklistScreen
- [ ] Implement digital checklists with photo evidence
- [ ] Add GPS-verified inspection locations
- [ ] Add offline inspection forms
- [ ] Add voice-to-text inspection notes

### MOBILE-CIVIL-SURVEY (Priority: HIGH)
- [ ] Create SiteSurveyScreen
- [ ] Add GPS coordinate capture
- [ ] Add photo documentation with location
- [ ] Add voice notes for observations
- [ ] Add offline survey forms

---

## Section 6: Implementation Priority

### Phase 1: Complete Existing (Weeks 1-3)
1. **MOBILE-CIVIL-SPEC** — Implement actual calculations in existing panels
2. **MOBILE-CIVIL-CALC** — Build engineering calculators
3. **Navigation integration** — Add civil engineering to app navigation

### Phase 2: Core Workflows (Weeks 4-7)
4. **MOBILE-CIVIL-INSPECTION** — On-site inspection workflow
5. **MOBILE-CIVIL-SURVEY** — GPS site survey
6. **MOBILE-CIVIL-UTILITIES** — Utility mapping

### Phase 3: Extended Workflows (Weeks 8-10)
7. **MOBILE-CIVIL-STRUCTURAL** — Structural inspection
8. **MOBILE-CIVIL-TRANSPORT** — Traffic survey

---

## Section 7: Dependencies

### Desktop Dependencies
- Civil engineering calculation APIs
- Site plan data availability
- Utility mapping data

### Mobile Dependencies
- expo-location GPS services
- expo-camera integration
- Map integration (react-native-maps)
- Offline storage for calculations

### Cross-Company Dependencies
- **InfraForge AI**: Civil engineering data APIs
- **DevForge AI**: Mobile civil UI components
- **QualityForge AI**: Calculation validation testing

---

*This mobile civil engineering workflows list serves as the roadmap for MobileForge AI civil engineering implementation.*
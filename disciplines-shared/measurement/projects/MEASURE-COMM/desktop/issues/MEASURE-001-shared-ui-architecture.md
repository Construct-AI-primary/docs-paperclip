---
title: "MEASURE-001: Shared UI Architecture"
description: "Design and implement shared UI components for IntegrateForge measurement platform"
gigabrain_tags: issue, measurement, ui, architecture, shared-components
para_section: disciplines-non/02025-measurement/projects/MEASURE-COMM/desktop/issues
last_updated: 2026-04-20
status: backlog
priority: High
---

# MEASURE-001: Shared UI Architecture

## Overview

Design and implement shared UI components that work across all IntegrateForge integrations (AutoCAD, Civil 3D, Revit, CostX, etc.)

## Requirements

1. IntegrationCard component with OAuth flow
2. MeasurementGrid with AG Grid spreadsheet
3. AccuracyMeter with 100% indicator
4. DisciplineBadge color-coded labels
5. ConnectionWizard with 4-step OAuth
6. 4-Panel UI Layout for measurement workflows (including AI chat interface)

## VS Code-Style Panel Architecture

### Panel Structure (VS Code Inspired)
```javascript
// VS Code-style collapsible panel interface
const VSCodeStyleLayout = {
  activityBar: {
    position: 'left',
    width: '48px',
    component: 'ActivityBar',
    icons: [
      'Explorer',
      'Measurement',
      'Templates',
      'AIAssistant',
      'Settings'
    ]
  },
  primarySideBar: {
    position: 'left',
    width: '300px',
    collapsible: true,
    component: 'PrimarySideBar',
    views: [
      'ProjectExplorer',
      'DisciplineSelector',
      'TemplateLibrary',
      'StandardsPanel'
    ]
  },
  editorArea: {
    position: 'center',
    component: 'EditorArea',
    content: [
      'DrawingViewer',
      'MeasurementCanvas',
      'AnnotationLayer',
      'ValidationOverlay'
    ]
  },
  secondarySideBar: {
    position: 'right',
    width: '300px',
    collapsible: true,
    component: 'SecondarySideBar',
    views: [
      'MeasurementGrid',
      'PropertiesPanel',
      'AuditTrail',
      'ExportControls'
    ]
  },
  panelArea: {
    position: 'bottom',
    height: '200px',
    collapsible: true,
    component: 'PanelArea',
    tabs: [
      'AIChat',
      'Terminal',
      'Output',
      'Problems'
    ]
  },
  statusBar: {
    position: 'bottom',
    height: '22px',
    component: 'StatusBar',
    indicators: [
      'AccuracyMeter',
      'ConnectionStatus',
      'AgentStatus',
      'ProgressIndicator'
    ]
  }
};
```

### Panel Functionality (VS Code Style)

#### Activity Bar (Left Edge)
- **Explorer Icon**: Project tree and file navigation
- **Measurement Icon**: Measurement tools and workflows
- **Templates Icon**: Template library access
- **AI Assistant Icon**: Chat interface toggle
- **Settings Icon**: Configuration and preferences

#### Primary Side Bar (Left, Collapsible)
- **Project Explorer**: Hierarchical view of drawings and measurements
- **Discipline Selector**: Civil, Electrical, Mechanical, Structural filters
- **Template Library**: Quick access to measurement templates
- **Standards Panel**: Real-time validation indicators and compliance status

#### Editor Area (Center, Main Workspace)
- **Drawing Viewer**: CAD drawing display with zoom/pan controls
- **Measurement Canvas**: Interactive measurement tools and annotation layer
- **Validation Overlay**: Real-time accuracy feedback and error highlighting
- **Multi-Document Support**: Tabbed interface for multiple drawings

#### Secondary Side Bar (Right, Collapsible)
- **Measurement Grid**: Spreadsheet view of all measurements with AG Grid
- **Properties Panel**: Selected element properties and attributes
- **Audit Trail**: Change history and user activity log
- **Export Controls**: CSV, Excel, PDF export options and format selection

#### Panel Area (Bottom, Collapsible)
- **AI Chat Tab**: Real-time conversation with specialized measurement agents
- **Terminal Tab**: Command-line interface for advanced operations
- **Output Tab**: System messages, processing logs, and status updates
- **Problems Tab**: Validation errors, warnings, and compliance issues

#### Status Bar (Bottom Edge)
- **Accuracy Meter**: Real-time measurement accuracy percentage
- **Connection Status**: Integration connection indicators (AutoCAD, Revit, etc.)
- **Agent Status**: AI assistant availability and current activity
- **Progress Indicator**: Long-running operation progress bars

### Responsive Behavior (VS Code Style)
```css
/* VS Code-style responsive panel behavior */
@media (max-width: 1400px) {
  .primary-sidebar, .secondary-sidebar {
    width: 250px; /* Slightly narrower sidebars */
  }
  .panel-area { height: 150px; } /* Shorter bottom panel */
}

@media (max-width: 1200px) {
  .primary-sidebar, .secondary-sidebar {
    width: 200px; /* Narrower for smaller screens */
  }
  .panel-area { height: 120px; }
}

@media (max-width: 900px) {
  /* Auto-hide sidebars on smaller screens */
  .primary-sidebar, .secondary-sidebar {
    position: absolute;
    z-index: 1000;
    box-shadow: 0 0 10px rgba(0,0,0,0.3);
  }
  .primary-sidebar { left: -200px; } /* Hidden off-screen */
  .secondary-sidebar { right: -200px; }
  .panel-area { height: 100px; }
}

@media (max-width: 600px) {
  /* Mobile: hide all panels, show only editor area */
  .primary-sidebar, .secondary-sidebar, .panel-area {
    display: none;
  }
  .activity-bar { width: 40px; } /* Narrower activity bar */
  .editor-area { width: 100%; }
  .status-bar { height: 20px; } /* Shorter status bar */
}
```

### Panel Communication
```javascript
// Inter-panel communication protocol
const PanelCommunication = {
  // Left panel → Center panel
  onTemplateSelected: (template) => {
    centerPanel.loadTemplate(template);
  },

  // Center panel → Right panel
  onMeasurementSelected: (measurement) => {
    rightPanel.showProperties(measurement);
  },

  // Right panel → Center panel
  onMeasurementUpdated: (measurement) => {
    centerPanel.updateAnnotation(measurement);
  }
};
```

## Acceptance Criteria

- [ ] IntegrationCard renders for all 21 integrations
- [ ] MeasurementGrid supports inline editing
- [ ] AccuracyMeter shows 100% accuracy
- [ ] DisciplineBadge updates based on discipline
- [ ] ConnectionWizard completes OAuth flow
- [ ] VS Code-style panel interface renders correctly on desktop
- [ ] AI chat interface integrates with measurement workflow
- [ ] Panel communication protocol functions properly
- [ ] Responsive behavior works on tablets and mobile

## Assignee

TBD - IntegrateForge UI Team

## Related Components

- ui/src/components/integrateforge/common/
- ui/src/components/integrateforge/measurement/
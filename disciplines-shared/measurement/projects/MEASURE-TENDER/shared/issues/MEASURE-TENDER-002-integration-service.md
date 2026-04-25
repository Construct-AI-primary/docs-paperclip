---
title: "MEASURE-TENDER-002: Subcontract Integration Service"
description: "Implement subcontract-integration-service.js following the proven tender-integration-service.js pattern with parallel architecture"
gigabrain_tags: issue, measurement, tender, integration-service, nodejs, tender-integration, parallel-pattern
labels: ["measurement", "tender", "backend", "service"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/issues
last_updated: 2026-04-25
status: backlog
priority: High
story_points: 21
due_date: "2026-05-08"
assigned_to: devcore-devforge
company: devforge-ai
team: engineering
---

# MEASURE-TENDER-002: Subcontract Integration Service

## Overview

Implement `subcontract-integration-service.js` - a parallel integration service for managing subcontractor portal sources and RFQ synchronization. This service follows the **same proven pattern** as `tender-integration-service.js` from the gov.za integration but operates on separate tables to maintain security isolation.

## Requirements

### Service Architecture

1. **Source Registration**: Add/update/remove subcontractor portal sources
2. **Health Monitoring**: Continuous health checks for all configured sources
3. **Sync Management**: Scheduled and on-demand RFQ synchronization
4. **Error Recovery**: Retry logic with exponential backoff
5. **Metrics Collection**: Track sync performance and success rates

### Core Methods

```javascript
class SubcontractIntegrationService {
  // Initialization
  initialize(): Promise<void>
  
  // Source Management
  registerSource(config: PortalSourceConfig): Promise<Source>
  updateSource(sourceId: string, config: Partial<PortalSourceConfig>): Promise<Source>
  removeSource(sourceId: string): Promise<void>
  testConnection(sourceId: string): Promise<HealthStatus>
  
  // Sync Operations
  syncSource(sourceId: string, options?: SyncOptions): Promise<SyncResult>
  syncAll(options?: SyncOptions): Promise<SyncResult[]>
  
  // Health & Monitoring
  getHealthStatus(): Promise<HealthStatus>
  getSyncHistory(sourceId?: string): Promise<SyncHistory[]>
  getErrorLogs(sourceId?: string, limit?: number): Promise<ErrorLog[]>
  
  // RFQ Management
  createRFQ(rfq: RFQData): Promise<RFQ>
  updateRFQ(rfqId: string, data: Partial<RFQData>): Promise<RFQ>
  getRFQs(filters?: RQFFilters): Promise<RFQ[]>
  
  // Prequalification
  prequalifySubcontractor(data: PrequalData): Promise<Prequalification>
  validateSubcontractor(subId: string): Promise<ValidationResult>
}
```

### Integration Types Supported

1. **API Integration**: REST API with OAuth/API key authentication
2. **Email Integration**: Parse RFQ emails with attachments
3. **Portal Scraping**: Browser automation for portal logins
4. **Manual Entry**: CSV/Excel upload for offline data

### Sync Logic

```javascript
async syncSource(sourceId: string, options?: SyncOptions) {
  const source = await this.getSource(sourceId);
  const startTime = Date.now();
  
  try {
    // 1. Fetch data from source
    const rawData = await this.fetchFromSource(source);
    
    // 2. Normalize to standard format
    const normalized = this.normalizeRFQs(rawData, source);
    
    // 3. Upsert to database
    const result = await this.upsertRFQs(normalized);
    
    // 4. Log sync history
    await this.logSyncHistory(sourceId, {
      status: 'success',
      duration: Date.now() - startTime,
      recordsProcessed: result.total,
      recordsAdded: result.added,
      recordsUpdated: result.updated
    });
    
    return result;
  } catch (error) {
    // Log error with retry logic
    await this.handleError(sourceId, error);
    throw error;
  }
}
```

### Error Recovery

- **Retry Policy**: 3 attempts with exponential backoff (1s, 5s, 30s)
- **Circuit Breaker**: Disable source after 5 consecutive failures
- **Dead Letter Queue**: Store failed records for manual review

## Acceptance Criteria

- [ ] Service initialized and health checks passing
- [ ] Source registration working (all 4 integration types)
- [ ] Sync operations complete without data loss
- [ ] Error recovery with retry logic functional
- [ ] Metrics collection for monitoring dashboards
- [ ] Integration with `subcontract_portal_sources` table
- [ ] Integration with `subcontract_rfqs` table
- [ ] Unit tests covering core functionality

## Dependencies

- MEASURE-TENDER-001: Database Schema must be complete
- References: `tender-integration-service.js` for pattern reference
- Node.js service (not React component)

## Files to Create

```
server/src/services/
├── subcontract-integration-service.js   # Main service
├── rfq-normalizer.js                   # Data transformation
├── portal-connectors/                  # Integration adapters
│   ├── api-connector.js
│   ├── email-connector.js
│   ├── portal-connector.js
│   └── manual-connector.js
└── tests/
    └── subcontract-integration.test.js
```

## Reference Architecture

The gov.za `tender-integration-service.js` pattern:

```
┌─────────────────────────────────────────────────────────┐
│ TenderIntegrationService                                  │
│                                                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │ OCDS API   │  │ eTenders    │  │ CSD         │    │
│  │ Connector  │  │ Connector   │  │ Connector   │    │
│  └──────┬─────┘  └──────┬─────┘  └──────┬─────┘    │
│         │               │               │            │
│         └───────────────┴───────────────┘            │
│                         │                             │
│                    ┌────▼────┐                       │
│                    │ Sync    │                       │
│                    │ Engine  │                       │
│                    └────┬────┘                       │
│                         │                             │
│         ┌───────────────┼───────────────┐            │
│         │               │               │            │
│    ┌────▼────┐    ┌────▼────┐    ┌────▼────┐       │
│    │ History │    │ Errors  │    │ Metrics │       │
│    │ Logger │    │ Handler │    │ Collector│       │
│    └─────────┘    └─────────┘    └─────────┘       │
└─────────────────────────────────────────────────────────┘
```

Apply the **same architecture** to `subcontract-integration-service.js` with the 4 new connector types.

---

**Issue Type**: Backend Service
**Estimated Hours**: 16-20 hours
**Agent Assignment**: devcore-devforge (DevForge AI)

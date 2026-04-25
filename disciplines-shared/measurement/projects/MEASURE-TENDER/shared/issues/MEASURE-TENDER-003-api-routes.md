---
title: "MEASURE-TENDER-003: API Routes & Authentication"
description: "Create RESTful API routes for subcontractor RFQ management following the proven /api/tender-integration pattern"
gigabrain_tags: issue, measurement, tender, api-routes, restful, authentication, express
labels: ["measurement", "tender", "backend", "api"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001", "MEASURE-TENDER-002"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/issues
last_updated: 2026-04-25
status: backlog
priority: High
story_points: 13
due_date: "2026-05-10"
assigned_to: api-devforge
company: devforge-ai
team: engineering
---

# MEASURE-TENDER-003: API Routes & Authentication

## Overview

Create the RESTful API routes for the Subcontract Tender Integration System following the proven pattern from `/api/tender-integration/*`. These routes will enable frontend clients and agents to manage subcontractor portal sources, RFQs, and quotations.

## Requirements

### API Route Structure

```
/api/subcontract-rfq/
├── health                          GET    - System health status
├── sources                         GET    - List all portal sources
├── sources                         POST   - Register new source
├── sources/:sourceId               GET    - Get source details
├── sources/:sourceId               PUT    - Update source config
├── sources/:sourceId               DELETE - Remove source
├── sources/:sourceId/test           POST   - Test connection
├── sources/:sourceId/sync           POST   - Trigger manual sync
├── bulk/sync                       POST   - Sync multiple sources
├── rfqs                            GET    - List RFQs (with filters)
├── rfqs                            POST   - Create new RFQ
├── rfqs/:rfqId                     GET    - Get RFQ details
├── rfqs/:rfqId                     PUT    - Update RFQ
├── rfqs/:rfqId                     DELETE - Cancel RFQ
├── rfqs/:rfqId/publish             POST   - Publish to sub-vendors
├── rfqs/:rfqId/close               POST   - Close bidding
├── subcontractors                   GET    - List prequalified subs
├── subcontractors                   POST   - Add subcontractor
├── subcontractors/:subId           PUT    - Update prequal status
├── quotations/:rfqId                GET    - Get comparison matrix
├── quotations/:rfqId                POST   - Submit quotation
├── quotations/:rfqId/:quoteId      PUT    - Update quotation
├── quotations/:rfqId/:quoteId/recommend POST - Mark for award
├── sync-history                    GET    - Get sync history
├── sync-history/:sourceId           GET    - Get source sync history
├── errors                          GET    - Get error logs
└── errors/:errorId/resolve          POST   - Mark error resolved
```

### Request/Response Examples

#### Health Check
```http
GET /api/subcontract-rfq/health
```
```json
{
  "success": true,
  "health": {
    "service": "healthy",
    "database": "healthy",
    "sources_active": 3,
    "sources_total": 5,
    "last_sync": "2026-04-25T08:30:00Z"
  }
}
```

#### Create RFQ
```http
POST /api/subcontract-rfq/rfqs
Content-Type: application/json

{
  "title": "Electrical Installation - Phase 1",
  "description": "Complete electrical installation for building A",
  "trade_category": "electrical",
  "scope_of_works": "Full electrical installation including...",
  "cidb_grading_required": "3GB",
  "estimated_value": 2500000,
  "closing_date": "2026-05-15T12:00:00Z",
  "boq_reference_id": "uuid-here"
}
```

#### Get Quotations Comparison
```http
GET /api/subcontract-rfq/quotations/{rfqId}
```
```json
{
  "success": true,
  "rfq": {
    "id": "uuid",
    "rfq_number": "RFQ-2026-001",
    "title": "Electrical Installation - Phase 1",
    "status": "closed"
  },
  "quotations": [
    {
      "id": "uuid",
      "subcontractor": {
        "name": "ABC Electrical",
        "cidb_grade": "3GB",
        "bbbee_level": "1"
      },
      "quoted_amount": 2350000,
      "technical_score": 85.5,
      "commercial_score": 92.0,
      "overall_score": 89.2,
      "compliance_status": "compliant",
      "recommended_for_award": true
    }
  ]
}
```

### Authentication & Authorization

1. **Bearer Token**: All routes require valid `Authorization: Bearer <token>`
2. **Organization Scope**: All queries filtered by `organization_id` from token
3. **Role-Based Access**:
   - `procurement_officer`: Full CRUD on RFQs and quotations
   - `procurement_manager`: All + approve awards
   - `admin`: Full access including source management

### Error Handling

Standard error response format:
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Closing date must be in the future",
    "field": "closing_date",
    "details": {}
  }
}
```

### Rate Limiting

- **General**: 100 requests/minute per organization
- **Sync Operations**: 10 requests/minute per source
- **Bulk Operations**: 5 requests/minute

## Acceptance Criteria

- [ ] All 20+ API endpoints implemented
- [ ] Bearer token authentication enforced
- [ ] Organization scoping applied to all queries
- [ ] Role-based access control implemented
- [ ] Rate limiting configured
- [ ] Error responses standardized
- [ ] Request validation with Joi/Zod schemas
- [ ] API documentation (OpenAPI/Swagger)
- [ ] Unit tests for route handlers

## Dependencies

- MEASURE-TENDER-002: Integration Service must be complete
- Express.js server infrastructure
- Authentication middleware

## Files to Create

```
server/src/routes/
├── subcontract-rfq-routes.js          # Main route file
├── middleware/
│   ├── auth.js                        # Token verification
│   ├── rbac.js                        # Role checking
│   └── rate-limit.js                  # Rate limiting
├── validators/
│   ├── source-validators.js
│   ├── rfq-validators.js
│   └── quotation-validators.js
└── tests/
    └── subcontract-rfq.test.js
```

## Route Handler Pattern

```javascript
// Example route handler pattern
router.post('/rfqs', 
  authenticateToken,
  validateRFQInput,
  async (req, res) => {
    try {
      const rfq = await subcontractService.createRFQ({
        ...req.body,
        organization_id: req.user.organization_id
      });
      
      res.status(201).json({
        success: true,
        data: rfq
      });
    } catch (error) {
      res.status(error.status || 500).json({
        success: false,
        error: {
          code: error.code || 'INTERNAL_ERROR',
          message: error.message
        }
      });
    }
  }
);
```

---

**Issue Type**: Backend API
**Estimated Hours**: 12-16 hours
**Agent Assignment**: api-devforge (DevForge AI)

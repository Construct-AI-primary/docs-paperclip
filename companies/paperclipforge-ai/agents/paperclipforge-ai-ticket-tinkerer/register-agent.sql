-- PaperclipForge AI Agent Registration
-- Ticket Tinkerer (Issue Generator Role)
-- Registration timestamp: 2026-04-22

-- Insert agent record
INSERT INTO agents (id, name, role, description, model, status, config, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Ticket Tinkerer',
  'issue_generator',
  'Automated issue generation, categorization, and routing for PaperclipForge AI. Transforms system events, agent outputs, error conditions, and quality gate failures into trackable tickets. Manages ticket lifecycle from creation through resolution.',
  'anthropic/claude-sonnet-4',
  'active',
  '{
    "severity_scale": {
      "SEV1": 1,
      "SEV2": 2,
      "SEV3": 3,
      "SEV4": 4,
      "SEV5": 5
    },
    "severity_labels": {
      "1": "Critical",
      "2": "High",
      "3": "Medium",
      "4": "Low",
      "5": "Minimal"
    },
    "sla_thresholds": {
      "SEV1": 3600,
      "SEV2": 14400,
      "SEV3": 86400,
      "SEV4": 259200,
      "SEV5": 604800
    },
    "stale_thresholds": {
      "reminder_hours": 48,
      "escalation_hours": 168,
      "auto_close_hours": 336
    },
    "correlation_threshold": 0.8,
    "systemic_issue_ticket_count": 5,
    "systemic_issue_window_hours": 24,
    "max_open_tickets": 1000,
    "routing_timeout_seconds": 5,
    "fingerprint_batch_size": 100,
    "skill_score_weight": 0.40,
    "load_score_weight": 0.30,
    "resolution_rate_weight": 0.20,
    "availability_score_weight": 0.10,
    "tool_permissions": [
      "query_events",
      "query_tickets",
      "create_ticket",
      "update_ticket",
      "link_tickets",
      "get_ticket_history",
      "resolve_ticket",
      "close_ticket",
      "reopen_ticket",
      "query_quality_gates",
      "broadcast_alert"
    ]
  }'::jsonb,
  NOW(),
  NOW()
);

-- Insert capability records for Ticket Tinkerer
INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
  gen_random_uuid(),
  a.id,
  cap.capability_name,
  cap.capability_type,
  cap.description,
  cap.config::jsonb
FROM agents a
CROSS JOIN (
  VALUES
    ('event_monitoring', 'skill', 'Monitor and receive system events, agent outputs, and error streams for ticket generation', '{"version": "1.0"}'),
    ('ticket_creation', 'skill', 'Generate well-formed tickets from raw events with complete metadata and proper categorization', '{"version": "1.0"}'),
    ('ticket_categorization', 'skill', 'Classify tickets by type including bug, feature, improvement, incident, spike, and tech debt', '{"version": "1.0"}'),
    ('severity_assessment', 'skill', 'Assess and assign severity levels (SEV1-SEV5) based on impact and urgency dimensions', '{"version": "1.0"}'),
    ('priority_assignment', 'skill', 'Assign priority levels balanced across severity, deadline pressure, and business impact', '{"version": "1.0"}'),
    ('intelligent_routing', 'skill', 'Route tickets to appropriate resolvers based on category, required skills, and current workload', '{"version": "1.0"}'),
    ('lifecycle_management', 'skill', 'Track tickets through all lifecycle states from open to resolved and closed', '{"version": "1.0"}'),
    ('correlation_analysis', 'skill', 'Identify related tickets, duplicates, and systemic patterns via fingerprint matching', '{"version": "1.0"}'),
    ('quality_gate_tracking', 'skill', 'Monitor quality gates and generate blocking tickets on failure with full gate metadata', '{"version": "1.0"}'),
    ('trend_reporting', 'skill', 'Generate reports on ticket trends, MTTR metrics, and systemic issue analysis', '{"version": "1.0"}'),
    ('query_events', 'tool', 'Retrieve system events and error streams for ticket generation and correlation', '{"version": "1.0"}'),
    ('query_tickets', 'tool', 'Fetch existing tickets for correlation analysis, status tracking, and routing decisions', '{"version": "1.0"}'),
    ('create_ticket', 'tool', 'Create new tickets with full metadata, categorization, severity, and routing assignment', '{"version": "1.0"}'),
    ('update_ticket', 'tool', 'Modify ticket fields including status, priority, assignee, category, and metadata', '{"version": "1.0"}'),
    ('link_tickets', 'tool', 'Create and manage relationships between related tickets for correlation tracking', '{"version": "1.0"}'),
    ('get_ticket_history', 'tool', 'Retrieve full history and audit trail for a ticket including all state changes', '{"version": "1.0"}'),
    ('resolve_ticket', 'tool', 'Mark ticket as resolved with resolution metadata, root cause, and solution details', '{"version": "1.0"}'),
    ('close_ticket', 'tool', 'Close ticket after verification or user confirmation with closure metadata', '{"version": "1.0"}'),
    ('reopen_ticket', 'tool', 'Reopen ticket if issue recurs or resolution was incomplete, resetting lifecycle', '{"version": "1.0"}'),
    ('query_quality_gates', 'tool', 'Check current quality gate status, thresholds, and recent failure history', '{"version": "1.0"}'),
    ('broadcast_alert', 'tool', 'Send alerts to relevant agents or channels about ticket events and escalations', '{"version": "1.0"}')
) AS cap(capability_name, capability_type, description, config)
WHERE a.name = 'Ticket Tinkerer'
  AND a.role = 'issue_generator';

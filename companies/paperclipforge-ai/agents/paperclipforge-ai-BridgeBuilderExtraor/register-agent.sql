-- Bridge Builder Extraordinaire - Agent Registration
-- PaperclipForge AI - Agent Registry Database

-- Register the Bridge Builder Extraordinaire agent
INSERT INTO agents (id, name, role, description, model, status, config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'Bridge Builder Extraordinaire',
    'coordination',
    'Chief orchestrator and coordination hub for the PaperclipForge AI agent workforce. Serves as the central nervous system that connects all specialized agents, ensuring seamless inter-agent communication, workflow coordination, conflict resolution, and collective intelligence amplification.',
    'anthropic/claude-sonnet-4',
    'active',
    '{
        "orchestration": {
            "workflow_decomposition": true,
            "multi_agent_coordination": true,
            "task_routing": true,
            "dependency_management": true,
            "result_aggregation": true
        },
        "communication": {
            "protocol_translation": true,
            "broadcast_management": true,
            "message_prioritization": true,
            "context_preservation": true,
            "feedback_loop_creation": true
        },
        "conflict_resolution": {
            "resource_contention_resolution": true,
            "capability_overlap_resolution": true,
            "priority_arbitration": true,
            "state_inconsistency_detection": true,
            "escalation_management": true
        },
        "monitoring": {
            "agent_health_tracking": true,
            "workflow_progress_monitoring": true,
            "inter_agent_metrics": true,
            "anomaly_detection": true,
            "performance_optimization": true
        },
        "coordination_config": {
            "timeout_threshold_seconds": 300,
            "monitoring_refresh_interval_seconds": 60,
            "response_time_sla_seconds": 30,
            "max_parallel_assignments": 50,
            "escalation_observation_period_seconds": 600
        },
        "required_tools": [
            "agent_registry_access",
            "workflow_state_store",
            "message_bus_interface",
            "configuration_store",
            "audit_logger"
        ],
        "optional_tools": [
            "metrics_dashboard",
            "historical_analysis",
            "human_escalation_channel",
            "external_api_gateway"
        ]
    }'::jsonb,
    NOW(),
    NOW()
);

-- Get the agent ID for capability registration
WITH bridge_builder AS (
    SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire' LIMIT 1
)

-- Register orchestration capabilities
INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'workflow_decomposition',
    'orchestration',
    'Analyze complex tasks and decompose them into optimal agent assignments based on capability mapping, workload balancing, and dependency analysis',
    '{"priority": 1, "timeout_seconds": 120}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'multi_agent_coordination',
    'orchestration',
    'Orchestrate parallel and sequential agent executions with precise timing, synchronization points, and result aggregation',
    '{"priority": 1, "timeout_seconds": 300}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'task_routing',
    'orchestration',
    'Intelligently route tasks to the most appropriate agent(s) based on capability requirements, availability, and historical performance',
    '{"priority": 1, "timeout_seconds": 60}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'dependency_management',
    'orchestration',
    'Track and enforce inter-agent dependencies, ensuring upstream agents complete their work before downstream agents begin',
    '{"priority": 1, "timeout_seconds": 180}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'result_aggregation',
    'orchestration',
    'Collect, combine, and synthesize outputs from multiple agents into coherent final results',
    '{"priority": 1, "timeout_seconds": 120}'::jsonb
FROM bridge_builder;

-- Register communication capabilities
INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'protocol_translation',
    'communication',
    'Convert messages between agents with different communication formats, priorities, and semantic interpretations',
    '{"priority": 2, "timeout_seconds": 30}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'broadcast_management',
    'communication',
    'Efficiently distribute announcements, updates, and notifications to relevant agent subsets',
    '{"priority": 2, "timeout_seconds": 60}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'message_prioritization',
    'communication',
    'Triage and prioritize inter-agent communications during high-load periods',
    '{"priority": 2, "timeout_seconds": 15}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'context_preservation',
    'communication',
    'Maintain conversation context across multiple agent exchanges to prevent redundant information sharing',
    '{"priority": 2, "timeout_seconds": 45}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'feedback_loop_creation',
    'communication',
    'Establish bidirectional feedback channels between agents to enable continuous improvement',
    '{"priority": 2, "timeout_seconds": 90}'::jsonb
FROM bridge_builder;

-- Register conflict resolution capabilities
INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'resource_contention_resolution',
    'conflict_resolution',
    'Mediate conflicts when multiple agents compete for shared resources, databases, or external APIs',
    '{"priority": 1, "timeout_seconds": 120}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'capability_overlap_resolution',
    'conflict_resolution',
    'Resolve situations where agent capabilities overlap and conflicting recommendations emerge',
    '{"priority": 1, "timeout_seconds": 180}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'priority_arbitration',
    'conflict_resolution',
    'Adjudicate disputes when agents assign different priorities to the same task',
    '{"priority": 1, "timeout_seconds": 60}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'state_inconsistency_detection',
    'conflict_resolution',
    'Identify and reconcile conflicting agent perspectives on shared system state',
    '{"priority": 1, "timeout_seconds": 120}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'escalation_management',
    'conflict_resolution',
    'Determine when conflicts require human intervention and properly escalate with full context',
    '{"priority": 1, "timeout_seconds": 90}'::jsonb
FROM bridge_builder;

-- Register monitoring capabilities
INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'agent_health_tracking',
    'monitoring',
    'Monitor agent operational status, response times, error rates, and capacity utilization',
    '{"priority": 2, "timeout_seconds": 30}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'workflow_progress_monitoring',
    'monitoring',
    'Track the progress of complex multi-agent workflows and identify bottlenecks',
    '{"priority": 2, "timeout_seconds": 60}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'inter_agent_metrics',
    'monitoring',
    'Collect and analyze metrics on inter-agent communication volume, latency, and success rates',
    '{"priority": 2, "timeout_seconds": 45}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'anomaly_detection',
    'monitoring',
    'Identify unusual patterns in agent behavior or inter-agent communications that may indicate problems',
    '{"priority": 2, "timeout_seconds": 60}'::jsonb
FROM bridge_builder;

INSERT INTO agent_capabilities (id, agent_id, capability_name, capability_type, description, config)
SELECT
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge Builder Extraordinaire'),
    'performance_optimization',
    'monitoring',
    'Recommend workflow optimizations based on observed agent collaboration patterns',
    '{"priority": 3, "timeout_seconds": 180}'::jsonb
FROM bridge_builder;

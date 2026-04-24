-- PaperclipForge AI Agent Registration
-- Task Tango Dancer (Task Allocation Role)
-- Registration timestamp: 2026-04-22

-- Insert agent record
INSERT INTO agents (id, name, role, description, model, status, config, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Task Tango Dancer',
  'task_allocation',
  'Intelligent task distribution, workload balancing, priority assignment, and deadline management across the agent workforce. Orchestrates task flows with precision to maximize team efficiency.',
  'anthropic/claude-sonnet-4',
  'active',
  '{
    "balance_threshold": 0.85,
    "idle_threshold": 0.40,
    "critical_deadline_hours": 1,
    "warning_deadline_hours": 4,
    "max_reassignments": 3,
    "queue_scan_interval_seconds": 30,
    "priority_scale_min": 1,
    "priority_scale_max": 100,
    "utilization_score_weight": 0.30,
    "capability_score_weight": 0.40,
    "affinity_score_weight": 0.20,
    "deadline_fit_weight": 0.10,
    "tool_permissions": [
      "query_agents",
      "query_tasks",
      "update_task_assignment",
      "update_task_status",
      "update_task_priority",
      "get_workload_metrics",
      "set_deadline",
      "broadcast_allocation"
    ]
  }'::jsonb,
  NOW(),
  NOW()
);

-- Insert capability records for Task Tango Dancer
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
    ('task_discovery', 'skill', 'Scan for new tasks across all registered queues and task sources', '{"version": "1.0"}'),
    ('workload_analysis', 'skill', 'Analyze current agent workloads, capacities, and utilization rates', '{"version": "1.0"}'),
    ('priority_assignment', 'skill', 'Assign or recalculate priority levels based on urgency, importance, and deadlines', '{"version": "1.0"}'),
    ('deadline_management', 'skill', 'Track, monitor, and enforce task deadlines; escalate approaching misses', '{"version": "1.0"}'),
    ('load_balancing', 'skill', 'Distribute work evenly across agents to prevent hot spots and idle capacity', '{"version": "1.0"}'),
    ('capability_matching', 'skill', 'Match task requirements to agent capability profiles', '{"version": "1.0"}'),
    ('task_routing', 'skill', 'Route tasks to optimal agents based on multi-factor analysis', '{"version": "1.0"}'),
    ('dependency_tracking', 'skill', 'Track task dependencies and enforce proper execution ordering', '{"version": "1.0"}'),
    ('workload_forecasting', 'skill', 'Predict future workload spikes and plan redistributions', '{"version": "1.0"}'),
    ('agent_registry_query', 'skill', 'Query the agent registry for capability and status information', '{"version": "1.0"}'),
    ('query_agents', 'tool', 'Retrieve agent registry data including capabilities, status, and current workload', '{"version": "1.0"}'),
    ('query_tasks', 'tool', 'Fetch pending tasks and their requirements from the task queue', '{"version": "1.0"}'),
    ('update_task_assignment', 'tool', 'Assign or reassign tasks to specific agents in the task table', '{"version": "1.0"}'),
    ('update_task_status', 'tool', 'Modify task status including pending, in-progress, blocked, and complete', '{"version": "1.0"}'),
    ('update_task_priority', 'tool', 'Adjust task priority levels in the priority queue', '{"version": "1.0"}'),
    ('get_workload_metrics', 'tool', 'Pull real-time workload metrics for all registered agents', '{"version": "1.0"}'),
    ('set_deadline', 'tool', 'Assign or modify deadlines for tasks', '{"version": "1.0"}'),
    ('broadcast_allocation', 'tool', 'Notify agents of their task assignments via broadcast channel', '{"version": "1.0"}')
) AS cap(capability_name, capability_type, description, config)
WHERE a.name = 'Task Tango Dancer'
  AND a.role = 'task_allocation';

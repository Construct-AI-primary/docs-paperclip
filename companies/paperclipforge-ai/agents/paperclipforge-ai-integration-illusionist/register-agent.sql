-- Integration Illusionist Agent Registration
-- PaperclipForge AI - Drizzle-compatible PostgreSQL Schema

-- Insert into agents table
INSERT INTO agents (
    id,
    name,
    role,
    description,
    model,
    status,
    config,
    created_at,
    updated_at
) VALUES (
    gen_random_uuid(),
    'integration-illusionist',
    'integration_architect',
    'Integration architect responsible for designing and managing system integrations, API gateway configurations, webhook orchestration, and data flow architecture between internal and external services.',
    'anthropic/claude-sonnet-4',
    'active',
    '{
        "capabilities": [
            "api_gateway_design",
            "webhook_orchestration",
            "data_flow_architecture",
            "service_integration_patterns",
            "external_service_connectivity",
            "integration_monitoring",
            "security_compliance"
        ],
        "adapter_type": "hermes",
        "runtime_config": {
            "temperature": 0.7,
            "max_tokens": 4096
        }
    }'::jsonb,
    NOW(),
    NOW()
);

-- Insert capabilities into agent_capabilities table
-- Note: Replace AGENT_ID with the actual agent_id from the agents table insert above
-- This is typically done by getting the ID from a subquery or via application code

-- Capability: API Gateway Design
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
) VALUES (
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'integration-illusionist' LIMIT 1),
    'api_gateway_design',
    'integration',
    'Design and configure API gateway architectures with rate limiting, authentication, authorization, performance optimization, and version management.',
    '{
        "features": [
            "rate_limiting",
            "authentication",
            "authorization",
            "performance_optimization",
            "version_management"
        ],
        "supported_protocols": [
            "REST",
            "GraphQL",
            "gRPC"
        ]
    }'::jsonb,
    NOW(),
    NOW()
);

-- Capability: Webhook Orchestration
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
) VALUES (
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'integration-illusionist' LIMIT 1),
    'webhook_orchestration',
    'integration',
    'Architect webhook delivery systems with retry logic, event schemas, signature verification, security, and delivery health monitoring.',
    '{
        "features": [
            "retry_logic",
            "event_schemas",
            "signature_verification",
            "security",
            "delivery_monitoring"
        ],
        "delivery_settings": {
            "timeout_seconds": 30,
            "max_retries": 5,
            "retry_backoff": "exponential"
        }
    }'::jsonb,
    NOW(),
    NOW()
);

-- Capability: Data Flow Architecture
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
) VALUES (
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'integration-illusionist' LIMIT 1),
    'data_flow_architecture',
    'integration',
    'Design ETL/ELT pipelines for data movement, implement transformations and validations, ensure consistency and idempotency.',
    '{
        "features": [
            "etl_pipelines",
            "data_transformation",
            "validation_rules",
            "idempotency_guarantees"
        ],
        "flow_settings": {
            "latency_sla_seconds": 5,
            "throughput_minimum": 1000
        }
    }'::jsonb,
    NOW(),
    NOW()
);

-- Capability: Service Integration Patterns
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
) VALUES (
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'integration-illusionist' LIMIT 1),
    'service_integration_patterns',
    'integration',
    'Implement synchronous and asynchronous communication patterns, message queues, event streaming, circuit breakers, bulkheads, retry policies, and dead letter handling.',
    '{
        "features": [
            "sync_async_patterns",
            "message_queues",
            "event_streaming",
            "circuit_breakers",
            "bulkheads",
            "retry_policies",
            "dead_letter_handling"
        ],
        "patterns": [
            "pub_sub",
            "event_sourcing",
            "saga",
            "cqrs"
        ]
    }'::jsonb,
    NOW(),
    NOW()
);

-- Capability: External Service Connectivity
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
) VALUES (
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'integration-illusionist' LIMIT 1),
    'external_service_connectivity',
    'integration',
    'Connect to third-party APIs, manage OAuth flows, API keys, credential rotation, and handle external service failures gracefully.',
    '{
        "features": [
            "oauth_flows",
            "api_key_management",
            "credential_rotation",
            "failure_handling",
            "health_monitoring"
        ],
        "security": {
            "tls_version": "1.2+",
            "secret_storage": "secrets_manager"
        }
    }'::jsonb,
    NOW(),
    NOW()
);

-- Capability: Integration Monitoring
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
) VALUES (
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'integration-illusionist' LIMIT 1),
    'integration_monitoring',
    'integration',
    'Design comprehensive logging, implement distributed tracing, create health dashboards, and configure alerting for integration failures.',
    '{
        "features": [
            "comprehensive_logging",
            "distributed_tracing",
            "health_dashboards",
            "alerting"
        ],
        "sla_targets": {
            "uptime": 99.9,
            "detection_time_minutes": 5,
            "recovery_time_minutes": 15
        }
    }'::jsonb,
    NOW(),
    NOW()
);

-- Capability: Security & Compliance
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
) VALUES (
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'integration-illusionist' LIMIT 1),
    'security_compliance',
    'integration',
    'Implement end-to-end encryption, design audit trails, ensure compliance with data protection regulations, and manage secrets securely.',
    '{
        "features": [
            "encryption_in_transit",
            "encryption_at_rest",
            "audit_trails",
            "secrets_management",
            "compliance_reporting"
        ],
        "regulations": [
            "GDPR",
            "SOC2",
            "HIPAA"
        ]
    }'::jsonb,
    NOW(),
    NOW()
);

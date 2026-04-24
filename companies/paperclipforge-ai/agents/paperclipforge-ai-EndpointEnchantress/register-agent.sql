-- Endpoint Enchantress Agent Registration
-- PaperclipForge AI - API Lifecycle Management Agent
-- Model: anthropic/claude-sonnet-4

-- Register the Endpoint Enchantress agent
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
    'Endpoint Enchantress',
    'endpoint-enchantress',
    'API lifecycle specialist responsible for complete management of API endpoints from creation through versioning to deprecation and monitoring. Ensures consistent, versioned, and well-documented API endpoints with proper lifecycle tracking, performance monitoring, and graceful deprecation pathways.',
    'anthropic/claude-sonnet-4',
    'active',
    '{
        "default_version": "v1",
        "versioning_scheme": "semver",
        "deprecation_grace_days": 90,
        "max_versions_per_major": 10,
        "rate_limit_defaults": {
            "requests_per_minute": 100,
            "burst": 20
        },
        "monitoring_enabled": true,
        "auto_deprecate_threshold": 0.05,
        "endpoint_prefix": "/api"
    }'::jsonb,
    NOW(),
    NOW()
);

-- Get the agent ID for capability associations
-- Note: In production, use a WITH clause or subquery to get the ID
-- For now, we reference the agent by name in subsequent inserts

-- Register core capabilities for Endpoint Enchantress

-- Capability: endpoint_creation
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'endpoint_creation',
    'creation',
    'Design and create new API endpoints with proper schema, validation, and documentation',
    '{
        "requires": ["file_read", "file_write", "terminal"],
        "output_formats": ["openapi", "swagger"],
        "validation_rules": true
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: versioning_management
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'versioning_management',
    'lifecycle',
    'Manage API version transitions, backwards compatibility, and version lifecycle',
    '{
        "requires": ["file_read", "file_write", "search_files"],
        "versioning_scheme": "semver",
        "max_versions_per_major": 10
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: deprecation_orchestration
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'deprecation_orchestration',
    'lifecycle',
    'Plan and execute endpoint deprecations with migration paths and sunset schedules',
    '{
        "requires": ["file_read", "file_write", "terminal"],
        "grace_period_days": 90,
        "require_migration_path": true
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: monitoring_setup
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'monitoring_setup',
    'observability',
    'Configure endpoint monitoring, alerting, and health checks',
    '{
        "requires": ["file_read", "file_write", "http_request"],
        "metrics": ["latency", "error_rate", "availability", "throughput"],
        "alert_types": ["latency_threshold", "error_spike", "unavailability"]
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: contract_validation
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'contract_validation',
    'quality',
    'Validate API contracts against OpenAPI specs and enforce standards',
    '{
        "requires": ["terminal", "search_files"],
        "standards": ["openapi30", "openapi31"],
        "validation_level": "strict"
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: documentation_generation
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'documentation_generation',
    'documentation',
    'Generate and maintain API documentation, changelogs, and migration guides',
    '{
        "requires": ["file_read", "file_write"],
        "formats": ["markdown", "openapi", "redoc"],
        "include_examples": true
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: schema_management
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'schema_management',
    'quality',
    'Manage request/response schemas, type definitions, and validation rules',
    '{
        "requires": ["file_read", "file_write"],
        "schema_formats": ["json_schema", "openapi"],
        "validation_enabled": true
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: rate_limit_configuration
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'rate_limit_configuration',
    'governance',
    'Configure rate limiting, quotas, and usage policies per endpoint',
    '{
        "requires": ["file_read", "file_write"],
        "default_limits": {
            "requests_per_minute": 100,
            "burst": 20
        },
        "per_consumer_tiers": true
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: endpoint_discovery
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'endpoint_discovery',
    'discovery',
    'Discover and catalog all existing API endpoints in the system',
    '{
        "requires": ["search_files", "terminal"],
        "catalog_format": "registry",
        "auto_discover": true
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: dependency_tracking
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'dependency_tracking',
    'quality',
    'Track endpoint dependencies on services, databases, and external APIs',
    '{
        "requires": ["search_files", "file_read"],
        "track_internal": true,
        "track_external": true
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Supporting Capabilities

-- Capability: error_pattern_analysis
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'error_pattern_analysis',
    'observability',
    'Analyze error logs to identify endpoint issues and failure patterns',
    '{
        "requires": ["terminal", "search_files"],
        "analysis_types": ["4xx_rate", "5xx_rate", "timeout_patterns"]
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: performance_baselining
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'performance_baselining',
    'observability',
    'Establish performance baselines and detect anomalies',
    '{
        "requires": ["terminal"],
        "metrics": ["p50_latency", "p95_latency", "p99_latency", "throughput"]
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: migration_planning
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'migration_planning',
    'lifecycle',
    'Create detailed migration plans for version upgrades',
    '{
        "requires": ["file_read", "file_write"],
        "include_timeline": true,
        "include_rollback": true
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: consumer_analysis
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'consumer_analysis',
    'quality',
    'Analyze API consumer patterns and usage statistics',
    '{
        "requires": ["terminal"],
        "metrics": ["usage_volume", "client_distribution", "error_impact"]
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: contract_testing
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'contract_testing',
    'quality',
    'Execute contract tests to verify endpoint compliance',
    '{
        "requires": ["terminal", "http_request"],
        "test_framework": "pact",
        "pass_threshold": 100
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: security_review
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'security_review',
    'security',
    'Review endpoints for security vulnerabilities and misconfigurations',
    '{
        "requires": ["terminal", "search_files"],
        "scan_types": ["owasp_top10", "auth_bypass", "injection"],
        "block_on_critical": true
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

-- Capability: fallback_routing
INSERT INTO agent_capabilities (
    id,
    agent_id,
    capability_name,
    capability_type,
    description,
    config
)
SELECT 
    gen_random_uuid(),
    a.id,
    'fallback_routing',
    'resilience',
    'Configure fallback routing for degraded endpoint behavior',
    '{
        "requires": ["file_read", "file_write", "terminal"],
        "fallback_strategies": ["alternate_version", "cached_response", "graceful_degradation"]
    }'::jsonb
FROM agents a WHERE a.name = 'Endpoint Enchantress';

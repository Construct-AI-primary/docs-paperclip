# Atlas Agent Creator Script

A Node.js script for automated creation and management of Paperclip agents in Supabase, similar to JSX for database records.

## Overview

This script provides a programmatic interface for creating, updating, and managing Paperclip agents in the Supabase database. It handles all the complex relationships between agents, API keys, model assignments, and activity logging automatically.

## Features

- ✅ **Complete Agent Creation**: Creates agents with all related records (API keys, models, permissions)
- ✅ **Schema Validation**: Validates data against database schema requirements
- ✅ **Error Handling**: Comprehensive error handling with detailed feedback
- ✅ **CLI Interface**: Easy-to-use command-line interface
- ✅ **Template Support**: Load agent templates from JSON files
- ✅ **Activity Logging**: Automatic activity log creation for audit trails

## Installation

1. **Install Dependencies**:
```bash
npm install
# or
pnpm install
```

2. **Set Environment Variables**:
```bash
export SUPABASE_URL="your-supabase-project-url"
export SUPABASE_SERVICE_ROLE_KEY="your-service-role-key"
```

## Usage

### Create a New Agent

```bash
node agent-creator-script.js create-agent \
  --name "github-ops-specialist" \
  --company "PaperclipForge AI" \
  --title "GitHub Operations Specialist" \
  --capabilities "GitHub repository management, commit standards, pull request lifecycle" \
  --skills "github-commit-management,github-branch-management,github-pr-lifecycle" \
  --model "anthropic/claude-sonnet-4.5" \
  --reports-to "paperclipforge-ai-operations-director" \
  --budget 50000
```

### Update an Existing Agent

```bash
node agent-creator-script.js update-agent \
  --id "123e4567-e89b-12d3-a456-426614174000" \
  --status "idle" \
  --capabilities "Updated capabilities description"
```

### List Agents

```bash
# List all agents
node agent-creator-script.js list-agents

# List agents for specific company
node agent-creator-script.js list-agents --company "PaperclipForge AI"
```

### Using NPM Scripts

```bash
# Create agent
npm run create-agent -- --name "test-agent" --company "PaperclipForge AI" --title "Test Agent" --capabilities "Testing"

# List agents
npm run list-agents -- --company "PaperclipForge AI"

# Show help
npm run help
```

## Command Reference

### create-agent

Create a new agent with all related records.

**Required Options:**
- `--name <name>`: Agent name/slug
- `--company <company>`: Company name
- `--title <title>`: Agent display title
- `--capabilities <text>`: Agent capabilities description

**Optional Options:**
- `--role <role>`: Agent role (default: "specialist")
- `--status <status>`: Agent status (default: "active")
- `--skills <skill1,skill2>`: Comma-separated skill list
- `--model <model>`: AI model identifier (default: "anthropic/claude-sonnet-4.5")
- `--reports-to <agent>`: Manager agent name
- `--budget <cents>`: Monthly budget in cents (default: 50000)

### update-agent

Update an existing agent's properties.

**Required Options:**
- `--id <uuid>`: Agent ID to update

**Optional Options:**
- `--status <status>`: New status
- `--capabilities <text>`: New capabilities
- `--budget <cents>`: New budget

### list-agents

List agents with filtering options.

**Optional Options:**
- `--company <company>`: Filter by company name

## Examples

### Create GitHub Operations Specialist

```bash
node agent-creator-script.js create-agent \
  --name "paperclipforge-ai-github-operations-specialist" \
  --company "PaperclipForge AI" \
  --title "GitHub Operations Specialist" \
  --capabilities "GitHub repository management, commit standards, pull request lifecycle, branch protection, CI/CD integration" \
  --skills "github-commit-management,github-branch-management,github-pr-lifecycle,github-repository-maintenance,github-api-integration,github-ci-cd-monitoring" \
  --model "anthropic/claude-sonnet-4.5" \
  --reports-to "paperclipforge-ai-operations-director" \
  --budget 50000
```

### Create Engineering Specialist

```bash
node agent-creator-script.js create-agent \
  --name "engineering-analysis-specialist" \
  --company "PaperclipForge AI" \
  --title "Advanced Engineering Analysis Specialist" \
  --capabilities "Structural, thermal, fluid dynamics, and modal analysis across civil, electrical, mechanical, and structural engineering disciplines" \
  --skills "engineering-analysis,fea-analysis,cfd-analysis,modal-analysis" \
  --model "anthropic/claude-opus-4.6" \
  --reports-to "paperclipforge-ai-operations-director"
```

### Update Agent Status

```bash
node agent-creator-script.js update-agent \
  --id "550e8400-e29b-41d4-a716-446655440001" \
  --status "idle"
```

## What Gets Created

When you create an agent, the script automatically creates:

1. **Agent Record** (`agents` table)
   - Basic agent information, configuration, permissions
   - Adapter settings for Hermes integration
   - Runtime configuration and metadata

2. **API Key** (`agent_api_keys` table)
   - Secure API key with `pcak_` prefix
   - SHA256 hash for authentication
   - Company and agent association

3. **Model Assignment** (`agent_models` table)
   - Primary AI model assignment
   - Temperature, token limits, priority settings
   - Assignment metadata and reasoning

4. **Activity Log** (`activity_log` table)
   - Audit trail of agent creation
   - Creation details and metadata
   - System attribution

## Template System

The script supports loading agent templates from JSON files in the `templates/` directory:

```json
{
  "name": "github-specialist-template",
  "title": "GitHub Operations Specialist",
  "capabilities": "GitHub repository management and operations",
  "skills": ["github-commit-management", "github-pr-lifecycle"],
  "model": "anthropic/claude-sonnet-4.5",
  "budget": 50000
}
```

Use templates by referencing them in the create command (future enhancement).

## Error Handling

The script provides detailed error messages and validation:

- **Company Not Found**: When specified company doesn't exist
- **Manager Not Found**: When reports-to agent doesn't exist
- **Schema Validation**: When required fields are missing
- **Database Errors**: Detailed Supabase error messages

## Security Features

- **Secure API Key Generation**: Cryptographically secure random keys
- **Hash Storage**: Only SHA256 hashes stored in database
- **Company Isolation**: Agents can only access their company's data
- **Permission Scoping**: Granular permission controls based on skills

## Integration Points

The script integrates with all Paperclip ecosystem components:

- **Hermes Agent Runtime**: Automatic adapter configuration
- **Company Structure**: Validates against existing companies
- **Skill System**: Maps skills to agent capabilities
- **Model Registry**: Validates AI model availability
- **Activity Logging**: Comprehensive audit trails

## Troubleshooting

### Common Issues

1. **"Company not found"**
   - Verify company name matches exactly
   - Check if company exists in database

2. **"Manager not found"**
   - Verify reports-to agent name
   - Ensure manager agent exists and is active

3. **"Supabase connection failed"**
   - Check environment variables
   - Verify Supabase credentials
   - Ensure network connectivity

4. **"Schema validation failed"**
   - Check required fields are provided
   - Verify data types and formats

### Debug Mode

Set `DEBUG=true` environment variable for detailed logging:

```bash
DEBUG=true node agent-creator-script.js create-agent --name "test" --company "Test Company" --title "Test" --capabilities "Testing"
```

## API Usage

The script can also be used programmatically:

```javascript
const { AgentCreator } = require('./agent-creator-script');

const creator = new AgentCreator();

const result = await creator.createAgent({
  name: 'test-agent',
  companyName: 'PaperclipForge AI',
  title: 'Test Agent',
  capabilities: 'Testing agent creation',
  skills: ['test-skill'],
  model: 'anthropic/claude-sonnet-4.5'
});

if (result.success) {
  console.log('Agent created:', result.agent);
  console.log('API Key:', result.apiKey);
} else {
  console.error('Failed:', result.error);
}
```

## Contributing

When adding new features:

1. Update the `AgentCreator` class methods
2. Add corresponding CLI commands
3. Update validation logic
4. Add comprehensive error handling
5. Update this README

## License

MIT License - See package.json for details.
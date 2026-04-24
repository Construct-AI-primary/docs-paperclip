/**
 * Atlas Agent Creator Script
 * Auto-generates and edits Supabase records for Paperclip agents
 *
 * Usage:
 * node agent-creator-script.js create-agent --name "agent-name" --company "company-name" [options]
 * node agent-creator-script.js update-agent --id "agent-id" [options]
 * node agent-creator-script.js list-agents --company "company-name"
 */

const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL || 'your-supabase-url';
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || 'your-service-role-key';

// Initialize Supabase client
const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

/**
 * Agent Creator Class
 * Handles all agent creation and management operations
 */
class AgentCreator {
  constructor() {
    this.templates = this.loadTemplates();
  }

  /**
   * Load agent templates from filesystem
   */
  loadTemplates() {
    const templatesDir = path.join(__dirname, 'templates');
    const templates = {};

    if (fs.existsSync(templatesDir)) {
      const files = fs.readdirSync(templatesDir);
      files.forEach(file => {
        if (file.endsWith('.json')) {
          const templateName = file.replace('.json', '');
          const templatePath = path.join(templatesDir, file);
          try {
            templates[templateName] = JSON.parse(fs.readFileSync(templatePath, 'utf8'));
          } catch (error) {
            console.warn(`Failed to load template ${templateName}:`, error.message);
          }
        }
      });
    }

    return templates;
  }

  /**
   * Generate a secure API key
   */
  generateApiKey() {
    const randomBytes = crypto.randomBytes(32);
    return 'pcak_' + Buffer.from(randomBytes).toString('base64').replace(/[^a-zA-Z0-9]/g, '').substring(0, 32);
  }

  /**
   * Generate a key hash for storage
   */
  generateKeyHash(apiKey) {
    return crypto.createHash('sha256').update(apiKey).digest('hex');
  }

  /**
   * Create a new agent with all related records
   */
  async createAgent(options) {
    const {
      name,
      companyName,
      title,
      role = 'specialist',
      status = 'active',
      capabilities,
      skills = [],
      model = 'anthropic/claude-sonnet-4.5',
      reportsTo,
      budget = 50000
    } = options;

    try {
      console.log(`Creating agent: ${name} for company: ${companyName}`);

      // 1. Get company ID
      const { data: company, error: companyError } = await supabase
        .from('companies')
        .select('id')
        .eq('name', companyName)
        .single();

      if (companyError || !company) {
        throw new Error(`Company "${companyName}" not found: ${companyError?.message}`);
      }

      // 2. Get reports_to agent ID if specified
      let reportsToId = null;
      if (reportsTo) {
        const { data: manager, error: managerError } = await supabase
          .from('agents')
          .select('id')
          .eq('name', reportsTo)
          .single();

        if (managerError || !manager) {
          console.warn(`Manager "${reportsTo}" not found, creating agent without manager`);
        } else {
          reportsToId = manager.id;
        }
      }

      // 3. Create agent record
      const agentData = {
        company_id: company.id,
        name,
        role,
        title,
        status,
        reports_to: reportsToId,
        capabilities,
        adapter_type: 'hermes_local',
        adapter_config: {
          model,
          skills,
          endpoints: { primary: 'hermes_local', fallback: null }
        },
        runtime_config: {
          automation_enabled: true,
          max_concurrent_tasks: 5,
          timeout_seconds: 1800,
          retry_attempts: 3
        },
        permissions: {
          github_api_access: skills.some(s => s.includes('github')),
          repository_management: skills.some(s => s.includes('github')),
          ci_cd_control: skills.some(s => s.includes('ci-cd')),
          webhook_management: skills.some(s => s.includes('webhook'))
        },
        metadata: {
          specialization: this.inferSpecialization(skills),
          team: 'operations',
          skills_count: skills.length,
          integration_points: this.inferIntegrationPoints(skills),
          created_by: 'atlas-agent-creator',
          created_at: new Date().toISOString()
        },
        budget_monthly_cents: budget,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      const { data: agent, error: agentError } = await supabase
        .from('agents')
        .insert(agentData)
        .select()
        .single();

      if (agentError) {
        throw new Error(`Failed to create agent: ${agentError.message}`);
      }

      console.log(`✓ Agent created with ID: ${agent.id}`);

      // 4. Create API key
      const apiKey = this.generateApiKey();
      const keyHash = this.generateKeyHash(apiKey);

      const { data: apiKeyRecord, error: apiKeyError } = await supabase
        .from('agent_api_keys')
        .insert({
          agent_id: agent.id,
          company_id: company.id,
          name: `${name}_primary_key`,
          api_key: apiKey,
          key_hash: keyHash,
          created_at: new Date().toISOString()
        })
        .select()
        .single();

      if (apiKeyError) {
        console.error(`Warning: Failed to create API key: ${apiKeyError.message}`);
      } else {
        console.log(`✓ API key created: ${apiKey.substring(0, 12)}...`);
      }

      // 5. Create model assignment
      const { data: modelAssignment, error: modelError } = await supabase
        .from('agent_models')
        .insert({
          agent_id: name, // Note: uses name, not ID
          model_id: model,
          assignment_type: 'primary',
          priority: 1,
          temperature: 0.7,
          max_tokens: 8192,
          assigned_at: new Date().toISOString(),
          assigned_by: 'atlas-agent-creator',
          reason: `Auto-assigned by Atlas for ${capabilities}`,
          is_active: true
        });

      if (modelError) {
        console.error(`Warning: Failed to create model assignment: ${modelError.message}`);
      } else {
        console.log(`✓ Model assignment created: ${model}`);
      }

      // 6. Create activity log entry
      await supabase
        .from('activity_log')
        .insert({
          company_id: company.id,
          actor_type: 'system',
          actor_id: 'atlas-agent-creator',
          action: 'create',
          entity_type: 'agent',
          entity_id: agent.id,
          agent_id: agent.id,
          details: {
            description: `Created ${role} agent: ${title}`,
            skills,
            capabilities,
            company: companyName,
            reports_to: reportsTo,
            model,
            budget
          },
          created_at: new Date().toISOString()
        });

      console.log(`✓ Activity log created`);
      console.log(`\n🎉 Agent "${name}" created successfully!`);
      console.log(`API Key: ${apiKey}`);
      console.log(`Agent ID: ${agent.id}`);

      return {
        success: true,
        agent,
        apiKey,
        modelAssignment,
        apiKeyRecord
      };

    } catch (error) {
      console.error(`❌ Failed to create agent: ${error.message}`);
      return { success: false, error: error.message };
    }
  }

  /**
   * Update an existing agent
   */
  async updateAgent(agentId, updates) {
    try {
      console.log(`Updating agent: ${agentId}`);

      const { data: agent, error: updateError } = await supabase
        .from('agents')
        .update({
          ...updates,
          updated_at: new Date().toISOString()
        })
        .eq('id', agentId)
        .select()
        .single();

      if (updateError) {
        throw new Error(`Failed to update agent: ${updateError.message}`);
      }

      console.log(`✓ Agent updated successfully`);
      return { success: true, agent };

    } catch (error) {
      console.error(`❌ Failed to update agent: ${error.message}`);
      return { success: false, error: error.message };
    }
  }

  /**
   * List agents for a company
   */
  async listAgents(companyName) {
    try {
      let query = supabase
        .from('agents')
        .select(`
          id,
          name,
          role,
          title,
          status,
          created_at,
          companies!inner(name)
        `)
        .order('created_at', { ascending: false });

      if (companyName) {
        query = query.eq('companies.name', companyName);
      }

      const { data: agents, error } = await query;

      if (error) {
        throw new Error(`Failed to list agents: ${error.message}`);
      }

      console.log(`\n📋 Agents ${companyName ? `for ${companyName}` : 'across all companies'}:`);
      console.table(agents.map(agent => ({
        ID: agent.id.substring(0, 8) + '...',
        Name: agent.name,
        Role: agent.role,
        Title: agent.title,
        Status: agent.status,
        Company: agent.companies?.name || 'Unknown',
        Created: new Date(agent.created_at).toLocaleDateString()
      })));

      return { success: true, agents };

    } catch (error) {
      console.error(`❌ Failed to list agents: ${error.message}`);
      return { success: false, error: error.message };
    }
  }

  /**
   * Infer specialization from skills
   */
  inferSpecialization(skills) {
    if (skills.some(s => s.includes('github'))) return 'github_operations';
    if (skills.some(s => s.includes('engineering'))) return 'engineering';
    if (skills.some(s => s.includes('measurement'))) return 'measurement';
    if (skills.some(s => s.includes('ui'))) return 'ui_design';
    return 'general';
  }

  /**
   * Infer integration points from skills
   */
  inferIntegrationPoints(skills) {
    const points = [];
    if (skills.some(s => s.includes('github'))) points.push('devforge_ai');
    if (skills.some(s => s.includes('engineering'))) points.push('domainforge_ai');
    if (skills.some(s => s.includes('measurement'))) points.push('integrateforge_ai');
    if (skills.some(s => s.includes('quality'))) points.push('qualityforge_ai');
    points.push('paperclipforge_ai');
    return points;
  }

  /**
   * Validate agent data before creation
   */
  validateAgentData(data) {
    const errors = [];

    if (!data.name) errors.push('Agent name is required');
    if (!data.companyName) errors.push('Company name is required');
    if (!data.title) errors.push('Agent title is required');
    if (!data.capabilities) errors.push('Agent capabilities are required');

    if (data.skills && !Array.isArray(data.skills)) {
      errors.push('Skills must be an array');
    }

    return errors;
  }
}

/**
 * CLI Interface
 */
async function main() {
  const args = process.argv.slice(2);
  const command = args[0];

  const creator = new AgentCreator();

  switch (command) {
    case 'create-agent': {
      const options = parseArgs(args.slice(1));
      const validationErrors = creator.validateAgentData(options);

      if (validationErrors.length > 0) {
        console.error('❌ Validation errors:');
        validationErrors.forEach(error => console.error(`  - ${error}`));
        process.exit(1);
      }

      const result = await creator.createAgent(options);
      if (!result.success) {
        process.exit(1);
      }
      break;
    }

    case 'update-agent': {
      const options = parseArgs(args.slice(1));
      if (!options.id) {
        console.error('❌ Agent ID is required for update');
        process.exit(1);
      }

      const updates = {};
      if (options.status) updates.status = options.status;
      if (options.capabilities) updates.capabilities = options.capabilities;
      if (options.budget) updates.budget_monthly_cents = parseInt(options.budget);

      const result = await creator.updateAgent(options.id, updates);
      if (!result.success) {
        process.exit(1);
      }
      break;
    }

    case 'list-agents': {
      const options = parseArgs(args.slice(1));
      const result = await creator.listAgents(options.company);
      if (!result.success) {
        process.exit(1);
      }
      break;
    }

    default:
      console.log(`
Atlas Agent Creator Script

Usage:
  node agent-creator-script.js <command> [options]

Commands:
  create-agent    Create a new agent
  update-agent    Update an existing agent
  list-agents     List agents

Create Agent Options:
  --name <name>              Agent name (required)
  --company <company>        Company name (required)
  --title <title>            Agent title (required)
  --role <role>              Agent role (default: specialist)
  --status <status>          Agent status (default: active)
  --capabilities <text>      Agent capabilities (required)
  --skills <skill1,skill2>   Comma-separated skills
  --model <model>            AI model (default: anthropic/claude-sonnet-4.5)
  --reports-to <agent>       Manager agent name
  --budget <cents>           Monthly budget in cents (default: 50000)

Update Agent Options:
  --id <uuid>                Agent ID (required)
  --status <status>          New status
  --capabilities <text>      New capabilities
  --budget <cents>           New budget

List Agents Options:
  --company <company>        Filter by company name

Examples:
  node agent-creator-script.js create-agent --name "github-ops-specialist" --company "PaperclipForge AI" --title "GitHub Operations Specialist" --capabilities "GitHub repository management" --skills "github-commit-management,github-pr-lifecycle"

  node agent-creator-script.js list-agents --company "PaperclipForge AI"

  node agent-creator-script.js update-agent --id "123e4567-e89b-12d3-a456-426614174000" --status "idle"
      `);
      break;
  }
}

/**
 * Parse command line arguments
 */
function parseArgs(args) {
  const options = {};

  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    if (arg.startsWith('--')) {
      const key = arg.substring(2);
      const value = args[i + 1];

      if (key === 'skills' && value) {
        options[key] = value.split(',').map(s => s.trim());
      } else if (value && !value.startsWith('--')) {
        options[key] = value;
        i++; // Skip next arg as it's the value
      } else {
        options[key] = true; // Flag without value
      }
    }
  }

  return options;
}

// Run if called directly
if (require.main === module) {
  main().catch(error => {
    console.error('❌ Script failed:', error.message);
    process.exit(1);
  });
}

module.exports = { AgentCreator };
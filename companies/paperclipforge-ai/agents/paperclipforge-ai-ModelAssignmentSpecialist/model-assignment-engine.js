#!/usr/bin/env node

/**
 * Model Assignment Engine
 * Intelligent AI model assignment and optimization for Paperclip agents
 *
 * This engine implements the capability-based model assignment system that:
 * 1. Analyzes agent skills and maps them to AI capabilities
 * 2. Selects optimal models based on complexity and performance requirements
 * 3. Manages model assignments in the database with proper auditing
 * 4. Provides optimization recommendations and cost analysis
 */

const fs = require('fs');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');
const yaml = require('yaml');
const _ = require('lodash');

// Load environment variables
require('dotenv').config();

// Configuration
const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_SERVICE_ROLE_KEY,
  capabilityMappingPath: path.join(__dirname, '../../../scripts/agent-model-framework/skill-capability-mapping.yaml'),
  defaultTemperature: 0.7,
  defaultMaxTokens: 4096
};

// Initialize Supabase client
function initSupabase() {
  if (!CONFIG.supabaseUrl || !CONFIG.supabaseKey) {
    throw new Error('Missing Supabase configuration. Please set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY environment variables.');
  }
  return createClient(CONFIG.supabaseUrl, CONFIG.supabaseKey);
}

// Load capability mapping configuration
function loadCapabilityConfig() {
  try {
    const configContent = fs.readFileSync(CONFIG.capabilityMappingPath, 'utf8');
    return yaml.parse(configContent);
  } catch (error) {
    console.error('❌ Failed to load capability mapping configuration:', error.message);
    process.exit(1);
  }
}

// Analyze agent capabilities based on skills
async function analyzeAgentCapabilities(supabase, agentId) {
  console.log(`🔍 Analyzing capabilities for agent: ${agentId}`);

  // Get agent skills
  const { data: skillsData, error: skillsError } = await supabase
    .from('agent_skill_assignments')
    .select('skill_key')
    .eq('agent_id', agentId);

  if (skillsError) {
    throw new Error(`Failed to fetch agent skills: ${skillsError.message}`);
  }

  const skillKeys = skillsData.map(s => s.skill_key);
  console.log(`   Found ${skillKeys.length} skills: ${skillKeys.slice(0, 5).join(', ')}${skillKeys.length > 5 ? '...' : ''}`);

  // Load capability configuration
  const config = loadCapabilityConfig();

  // Map skills to capabilities
  const capabilityMapping = mapSkillsToCapabilities(skillKeys, config);

  // Determine primary capability
  const primaryCapability = determinePrimaryCapability(capabilityMapping, config);

  // Get optimal model and settings
  const optimalModel = getOptimalModelForCapability(primaryCapability, config);
  const optimalTemperature = getOptimalTemperatureForCapability(primaryCapability, config);

  return {
    agentId,
    skillCount: skillKeys.length,
    capabilities: Object.keys(capabilityMapping),
    primaryCapability,
    recommendedModel: optimalModel,
    recommendedTemperature: optimalTemperature,
    skillSample: skillKeys.slice(0, 5)
  };
}

// Map skills to capabilities using pattern matching
function mapSkillsToCapabilities(skillKeys, config) {
  const capabilityMapping = {};
  const skillPatterns = config.skill_patterns || [];

  for (const skillKey of skillKeys) {
    const skillKeyLower = skillKey.toLowerCase();
    const matchedCapabilities = new Set();

    // Check each pattern
    for (const patternConfig of skillPatterns) {
      const pattern = patternConfig.pattern;
      const capabilities = patternConfig.capabilities || [];

      if (new RegExp(pattern, 'i').test(skillKeyLower)) {
        capabilities.forEach(cap => matchedCapabilities.add(cap));
      }
    }

    // If no patterns matched, assign to 'general' capability
    if (matchedCapabilities.size === 0) {
      matchedCapabilities.add('general');
    }

    // Add skill to each matched capability
    for (const capability of matchedCapabilities) {
      if (!capabilityMapping[capability]) {
        capabilityMapping[capability] = [];
      }
      capabilityMapping[capability].push(skillKey);
    }
  }

  return capabilityMapping;
}

// Determine primary capability based on skill distribution and complexity
function determinePrimaryCapability(capabilityMapping, config) {
  if (!capabilityMapping || Object.keys(capabilityMapping).length === 0) {
    return 'general';
  }

  const capabilityCategories = config.capability_categories || {};

  // Sort by count, then by complexity level
  const sortedCapabilities = Object.keys(capabilityMapping)
    .map(capability => {
      const count = capabilityMapping[capability].length;
      const complexity = capabilityCategories[capability]?.complexity || 'standard';
      const complexityOrder = { 'simple': 0, 'standard': 1, 'complex': 2, 'expert': 3 };
      const complexityScore = complexityOrder[complexity] || 1;

      return { capability, count, complexityScore };
    })
    .sort((a, b) => {
      if (a.count !== b.count) return b.count - a.count;
      return b.complexityScore - a.complexityScore;
    });

  return sortedCapabilities[0]?.capability || 'general';
}

// Get optimal model for capability
function getOptimalModelForCapability(capability, config) {
  const capabilityCategories = config.capability_categories || {};
  const capabilityConfig = capabilityCategories[capability] || {};

  // Get key models for this capability
  const keyModels = capabilityConfig.key_models || ['anthropic/claude-3-haiku'];

  // Return the first (primary) model
  return keyModels[0];
}

// Get optimal temperature for capability
function getOptimalTemperatureForCapability(capability, config) {
  const capabilityCategories = config.capability_categories || {};
  const capabilityConfig = capabilityCategories[capability] || {};

  // Get temperature preference
  const tempRange = capabilityConfig.temperature_preference || '0.3-0.7';

  // Parse range and return midpoint
  if (tempRange.includes('-')) {
    try {
      const [low, high] = tempRange.split('-').map(parseFloat);
      return (low + high) / 2;
    } catch (error) {
      // Ignore parsing errors
    }
  }

  // Return default temperature
  return CONFIG.defaultTemperature;
}

// Assign models to agents
async function assignModelsToAgents(supabase, agentIds = null) {
  console.log('🎯 Starting model assignment process...');

  // Get agents to process
  let query = supabase
    .from('agents')
    .select('id, name, role, title, company_id');

  if (agentIds && agentIds.length > 0) {
    query = query.in('id', agentIds);
  }

  const { data: agents, error: agentsError } = await query;

  if (agentsError) {
    throw new Error(`Failed to fetch agents: ${agentsError.message}`);
  }

  console.log(`📊 Processing ${agents.length} agents...`);

  const results = [];
  const assignments = [];

  for (const agent of agents) {
    try {
      console.log(`\n🔄 Processing agent: ${agent.name} (${agent.id})`);

      // Analyze capabilities
      const analysis = await analyzeAgentCapabilities(supabase, agent.id);

      // Check for existing primary assignment
      const { data: existingAssignment } = await supabase
        .from('agent_models')
        .select('*')
        .eq('agent_id', agent.name)
        .eq('assignment_type', 'primary')
        .single();

      const assignment = {
        agent_id: agent.name,
        model_id: analysis.recommendedModel,
        assignment_type: 'primary',
        priority: 1,
        temperature: analysis.recommendedTemperature,
        max_tokens: CONFIG.defaultMaxTokens,
        assigned_by: 'model-assignment-specialist',
        reason: `Capability-based assignment: ${analysis.primaryCapability} (${analysis.skillCount} skills)`,
        is_active: true,
        company_id: agent.company_id
      };

      assignments.push(assignment);

      results.push({
        agent: agent.name,
        status: 'analyzed',
        primaryCapability: analysis.primaryCapability,
        recommendedModel: analysis.recommendedModel,
        skillCount: analysis.skillCount,
        existingAssignment: !!existingAssignment
      });

    } catch (error) {
      console.error(`❌ Error processing agent ${agent.name}:`, error.message);
      results.push({
        agent: agent.name,
        status: 'error',
        error: error.message
      });
    }
  }

  // Insert/update assignments
  console.log(`\n💾 Saving ${assignments.length} model assignments...`);

  for (const assignment of assignments) {
    const { error } = await supabase
      .from('agent_models')
      .upsert(assignment, {
        onConflict: 'agent_id,assignment_type'
      });

    if (error) {
      console.error(`❌ Failed to save assignment for ${assignment.agent_id}:`, error.message);
    } else {
      console.log(`✅ Saved assignment for ${assignment.agent_id}: ${assignment.model_id}`);
    }
  }

  return results;
}

// Optimize existing assignments
async function optimizeExistingAssignments(supabase) {
  console.log('🔧 Optimizing existing model assignments...');

  // Get all current assignments
  const { data: assignments, error } = await supabase
    .from('agent_models')
    .select(`
      *,
      agents!inner(id, name, role, title, company_id)
    `)
    .eq('assignment_type', 'primary')
    .eq('is_active', true);

  if (error) {
    throw new Error(`Failed to fetch assignments: ${error.message}`);
  }

  console.log(`📊 Analyzing ${assignments.length} existing assignments...`);

  const optimizations = [];

  for (const assignment of assignments) {
    try {
      // Analyze current agent
      const analysis = await analyzeAgentCapabilities(supabase, assignment.agent_id);

      // Check if current assignment is optimal
      const isOptimal = assignment.model_id === analysis.recommendedModel &&
                       Math.abs(assignment.temperature - analysis.recommendedTemperature) < 0.1;

      if (!isOptimal) {
        optimizations.push({
          agent: assignment.agent_id,
          currentModel: assignment.model_id,
          currentTemp: assignment.temperature,
          recommendedModel: analysis.recommendedModel,
          recommendedTemp: analysis.recommendedTemperature,
          primaryCapability: analysis.primaryCapability,
          reason: 'Suboptimal model assignment detected'
        });
      }

    } catch (error) {
      console.error(`❌ Error analyzing ${assignment.agent_id}:`, error.message);
    }
  }

  console.log(`\n🎯 Found ${optimizations.length} optimization opportunities`);

  // Apply optimizations
  for (const opt of optimizations) {
    console.log(`🔄 Optimizing ${opt.agent}: ${opt.currentModel} → ${opt.recommendedModel}`);

    const { error } = await supabase
      .from('agent_models')
      .update({
        model_id: opt.recommendedModel,
        temperature: opt.recommendedTemp,
        reason: `Optimization: ${opt.reason}`,
        updated_at: new Date().toISOString()
      })
      .eq('agent_id', opt.agent)
      .eq('assignment_type', 'primary');

    if (error) {
      console.error(`❌ Failed to optimize ${opt.agent}:`, error.message);
    } else {
      console.log(`✅ Optimized ${opt.agent}`);
    }
  }

  return optimizations;
}

// Monitor skill changes and trigger reassessments
async function monitorSkillChanges(supabase) {
  console.log('👀 Monitoring agent skill changes...');

  // Get agents with recent skill changes (last 24 hours)
  const oneDayAgo = new Date();
  oneDayAgo.setHours(oneDayAgo.getHours() - 24);

  // Get agents and their current skills
  const { data: agents, error: agentsError } = await supabase
    .from('agents')
    .select('id, name, updated_at')
    .gte('updated_at', oneDayAgo.toISOString());

  if (agentsError) {
    throw new Error(`Failed to fetch recently updated agents: ${agentsError.message}`);
  }

  console.log(`📊 Found ${agents.length} agents updated in the last 24 hours`);

  const skillChanges = [];
  const reassessmentNeeded = [];

  for (const agent of agents) {
    try {
      // Get current skills
      const { data: currentSkills, error: skillsError } = await supabase
        .from('agent_skill_assignments')
        .select('skill_key, created_at, updated_at')
        .eq('agent_id', agent.id);

      if (skillsError) {
        console.error(`❌ Error fetching skills for ${agent.name}:`, skillsError.message);
        continue;
      }

      // Check for recently added/modified skills
      const recentSkills = currentSkills.filter(skill =>
        new Date(skill.created_at) > oneDayAgo || new Date(skill.updated_at) > oneDayAgo
      );

      if (recentSkills.length > 0) {
        skillChanges.push({
          agent: agent.name,
          agentId: agent.id,
          skillChanges: recentSkills.length,
          recentSkills: recentSkills.map(s => s.skill_key)
        });

        // Analyze if this requires model reassessment
        const analysis = await analyzeAgentCapabilities(supabase, agent.id);
        const { data: currentAssignment } = await supabase
          .from('agent_models')
          .select('*')
          .eq('agent_id', agent.name)
          .eq('assignment_type', 'primary')
          .single();

        const needsReassessment = !currentAssignment ||
          currentAssignment.model_id !== analysis.recommendedModel ||
          Math.abs(currentAssignment.temperature - analysis.recommendedTemperature) > 0.1;

        if (needsReassessment) {
          reassessmentNeeded.push({
            agent: agent.name,
            agentId: agent.id,
            currentModel: currentAssignment?.model_id || 'None',
            recommendedModel: analysis.recommendedModel,
            currentTemp: currentAssignment?.temperature || 0,
            recommendedTemp: analysis.recommendedTemperature,
            primaryCapability: analysis.primaryCapability,
            reason: 'Skill changes require model reassessment'
          });
        }
      }

    } catch (error) {
      console.error(`❌ Error analyzing ${agent.name}:`, error.message);
    }
  }

  console.log(`\n📋 Skill Change Summary:`);
  console.log(`  • Agents with skill changes: ${skillChanges.length}`);
  console.log(`  • Agents needing reassessment: ${reassessmentNeeded.length}`);

  if (skillChanges.length > 0) {
    console.log(`\n🔄 Skill Changes Detected:`);
    skillChanges.forEach(change => {
      console.log(`  • ${change.agent}: ${change.skillChanges} skill changes`);
      console.log(`    Recent skills: ${change.recentSkills.join(', ')}`);
    });
  }

  if (reassessmentNeeded.length > 0) {
    console.log(`\n🎯 Model Reassessments Needed:`);
    reassessmentNeeded.forEach(need => {
      console.log(`  • ${need.agent}: ${need.currentModel} → ${need.recommendedModel}`);
      console.log(`    Temp: ${need.currentTemp} → ${need.recommendedTemp} (${need.primaryCapability})`);
    });

    // Apply reassessments
    console.log(`\n🔧 Applying ${reassessmentNeeded.length} model reassessments...`);
    for (const reassessment of reassessmentNeeded) {
      const { error } = await supabase
        .from('agent_models')
        .update({
          model_id: reassessment.recommendedModel,
          temperature: reassessment.recommendedTemp,
          reason: `Skill change reassessment: ${reassessment.reason}`,
          updated_at: new Date().toISOString()
        })
        .eq('agent_id', reassessment.agent)
        .eq('assignment_type', 'primary');

      if (error) {
        console.error(`❌ Failed to reassess ${reassessment.agent}:`, error.message);
      } else {
        console.log(`✅ Reassessed ${reassessment.agent}`);
      }
    }
  }

  return {
    skillChanges: skillChanges.length,
    reassessmentsApplied: reassessmentNeeded.length,
    details: reassessmentNeeded
  };
}

// Audit assignments
async function auditAssignments(supabase) {
  console.log('🔍 Auditing model assignments...');

  // Get assignment statistics
  const { data: stats, error: statsError } = await supabase
    .rpc('get_model_assignment_stats');

  if (statsError) {
    console.log('⚠️  Stats function not available, using basic queries...');

    // Fallback: basic statistics
    const { data: assignments } = await supabase
      .from('agent_models')
      .select('model_id, assignment_type, is_active')
      .eq('is_active', true);

    const modelStats = _.countBy(assignments, 'model_id');
    const typeStats = _.countBy(assignments, 'assignment_type');

    console.log('\n📊 Model Distribution:');
    Object.entries(modelStats)
      .sort(([,a], [,b]) => b - a)
      .forEach(([model, count]) => {
        console.log(`  • ${model}: ${count} assignments`);
      });

    console.log('\n🏷️  Assignment Types:');
    Object.entries(typeStats).forEach(([type, count]) => {
      console.log(`  • ${type}: ${count} assignments`);
    });

  } else {
    console.log('\n📊 Assignment Statistics:');
    console.log(stats);
  }

  // Check for agents without assignments
  const { data: agentsWithoutModels } = await supabase
    .from('agents')
    .select('name, role, title')
    .then(async ({ data: agents }) => {
      const agentsWithModels = new Set();

      const { data: assignments } = await supabase
        .from('agent_models')
        .select('agent_id')
        .eq('assignment_type', 'primary')
        .eq('is_active', true);

      assignments.forEach(a => agentsWithModels.add(a.agent_id));

      return agents.filter(agent => !agentsWithModels.has(agent.name));
    });

  console.log(`\n⚠️  Agents without model assignments: ${agentsWithoutModels.length}`);
  if (agentsWithoutModels.length > 0) {
    agentsWithoutModels.slice(0, 5).forEach(agent => {
      console.log(`  • ${agent.name} (${agent.role})`);
    });
    if (agentsWithoutModels.length > 5) {
      console.log(`  ... and ${agentsWithoutModels.length - 5} more`);
    }
  }

  return {
    agentsWithoutModels: agentsWithoutModels.length,
    stats: stats || { modelStats, typeStats }
  };
}

// Main CLI handler
async function main() {
  const command = process.argv[2];

  if (!command) {
    showHelp();
    return;
  }

  try {
    const supabase = initSupabase();

    switch (command) {
      case 'assign-models':
        const agentIds = process.argv.slice(3);
        const results = await assignModelsToAgents(supabase, agentIds.length > 0 ? agentIds : null);
        console.log(`\n✅ Processed ${results.length} agents`);
        break;

      case 'analyze-capabilities':
        const agentId = process.argv[3];
        if (!agentId) {
          console.error('❌ Please specify an agent ID');
          process.exit(1);
        }
        const analysis = await analyzeAgentCapabilities(supabase, agentId);
        console.log('\n📊 Capability Analysis:');
        console.log(JSON.stringify(analysis, null, 2));
        break;

      case 'optimize-assignments':
        const optimizations = await optimizeExistingAssignments(supabase);
        console.log(`\n✅ Applied ${optimizations.length} optimizations`);
        break;

      case 'audit-assignments':
        const audit = await auditAssignments(supabase);
        console.log('\n✅ Audit completed');
        break;

      case 'monitor-skills':
        const monitoring = await monitorSkillChanges(supabase);
        console.log(`\n✅ Skill monitoring completed - ${monitoring.reassessmentsApplied} reassessments applied`);
        break;

      default:
        console.error(`❌ Unknown command: ${command}`);
        showHelp();
        process.exit(1);
    }

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

function showHelp() {
  console.log(`
🤖 Model Assignment Specialist - Intelligent AI Model Assignment Engine

USAGE:
  node model-assignment-engine.js <command> [options]

COMMANDS:
  assign-models [agent-ids...]    Assign optimal models to agents
                                  If no agent IDs specified, processes all agents

  analyze-capabilities <agent-id> Analyze skills and capabilities for a specific agent

  optimize-assignments            Review and optimize existing model assignments

  audit-assignments               Audit current model assignment statistics

  monitor-skills                  Monitor recent skill changes and trigger model reassessments

EXAMPLES:
  # Assign models to all agents
  node model-assignment-engine.js assign-models

  # Assign models to specific agents
  node model-assignment-engine.js assign-models agent-1 agent-2

  # Analyze a specific agent
  node model-assignment-engine.js analyze-capabilities my-agent

  # Optimize existing assignments
  node model-assignment-engine.js optimize-assignments

  # Audit current state
  node model-assignment-engine.js audit-assignments

ENVIRONMENT:
  SUPABASE_URL                 - Supabase project URL
  SUPABASE_SERVICE_ROLE_KEY    - Supabase service role key

CONFIGURATION:
  Capability mapping loaded from: scripts/agent-model-framework/skill-capability-mapping.yaml
`);
}

// Run if called directly
if (require.main === module) {
  main().catch(error => {
    console.error('💥 Fatal error:', error);
    process.exit(1);
  });
}

module.exports = {
  analyzeAgentCapabilities,
  assignModelsToAgents,
  optimizeExistingAssignments,
  auditAssignments,
  monitorSkillChanges
};

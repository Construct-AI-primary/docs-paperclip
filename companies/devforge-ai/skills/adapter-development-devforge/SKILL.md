---
name: adapter-development-devforge
description: >
  Use when building new adapter types, modifying existing adapters, adding Ollama/local
  LLM support, or implementing adapter-specific features like HTTPS URLs, model selection,
  and token tracking. Handles claude_local, codex_local, opencode, gemini_local adapters.
---

# Adapter Development - DevForge AI

## Overview
Handles adapter development for the Paperclip codebase. Creates new adapter types (Ollama, local LLM), modifies existing adapters, implements adapter-specific features like HTTPS URL support, model selection, token tracking, and ensures adapters integrate with the heartbeat/wake lifecycle.

## When to Use
- When adding a new adapter type (ollama, lm-studio, text-generation-webui)
- When adapterConfig needs HTTPS URL support for Ollama or similar
- When model selection in adapterConfig doesn't work or resets between runs
- When token tracking is needed for local LLM adapters
- When adapter environment variables need new fields (PAPERCLIP_WAKE_ACTOR_TYPE)
- **Don't use when:** It's an adapter runtime error (use fixer-devforge-bug-fixing)

## Core Procedures
### New Adapter Workflow
1. **Define Adapter Type** - Add to `BUILTIN_ADAPTER_TYPES` in server adapters module
2. **Create Adapter Package** - Follow existing `*-local` adapter pattern in packages/adapters/
3. **Implement execute.ts** - Handle model API calls, token tracking, error handling
4. **Add Adapter Config Schema** - Define adapterConfig fields (baseUrl, model, thinking)
5. **Integrate Heartbeat** - Ensure adapter works with heartbeat/wake lifecycle
6. **Write Adapter Tests** - Match existing `*-local-adapter-environment.test.ts` pattern
7. **Update UI** - Add adapter to adapter type selector in UI

### Common Adapter Patterns
- OpenAI-compatible adapters: use `OPENAI_BASE_URL` env, `chat/completions` endpoint
- Local adapters: set `isLocal = true` for instructions bundle access
- Adapter env vars: export `PAPERCLIP_*` vars from execute.ts contextSnapshot

## Agent Assignment
**Primary Agent:** codesmith-devforge-backend-engineer
**Company:** DevForge AI
**Role:** Adapter Development Specialist
**Reports To:** codesmith-devforge-backend-engineer
**Backup Agents:** devcore-devforge-core-development, interface-devforge-api-integration

## Success Metrics
- New adapter works with heartbeat/wake lifecycle
- Model selection persists across runs
- HTTPS URLs supported for all compatible adapters
- Token tracking works for local LLM adapters

## Error Handling
- **Error:** Adapter config resets between runs
  **Response:** Check config persistence, ensure adapterConfig is saved to DB
- **Error:** HTTPS URL rejected by adapter
  **Response:** Add https:// to allowed URL schemes in adapter validation

## Cross-Team Integration
**Gigabrain Tags:** devforge, adapter, ollama, local-llm, openai-compatible, model-selection
**Related Skills:** codesmith-devforge-backend-engineer, devcore-devforge-core-development, interface-devforge-api-integration
**Last Updated:** 2026-04-07
# Integrated SDLC Framework

## Project Overview
A 10-agent SDLC framework with 116 skills for AI-assisted software development.

## Critical Rules

### Documentation Sync (MANDATORY)
**Whenever ANY change is made to this project, ALL related files must be updated including:**
- `README.md` - If architecture, workflow, or usage changes
- `agents/*/agent.yaml` - If skills or BMAD personas change
- `config/` files - If framework configuration changes
- `.bmad/config.yaml` - If BMAD integration changes
- `setup-sdlc-framework.sh` - If setup process changes
- Mermaid diagrams in README - If relationships between components change

**Never make a partial change. Always update all affected files in the same commit.**

## Tech Stack
- Frontend: React + TypeScript
- Backend: Node.js/Express (or Python/FastAPI)
- Database: PostgreSQL
- Auth: OAuth2 (Google, University SSO)

## Framework Integration
This project uses a 10-agent SDLC framework with 116 skills, integrating:
- GitHub Spec Kit (spec-driven development)
- Agentic SDLC 12 Factors (strategic principles)
- Obra Superpowers (engineering discipline skills)
- BMAD Method (specialized agent personas)
- Ralph Wiggum Plugin (autonomous execution loops)

## Workflow Commands
- `/orchestrate` - Start orchestrator for task coordination
- `/specify` - Begin spec-driven requirements capture
- `/plan` - Create technical implementation plan
- `/implement` - Execute implementation with agents
- `/test` - Run test manager for validation
- `/deploy` - Execute deployment workflow

## Autonomous Execution (Ralph Wiggum)
- `/ralph-loop "<task>" --max-iterations <n> --completion-promise "<done>"` - Run autonomous loop
- `/cancel-ralph` - Cancel active Ralph loop

## Key Directories
- `agents/` - 10 agent definitions with skills
- `skills/` - 116 skill templates organized by category
- `.specify/` - Spec Kit artifacts
- `.bmad/` - BMAD agent configurations
- `.ralph/` - Ralph loop configurations
- `docs/` - All documentation

## Privacy & Compliance
- GDPR compliant (EU students)
- FERPA aware (academic records)
- PII encryption required


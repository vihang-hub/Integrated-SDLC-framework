#!/bin/bash
#
# SDLC Framework Setup Script
# Automates the 11-phase setup process with prompts for manual steps
#
# Usage:
#   ./setup-sdlc-framework.sh                 # Run full setup in current directory
#   ./setup-sdlc-framework.sh --phase 3       # Start from phase 3
#   ./setup-sdlc-framework.sh --skip-to 5     # Skip to phase 5
#   ./setup-sdlc-framework.sh --dry-run       # Show what would be done
#   ./setup-sdlc-framework.sh --project-dir /path/to/project  # Use specific directory
#

set -e  # Exit on error

# =============================================================================
# Configuration
# =============================================================================

# Default to current directory; derive project name from directory name
PROJECT_DIR="${PWD}"
PROJECT_NAME="$(basename "${PROJECT_DIR}")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="${SCRIPT_DIR}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# State tracking
CURRENT_PHASE=1
DRY_RUN=false
START_PHASE=1

# =============================================================================
# Helper Functions
# =============================================================================

print_header() {
    echo ""
    echo -e "${BLUE}============================================================${NC}"
    echo -e "${BOLD}$1${NC}"
    echo -e "${BLUE}============================================================${NC}"
    echo ""
}

print_phase() {
    echo ""
    echo -e "${CYAN}────────────────────────────────────────────────────────────${NC}"
    echo -e "${CYAN}Phase $1: $2${NC}"
    echo -e "${CYAN}────────────────────────────────────────────────────────────${NC}"
    echo ""
}

print_step() {
    echo -e "${GREEN}▶ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✖ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✔ $1${NC}"
}

prompt_continue() {
    local message="${1:-Press Enter to continue...}"
    echo ""
    echo -e "${YELLOW}${message}${NC}"
    read -r
}

prompt_yes_no() {
    local message="$1"
    local default="${2:-y}"

    if [[ "$default" == "y" ]]; then
        prompt="[Y/n]"
    else
        prompt="[y/N]"
    fi

    echo -e "${YELLOW}${message} ${prompt}${NC}"
    read -r response

    if [[ -z "$response" ]]; then
        response="$default"
    fi

    [[ "$response" =~ ^[Yy] ]]
}

prompt_manual_step() {
    local title="$1"
    local instructions="$2"

    echo ""
    echo -e "${BOLD}${YELLOW}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${YELLOW}║  MANUAL STEP REQUIRED: ${title}${NC}"
    echo -e "${BOLD}${YELLOW}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${instructions}"
    echo ""
    prompt_continue "Press Enter when you have completed this step..."
}

check_command() {
    if ! command -v "$1" &> /dev/null; then
        print_error "Required command not found: $1"
        return 1
    fi
    return 0
}

run_or_dry() {
    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${BLUE}[DRY RUN] Would execute: $*${NC}"
    else
        "$@"
    fi
}

create_file() {
    local filepath="$1"
    local content="$2"

    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${BLUE}[DRY RUN] Would create: $filepath${NC}"
    else
        mkdir -p "$(dirname "$filepath")"
        echo "$content" > "$filepath"
        print_success "Created: $filepath"
    fi
}

# =============================================================================
# Phase Functions
# =============================================================================

phase_1_foundation() {
    print_phase 1 "Foundation Setup"

    # Check prerequisites
    print_step "Checking prerequisites..."
    check_command git || exit 1
    check_command node || print_warning "Node.js not found - some features may not work"
    check_command python3 || exit 1

    # Prompt for project directory
    echo -e "Project will be created at: ${BOLD}${PROJECT_DIR}${NC}"
    if [[ -d "$PROJECT_DIR" ]]; then
        print_warning "Directory already exists!"
        if ! prompt_yes_no "Continue and potentially overwrite existing files?"; then
            print_info "Aborting. Please backup or remove existing directory."
            exit 1
        fi
    fi

    # Create directory structure
    print_step "Creating directory structure..."
    run_or_dry mkdir -p "$PROJECT_DIR"
    cd "$PROJECT_DIR"

    local dirs=(
        ".specify/templates"
        ".bmad"
        ".ralph/prompts"
        ".sdlc"
        "agents/orchestrator"
        "agents/requirements"
        "agents/architecture"
        "agents/design"
        "agents/test-manager"
        "agents/developer"
        "agents/security"
        "agents/devops"
        "agents/documentation"
        "agents/operations"
        "skills"
        "docs/requirements"
        "docs/architecture/adrs"
        "docs/design"
        "docs/testing"
        "docs/security"
        "docs/runbooks"
        "src/frontend"
        "src/backend"
        "src/database/migrations"
        "tests/unit"
        "tests/integration"
        "tests/e2e"
        "config/spec-kit"
        "config/bmad"
        "config/ralph"
        "config/superpowers"
        "config/12-factors"
        "scripts"
        "infrastructure"
    )

    for dir in "${dirs[@]}"; do
        run_or_dry mkdir -p "$dir"
    done
    print_success "Directory structure created"

    # Initialize git
    if [[ ! -d ".git" ]]; then
        print_step "Initializing git repository..."
        run_or_dry git init
    else
        print_info "Git repository already initialized"
    fi

    # Create .gitignore
    print_step "Creating .gitignore..."
    create_file ".gitignore" "# Dependencies
node_modules/
__pycache__/
*.pyc
.venv/
venv/

# Environment
.env
.env.local
*.local

# IDE
.idea/
.vscode/
*.swp
*.swo

# Build
dist/
build/
*.egg-info/

# Logs
*.log
logs/

# Coverage
coverage/
.coverage
htmlcov/

# OS
.DS_Store
Thumbs.db

# Project specific
.sdlc/workflow-state.json
.sdlc/ralph-logs/
"

    # Create .env template
    print_step "Creating .env.example..."
    create_file ".env.example" "# ${PROJECT_NAME} Environment Configuration
# Copy to .env and fill in values

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/${PROJECT_NAME}

# External APIs (obtain from providers)
UNIVERSITY_API_KEY=
VISA_SERVICE_API_KEY=
HOUSING_API_KEY=

# OAuth2 Configuration
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=
OAUTH_REDIRECT_URI=http://localhost:3000/auth/callback

# Application
NODE_ENV=development
PORT=3000
SECRET_KEY=generate-a-secure-random-string

# Feature Flags
ENABLE_MOCK_APIS=true
"

    # Create initial CLAUDE.md
    print_step "Creating CLAUDE.md..."
    create_file "CLAUDE.md" "# ${PROJECT_NAME}

## Project Overview
[TODO: Add project description]

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
- \`/orchestrate\` - Start orchestrator for task coordination
- \`/specify\` - Begin spec-driven requirements capture
- \`/plan\` - Create technical implementation plan
- \`/implement\` - Execute implementation with agents
- \`/test\` - Run test manager for validation
- \`/deploy\` - Execute deployment workflow

## Autonomous Execution (Ralph Wiggum)
- \`/ralph-loop \"<task>\" --max-iterations <n> --completion-promise \"<done>\"\` - Run autonomous loop
- \`/cancel-ralph\` - Cancel active Ralph loop

## Key Directories
- \`agents/\` - 10 agent definitions with skills
- \`skills/\` - 116 skill templates organized by category
- \`.specify/\` - Spec Kit artifacts
- \`.bmad/\` - BMAD agent configurations
- \`.ralph/\` - Ralph loop configurations
- \`docs/\` - All documentation

## Privacy & Compliance
- GDPR compliant (EU students)
- FERPA aware (academic records)
- PII encryption required
"

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "chore: initialize ${PROJECT_NAME} project structure" || true
    fi

    print_success "Phase 1 complete!"
}

phase_2_spec_kit() {
    print_phase 2 "Spec Kit Installation & Configuration"

    cd "$PROJECT_DIR"

    print_step "Checking for Spec Kit..."

    # Spec Kit installation
    if prompt_yes_no "Install GitHub Spec Kit? (requires npm)"; then
        print_info "Installing Spec Kit..."
        run_or_dry npx @anthropic/spec-kit init || print_warning "Spec Kit installation may have failed"
    else
        print_info "Skipping Spec Kit installation - creating manual config..."
    fi

    # Create Spec Kit workflow config
    print_step "Creating Spec Kit workflow configuration..."
    create_file "config/spec-kit/workflow.yaml" "# Spec Kit Workflow Configuration
# Project: ${PROJECT_NAME}

workflow:
  name: \${PROJECT_NAME}-workflow

phases:
  - name: specify
    command: /speckit.specify
    agent: requirements
    outputs:
      - .specify/spec.md
      - docs/requirements/
    gate:
      - requirements_documented
      - acceptance_criteria_defined
      - user_journeys_mapped

  - name: plan
    command: /speckit.plan
    agent: architecture
    inputs:
      - .specify/spec.md
    outputs:
      - docs/architecture/
      - docs/architecture/adrs/
    gate:
      - architecture_documented
      - adrs_written
      - database_schema_defined

  - name: tasks
    command: /speckit.tasks
    agent: orchestrator
    inputs:
      - .specify/spec.md
      - docs/architecture/
    outputs:
      - .sdlc/tasks.json
    gate:
      - tasks_decomposed
      - dependencies_mapped

  - name: implement
    command: /speckit.implement
    agents:
      - developer
      - test-manager
    gate:
      - code_complete
      - tests_passing
      - coverage_met

templates:
  requirement: .specify/templates/requirement.md
  story: .specify/templates/story.md
  adr: .specify/templates/adr.md
"

    # Create requirement template
    print_step "Creating requirement template..."
    create_file ".specify/templates/requirement.md" "# Requirement: {{REQ_ID}}

## Summary
{{brief_description}}

## User Persona
{{persona}}

## User Journey Stage
{{journey_stage}}

## Detailed Description
{{detailed_description}}

## Acceptance Criteria
- [ ] {{criterion_1}}
- [ ] {{criterion_2}}

## Non-Functional Requirements
- Performance: {{performance_requirement}}
- Security: {{security_requirement}}
- Accessibility: {{accessibility_requirement}}

## Dependencies
- {{dependency_1}}

## Privacy Impact
- PII Involved: {{pii_fields}}
- GDPR Considerations: {{gdpr_notes}}

## External APIs
- {{api_name}}: {{api_usage}}

## Priority
{{priority}} (Critical/High/Medium/Low)

## Estimation
Story Points: {{points}}
"

    # Create constitution
    print_step "Creating constitution..."
    create_file ".specify/constitution.md" "# ${PROJECT_NAME} Constitution

## Mission
Empower students to discover, apply to, and successfully complete study abroad programs through a seamless digital experience.

## Core Principles

### 1. Student-First Design
Every feature must demonstrably improve the student experience across the journey stages: Discovery, Application, Preparation, Abroad, and Return.

### 2. Privacy by Design
- All PII must be encrypted at rest and in transit
- GDPR compliance is mandatory
- Data minimization: collect only what's necessary
- Right to deletion must be implemented

### 3. Accessibility
- WCAG 2.1 AA compliance minimum
- Support for screen readers
- Keyboard navigation for all features

### 4. Security
- OWASP Top 10 vulnerabilities must be addressed
- OAuth2/SSO for authentication
- Regular security audits

### 5. Quality
- 80% minimum test coverage
- All PRs require code review
- No deployment without passing tests

## Non-Negotiables
1. Never store plain-text passwords
2. Never expose PII in logs
3. Never skip security reviews for auth-related changes
4. Always validate external API responses
5. Always have a rollback plan for deployments

## Technology Choices
- Justified by ADRs
- Consider long-term maintenance
- Prefer well-supported libraries
"

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "feat: configure Spec Kit with ${PROJECT_NAME} workflow" || true
    fi

    print_success "Phase 2 complete!"
}

phase_3_superpowers() {
    print_phase 3 "Obra Superpowers Installation & Custom Skills"

    cd "$PROJECT_DIR"

    if prompt_yes_no "Install Obra Superpowers? (requires npm)"; then
        print_info "Installing Obra Superpowers..."
        run_or_dry npx obra-superpowers init || print_warning "Superpowers installation may have failed"
    else
        print_info "Skipping Superpowers installation - creating manual config..."
    fi

    # Create superpowers config
    print_step "Creating Superpowers configuration..."
    create_file "config/superpowers/config.yaml" "# Obra Superpowers Configuration
# Project: ${PROJECT_NAME}

superpowers:
  enabled:
    # Core Development
    - tdd
    - code-review
    - systematic-debugging

    # Planning
    - brainstorming
    - write-plan
    - execute-plan

    # Quality
    - verification-before-completion
    - testing-anti-patterns

  custom_skills:
    - name: gdpr-compliance-check
      description: Verify GDPR compliance for data handling
      trigger: changes_to_user_data

    - name: external-api-integration
      description: Pattern for integrating external APIs
      trigger: new_api_integration

    - name: user-journey-validation
      description: Validate feature against user journey stages
      trigger: feature_completion

tdd_config:
  coverage_target: 80
  require_tests_first: true

code_review_config:
  require_approval: true
  security_review_for:
    - auth/
    - user/
    - payment/
"

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "feat: configure Obra Superpowers for ${PROJECT_NAME}" || true
    fi

    print_success "Phase 3 complete!"
}

phase_4_bmad() {
    print_phase 4 "BMAD Method Installation & Agent Mapping"

    cd "$PROJECT_DIR"

    print_step "Installing BMAD Method..."

    # Install BMAD to .bmad-core directory, configured for Claude Code
    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${BLUE}[DRY RUN] Would execute: npx bmad-method install --full --directory .bmad-core --ide claude-code${NC}"
    else
        if npx bmad-method install --full --directory .bmad-core --ide claude-code; then
            print_success "BMAD Method installed to .bmad-core/"
        else
            print_warning "BMAD installation failed - creating manual structure..."
            # Create minimal BMAD structure if install fails
            mkdir -p .bmad-core/agents
            mkdir -p .bmad-core/templates
            mkdir -p .bmad-core/workflows
        fi
    fi

    # Create BMAD agent mapping with file references
    print_step "Creating BMAD agent mapping..."
    create_file "config/bmad/agent-mapping.yaml" "# Mapping: Your 10 Agents <-> BMAD Agents
# Project: ${PROJECT_NAME}
# BMAD Installation: .bmad-core/

bmad_root: .bmad-core

agent_mapping:
  orchestrator:
    bmad_personas:
      - name: bmad-orchestrator
        file: .bmad-core/agents/bmad-orchestrator.md
      - name: sm
        file: .bmad-core/agents/sm.md
    responsibilities:
      - workflow_management
      - task_coordination
      - gate_validation

  requirements:
    bmad_personas:
      - name: analyst
        file: .bmad-core/agents/analyst.md
      - name: pm
        file: .bmad-core/agents/pm.md
    responsibilities:
      - requirements_elicitation
      - user_story_writing
      - acceptance_criteria

  architecture:
    bmad_personas:
      - name: architect
        file: .bmad-core/agents/architect.md
    responsibilities:
      - system_design
      - technology_selection
      - adr_writing

  design:
    bmad_personas:
      - name: ux-expert
        file: .bmad-core/agents/ux-expert.md
    responsibilities:
      - ui_design
      - api_contracts
      - wireframing

  test-manager:
    bmad_personas:
      - name: qa
        file: .bmad-core/agents/qa.md
    responsibilities:
      - test_strategy
      - test_case_design
      - coverage_analysis

  developer:
    bmad_personas:
      - name: dev
        file: .bmad-core/agents/dev.md
    responsibilities:
      - code_implementation
      - unit_testing
      - code_review

  security:
    bmad_personas:
      - name: dev
        file: .bmad-core/agents/dev.md
        focus: security
    responsibilities:
      - security_review
      - threat_modeling
      - compliance_checking

  devops:
    bmad_personas:
      - name: dev
        file: .bmad-core/agents/dev.md
        focus: infrastructure
    responsibilities:
      - ci_cd_pipeline
      - infrastructure
      - deployment

  documentation:
    bmad_personas:
      - name: analyst
        file: .bmad-core/agents/analyst.md
        focus: documentation
    responsibilities:
      - api_docs
      - user_guides
      - runbooks

  operations:
    bmad_personas: []
    responsibilities:
      - monitoring
      - incident_response
      - performance_analysis
"

    # Create BMAD config with proper integration
    print_step "Creating BMAD configuration..."
    create_file ".bmad/config.yaml" "# BMAD Configuration for ${PROJECT_NAME}

project:
  name: ${PROJECT_NAME}
  type: web-application
  domain: education

bmad:
  version: 4.44.3
  installation_dir: .bmad-core
  ide: claude-code

integration:
  spec_kit: true
  superpowers: true
  ralph: true
  twelve_factors: true

# Agent persona locations
personas:
  analyst: .bmad-core/agents/analyst.md
  architect: .bmad-core/agents/architect.md
  dev: .bmad-core/agents/dev.md
  pm: .bmad-core/agents/pm.md
  po: .bmad-core/agents/po.md
  qa: .bmad-core/agents/qa.md
  sm: .bmad-core/agents/sm.md
  ux-expert: .bmad-core/agents/ux-expert.md
  bmad-master: .bmad-core/agents/bmad-master.md
  bmad-orchestrator: .bmad-core/agents/bmad-orchestrator.md

# Templates
templates:
  story: .bmad-core/templates/story-tmpl.yaml
  project_brief: .bmad-core/templates/project-brief-tmpl.yaml
  prd: .bmad-core/templates/prd-tmpl.yaml
  epic: .bmad-core/templates/epic-tmpl.yaml

# Checklists
checklists:
  architect: .bmad-core/checklists/architect-checklist.md
  pm: .bmad-core/checklists/pm-checklist.md
  po: .bmad-core/checklists/po-master-checklist.md
  story_dod: .bmad-core/checklists/story-dod-checklist.md
  change: .bmad-core/checklists/change-checklist.md
"

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "feat: install and configure BMAD method for ${PROJECT_NAME}" || true
    fi

    print_success "Phase 4 complete!"
}

phase_5_ralph() {
    print_phase 5 "Ralph Wiggum Configuration"

    cd "$PROJECT_DIR"

    # Check for jq dependency
    print_step "Checking for jq (Ralph dependency)..."
    if ! check_command jq; then
        print_warning "jq is required for Ralph Wiggum plugin"
        echo ""
        echo "Install jq:"
        echo "  macOS:  brew install jq"
        echo "  Ubuntu: sudo apt install jq"
        echo "  Windows: Use WSL or install from https://stedolan.github.io/jq/"
        echo ""
        if ! prompt_yes_no "Continue anyway?"; then
            print_info "Install jq and re-run this phase"
            return 1
        fi
    fi

    print_info "Plugin installation will be prompted at the end of setup (Phase 12)"

    # Create Ralph configuration
    print_step "Creating Ralph configuration..."
    create_file ".ralph/config.yaml" "# Ralph Wiggum Configuration for ${PROJECT_NAME}

project:
  name: ${PROJECT_NAME}

defaults:
  max_iterations: 50
  completion_detection: promise

agent_loops:
  orchestrator:
    typical_iterations: 10-20
    completion_promise: COORDINATION_COMPLETE

  requirements:
    typical_iterations: 15-30
    completion_promise: REQUIREMENTS_COMPLETE

  architecture:
    typical_iterations: 10-25
    completion_promise: ARCHITECTURE_COMPLETE

  design:
    typical_iterations: 15-30
    completion_promise: DESIGN_COMPLETE

  test_manager:
    typical_iterations: 20-40
    completion_promise: TESTS_COMPLETE

  developer:
    typical_iterations: 30-50
    completion_promise: IMPLEMENTATION_COMPLETE

  security:
    typical_iterations: 20-40
    completion_promise: SECURITY_CLEAN

  devops:
    typical_iterations: 15-30
    completion_promise: PIPELINE_WORKING

  documentation:
    typical_iterations: 10-25
    completion_promise: DOCS_COMPLETE

  operations:
    typical_iterations: 20-50
    completion_promise: INCIDENT_RESOLVED

safety:
  absolute_max_iterations: 100
  cost_warning_threshold: 50
  require_confirmation_above: 75

logging:
  log_all_iterations: true
  log_directory: .sdlc/ralph-logs/
"

    # Create Ralph prompt templates
    print_step "Creating Ralph prompt templates..."

    create_file ".ralph/prompts/tdd-implementation.md" "# TDD Implementation Loop

## Task
{{task_description}}

## Requirements
- Requirement ID: {{req_id}}
- Acceptance Criteria: {{acceptance_criteria}}

## Process
1. Write a failing test for the next piece of functionality
2. Run the test - confirm it fails (RED)
3. Write minimal code to make the test pass
4. Run the test - confirm it passes (GREEN)
5. Refactor the code while keeping tests green (REFACTOR)
6. Repeat until all acceptance criteria covered
7. Ensure code coverage >= 80%

## Completion Criteria
- All acceptance criteria have passing tests
- Code coverage >= 80%
- No linting errors
- Code is well-refactored

When all criteria met, output: <promise>IMPLEMENTATION_COMPLETE</promise>
"

    create_file ".ralph/prompts/bug-fix.md" "# Bug Fix Loop

## Bug Description
{{bug_description}}

## Steps to Reproduce
{{reproduction_steps}}

## Expected Behavior
{{expected_behavior}}

## Process
1. Write a failing test that reproduces the bug
2. Run the test - confirm it fails
3. Analyze the failure to identify root cause
4. Implement the fix
5. Run the test - confirm it passes
6. Run full test suite - confirm no regressions
7. Document the fix

## Completion Criteria
- New test reproduces the original bug
- Fix makes the test pass
- All existing tests still pass
- No new issues introduced

When all criteria met, output: <promise>BUG_FIXED</promise>
"

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "feat: configure Ralph Wiggum plugin for autonomous execution loops" || true
    fi

    print_success "Phase 5 complete!"
}

phase_6_12factors() {
    print_phase 6 "12 Factors Integration"

    cd "$PROJECT_DIR"

    print_step "Creating 12 Factors configuration..."
    create_file "config/12-factors/factors.yaml" "# Agentic SDLC 12 Factors Configuration
# Project: ${PROJECT_NAME}

project:
  name: \${PROJECT_NAME}
  compliance:
    - GDPR
    - WCAG-2.1-AA

factors:
  factor_1_strategic_mindset:
    description: Intent-driven development with clear specifications
    enforcement:
      - Orchestrator blocks implementation without spec
      - Gate validation checks for specification artifacts

  factor_2_context_scaffolding:
    description: Rich organizational principles and guardrails
    artifacts:
      - .specify/constitution.md
      - CLAUDE.md
      - skills/*/SKILL.md

  factor_3_mission_definition:
    description: Structured specification creation process
    workflow: Elicit -> Structure -> Validate -> Approve

  factor_4_structured_planning:
    description: Multi-step refinement with technical planning
    artifacts:
      - docs/architecture/architecture.md
      - docs/architecture/adrs/

  factor_5_dual_execution_loops:
    description: SYNC/ASYNC execution modes
    sync_mode:
      - Human-in-loop decisions
      - Gate approvals
    async_mode:
      - Parallel task execution
      - Automated testing

  factor_6_the_great_filter:
    description: Quality gates and validation checkpoints
    gates:
      - requirements_complete
      - architecture_approved
      - design_validated
      - tests_designed
      - implementation_complete
      - all_tests_pass
      - security_approved
      - deployment_ready

  factor_7_adaptive_quality_gates:
    description: Flexible QA based on risk level

  factor_8_ai_augmented_testing:
    description: Risk-based intelligent testing

  factor_9_traceability:
    description: End-to-end artifact traceability

  factor_10_continuous_feedback:
    description: Production reality informs specification evolution

  factor_11_security_by_design:
    description: Built-in security practices

  factor_12_team_capability:
    description: Knowledge sharing and continuous improvement
"

    print_step "Creating enforcement rules..."
    create_file "config/12-factors/enforcement.yaml" "# 12 Factors Enforcement Rules
# Project: ${PROJECT_NAME}

enforcement_rules:
  rule_no_code_without_spec:
    factor: 1
    trigger: implementation_start
    condition: '!exists(.specify/spec.md)'
    action: block
    message: 'Factor 1 violation: Cannot start implementation without approved specification'

  rule_constitution_required:
    factor: 2
    trigger: project_init
    condition: '!exists(.specify/constitution.md)'
    action: warn
    message: 'Factor 2: Constitution not defined'

  rule_gate_validation:
    factor: 6
    trigger: phase_transition
    condition: '!gate_validation_passed'
    action: block
    message: 'Factor 6 violation: Gate validation failed'

  rule_traceability_required:
    factor: 9
    trigger: pull_request
    condition: '!has_requirement_reference'
    action: warn
    message: 'Factor 9: PR should reference requirement ID'

  rule_security_review:
    factor: 11
    trigger: code_change
    condition: changes_auth_code || changes_data_handling
    action: require_approval
    approver: security-agent
    message: 'Factor 11: Security review required'
"

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "feat: add 12 Factors configuration for ${PROJECT_NAME}" || true
    fi

    print_success "Phase 6 complete!"
}

phase_7_agents() {
    print_phase 7 "Wiring Your 10 Agents"

    cd "$PROJECT_DIR"

    print_step "Creating agent definition files..."

    # Create agent directories first
    local agents=("orchestrator" "requirements" "architecture" "design" "test-manager" "developer" "security" "devops" "documentation" "operations")

    for agent in "${agents[@]}"; do
        run_or_dry mkdir -p "agents/${agent}"
    done

    # Create fully wired agent definitions with skills and BMAD persona references
    create_file "agents/orchestrator/agent.yaml" "# Orchestrator Agent Definition
agent:
  id: orchestrator
  name: Orchestrator Agent
  project: ${PROJECT_NAME}

description: |
  Coordinates the complete SDLC workflow across all 10 agents, managing phase
  transitions, enforcing gate validations, and ensuring smooth project progression.

responsibilities:
  - workflow_management
  - task_coordination
  - gate_validation
  - conflict_resolution
  - priority_management

frameworks:
  bmad:
    personas:
      - name: bmad-orchestrator
        file: .bmad-core/agents/bmad-orchestrator.md
      - name: sm
        file: .bmad-core/agents/sm.md
  ralph:
    use_cases:
      - workflow-coordination
      - gate-validation
    completion_promise: COORDINATION_COMPLETE
  superpowers:
    skills:
      - orchestration/workflow-management
      - orchestration/task-decomposition
      - orchestration/progress-tracking
      - orchestration/gate-validation
      - orchestration/conflict-resolution
      - orchestration/priority-management
      - orchestration/communication-routing
      - orchestration/risk-assessment

delegation:
  requirements: requirements-agent
  architecture: architecture-agent
  design: design-agent
  test_design: test-manager-agent
  implementation: developer-agent
  testing: test-manager-agent
  security: security-agent
  deployment: devops-agent
  documentation: documentation-agent
  operations: operations-agent
"

    create_file "agents/requirements/agent.yaml" "# Requirements Agent Definition
agent:
  id: requirements
  name: Requirements Agent
  project: ${PROJECT_NAME}

description: |
  Handles requirements elicitation, documentation, and management,
  ensuring clear acceptance criteria and traceability.

responsibilities:
  - requirements_elicitation
  - user_story_writing
  - acceptance_criteria
  - prioritization
  - traceability

frameworks:
  bmad:
    personas:
      - name: analyst
        file: .bmad-core/agents/analyst.md
      - name: pm
        file: .bmad-core/agents/pm.md
  ralph:
    use_cases:
      - requirements-gathering
      - spec-writing
    completion_promise: REQUIREMENTS_COMPLETE
  superpowers:
    skills:
      - requirements/elicitation
      - requirements/user-stories
      - requirements/classification
      - requirements/ambiguity-detection
      - requirements/prioritization
      - requirements/dependency-mapping
      - requirements/change-impact
      - requirements/traceability
      - requirements/acceptance-criteria
      - requirements/nfr-quantification

cross_cutting_collaborations:
  - skill: requirements/change-impact
    collaborators: [test-manager, developer]
    reason: Impact analysis affects test planning and development estimates
"

    create_file "agents/architecture/agent.yaml" "# Architecture Agent Definition
agent:
  id: architecture
  name: Architecture Agent
  project: ${PROJECT_NAME}

description: |
  Designs system architecture, makes technology decisions, and documents
  architectural decisions through ADRs.

responsibilities:
  - system_design
  - technology_selection
  - adr_writing
  - database_design
  - api_architecture

frameworks:
  bmad:
    personas:
      - name: architect
        file: .bmad-core/agents/architect.md
  ralph:
    use_cases:
      - architecture-design
      - technology-evaluation
    completion_promise: ARCHITECTURE_COMPLETE
  superpowers:
    skills:
      - architecture/architecture-pattern-selection
      - architecture/technology-evaluation
      - architecture/database-design
      - architecture/api-architecture
      - architecture/infrastructure-design
      - architecture/security-architecture
      - architecture/scalability-planning
      - architecture/integration-architecture
      - architecture/cost-estimation
      - architecture/adr-writing
      - architecture/diagram-generation
      - architecture/environment-design

cross_cutting_collaborations:
  - skill: architecture/adr-writing
    collaborators: [developer, security]
    reason: Implementation and security decisions need formal ADR documentation
"

    create_file "agents/design/agent.yaml" "# Design Agent Definition
agent:
  id: design
  name: Design Agent
  project: ${PROJECT_NAME}

description: |
  Handles UI/UX design, API contracts, component design, and data flow
  for frontend and integration points.

responsibilities:
  - ui_design
  - api_contracts
  - wireframing
  - component_design
  - state_management

frameworks:
  bmad:
    personas:
      - name: ux-expert
        file: .bmad-core/agents/ux-expert.md
  ralph:
    use_cases:
      - ui-design
      - api-contract-design
    completion_promise: DESIGN_COMPLETE
  superpowers:
    skills:
      - design/module-design
      - design/api-contracts
      - design/ui-ux
      - design/components
      - design/data-flow
      - design/error-handling
      - design/state-management
      - design/integration-design
      - design/validation
      - design/wireframing
"

    create_file "agents/test-manager/agent.yaml" "# Test Manager Agent Definition
agent:
  id: test-manager
  name: Test Manager Agent
  project: ${PROJECT_NAME}

description: |
  Manages test strategy, test case design, coverage analysis, and quality
  assurance.

responsibilities:
  - test_strategy
  - test_case_design
  - coverage_analysis
  - defect_analysis
  - regression_management

frameworks:
  bmad:
    personas:
      - name: qa
        file: .bmad-core/agents/qa.md
  ralph:
    use_cases:
      - test-design
      - coverage-analysis
    completion_promise: TESTS_COMPLETE
  superpowers:
    skills:
      - testing/test-strategy
      - testing/test-case-design
      - testing/test-data
      - testing/coverage-analysis
      - testing/traceability-management
      - testing/impact-analysis
      - testing/prioritization
      - testing/defect-analysis
      - testing/reporting
      - testing/regression-management
      - testing/environment-management
      - testing/performance-test
      - testing/security-test

cross_cutting_collaborations:
  - skill: testing/traceability-management
    collaborators: [requirements]
    reason: Verify requirement coverage and update traceability matrix
  - skill: testing/impact-analysis
    collaborators: [requirements, developer]
    reason: Assess test impacts from requirement or code changes
"

    create_file "agents/developer/agent.yaml" "# Developer Agent Definition
agent:
  id: developer
  name: Developer Agent
  project: ${PROJECT_NAME}

description: |
  Implements features, writes tests, performs code reviews, and handles
  all development tasks.

responsibilities:
  - code_implementation
  - unit_testing
  - code_review
  - bug_fixing
  - refactoring

frameworks:
  bmad:
    personas:
      - name: dev
        file: .bmad-core/agents/dev.md
  ralph:
    use_cases:
      - tdd-implementation
      - bug-fix
      - feature-development
    completion_promise: IMPLEMENTATION_COMPLETE
  superpowers:
    skills:
      - development/code-implementation
      - development/unit-testing
      - development/api-implementation
      - development/database-integration
      - development/frontend-development
      - development/authentication
      - development/integration-implementation
      - development/error-handling
      - development/refactoring
      - development/bug-fixing
      - development/code-review
      - development/code-documentation
      - development/migration-writing
      - development/performance-optimization

cross_cutting_collaborations:
  - skill: development/code-review
    collaborators: [security, architecture]
    reason: Security and architectural compliance reviews
  - skill: development/code-documentation
    collaborators: [documentation]
    reason: Generate API docs from code comments
"

    create_file "agents/security/agent.yaml" "# Security Agent Definition
agent:
  id: security
  name: Security Agent
  project: ${PROJECT_NAME}

description: |
  Ensures security compliance, performs threat modeling, vulnerability scanning,
  and security reviews (GDPR, FERPA aware).

responsibilities:
  - security_review
  - threat_modeling
  - compliance_checking
  - vulnerability_scanning
  - incident_analysis

frameworks:
  bmad:
    personas:
      - name: dev
        file: .bmad-core/agents/dev.md
        focus: security
  ralph:
    use_cases:
      - security-audit
      - threat-modeling
    completion_promise: SECURITY_CLEAN
  superpowers:
    skills:
      - security/security-architecture-review
      - security/threat-modeling
      - security/vulnerability-scanning
      - security/dependency-auditing
      - security/code-security-review
      - security/authentication-testing
      - security/authorization-testing
      - security/input-validation-testing
      - security/security-configuration
      - security/compliance-checking
      - security/penetration-testing
      - security/security-reporting
      - security/incident-analysis

cross_cutting_collaborations:
  - skill: security/code-security-review
    collaborators: [developer]
    reason: Security guidance during auth/data handling implementation

compliance:
  - GDPR
  - FERPA
  - OWASP-Top-10
"

    create_file "agents/devops/agent.yaml" "# DevOps Agent Definition
agent:
  id: devops
  name: DevOps Agent
  project: ${PROJECT_NAME}

description: |
  Manages CI/CD pipelines, infrastructure, deployment, and operational tooling.

responsibilities:
  - ci_cd_pipeline
  - infrastructure
  - deployment
  - containerization
  - monitoring_setup

frameworks:
  bmad:
    personas:
      - name: dev
        file: .bmad-core/agents/dev.md
        focus: infrastructure
  ralph:
    use_cases:
      - pipeline-setup
      - deployment
    completion_promise: PIPELINE_WORKING
  superpowers:
    skills:
      - devops/cicd-pipeline
      - devops/containerization
      - devops/infrastructure-as-code
      - devops/deployment-strategy
      - devops/environment-configuration
      - devops/database-operations
      - devops/monitoring-setup
      - devops/log-management
      - devops/auto-scaling
      - devops/load-balancing
      - devops/ssl-management
      - devops/backup-recovery
      - devops/performance-tuning
      - devops/cost-optimization
"

    create_file "agents/documentation/agent.yaml" "# Documentation Agent Definition
agent:
  id: documentation
  name: Documentation Agent
  project: ${PROJECT_NAME}

description: |
  Creates and maintains all documentation including API docs, user guides,
  runbooks, and architectural documentation.

responsibilities:
  - api_docs
  - user_guides
  - runbooks
  - architecture_docs
  - onboarding_docs

frameworks:
  bmad:
    personas:
      - name: analyst
        file: .bmad-core/agents/analyst.md
        focus: documentation
  ralph:
    use_cases:
      - documentation-generation
      - api-doc-update
    completion_promise: DOCS_COMPLETE
  superpowers:
    skills:
      - documentation/technical-writing
      - documentation/api-documentation
      - documentation/code-documentation
      - documentation/user-guides
      - documentation/architecture-documentation
      - documentation/runbook-writing
      - documentation/changelog-management
      - documentation/onboarding-documentation
      - documentation/compliance-documentation
      - documentation/diagram-creation

cross_cutting_collaborations:
  - skill: documentation/api-documentation
    collaborators: [developer, design]
    reason: API implementation and OpenAPI spec changes require doc updates
"

    create_file "agents/operations/agent.yaml" "# Operations Agent Definition
agent:
  id: operations
  name: Operations Agent
  project: ${PROJECT_NAME}

description: |
  Handles production monitoring, incident response, capacity planning,
  and operational excellence.

responsibilities:
  - monitoring
  - incident_response
  - performance_analysis
  - capacity_planning
  - sla_management

frameworks:
  bmad:
    personas: []
    # No direct BMAD persona - uses dev.md with ops focus when needed
  ralph:
    use_cases:
      - incident-response
      - performance-analysis
    completion_promise: INCIDENT_RESOLVED
  superpowers:
    skills:
      - operations/system-monitoring
      - operations/alerting-management
      - operations/incident-response
      - operations/capacity-planning
      - operations/sla-management
      - operations/security-monitoring
      - operations/performance-monitoring
      - operations/log-analysis
      - operations/availability-management
      - operations/change-management
      - operations/disaster-recovery
      - operations/reporting
"

    # Create agent protocol
    print_step "Creating agent communication protocol..."
    create_file "agents/PROTOCOL.md" "# Agent Communication Protocol

## Message Format
All inter-agent communication uses this structure:

\`\`\`json
{
  \"from\": \"agent-id\",
  \"to\": \"agent-id\",
  \"type\": \"request|response|notification\",
  \"priority\": \"critical|high|medium|low\",
  \"payload\": {},
  \"context\": {
    \"task_id\": \"string\",
    \"phase\": \"string\",
    \"requirement_id\": \"string\"
  }
}
\`\`\`

## Escalation Rules
1. Blockers -> Orchestrator
2. Security issues -> Security Agent
3. Requirement clarifications -> Requirements Agent
4. Architecture decisions -> Architecture Agent
"

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "feat: create agent definitions and communication protocol" || true
    fi

    print_success "Phase 7 complete!"
}

phase_8_skills() {
    print_phase 8 "Creating Your 116 Skills"

    cd "$PROJECT_DIR"

    print_step "Running skill population script..."

    if [[ -f "${CONTENT_DIR}/populate-skills.py" ]] && [[ -f "${CONTENT_DIR}/all-skills-content.md" ]]; then
        if prompt_yes_no "Populate 116 skills from content file?"; then
            if [[ "$DRY_RUN" == true ]]; then
                python3 "${CONTENT_DIR}/populate-skills.py" \
                    --content-dir "${CONTENT_DIR}" \
                    --skills-dir "${PROJECT_DIR}/skills" \
                    --dry-run \
                    --verify-ownership
            else
                python3 "${CONTENT_DIR}/populate-skills.py" \
                    --content-dir "${CONTENT_DIR}" \
                    --skills-dir "${PROJECT_DIR}/skills" \
                    --verify-ownership
            fi
        else
            print_info "Skipping skill population - you can run it later with:"
            echo "  python3 ${CONTENT_DIR}/populate-skills.py --content-dir ${CONTENT_DIR} --skills-dir ${PROJECT_DIR}/skills"
        fi
    else
        print_warning "Skill content files not found"
        print_info "Expected files:"
        echo "  - ${CONTENT_DIR}/populate-skills.py"
        echo "  - ${CONTENT_DIR}/all-skills-content.md"

        if prompt_yes_no "Create placeholder skill directories?"; then
            local categories=("orchestration" "requirements" "architecture" "design" "testing" "development" "security" "devops" "documentation" "operations")
            for cat in "${categories[@]}"; do
                run_or_dry mkdir -p "skills/${cat}"
            done
            print_success "Created skill category directories"
        fi
    fi

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "feat: populate 116 skills with ownership pattern" || true
    fi

    print_success "Phase 8 complete!"
}

phase_9_orchestrator() {
    print_phase 9 "Orchestrator Configuration"

    cd "$PROJECT_DIR"

    print_step "Creating orchestrator configuration..."
    create_file "agents/orchestrator/orchestrator.yaml" "# Orchestrator Main Configuration

orchestrator:
  project: \${PROJECT_NAME}

workflow:
  phases:
    - requirements
    - architecture
    - design
    - test_design
    - implementation
    - testing
    - security_review
    - deployment
    - operations

gates:
  requirements:
    required:
      - spec_document_exists
      - acceptance_criteria_defined
      - user_journeys_mapped
    approver: human

  architecture:
    required:
      - architecture_document_exists
      - adrs_written
      - database_schema_defined
    approver: human

  implementation:
    required:
      - all_tests_pass
      - coverage_minimum_met
      - code_review_approved
    approver: developer

delegation:
  requirements: requirements-agent
  architecture: architecture-agent
  design: design-agent
  test_design: test-manager-agent
  implementation: developer-agent
  testing: test-manager-agent
  security: security-agent
  deployment: devops-agent
  documentation: documentation-agent
  operations: operations-agent
"

    print_step "Creating orchestrator commands reference..."
    create_file "agents/orchestrator/commands.md" "# Orchestrator Commands

## Workflow Commands
\`\`\`
/orchestrate start <feature>     # Start new feature workflow
/orchestrate status              # Show current workflow state
/orchestrate gate <phase>        # Run gate validation
/orchestrate delegate <agent>    # Delegate to specific agent
/orchestrate escalate            # Escalate to human
\`\`\`

## Spec Kit Integration
\`\`\`
/orchestrate specify             # -> /speckit.specify
/orchestrate plan                # -> /speckit.plan
/orchestrate tasks               # -> /speckit.tasks
/orchestrate implement           # -> /speckit.implement
\`\`\`

## BMAD Integration
\`\`\`
/orchestrate bmad analyst        # Activate BMAD analyst
/orchestrate bmad architect      # Activate BMAD architect
/orchestrate bmad dev            # Activate BMAD developer
\`\`\`

## Ralph Integration
\`\`\`
/ralph-loop \"<task>\" --max-iterations <n> --completion-promise \"<promise>\"
/cancel-ralph
\`\`\`
"

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "feat: configure orchestrator with workflow and gates" || true
    fi

    print_success "Phase 9 complete!"
}

phase_10_testing() {
    print_phase 10 "Testing the Integration"

    cd "$PROJECT_DIR"

    print_step "Creating integration test script..."
    create_file "scripts/verify-setup.sh" '#!/bin/bash
# Verify SDLC Framework Setup

echo "========================================"
echo "SDLC Framework Setup Verification"
echo "========================================"

errors=0

# Check directories
echo ""
echo "1. Checking directories..."
dirs=(".specify" ".bmad" ".bmad-core" ".ralph" ".sdlc" "agents" "skills" "docs" "config")
for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "   ✅ $dir exists"
    else
        echo "   ❌ $dir missing"
        ((errors++))
    fi
done

# Check BMAD installation
echo ""
echo "2. Checking BMAD installation..."
if [ -d ".bmad-core/agents" ]; then
    bmad_agents=$(ls -1 .bmad-core/agents/*.md 2>/dev/null | wc -l)
    echo "   Found $bmad_agents BMAD agent personas"
    if [ "$bmad_agents" -ge 8 ]; then
        echo "   ✅ BMAD agents installed"
    else
        echo "   ⚠️  Expected 8+ BMAD agents, found $bmad_agents"
    fi
else
    echo "   ❌ .bmad-core/agents not found - BMAD not installed"
    ((errors++))
fi

if [ -f ".bmad-core/install-manifest.yaml" ]; then
    echo "   ✅ BMAD install manifest found"
else
    echo "   ⚠️  BMAD install manifest missing"
fi

# Check key files
echo ""
echo "3. Checking key files..."
files=("CLAUDE.md" ".specify/constitution.md" "config/spec-kit/workflow.yaml" "config/bmad/agent-mapping.yaml" ".ralph/config.yaml" "config/12-factors/factors.yaml")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✅ $file exists"
    else
        echo "   ❌ $file missing"
        ((errors++))
    fi
done

# Check agents
echo ""
echo "4. Checking agent definitions..."
agents=("orchestrator" "requirements" "architecture" "design" "test-manager" "developer" "security" "devops" "documentation" "operations")
for agent in "${agents[@]}"; do
    if [ -d "agents/$agent" ]; then
        echo "   ✅ agents/$agent exists"
    else
        echo "   ❌ agents/$agent missing"
        ((errors++))
    fi
done

# Check skills
echo ""
echo "5. Checking skills..."
skill_count=$(find skills -name "SKILL.md" 2>/dev/null | wc -l)
echo "   Found $skill_count skill files"
if [ "$skill_count" -ge 100 ]; then
    echo "   ✅ Skills populated"
else
    echo "   ⚠️  Expected ~116 skills, found $skill_count"
fi

# Check skill wiring in agents
echo ""
echo "6. Checking skill wiring in agents..."
wired_agents=0
for agent in "${agents[@]}"; do
    if [ -f "agents/$agent/agent.yaml" ]; then
        skill_refs=$(grep -c "skills:" "agents/$agent/agent.yaml" 2>/dev/null || echo "0")
        skill_lines=$(grep -A 20 "superpowers:" "agents/$agent/agent.yaml" 2>/dev/null | grep -c "      - " || echo "0")
        if [ "$skill_lines" -gt 0 ]; then
            echo "   ✅ agents/$agent has $skill_lines skills wired"
            ((wired_agents++))
        else
            echo "   ❌ agents/$agent has no skills wired"
            ((errors++))
        fi
    fi
done
if [ "$wired_agents" -eq 10 ]; then
    echo "   ✅ All agents have skills wired"
else
    echo "   ⚠️  Only $wired_agents/10 agents have skills wired"
fi

# Check BMAD persona wiring in agents
echo ""
echo "7. Checking BMAD persona wiring in agents..."
bmad_wired=0
for agent in "${agents[@]}"; do
    if [ -f "agents/$agent/agent.yaml" ]; then
        if grep -q "personas:" "agents/$agent/agent.yaml" 2>/dev/null; then
            persona_count=$(grep -A 10 "bmad:" "agents/$agent/agent.yaml" 2>/dev/null | grep -c "file:" || echo "0")
            if [ "$persona_count" -gt 0 ]; then
                echo "   ✅ agents/$agent has $persona_count BMAD persona(s) linked"
                ((bmad_wired++))
            else
                echo "   ⚠️  agents/$agent has personas key but no files linked"
            fi
        else
            echo "   ⚠️  agents/$agent uses old bmad.agents format (not personas)"
        fi
    fi
done
echo "   $bmad_wired/10 agents have BMAD personas wired"

# Summary
echo ""
echo "========================================"
if [ $errors -eq 0 ]; then
    echo "✅ All checks passed!"
else
    echo "❌ Found $errors issues"
fi
echo "========================================"

exit $errors
'

    run_or_dry chmod +x "scripts/verify-setup.sh"

    if prompt_yes_no "Run verification script now?"; then
        echo ""
        if [[ "$DRY_RUN" != true ]]; then
            bash scripts/verify-setup.sh || true
        else
            print_info "[DRY RUN] Would run: bash scripts/verify-setup.sh"
        fi
    fi

    # Create initial workflow state
    print_step "Creating initial workflow state..."
    create_file ".sdlc/workflow-state.json" '{
  "project": "'${PROJECT_NAME}'",
  "current_phase": "setup",
  "phases_completed": ["initialization"],
  "gates_passed": [],
  "active_tasks": [],
  "blockers": [],
  "created_at": "'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'",
  "updated_at": "'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'"
}'

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "feat: add integration test script and initial workflow state" || true
    fi

    print_success "Phase 10 complete!"
}

phase_11_production() {
    print_phase 11 "Production Workflow"

    cd "$PROJECT_DIR"

    print_step "Final setup steps..."

    # Create README
    create_file "README.md" "# ${PROJECT_NAME}

[TODO: Add project description]

## Quick Start

\`\`\`bash
# Clone and setup
git clone <repo-url>
cd ${PROJECT_NAME}
cp .env.example .env
# Edit .env with your configuration

# Start development
npm install  # or pip install -r requirements.txt
npm run dev
\`\`\`

## SDLC Framework

This project uses a 10-agent SDLC framework. See [CLAUDE.md](CLAUDE.md) for details.

### Available Commands (in Claude Code)

| Command | Description |
|---------|-------------|
| \`/orchestrate\` | Start task coordination |
| \`/specify\` | Capture requirements |
| \`/plan\` | Create implementation plan |
| \`/implement\` | Execute implementation |
| \`/ralph-loop\` | Autonomous execution |

## Project Structure

\`\`\`
├── agents/          # 10 agent definitions
├── skills/          # 116 skill templates
├── .specify/        # Spec Kit artifacts
├── .bmad/           # BMAD configuration
├── .ralph/          # Ralph loop configuration
├── docs/            # Documentation
├── src/             # Source code
└── tests/           # Test suites
\`\`\`

## Documentation

- [Architecture](docs/architecture/)
- [API Documentation](docs/api/)
- [User Guide](docs/user-guide/)

## License

[Your License]
"

    if [[ "$DRY_RUN" != true ]]; then
        git add -A
        git commit -m "docs: add README and finalize project setup" || true
    fi

    print_success "Phase 11 complete!"
}

phase_12_plugins() {
    print_phase 12 "Plugin Installation"

    cd "$PROJECT_DIR"

    print_header "Claude Code Plugin Installation"

    echo -e "${BOLD}The following plugins enhance the SDLC framework:${NC}"
    echo ""
    echo "  1. ${CYAN}Ralph Wiggum${NC} - Autonomous execution loops"
    echo "     Commands: /ralph-loop, /cancel-ralph"
    echo ""

    prompt_manual_step "Install Claude Code Plugins" "
${BOLD}In Claude Code, run the following commands:${NC}

${CYAN}1. Install Ralph Wiggum Plugin:${NC}
   /plugin marketplace add https://github.com/anthropics/claude-code
   /plugin install ralph-wiggum

${CYAN}2. Verify installation:${NC}
   /help

${BOLD}You should see these commands available:${NC}
   - /ralph-loop \"<task>\" --max-iterations <n> --completion-promise \"<done>\"
   - /cancel-ralph

${YELLOW}Note: You may need to restart Claude Code after installation.${NC}
"

    print_header "Setup Complete!"

    echo -e "
${GREEN}${PROJECT_NAME} SDLC Framework has been set up!${NC}

${BOLD}Project Location:${NC} ${PROJECT_DIR}

${BOLD}What was configured:${NC}
  - 10 agents with skills wired (116 total skills)
  - Spec Kit workflow integration
  - BMAD agent personas
  - Ralph Wiggum autonomous loops
  - 12 Factors enforcement rules

${BOLD}Next Steps:${NC}
1. Review and customize CLAUDE.md
2. Update .env with your API keys
3. Start Claude Code and run: ${CYAN}/orchestrate status${NC}
4. Begin with: ${CYAN}/orchestrate specify${NC}

${BOLD}Useful Commands:${NC}
  cd ${PROJECT_DIR}
  ./scripts/verify-setup.sh    # Verify setup
  git log --oneline            # See setup commits

${BOLD}Documentation:${NC}
  - Implementation Guide: ${SCRIPT_DIR}/
  - Skills Content: ${SCRIPT_DIR}/all-skills-content.md
"

    print_success "Phase 12 complete! Happy coding!"
}

# =============================================================================
# Main Execution
# =============================================================================

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --phase)
                START_PHASE="$2"
                shift 2
                ;;
            --skip-to)
                START_PHASE="$2"
                shift 2
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --project-dir)
                PROJECT_DIR="$2"
                PROJECT_NAME="$(basename "${PROJECT_DIR}")"
                shift 2
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --phase N       Start from phase N"
                echo "  --skip-to N     Skip to phase N"
                echo "  --dry-run       Show what would be done without making changes"
                echo "  --project-dir   Override project directory"
                echo "  --help          Show this help message"
                echo ""
                echo "Phases:"
                echo "  1  - Foundation Setup"
                echo "  2  - Spec Kit Installation"
                echo "  3  - Obra Superpowers Installation"
                echo "  4  - BMAD Method Installation"
                echo "  5  - Ralph Wiggum Configuration"
                echo "  6  - 12 Factors Integration"
                echo "  7  - Wiring Your 10 Agents (with skills)"
                echo "  8  - Creating Your 116 Skills"
                echo "  9  - Orchestrator Configuration"
                echo "  10 - Testing the Integration"
                echo "  11 - Production Workflow"
                echo "  12 - Plugin Installation (final step)"
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
}

main() {
    parse_args "$@"

    print_header "${PROJECT_NAME} SDLC Framework Setup"

    if [[ "$DRY_RUN" == true ]]; then
        print_warning "DRY RUN MODE - No changes will be made"
    fi

    echo -e "Project directory: ${BOLD}${PROJECT_DIR}${NC}"
    echo -e "Starting from phase: ${BOLD}${START_PHASE}${NC}"
    echo ""

    if ! prompt_yes_no "Continue with setup?"; then
        print_info "Setup cancelled"
        exit 0
    fi

    # Run phases
    local phases=(
        "phase_1_foundation"
        "phase_2_spec_kit"
        "phase_3_superpowers"
        "phase_4_bmad"
        "phase_5_ralph"
        "phase_6_12factors"
        "phase_7_agents"
        "phase_8_skills"
        "phase_9_orchestrator"
        "phase_10_testing"
        "phase_11_production"
        "phase_12_plugins"
    )

    for i in "${!phases[@]}"; do
        local phase_num=$((i + 1))
        if [[ $phase_num -ge $START_PHASE ]]; then
            ${phases[$i]}

            if [[ $phase_num -lt 12 ]]; then
                if ! prompt_yes_no "Continue to next phase?"; then
                    print_info "Setup paused at phase $phase_num"
                    print_info "Resume with: $0 --phase $((phase_num + 1))"
                    exit 0
                fi
            fi
        fi
    done
}

# Run main
main "$@"

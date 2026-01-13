# Complete SDLC Agent Framework Implementation Guide
## For StudyAbroad-v1 Project
### Framework Location: ~/projects/studyabroad-v1

---

## Table of Contents

1. [Overview & Architecture](#1-overview--architecture)
2. [Prerequisites](#2-prerequisites)
3. [Phase 1: Foundation Setup](#3-phase-1-foundation-setup)
4. [Phase 2: Spec Kit Installation & Configuration](#4-phase-2-spec-kit-installation--configuration)
5. [Phase 3: Obra Superpowers Installation & Custom Skills](#5-phase-3-obra-superpowers-installation--custom-skills)
6. [Phase 4: BMAD Method Installation & Agent Mapping](#6-phase-4-bmad-method-installation--agent-mapping)
7. [Phase 5: Ralph Wiggum Plugin Installation](#7-phase-5-ralph-wiggum-plugin-installation)
8. [Phase 6: 12 Factors Integration](#8-phase-6-12-factors-integration)
9. [Phase 7: Wiring Your 10 Agents](#9-phase-7-wiring-your-10-agents)
10. [Phase 8: Creating Your 116 Skills](#10-phase-8-creating-your-116-skills)
11. [Phase 9: Orchestrator Configuration](#11-phase-9-orchestrator-configuration)
12. [Phase 10: Testing the Integration](#12-phase-10-testing-the-integration)
13. [Phase 11: Production Workflow](#13-phase-11-production-workflow)
14. [Appendix: Reusing for Other Projects](#14-appendix-reusing-for-other-projects)

---

## 1. Overview & Architecture

### Your Project Structure (Option A: Framework Inside Project)

```
~/projects/studyabroad-v1/
├── CLAUDE.md                    # Root config (Claude reads this)
├── .gitignore
├── .env
│
├── .specify/                    # Spec Kit
├── .bmad/                       # BMAD Method (agent personas)
├── .ralph/                      # Ralph Wiggum (autonomous loops)
├── .sdlc/                       # Workflow state
│
├── agents/                      # Your 10 agent definitions
├── skills/                      # Your 116 skills
├── config/                      # Framework configuration
│
├── docs/                        # Project documentation
│   ├── requirements/
│   ├── architecture/
│   ├── design/
│   └── testing/
│
└── src/                         # Your actual StudyAbroad app code
    ├── frontend/
    ├── backend/
    ├── database/
    └── ...
```

### Target Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         YOUR ORCHESTRATOR AGENT                              │
│                    (Coordinates all 10 agents)                               │
│         Skills: ORCH-001 to ORCH-008 (Workflow, Gates, Routing)             │
└─────────────────────────────────────────────────────────────────────────────┘
         │
         ├──────────┬──────────┬──────────┬──────────┬──────────┬──────────┐
         ▼          ▼          ▼          ▼          ▼          ▼          ▼
    ┌─────────┐┌─────────┐┌─────────┐┌─────────┐┌─────────┐┌─────────┐┌─────────┐
    │Requirements││Architecture││ Design  ││  Test   ││Developer││Security ││  DevOps │
    │  Agent  ││  Agent  ││  Agent  ││ Manager ││  Agent  ││  Agent  ││  Agent  │
    └─────────┘└─────────┘└─────────┘└─────────┘└─────────┘└─────────┘└─────────┘
         │          │          │          │          │          │          │
         └──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
                                        │
                              ┌─────────┴─────────┐
                              ▼                   ▼
                        ┌──────────┐        ┌──────────┐
                        │   Docs   │        │Operations│
                        │  Agent   │        │  Agent   │
                        └──────────┘        └──────────┘
```

### Agent-to-Framework Mapping

| Your Agent | Primary Framework | Secondary Framework | Execution Mode |
|------------|-------------------|---------------------|----------------|
| 1. Orchestrator | Custom + 12 Factors | Spec Kit workflow | Ralph loops for complex coordination |
| 2. Requirements | Spec Kit (specify) | BMAD Analyst | Ralph loops for iterative elicitation |
| 3. Architecture | BMAD Architect | Spec Kit (plan) | Ralph loops for design refinement |
| 4. Design | BMAD Designer/UX | Custom skills | Ralph loops for iterative design |
| 5. Test Manager | BMAD QA + SM | Superpowers TDD | Ralph loops for test-until-pass |
| 6. Developer | BMAD Dev | Superpowers coder | Ralph loops for TDD implementation |
| 7. Security | BMAD Security | Custom security skills | Ralph loops for vulnerability fixes |
| 8. DevOps | BMAD DevOps | Custom CI/CD skills | Ralph loops for pipeline fixes |
| 9. Documentation | BMAD Tech Writer | Custom doc skills | Ralph loops for doc completion |
| 10. Operations | Custom | Superpowers debugging | Ralph loops for incident resolution |

### Framework Responsibilities

| Framework | Purpose | When Used |
|-----------|---------|-----------|
| **Spec Kit** | Specification-driven development | Requirements, planning phases |
| **BMAD Method** | Agent persona specialization | Role-based task execution |
| **Ralph Wiggum** | Autonomous iteration loops | Complex tasks requiring refinement |
| **Superpowers** | Engineering discipline skills | TDD, debugging, code review |
| **12 Factors** | Strategic principles & gates | Quality enforcement throughout |

---

## 2. Prerequisites

### Required Software

```bash
# 1. Node.js (v18+)
node --version  # Should be 18.x or higher

# 2. Python (3.10+)
python3 --version

# 3. Git
git --version

# 4. Claude Code CLI
npm install -g @anthropic-ai/claude-code

# 5. UV (Python package manager - for Spec Kit)
curl -LsSf https://astral.sh/uv/install.sh | sh

# 6. tmux (optional, for dashboards)
# macOS: brew install tmux
# Ubuntu: sudo apt install tmux
```

### Verify Your Project Directory

```bash
# Navigate to your project
cd ~/projects/studyabroad-v1

# Check current contents (if any)
ls -la

# If project doesn't exist yet, create it
mkdir -p ~/projects/studyabroad-v1
cd ~/projects/studyabroad-v1
```

---

## 3. Phase 1: Foundation Setup

### Step 1.1: Initialize or Prepare Git Repository

```bash
cd ~/projects/studyabroad-v1

# If not already a git repo, initialize
git init
git branch -m main

# Create/update .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
__pycache__/
*.pyc
venv/
.venv/

# Environment
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Claude
.claude/

# Build outputs
dist/
build/
*.log

# Database
*.sqlite
*.db

# SDLC State (keep structure, ignore state files)
.sdlc/*.json
!.sdlc/.gitkeep

# Test outputs
coverage/
.nyc_output/
EOF

git add .gitignore
git commit -m "chore: update .gitignore for SDLC framework"
```

### Step 1.2: Create Directory Structure

```bash
cd ~/projects/studyabroad-v1

# Create SDLC framework directories
mkdir -p {config,agents,skills,workflows,templates}
mkdir -p agents/{orchestrator,requirements,architecture,design,test-manager,developer,security,devops,documentation,operations}
mkdir -p skills/{orchestration,requirements,architecture,design,testing,development,security,devops,documentation,operations}
mkdir -p config/{spec-kit,bmad,ralph,superpowers,12-factors}

# Create documentation directories
mkdir -p docs/{requirements,architecture,design,testing,runbooks}

# Create source code directories (adjust based on your stack)
mkdir -p src/{frontend,backend,database}

# Create SDLC state directory
mkdir -p .sdlc
touch .sdlc/.gitkeep

# Create scripts directory
mkdir -p scripts
```

### Step 1.3: Create Base CLAUDE.md

This is the root configuration that Claude Code reads:

```bash
cat > CLAUDE.md << 'EOF'
# StudyAbroad-v1 - SDLC Agent Framework Configuration

## Project Overview
StudyAbroad-v1 is a web application with:
- User accounts and profile management
- User journeys for study abroad planning
- API integrations with external services
- Persistent database storage

This project uses a 10-agent SDLC framework with 116 skills, integrating:
- GitHub Spec Kit (spec-driven development)
- Agentic SDLC 12 Factors (strategic principles)
- Obra Superpowers (engineering discipline skills)
- BMAD Method (specialized agent personas)
- Ralph Wiggum Plugin (autonomous execution loops)

## Agent System
This project uses a multi-agent architecture with the following agents:
1. **Orchestrator** - Central coordinator (ORCH-001 to ORCH-008)
2. **Requirements** - Requirements capture (REQ-001 to REQ-010)
3. **Architecture** - System design (ARCH-001 to ARCH-012)
4. **Design** - Detailed design (DES-001 to DES-010)
5. **Test Manager** - Test orchestration (TEST-001 to TEST-013)
6. **Developer** - Implementation (DEV-001 to DEV-014)
7. **Security** - Security review (SEC-001 to SEC-013)
8. **DevOps** - CI/CD & deployment (OPS-001 to OPS-014)
9. **Documentation** - All documentation (DOC-001 to DOC-010)
10. **Operations** - Production monitoring (MON-001 to MON-012)

## Development Standards
- Always use TDD (red-green-refactor)
- Follow Conventional Commits
- Maintain 80%+ code coverage
- Security scanning on every PR
- Documentation required for all features

## Skill Locations
- Orchestration skills: ./skills/orchestration/
- Requirements skills: ./skills/requirements/
- Architecture skills: ./skills/architecture/
- Design skills: ./skills/design/
- Testing skills: ./skills/testing/
- Development skills: ./skills/development/
- Security skills: ./skills/security/
- DevOps skills: ./skills/devops/
- Documentation skills: ./skills/documentation/
- Operations skills: ./skills/operations/

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

Use Ralph loops for complex tasks requiring iteration:
- TDD implementation (iterate until tests pass)
- Bug fixing (iterate until issue resolved)
- Documentation completion (iterate until comprehensive)
- Integration testing (iterate until all APIs working)

## Source Code Structure
- Frontend: ./src/frontend/
- Backend: ./src/backend/
- Database: ./src/database/
- Documentation: ./docs/

## 12 Factors Compliance
All agent actions must comply with the Agentic SDLC 12 Factors:
- Factor I: Strategic Mindset
- Factor II: Context Scaffolding
- Factor III: Mission Definition
- Factor IV: Structured Planning
- Factor V: Dual Execution Loops
- Factor VI: The Great Filter
- Factor VII: Adaptive Quality Gates
- Factor VIII: AI-Augmented Testing
- Factor IX: Traceability
- Factor X: Continuous Feedback
- Factor XI: Security by Design
- Factor XII: Team Capability
EOF

git add CLAUDE.md
git commit -m "chore: add root CLAUDE.md configuration for StudyAbroad-v1"
```

### Step 1.4: Create Environment Configuration

```bash
cat > .env.example << 'EOF'
# StudyAbroad-v1 Environment Configuration

# Claude API (if needed for programmatic access)
ANTHROPIC_API_KEY=your_api_key_here

# Project Settings
PROJECT_NAME=studyabroad-v1
ENVIRONMENT=development

# Agent Configuration
MAX_CONCURRENT_AGENTS=5
AGENT_TIMEOUT_SECONDS=300

# Database
DATABASE_URL=postgresql://localhost:5432/studyabroad

# Authentication (OAuth2)
OAUTH_CLIENT_ID=your_client_id
OAUTH_CLIENT_SECRET=your_client_secret
OAUTH_REDIRECT_URI=http://localhost:3000/auth/callback

# External APIs (Study Abroad Services)
UNIVERSITY_API_KEY=your_university_api_key
VISA_SERVICE_API_KEY=your_visa_api_key
HOUSING_API_KEY=your_housing_api_key

# Email Service
SMTP_HOST=smtp.example.com
SMTP_PORT=587
SMTP_USER=your_email
SMTP_PASS=your_password
EOF
```

---

## 4. Phase 2: Spec Kit Installation & Configuration

### Step 2.1: Install Spec Kit

```bash
# Install Spec Kit CLI
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Verify installation
specify --version
```

### Step 2.2: Initialize Spec Kit in Your Project

```bash
cd ~/projects/studyabroad-v1

# Initialize with Claude as the AI agent
specify init . --ai claude --here

# This creates:
# - .specify/ directory with templates
# - .github/agents/ with Spec Kit agents (if using GitHub)
```

### Step 2.3: Configure Spec Kit Constitution

The constitution defines immutable principles for StudyAbroad-v1:

```bash
cat > .specify/constitution.md << 'EOF'
# StudyAbroad-v1 Project Constitution

## Core Principles

### 1. Specification First
No code is written without an approved specification. Specifications are living documents that evolve with the project.

### 2. Quality Gates
Every phase transition requires validation:
- Requirements → Architecture: Completeness check
- Architecture → Design: Feasibility review
- Design → Implementation: Test coverage plan
- Implementation → Deployment: All tests pass

### 3. Traceability
Every artifact must trace back to a requirement:
- Code → Test → Design → Architecture → Requirement

### 4. Security by Design
Security is critical for user data:
- Threat modeling during architecture
- Security Agent reviews all phases
- Security tests mandatory
- GDPR compliance for user data

### 5. Test-Driven Development
All implementation follows TDD:
- Write failing test first (RED)
- Implement minimum code to pass (GREEN)
- Refactor for quality (REFACTOR)

## Technology Constraints

### Required Stack (StudyAbroad-v1)
- Frontend: React with TypeScript
- Backend: Node.js with Express or Python with FastAPI
- Database: PostgreSQL
- Authentication: OAuth2/OIDC (Google, University SSO)
- API Style: REST with OpenAPI specification
- Caching: Redis
- File Storage: AWS S3 or equivalent

### Coding Standards
- ESLint/Prettier for JavaScript/TypeScript
- Black/Ruff for Python
- Conventional Commits for git messages
- Minimum 80% test coverage

### Security Requirements
- OWASP Top 10 compliance
- Input validation on all endpoints
- Secrets in environment variables only
- HTTPS enforced
- PII encryption at rest
- GDPR compliance for EU users
- Session management with secure cookies

### External Integrations
- University database APIs
- Visa service providers
- Housing/accommodation services
- Payment processing (if applicable)
- Email service provider

## Agent Governance

### Decision Authority
- Requirements Agent: Owns requirement specifications
- Architecture Agent: Owns technical decisions (with ADRs)
- Test Manager: Owns test strategy and coverage
- Security Agent: Can block deployment for security issues
- Orchestrator: Final arbiter of conflicts

### Human Checkpoints
Human approval required for:
- Phase gate transitions
- Architecture decisions
- Security sign-offs
- Production deployments
- External API integration decisions
- User data schema changes
EOF
```

### Step 2.4: Create Spec Kit Templates

```bash
# Requirements template
cat > .specify/templates/requirement.md << 'EOF'
# Requirement: {{REQ_ID}}

## Summary
{{Brief description}}

## Type
- [ ] Functional
- [ ] Non-Functional
- [ ] Constraint

## User Story
**As a** {{persona - e.g., prospective study abroad student}}
**I want to** {{goal}}
**So that** {{benefit}}

## Acceptance Criteria
- [ ] Given {{context}}, when {{action}}, then {{outcome}}
- [ ] Given {{context}}, when {{action}}, then {{outcome}}

## Priority
- [ ] Must Have
- [ ] Should Have
- [ ] Could Have
- [ ] Won't Have (this release)

## Dependencies
- Depends on: {{REQ_IDs}}
- Blocks: {{REQ_IDs}}

## Traceability
- Design: {{DES_ID}}
- Test Cases: {{TEST_IDs}}
- Code: {{file paths}}

## StudyAbroad-Specific Context
- User Journey Stage: {{discovery/application/preparation/abroad/return}}
- External APIs Required: {{list}}
- Data Privacy Considerations: {{GDPR, etc.}}
EOF

# Architecture Decision Record template
cat > .specify/templates/adr.md << 'EOF'
# ADR-{{NUMBER}}: {{TITLE}}

## Status
{{Proposed | Accepted | Deprecated | Superseded}}

## Context
{{What is the issue we're addressing?}}

## Decision
{{What is the change we're proposing?}}

## Consequences

### Positive
- {{benefit}}

### Negative
- {{drawback}}

### Risks
- {{risk and mitigation}}

## Alternatives Considered
1. {{Alternative 1}}: {{Why rejected}}
2. {{Alternative 2}}: {{Why rejected}}

## Related
- Requirements: {{REQ_IDs}}
- ADRs: {{ADR_numbers}}

## StudyAbroad-Specific Impact
- User Data: {{impact on user data handling}}
- External APIs: {{impact on integrations}}
- Performance: {{expected load/scale considerations}}
EOF
```

### Step 2.5: Create Spec Kit Workflow Integration

```bash
cat > config/spec-kit/workflow.yaml << 'EOF'
# Spec Kit Workflow Configuration for StudyAbroad-v1

project:
  name: "StudyAbroad-v1"
  type: "web-application"
  domain: "education/study-abroad"

phases:
  specify:
    description: "Capture and structure requirements"
    agent: requirements-agent
    inputs:
      - user_brief
      - stakeholder_interviews
      - competitor_analysis
    outputs:
      - requirements_spec.md
      - user_stories.json
      - nfr_matrix.md
      - user_journey_maps.md
    validation:
      - completeness_check
      - ambiguity_detection
      - gdpr_compliance_check
    gate:
      requires_human_approval: true
      
  plan:
    description: "Create technical architecture and plan"
    agent: architecture-agent
    inputs:
      - requirements_spec.md
    outputs:
      - architecture.md
      - tech_stack_decision.md
      - adrs/
      - database_schema.sql
      - api_integration_plan.md
    validation:
      - requirements_coverage
      - security_review
      - scalability_review
    gate:
      requires_human_approval: true
      
  design:
    description: "Detailed design and API contracts"
    agent: design-agent
    inputs:
      - architecture.md
      - requirements_spec.md
    outputs:
      - openapi_spec.yaml
      - module_designs/
      - wireframes/
      - error_taxonomy.md
      - user_flow_diagrams/
    validation:
      - api_contract_review
      - ui_coverage_check
      - accessibility_review
    gate:
      requires_human_approval: false
      
  tasks:
    description: "Break down into implementation tasks"
    agent: orchestrator-agent
    inputs:
      - all_design_artifacts
    outputs:
      - task_breakdown.json
      - dependency_graph.json
      - sprint_plan.md
    validation:
      - task_completeness
      - dependency_check
    gate:
      requires_human_approval: false
      
  implement:
    description: "Execute implementation with TDD"
    agents:
      - developer-agent
      - test-manager-agent
      - security-agent
    inputs:
      - task_breakdown.json
      - design_artifacts
    outputs:
      - src/frontend/
      - src/backend/
      - src/database/
      - tests/
      - coverage_report.html
    validation:
      - all_tests_pass
      - coverage_threshold_met
      - security_scan_clean
    gate:
      requires_human_approval: true
EOF

git add .specify/ config/spec-kit/
git commit -m "feat: configure Spec Kit with StudyAbroad-v1 templates and workflow"
```

---

## 5. Phase 3: Obra Superpowers Installation & Custom Skills

### Step 5.1: Install Superpowers Plugin

```bash
# Start Claude Code from your project directory
cd ~/projects/studyabroad-v1
claude

# In Claude Code, run:
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace

# Exit and restart Claude Code
exit
claude
```

### Step 5.2: Verify Superpowers Installation

After restart, you should see the bootstrap prompt. Verify with:

```bash
# In Claude Code
/help

# Should show superpowers commands:
# /superpowers:brainstorm
# /superpowers:write-plan
# /superpowers:execute-plan
```

### Step 5.3: Explore Built-in Superpowers Skills

```bash
# The skills are installed at:
ls ~/.claude/plugins/cache/Superpowers/skills/

# Key skill directories:
# - testing/tdd/
# - testing/async-testing/
# - debugging/systematic-debugging/
# - debugging/root-cause-tracing/
# - collaboration/brainstorming/
# - collaboration/write-plan/
# - meta/creating-skills/
```

### Step 5.4: Create Custom Skills Directory Structure

```bash
cd ~/projects/studyabroad-v1

# Create subdirectories for each skill category
mkdir -p skills/orchestration/{workflow-management,task-decomposition,gate-validation,progress-tracking,conflict-resolution,priority-management,communication-routing,risk-assessment}
mkdir -p skills/requirements/{elicitation,user-stories,classification,ambiguity-detection,prioritization,dependency-mapping,change-impact,traceability,acceptance-criteria,nfr-quantification}
mkdir -p skills/architecture/{patterns,technology-evaluation,database-design,api-architecture,infrastructure,security-architecture,scalability,integration,cost-estimation,adr-writing,diagrams,environments}
mkdir -p skills/design/{module-design,api-contracts,ui-ux,components,data-flow,error-handling,state-management,integration-design,validation,wireframing}
mkdir -p skills/testing/{test-strategy,test-case-design,test-data,coverage-analysis,traceability-management,impact-analysis,prioritization,defect-analysis,reporting,regression-management,environment,performance-test,security-test}
mkdir -p skills/development/{implementation,unit-testing,api-implementation,database-integration,frontend,authentication,integration,error-handling,refactoring,bug-fixing,code-review,documentation,migrations,performance}
mkdir -p skills/security/{architecture-review,threat-modeling,vulnerability-scanning,dependency-audit,code-review,auth-testing,authorization-testing,input-validation,configuration,compliance,penetration-testing,reporting,incident-analysis}
mkdir -p skills/devops/{ci-pipeline,cd-pipeline,iac,containers,environment-config,secrets,deployment,rollback,ssl-tls,dns,monitoring-setup,log-management,backup,performance-tuning}
mkdir -p skills/documentation/{technical-writing,api-docs,architecture-docs,user-docs,runbooks,readme,changelog,diagrams,review,versioning}
mkdir -p skills/operations/{monitoring-config,log-analysis,incident-detection,incident-response,root-cause,performance-analysis,capacity-planning,health-checking,alert-tuning,post-mortem,sla-monitoring,cost-monitoring}
```

### Step 5.5: Create Core Custom Skills

#### Orchestrator - Workflow Management Skill (ORCH-001)

```bash
cat > skills/orchestration/workflow-management/SKILL.md << 'EOF'
---
name: workflow-management
description: Manage SDLC workflow phases, transitions, and agent coordination
skill_id: ORCH-001
agent: orchestrator
when_to_use: Starting new features, phase transitions, task delegation
project: studyabroad-v1
---

# Workflow Management Skill

## Purpose
Coordinate the SDLC workflow across all 10 agents for StudyAbroad-v1, managing phase transitions and ensuring gate compliance.

## Workflow Phases

```
1. REQUIREMENTS  →  2. ARCHITECTURE  →  3. DESIGN
       ↓                    ↓                ↓
   (Gate 1)            (Gate 2)          (Gate 3)
       ↓                    ↓                ↓
4. TEST DESIGN  →  5. IMPLEMENTATION  →  6. TESTING
       ↓                    ↓                ↓
   (Gate 4)            (Gate 5)          (Gate 6)
       ↓                    ↓                ↓
7. VALIDATION  →  8. DEPLOYMENT  →  9. OPERATIONS
```

## Phase Transition Rules

### Gate 1: Requirements → Architecture
Required artifacts:
- [ ] docs/requirements/requirements_spec.md exists and is complete
- [ ] All user stories have acceptance criteria
- [ ] NFRs are quantified with metrics
- [ ] User journeys documented (discovery→application→preparation→abroad→return)
- [ ] External API requirements identified
- [ ] GDPR/privacy requirements documented
- [ ] Human approval obtained

### Gate 2: Architecture → Design
Required artifacts:
- [ ] docs/architecture/architecture.md approved
- [ ] Tech stack decision documented
- [ ] ADRs for major decisions
- [ ] Security architecture reviewed
- [ ] Database schema defined
- [ ] External API integration architecture defined
- [ ] Scalability plan documented

### Gate 3: Design → Test Design
Required artifacts:
- [ ] OpenAPI specification complete
- [ ] Module designs documented
- [ ] UI wireframes approved
- [ ] Error taxonomy defined
- [ ] User flow diagrams complete

### Gate 4: Test Design → Implementation
Required artifacts:
- [ ] Test strategy approved
- [ ] Test cases written (including integration tests for external APIs)
- [ ] Test data prepared
- [ ] Traceability matrix complete

### Gate 5: Implementation → Testing
Required artifacts:
- [ ] All code implemented in src/
- [ ] Unit tests pass (80%+ coverage)
- [ ] Code review approved
- [ ] Security scan clean

### Gate 6: Testing → Validation
Required artifacts:
- [ ] All test types pass
- [ ] Performance meets NFRs
- [ ] Security testing complete
- [ ] Accessibility verified (WCAG 2.1 AA)

## Commands

### Check Current Phase
```
What is the current workflow phase for StudyAbroad-v1?
List all completed gates and pending items.
```

### Transition to Next Phase
```
Validate Gate [N] requirements and transition to [NEXT_PHASE].
Document any blockers or missing items.
```

### Delegate Task to Agent
```
Assign task [TASK_ID] to [AGENT_NAME].
Provide context: [CONTEXT]
Expected output: [OUTPUT]
Deadline: [DEADLINE]
```

## State Management

The workflow state is stored in:
- `.sdlc/workflow-state.json` - Current phase and gate status
- `.sdlc/agent-assignments.json` - Task assignments per agent
- `.sdlc/blockers.json` - Current blockers and dependencies

## Integration Points

- **Spec Kit**: Use `/speckit.specify` for requirements phase
- **BMAD**: Delegate to BMAD agents for execution
- **Superpowers**: Enforce TDD during implementation
EOF
```

#### Test Manager - Impact Analysis Skill (TEST-006)

```bash
cat > skills/testing/impact-analysis/SKILL.md << 'EOF'
---
name: impact-analysis
description: Analyze impact of changes on existing tests and identify tests needing updates
skill_id: TEST-006
agent: test-manager
when_to_use: When requirements change, bugs are fixed, or code is modified
project: studyabroad-v1
---

# Impact Analysis Skill

## Purpose
Determine which tests are affected when requirements, design, or code changes in StudyAbroad-v1, ensuring test suite remains aligned.

## Trigger Events

| Event | Action Required |
|-------|-----------------|
| Requirement Added | Create new test cases |
| Requirement Modified | Review and update affected tests |
| Requirement Removed | Mark tests as deprecated |
| Bug Reported | Identify test gap, create regression test |
| Bug Fixed | Verify regression test exists |
| Code Changed | Run affected tests, update if needed |
| Design Changed | Review integration tests |
| External API Changed | Review integration tests for that API |

## StudyAbroad-Specific Considerations

### Critical Test Areas
1. **User Authentication** - OAuth2/SSO flows
2. **User Profile Management** - CRUD operations, data validation
3. **Application Workflows** - Multi-step user journeys
4. **External API Integrations** - University, visa, housing APIs
5. **Data Privacy** - GDPR compliance, PII handling

### Impact Analysis Process

#### Step 1: Identify Change Type
```
Analyze the change:
- What artifact changed? (requirement/design/code)
- What is the change ID? (REQ-xxx, DES-xxx, commit hash)
- What is the scope? (feature/module/component)
- Does it affect external API integration?
- Does it affect user data handling?
```

#### Step 2: Query Traceability Matrix
```
Using docs/testing/traceability_matrix.csv:
1. Find all tests linked to changed artifact
2. Find all downstream dependencies
3. List affected test IDs
4. Check for external API test dependencies
```

#### Step 3: Categorize Impact
```
For each affected test:
- MUST_UPDATE: Test logic no longer valid
- MUST_REVIEW: Test may need updates
- MUST_RUN: Test should be re-executed
- NO_IMPACT: Test unaffected
```

#### Step 4: Generate Impact Report
```markdown
# Impact Analysis Report - StudyAbroad-v1

## Change Summary
- Change ID: [ID]
- Change Type: [requirement|design|code]
- Description: [summary]
- Affected User Journey: [discovery|application|preparation|abroad|return]

## Affected Tests

### Must Update (Test logic invalid)
| Test ID | Reason | Priority | External API |
|---------|--------|----------|--------------|
| TEST-001 | Acceptance criteria changed | High | None |

### Must Review (May need updates)
| Test ID | Reason | Priority |
|---------|--------|----------|

### Must Run (Re-execute)
| Test ID | Last Run | Status |
|---------|----------|--------|

## External API Integration Tests
| API | Tests Affected | Mock Update Needed |
|-----|----------------|-------------------|

## Recommendations
1. [Action item]
2. [Action item]

## Risk Assessment
- Tests not covering change: [count]
- Estimated effort: [hours]
- GDPR/Privacy test review needed: [yes/no]
```

#### Step 5: Update Traceability
```
After tests are updated:
1. Update docs/testing/traceability_matrix.csv
2. Update test metadata with change reference
3. Log in .sdlc/change_history.json
```

## Traceability Matrix Format

```csv
requirement_id,design_id,test_id,code_path,external_api,last_validated,status
REQ-001,DES-001,TEST-001,src/backend/auth/login.ts,none,2024-01-15,valid
REQ-002,DES-002,TEST-005,src/backend/user/profile.ts,none,2024-01-14,valid
REQ-010,DES-010,TEST-020,src/backend/integrations/university.ts,university-api,2024-01-16,valid
```

## Integration with Other Agents

- **Requirements Agent**: Notify when requirements change
- **Developer Agent**: Receive code change notifications
- **Orchestrator**: Report impact analysis results

## Automation Hooks

```yaml
# Add to .github/workflows or CI config
on_requirement_change:
  - run: impact-analysis --type requirement --id $REQ_ID
  - notify: test-manager-agent
  
on_code_push:
  - run: impact-analysis --type code --commit $COMMIT_SHA
  - run: affected-tests --execute
  
on_api_change:
  - run: impact-analysis --type external-api --api $API_NAME
  - notify: developer-agent
```
EOF
```

#### Security - Threat Modeling Skill (SEC-002)

```bash
cat > skills/security/threat-modeling/SKILL.md << 'EOF'
---
name: threat-modeling
description: Identify security threats using STRIDE methodology and define mitigations
skill_id: SEC-002
agent: security
when_to_use: During architecture phase, before implementation, after significant design changes
project: studyabroad-v1
---

# Threat Modeling Skill

## Purpose
Systematically identify security threats to StudyAbroad-v1 and define appropriate mitigations.

## STRIDE Methodology

| Category | Description | StudyAbroad-v1 Focus |
|----------|-------------|----------------------|
| **S**poofing | Impersonating users | OAuth2/SSO vulnerabilities, session hijacking |
| **T**ampering | Modifying data | Application data, user profiles, documents |
| **R**epudiation | Denying actions | Audit logs for applications, payments |
| **I**nformation Disclosure | Data leaks | User PII, academic records, GDPR compliance |
| **D**enial of Service | Service disruption | Application deadlines, peak periods |
| **E**levation of Privilege | Gaining admin access | Admin vs student vs advisor roles |

## StudyAbroad-Specific Assets to Protect

| Asset | Sensitivity | Regulatory | Notes |
|-------|-------------|------------|-------|
| User credentials | Critical | GDPR | Password hashes, OAuth tokens |
| Personal information | High | GDPR | Name, DOB, nationality, passport |
| Academic records | High | FERPA | Transcripts, grades, enrollment |
| Application data | High | GDPR | Essays, recommendations |
| Financial information | Critical | PCI-DSS | Payment details (if applicable) |
| Session tokens | High | - | JWT, cookies |
| API keys | Critical | - | External service credentials |

## Threat Modeling Process

### Step 1: Define Scope
```
1. Identify the system/feature to analyze
2. Draw data flow diagram (DFD)
3. Identify trust boundaries:
   - Browser ↔ Frontend
   - Frontend ↔ Backend API
   - Backend ↔ Database
   - Backend ↔ External APIs (University, Visa, Housing)
   - Admin interface ↔ Backend
4. List assets to protect (see table above)
```

### Step 2: Identify Threats (Per Component)
```
For each component in the DFD:
1. Apply STRIDE categories
2. Document potential threats
3. Rate likelihood (High/Medium/Low)
4. Rate impact (High/Medium/Low)
```

### Step 3: Document Threats
```markdown
## Threat: [THREAT-ID]

### Category
[Spoofing|Tampering|Repudiation|Information Disclosure|DoS|Elevation of Privilege]

### Description
[What could happen]

### Attack Vector
[How an attacker would exploit this]

### Affected Component
[Component name from DFD]

### Likelihood
[High|Medium|Low] - [Justification]

### Impact
[High|Medium|Low] - [Justification]

### Risk Score
[Likelihood × Impact]

### Mitigation
[How to prevent or reduce risk]

### GDPR Implications
[Data protection impact, if any]

### Verification
[How to test that mitigation works]
```

### Step 4: StudyAbroad-v1 Common Threat Scenarios

#### Authentication Threats
- THREAT-AUTH-001: OAuth token theft via XSS
- THREAT-AUTH-002: Session fixation attack
- THREAT-AUTH-003: Brute force on password reset
- THREAT-AUTH-004: University SSO bypass

#### Data Exposure Threats
- THREAT-DATA-001: PII leakage via API response
- THREAT-DATA-002: Unauthorized access to other users' applications
- THREAT-DATA-003: Document download without authorization
- THREAT-DATA-004: GDPR right-to-deletion not implemented

#### Integration Threats
- THREAT-API-001: External API credential exposure
- THREAT-API-002: Man-in-the-middle on API calls
- THREAT-API-003: Injection via external API response

### Step 5: Create Threat Model Document
```markdown
# Threat Model: StudyAbroad-v1 [Feature/System Name]

## Overview
[Brief description of what's being modeled]

## Data Flow Diagram
[Include or reference DFD - save to docs/architecture/dfd/]

## Trust Boundaries
1. User Browser ↔ CDN/Frontend
2. Frontend ↔ API Gateway
3. API Gateway ↔ Backend Services
4. Backend ↔ PostgreSQL
5. Backend ↔ External APIs

## Assets (StudyAbroad-Specific)
[Reference assets table above]

## Threats

### Critical Risk
[List THREAT-IDs]

### High Risk
[List THREAT-IDs]

### Medium Risk
[List THREAT-IDs]

## Mitigation Summary
| Threat ID | Mitigation | Owner | Status |
|-----------|------------|-------|--------|

## Security Requirements Generated
- SEC-REQ-001: [Requirement text]

## GDPR Compliance Checklist
- [ ] Data minimization implemented
- [ ] Consent collection mechanism
- [ ] Right to access implemented
- [ ] Right to deletion implemented
- [ ] Data portability supported
- [ ] Breach notification process defined
```

## Integration Points

- **Architecture Agent**: Receive architecture for analysis
- **Design Agent**: Provide security requirements for API design
- **Test Manager**: Provide security test cases
- **Developer Agent**: Security coding guidelines
EOF
```

### Step 5.6: Create Skills Index

```bash
cat > skills/SKILLS_INDEX.md << 'EOF'
# StudyAbroad-v1 Custom Skills Index

This directory contains the 116 skills for the 10-agent SDLC framework.

## Skill Loading

These skills extend Obra Superpowers. To use them:

1. Skills are automatically loaded when relevant to the task
2. Reference skills by ID (e.g., ORCH-001, TEST-006)
3. Skills follow Superpowers format for compatibility

## Skills by Agent

### Orchestrator Agent (8 skills)
| Skill ID | Name | Status |
|----------|------|--------|
| ORCH-001 | [Workflow Management](orchestration/workflow-management/SKILL.md) | ✅ Created |
| ORCH-002 | Task Decomposition | 📝 Template |
| ORCH-003 | Progress Tracking | 📝 Template |
| ORCH-004 | Gate Validation | 📝 Template |
| ORCH-005 | Conflict Resolution | 📝 Template |
| ORCH-006 | Priority Management | 📝 Template |
| ORCH-007 | Communication Routing | 📝 Template |
| ORCH-008 | Risk Assessment | 📝 Template |

### Requirements Agent (10 skills)
| Skill ID | Name | Status |
|----------|------|--------|
| REQ-001 | Requirements Elicitation | 📝 Template |
| REQ-002 | User Story Writing | 📝 Template |
| REQ-003 | Requirements Classification | 📝 Template |
| REQ-004 | Ambiguity Detection | 📝 Template |
| REQ-005 | Requirements Prioritization | 📝 Template |
| REQ-006 | Dependency Mapping | 📝 Template |
| REQ-007 | Change Impact Analysis | 📝 Template |
| REQ-008 | Traceability Management | 📝 Template |
| REQ-009 | Acceptance Criteria Writing | 📝 Template |
| REQ-010 | NFR Quantification | 📝 Template |

### Architecture Agent (12 skills)
| Skill ID | Name | Status |
|----------|------|--------|
| ARCH-001 | Architecture Pattern Selection | 📝 Template |
| ARCH-002 | Technology Evaluation | 📝 Template |
| ARCH-003 | Database Design | 📝 Template |
| ARCH-004 | API Architecture | 📝 Template |
| ARCH-005 | Infrastructure Design | 📝 Template |
| ARCH-006 | Security Architecture | 📝 Template |
| ARCH-007 | Scalability Planning | 📝 Template |
| ARCH-008 | Integration Architecture | 📝 Template |
| ARCH-009 | Cost Estimation | 📝 Template |
| ARCH-010 | ADR Writing | 📝 Template |
| ARCH-011 | Diagram Generation | 📝 Template |
| ARCH-012 | Environment Design | 📝 Template |

### Design Agent (10 skills)
| Skill ID | Name | Status |
|----------|------|--------|
| DES-001 | Module Design | 📝 Template |
| DES-002 | API Contract Design | 📝 Template |
| DES-003 | UI/UX Design | 📝 Template |
| DES-004 | Component Design | 📝 Template |
| DES-005 | Data Flow Design | 📝 Template |
| DES-006 | Error Handling Design | 📝 Template |
| DES-007 | State Management Design | 📝 Template |
| DES-008 | Integration Design | 📝 Template |
| DES-009 | Validation Design | 📝 Template |
| DES-010 | Wireframing | 📝 Template |

### Test Manager Agent (13 skills) ⭐
| Skill ID | Name | Status |
|----------|------|--------|
| TEST-001 | Test Strategy Design | 📝 Template |
| TEST-002 | Test Case Design | 📝 Template |
| TEST-003 | Test Data Generation | 📝 Template |
| TEST-004 | Coverage Analysis | 📝 Template |
| TEST-005 | Traceability Management | 📝 Template |
| TEST-006 | [Impact Analysis](testing/impact-analysis/SKILL.md) | ✅ Created |
| TEST-007 | Test Prioritization | 📝 Template |
| TEST-008 | Defect Analysis | 📝 Template |
| TEST-009 | Test Reporting | 📝 Template |
| TEST-010 | Regression Management | 📝 Template |
| TEST-011 | Test Environment Management | 📝 Template |
| TEST-012 | Performance Test Design | 📝 Template |
| TEST-013 | Security Test Design | 📝 Template |

### Developer Agent (14 skills)
| Skill ID | Name | Status |
|----------|------|--------|
| DEV-001 | Code Implementation | 📝 Template |
| DEV-002 | Unit Test Writing | 📝 Template |
| DEV-003 | API Implementation | 📝 Template |
| DEV-004 | Database Integration | 📝 Template |
| DEV-005 | Frontend Development | 📝 Template |
| DEV-006 | Authentication Implementation | 📝 Template |
| DEV-007 | Integration Implementation | 📝 Template |
| DEV-008 | Error Handling | 📝 Template |
| DEV-009 | Code Refactoring | 📝 Template |
| DEV-010 | Bug Fixing | 📝 Template |
| DEV-011 | Code Review | 📝 Template |
| DEV-012 | Code Documentation | 📝 Template |
| DEV-013 | Migration Writing | 📝 Template |
| DEV-014 | Performance Optimization | 📝 Template |

### Security Agent (13 skills)
| Skill ID | Name | Status |
|----------|------|--------|
| SEC-001 | Security Architecture Review | 📝 Template |
| SEC-002 | [Threat Modeling](security/threat-modeling/SKILL.md) | ✅ Created |
| SEC-003 | Vulnerability Scanning | 📝 Template |
| SEC-004 | Dependency Auditing | 📝 Template |
| SEC-005 | Code Security Review | 📝 Template |
| SEC-006 | Authentication Testing | 📝 Template |
| SEC-007 | Authorization Testing | 📝 Template |
| SEC-008 | Input Validation Testing | 📝 Template |
| SEC-009 | Security Configuration | 📝 Template |
| SEC-010 | Compliance Checking | 📝 Template |
| SEC-011 | Penetration Testing | 📝 Template |
| SEC-012 | Security Reporting | 📝 Template |
| SEC-013 | Incident Analysis | 📝 Template |

### DevOps Agent (14 skills)
| Skill ID | Name | Status |
|----------|------|--------|
| OPS-001 | CI Pipeline Configuration | 📝 Template |
| OPS-002 | CD Pipeline Configuration | 📝 Template |
| OPS-003 | Infrastructure as Code | 📝 Template |
| OPS-004 | Container Management | 📝 Template |
| OPS-005 | Environment Configuration | 📝 Template |
| OPS-006 | Secret Management | 📝 Template |
| OPS-007 | Deployment Execution | 📝 Template |
| OPS-008 | Rollback Management | 📝 Template |
| OPS-009 | SSL/TLS Management | 📝 Template |
| OPS-010 | DNS Management | 📝 Template |
| OPS-011 | Monitoring Setup | 📝 Template |
| OPS-012 | Log Management | 📝 Template |
| OPS-013 | Backup Management | 📝 Template |
| OPS-014 | Performance Tuning | 📝 Template |

### Documentation Agent (10 skills)
| Skill ID | Name | Status |
|----------|------|--------|
| DOC-001 | Technical Writing | 📝 Template |
| DOC-002 | API Documentation | 📝 Template |
| DOC-003 | Architecture Documentation | 📝 Template |
| DOC-004 | User Documentation | 📝 Template |
| DOC-005 | Runbook Writing | 📝 Template |
| DOC-006 | README Creation | 📝 Template |
| DOC-007 | Changelog Management | 📝 Template |
| DOC-008 | Diagram Creation | 📝 Template |
| DOC-009 | Documentation Review | 📝 Template |
| DOC-010 | Documentation Versioning | 📝 Template |

### Operations Agent (12 skills)
| Skill ID | Name | Status |
|----------|------|--------|
| MON-001 | Monitoring Configuration | 📝 Template |
| MON-002 | Log Analysis | 📝 Template |
| MON-003 | Incident Detection | 📝 Template |
| MON-004 | Incident Response | 📝 Template |
| MON-005 | Root Cause Analysis | 📝 Template |
| MON-006 | Performance Analysis | 📝 Template |
| MON-007 | Capacity Planning | 📝 Template |
| MON-008 | Health Checking | 📝 Template |
| MON-009 | Alert Tuning | 📝 Template |
| MON-010 | Post-Mortem Writing | 📝 Template |
| MON-011 | SLA Monitoring | 📝 Template |
| MON-012 | Cost Monitoring | 📝 Template |

---

## Summary

| Agent | Skills | Created | Template |
|-------|--------|---------|----------|
| Orchestrator | 8 | 1 | 7 |
| Requirements | 10 | 0 | 10 |
| Architecture | 12 | 0 | 12 |
| Design | 10 | 0 | 10 |
| Test Manager | 13 | 1 | 12 |
| Developer | 14 | 0 | 14 |
| Security | 13 | 1 | 12 |
| DevOps | 14 | 0 | 14 |
| Documentation | 10 | 0 | 10 |
| Operations | 12 | 0 | 12 |
| **Total** | **116** | **3** | **113** |

Legend:
- ✅ Created: Full skill documentation complete
- 📝 Template: Basic structure created, needs detailed content
EOF

git add skills/
git commit -m "feat: add custom skills directory structure and core skills for StudyAbroad-v1"
```

---

## 6. Phase 4: BMAD Method Installation & Agent Mapping

### Step 6.1: Install BMAD Method

```bash
cd ~/projects/studyabroad-v1

# Install BMAD
npx bmad-method install

# This creates:
# - .bmad/ directory with agent definitions
```

### Step 6.2: Configure BMAD Agent Mapping

```bash
cat > config/bmad/agent-mapping.yaml << 'EOF'
# Mapping: Your 10 Agents ↔ BMAD 19 Agents
# Project: StudyAbroad-v1

agent_mapping:
  # Your Orchestrator = BMAD Orchestrator + Scrum Master
  orchestrator:
    bmad_agents:
      - orchestrator
      - scrum-master
    responsibilities:
      - workflow_coordination
      - sprint_planning
      - task_assignment
      - blocker_resolution
    
  # Your Requirements = BMAD Analyst + PM
  requirements:
    bmad_agents:
      - analyst
      - product-manager
    responsibilities:
      - stakeholder_interviews
      - requirement_elicitation
      - user_story_creation
      - acceptance_criteria
      - prioritization
      - user_journey_mapping
    
  # Your Architecture = BMAD Architect
  architecture:
    bmad_agents:
      - architect
    responsibilities:
      - system_design
      - tech_stack_selection
      - adr_creation
      - database_design
      - integration_design
      - external_api_architecture
    
  # Your Design = BMAD Designer + UX Designer
  design:
    bmad_agents:
      - designer
      - ux-designer
    responsibilities:
      - api_contract_design
      - ui_wireframes
      - component_design
      - user_flows
      - accessibility_design
    
  # Your Test Manager = BMAD QA + Scrum Master (testing aspects)
  test_manager:
    bmad_agents:
      - qa-tester
      - scrum-master
    responsibilities:
      - test_strategy
      - test_case_design
      - coverage_tracking
      - regression_management
      - acceptance_testing
      - external_api_mocking
    
  # Your Developer = BMAD Developer + Frontend Dev + Backend Dev
  developer:
    bmad_agents:
      - developer
      - frontend-developer
      - backend-developer
    responsibilities:
      - code_implementation
      - unit_testing
      - code_review
      - refactoring
      - external_api_integration
    
  # Your Security = BMAD Security Expert
  security:
    bmad_agents:
      - security-expert
    responsibilities:
      - threat_modeling
      - security_review
      - vulnerability_scanning
      - compliance_checking
      - gdpr_compliance
      - pii_protection
    
  # Your DevOps = BMAD DevOps + Database Admin
  devops:
    bmad_agents:
      - devops
      - database-admin
    responsibilities:
      - ci_cd_pipeline
      - infrastructure
      - deployment
      - database_management
      - environment_configuration
    
  # Your Documentation = BMAD Technical Writer
  documentation:
    bmad_agents:
      - technical-writer
    responsibilities:
      - api_documentation
      - user_guides
      - runbooks
      - readme_creation
      - privacy_policy_docs
    
  # Your Operations = Custom (no direct BMAD equivalent)
  operations:
    bmad_agents: []
    responsibilities:
      - monitoring_setup
      - alerting
      - incident_response
      - log_analysis
      - performance_monitoring
EOF
```

### Step 6.3: Configure BMAD for StudyAbroad-v1

```bash
cat > .bmad/config.yaml << 'EOF'
# BMAD Configuration for StudyAbroad-v1

project:
  name: "StudyAbroad-v1"
  type: "web-application"
  domain: "education"
  methodology: "spec-driven-agile"
  
integration:
  spec_kit: true
  superpowers: true
  twelve_factors: true

workflow:
  phases:
    - name: specify
      bmad_agents: [analyst, product-manager]
      spec_kit_command: /speckit.specify
      focus:
        - user_journeys
        - external_api_requirements
        - gdpr_requirements
      
    - name: plan
      bmad_agents: [architect]
      spec_kit_command: /speckit.plan
      focus:
        - database_schema
        - api_architecture
        - external_integrations
      
    - name: design
      bmad_agents: [designer, ux-designer, api-designer]
      custom_agents: [design-agent]
      focus:
        - openapi_spec
        - user_flows
        - wireframes
      
    - name: tasks
      bmad_agents: [scrum-master]
      spec_kit_command: /speckit.tasks
      
    - name: implement
      bmad_agents: [developer, frontend-developer, backend-developer]
      superpowers: [tdd, code-review]
      spec_kit_command: /speckit.implement
      focus:
        - src/frontend
        - src/backend
        - src/database
      
    - name: test
      bmad_agents: [qa-tester]
      custom_agents: [test-manager-agent]
      focus:
        - unit_tests
        - integration_tests
        - e2e_tests
        - api_mock_tests
      
    - name: secure
      bmad_agents: [security-expert]
      custom_agents: [security-agent]
      focus:
        - gdpr_compliance
        - owasp_top_10
        - pii_protection
      
    - name: deploy
      bmad_agents: [devops, database-admin]
      custom_agents: [devops-agent]
      
    - name: document
      bmad_agents: [technical-writer]
      focus:
        - api_docs
        - user_guide
        - privacy_policy
      
    - name: operate
      custom_agents: [operations-agent]

# StudyAbroad-specific story template
story_template: |
  # Story: {{story_id}}
  
  ## Requirement Reference
  - Requirement ID: {{req_id}}
  - Acceptance Criteria: {{acceptance_criteria}}
  - User Journey Stage: {{journey_stage}}
  
  ## Technical Context
  - Architecture: {{architecture_reference}}
  - Design: {{design_reference}}
  - API Contract: {{api_reference}}
  - External APIs: {{external_apis}}
  
  ## Implementation Notes
  {{implementation_notes}}
  
  ## Test Coverage
  - Unit Tests: {{unit_test_ids}}
  - Integration Tests: {{integration_test_ids}}
  - E2E Tests: {{e2e_test_ids}}
  
  ## Privacy Considerations
  - PII Involved: {{pii_fields}}
  - GDPR Requirements: {{gdpr_requirements}}
  
  ## Definition of Done
  - [ ] Code implemented in src/
  - [ ] Unit tests pass (80%+ coverage)
  - [ ] Code reviewed
  - [ ] Security scan clean
  - [ ] GDPR compliance verified
  - [ ] Documentation updated
EOF

git add config/bmad/ .bmad/
git commit -m "feat: configure BMAD method with agent mapping for StudyAbroad-v1"
```

---

## 7. Phase 5: Ralph Wiggum Plugin Installation

Ralph Wiggum provides autonomous execution loops that allow agents to iterate on tasks until completion. While BMAD defines WHO does the work (agent personas), Ralph defines HOW complex work gets done (iterative refinement).

### Step 7.1: Install Ralph Wiggum Plugin

```bash
cd ~/projects/studyabroad-v1

# Start Claude Code
claude

# Install Ralph Wiggum from official marketplace
/plugin install ralph-wiggum@claude-plugins-official

# Exit and restart Claude Code to activate
exit
claude
```

**Note:** Ralph Wiggum has a dependency on `jq`. Install it first:
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt install jq

# Windows (use WSL or Git Bash with manual jq install)
```

### Step 7.2: Verify Ralph Installation

```bash
# In Claude Code, verify commands are available
/help

# Should show:
# /ralph-loop - Start autonomous iteration loop
# /cancel-ralph - Cancel active loop
```

### Step 7.3: Configure Ralph for StudyAbroad-v1

```bash
mkdir -p .ralph
cat > .ralph/config.yaml << 'EOF'
# Ralph Wiggum Configuration for StudyAbroad-v1
# Autonomous execution loops for iterative task completion

project:
  name: "StudyAbroad-v1"

defaults:
  max_iterations: 50
  completion_detection: "promise"

# Agent-specific loop configurations
agent_loops:

  orchestrator:
    description: "Complex coordination tasks"
    typical_iterations: 10-20
    completion_promise: "COORDINATION_COMPLETE"
    use_cases:
      - Multi-agent task coordination
      - Gate validation with fixes
      - Conflict resolution

  requirements:
    description: "Iterative requirements elicitation"
    typical_iterations: 15-30
    completion_promise: "REQUIREMENTS_COMPLETE"
    use_cases:
      - User story refinement until acceptance criteria clear
      - Ambiguity resolution through iteration
      - Stakeholder feedback incorporation

  architecture:
    description: "Architecture design refinement"
    typical_iterations: 10-25
    completion_promise: "ARCHITECTURE_COMPLETE"
    use_cases:
      - ADR writing with review feedback
      - Database schema optimization
      - External API integration design

  design:
    description: "Iterative design improvement"
    typical_iterations: 15-30
    completion_promise: "DESIGN_COMPLETE"
    use_cases:
      - OpenAPI spec until validation passes
      - Wireframe refinement
      - User flow optimization

  test_manager:
    description: "Test iteration until coverage met"
    typical_iterations: 20-40
    completion_promise: "TESTS_COMPLETE"
    use_cases:
      - Test case generation until coverage target
      - Test data generation
      - Regression suite optimization

  developer:
    description: "TDD implementation loops"
    typical_iterations: 30-50
    completion_promise: "IMPLEMENTATION_COMPLETE"
    use_cases:
      - RED-GREEN-REFACTOR cycles
      - Bug fixing until tests pass
      - Feature implementation with iterative testing
    example: |
      /ralph-loop "Implement user profile API endpoint:
      1. Write failing test for GET /api/user/profile
      2. Implement endpoint to pass test
      3. Write failing test for PUT /api/user/profile
      4. Implement update to pass test
      5. Refactor for code quality
      6. Ensure 80%+ coverage
      Output: <promise>IMPLEMENTATION_COMPLETE</promise>"
      --max-iterations 30 --completion-promise "IMPLEMENTATION_COMPLETE"

  security:
    description: "Security issue remediation"
    typical_iterations: 20-40
    completion_promise: "SECURITY_CLEAN"
    use_cases:
      - Vulnerability fix iteration
      - Security scan until clean
      - GDPR compliance fixes

  devops:
    description: "CI/CD pipeline fixes"
    typical_iterations: 15-30
    completion_promise: "PIPELINE_WORKING"
    use_cases:
      - Pipeline debugging until green
      - Infrastructure fixes
      - Deployment issue resolution

  documentation:
    description: "Documentation completion"
    typical_iterations: 10-25
    completion_promise: "DOCS_COMPLETE"
    use_cases:
      - API documentation until comprehensive
      - User guide completion
      - Runbook refinement

  operations:
    description: "Incident resolution"
    typical_iterations: 20-50
    completion_promise: "INCIDENT_RESOLVED"
    use_cases:
      - Root cause analysis iteration
      - Alert tuning until noise reduced
      - Performance optimization

# Safety settings
safety:
  absolute_max_iterations: 100
  cost_warning_threshold: 50  # Warn after $50 estimated spend
  require_confirmation_above: 75  # Require human confirmation above 75 iterations

# Logging
logging:
  log_all_iterations: true
  log_directory: ".sdlc/ralph-logs/"
  include_cost_estimates: true
EOF
```

### Step 7.4: Create Ralph Prompt Templates

```bash
mkdir -p .ralph/prompts

# TDD Implementation template
cat > .ralph/prompts/tdd-implementation.md << 'EOF'
# TDD Implementation Loop

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
EOF

# Bug Fix template
cat > .ralph/prompts/bug-fix.md << 'EOF'
# Bug Fix Loop

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
EOF

# Security Remediation template
cat > .ralph/prompts/security-fix.md << 'EOF'
# Security Remediation Loop

## Vulnerability
{{vulnerability_description}}

## Severity
{{severity_level}}

## Affected Components
{{affected_components}}

## Process
1. Analyze the vulnerability in detail
2. Write a test that exposes the vulnerability
3. Implement the security fix
4. Run security scan to confirm fix
5. Verify no new vulnerabilities introduced
6. Update security documentation

## Completion Criteria
- Vulnerability is patched
- Security test confirms fix
- Security scan passes
- No regression in functionality

When all criteria met, output: <promise>SECURITY_CLEAN</promise>
EOF

git add .ralph/
git commit -m "feat: configure Ralph Wiggum plugin for autonomous execution loops"
```

### Step 7.5: Integration with BMAD Agents

Ralph and BMAD work together - BMAD provides the persona, Ralph provides the execution loop:

```
┌─────────────────────────────────────────────────────────────────┐
│                     Task Execution Flow                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  1. Orchestrator receives task                                    │
│           │                                                       │
│           ▼                                                       │
│  2. Activate BMAD persona (e.g., developer)                       │
│           │                                                       │
│           ▼                                                       │
│  3. Start Ralph loop for autonomous execution                     │
│           │                                                       │
│           ▼                                                       │
│  ┌────────────────────────────────────────────┐                  │
│  │  /ralph-loop "Implement feature X with TDD" │                  │
│  │  --max-iterations 30                        │                  │
│  │  --completion-promise "DONE"                │                  │
│  └────────────────────────────────────────────┘                  │
│           │                                                       │
│           ▼                                                       │
│  4. Ralph iterates until completion or max                        │
│           │                                                       │
│           ▼                                                       │
│  5. Return to Orchestrator with results                           │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## 8. Phase 6: 12 Factors Integration

### Step 8.1: Create 12 Factors Configuration

```bash
cat > config/12-factors/factors.yaml << 'EOF'
# Agentic SDLC 12 Factors Configuration
# Project: StudyAbroad-v1

project:
  name: "StudyAbroad-v1"
  compliance:
    - GDPR
    - WCAG-2.1-AA

factors:
  
  factor_1_strategic_mindset:
    description: "Intent-driven development with clear specifications"
    implementation:
      - All work starts with a specification (Spec Kit)
      - No code without approved requirements
      - Focus on "why" before "what"
      - User journey stages define feature grouping
    enforcement:
      - Orchestrator blocks implementation without spec
      - Gate validation checks for specification artifacts
    studyabroad_specific:
      - Map features to user journey (discovery→application→preparation→abroad→return)
      - External API requirements must be specified upfront
    
  factor_2_context_scaffolding:
    description: "Rich organizational principles and guardrails"
    implementation:
      - Constitution document defines principles
      - CLAUDE.md provides agent context
      - Skills provide domain knowledge
    artifacts:
      - .specify/constitution.md
      - CLAUDE.md
      - skills/*/SKILL.md
    studyabroad_specific:
      - Education domain context
      - GDPR/privacy guardrails
      - External API integration patterns
    
  factor_3_mission_definition:
    description: "Structured specification creation process"
    implementation:
      - Use /speckit.specify for all requirements
      - Requirements Agent owns this phase
      - Clear acceptance criteria required
    workflow:
      - Elicit → Structure → Validate → Approve
    studyabroad_specific:
      - Include user persona (student/advisor/admin)
      - Include user journey stage
      - Include privacy impact assessment
    
  factor_4_structured_planning:
    description: "Multi-step refinement with technical planning"
    implementation:
      - Architecture phase follows requirements
      - Use ADRs for decisions
      - Design phase details implementation
    artifacts:
      - docs/architecture/architecture.md
      - docs/architecture/adrs/
      - docs/design/
    studyabroad_specific:
      - External API integration architecture
      - Database schema with PII annotations
      - Scalability for application deadlines
    
  factor_5_dual_execution_loops:
    description: "SYNC/ASYNC execution modes"
    implementation:
      sync_mode:
        - Human-in-loop decisions
        - Gate approvals
        - Critical reviews
        - GDPR compliance decisions
      async_mode:
        - Parallel task execution
        - Automated testing
        - Background scanning
        - API integration testing
    
  factor_6_the_great_filter:
    description: "Quality gates and validation checkpoints"
    implementation:
      - Gate validation at each phase transition
      - Orchestrator enforces gates
      - No phase skipping allowed
    gates:
      - requirements_complete
      - architecture_approved
      - design_validated
      - tests_designed
      - implementation_complete
      - all_tests_pass
      - security_approved
      - gdpr_compliant
      - deployment_ready
    
  factor_7_adaptive_quality_gates:
    description: "Flexible QA based on project needs"
    implementation:
      - Risk-based test selection
      - Coverage targets per component criticality
      - Configurable gate strictness
    configuration:
      high_risk:  # Auth, payments, PII handling
        coverage_target: 90
        security_scan: full
        gdpr_review: required
        manual_review: required
      medium_risk:  # Core features
        coverage_target: 80
        security_scan: standard
        gdpr_review: automated
        manual_review: optional
      low_risk:  # UI polish, content
        coverage_target: 70
        security_scan: quick
        manual_review: none
    
  factor_8_ai_augmented_testing:
    description: "Risk-based intelligent testing"
    implementation:
      - Test Manager Agent uses impact analysis
      - AI generates test cases from requirements
      - Smart regression test selection
      - External API mock generation
    skills:
      - TEST-006: Impact Analysis
      - TEST-007: Test Prioritization
      - TEST-010: Regression Management
    
  factor_9_traceability:
    description: "End-to-end artifact traceability"
    implementation:
      - Traceability matrix links all artifacts
      - Every code file links to requirement
      - Every test links to acceptance criteria
    matrix_format:
      requirement → design → test → code → deployment
    storage:
      - docs/testing/traceability_matrix.csv
    
  factor_10_continuous_feedback:
    description: "Production reality informs specification evolution"
    implementation:
      - Operations Agent monitors production
      - Incidents create feedback to Requirements
      - Metrics inform NFR updates
    loop:
      production_metrics → analysis → requirement_updates → implementation
    studyabroad_specific:
      - User feedback on journey friction points
      - API reliability metrics
      - Application completion rates
    
  factor_11_security_by_design:
    description: "Built-in security practices"
    implementation:
      - Threat modeling during architecture
      - Security Agent reviews all phases
      - Security tests mandatory
    checkpoints:
      - architecture: threat_model
      - design: security_review
      - implementation: sast_scan
      - testing: security_tests
      - deployment: dast_scan
    studyabroad_specific:
      - GDPR compliance checks
      - PII encryption verification
      - OAuth2/SSO security review
      - Third-party API security assessment
    
  factor_12_team_capability:
    description: "Knowledge sharing and continuous improvement"
    implementation:
      - Skills capture best practices
      - Retrospectives after each sprint
      - Shared learnings across agents
    mechanisms:
      - skills/: Reusable knowledge
      - docs/retrospectives/: Lessons learned
      - .sdlc/metrics/: Performance tracking
EOF
```

### Step 8.2: Create Factor Enforcement Rules

```bash
cat > config/12-factors/enforcement.yaml << 'EOF'
# 12 Factors Enforcement Rules
# Project: StudyAbroad-v1

enforcement_rules:

  # Block implementation without specification
  rule_no_code_without_spec:
    factor: 1
    trigger: implementation_start
    condition: "!exists(.specify/spec.md)"
    action: block
    message: "Factor 1 violation: Cannot start implementation without approved specification"
    
  # Require constitution before project start
  rule_constitution_required:
    factor: 2
    trigger: project_init
    condition: "!exists(.specify/constitution.md)"
    action: warn
    message: "Factor 2: Constitution not defined. Run /speckit.constitution first"
    
  # Gate validation must pass
  rule_gate_validation:
    factor: 6
    trigger: phase_transition
    condition: "!gate_validation_passed"
    action: block
    message: "Factor 6 violation: Gate validation failed. Complete all requirements before proceeding"
    
  # Traceability required for PRs
  rule_traceability_required:
    factor: 9
    trigger: pull_request
    condition: "!has_requirement_reference"
    action: warn
    message: "Factor 9: PR should reference requirement ID (REQ-xxx)"
    
  # Security review for high-risk changes
  rule_security_review:
    factor: 11
    trigger: code_change
    condition: "changes_auth_code || changes_data_handling"
    action: require_approval
    approver: security-agent
    message: "Factor 11: Security review required for auth/data changes"

  # GDPR compliance for PII changes (StudyAbroad-specific)
  rule_gdpr_compliance:
    factor: 11
    trigger: code_change
    condition: "changes_pii_handling || changes_user_data_schema"
    action: require_approval
    approver: security-agent
    message: "GDPR: Review required for changes affecting personal data"
    
  # External API changes require architecture review
  rule_external_api_review:
    factor: 4
    trigger: code_change
    condition: "changes_external_api_integration"
    action: require_review
    reviewer: architecture-agent
    message: "External API integration change requires architecture review"
EOF

git add config/12-factors/
git commit -m "feat: add 12 Factors configuration for StudyAbroad-v1"
```

---

## 9. Phase 7: Wiring Your 10 Agents

### Step 9.1: Create Agent Definition Files

```bash
# Agent 1: Orchestrator
cat > agents/orchestrator/agent.yaml << 'EOF'
agent:
  id: orchestrator
  name: "SDLC Orchestrator"
  project: "studyabroad-v1"
  description: "Central coordinator managing workflow, delegation, and gate validation"
  
skills:
  - ORCH-001  # Workflow Management
  - ORCH-002  # Task Decomposition
  - ORCH-003  # Progress Tracking
  - ORCH-004  # Gate Validation
  - ORCH-005  # Conflict Resolution
  - ORCH-006  # Priority Management
  - ORCH-007  # Communication Routing
  - ORCH-008  # Risk Assessment

frameworks:
  spec_kit:
    commands:
      - /speckit.specify (delegates to requirements agent)
      - /speckit.plan (delegates to architecture agent)
      - /speckit.tasks (owns)
      - /speckit.implement (coordinates)
  bmad:
    agents:
      - orchestrator
      - scrum-master
  ralph:
    use_cases:
      - Complex multi-agent coordination
      - Gate validation with iterative fixes
      - Conflict resolution requiring multiple rounds
    example_prompt: |
      Coordinate implementation of user authentication feature.
      1. Delegate architecture design to architecture-agent
      2. Wait for completion, validate output
      3. Delegate detailed design to design-agent
      4. Delegate test design to test-manager-agent
      5. Delegate implementation to developer-agent with TDD
      6. Validate all tests pass
      7. Delegate security review to security-agent
      Output: <promise>COORDINATION_COMPLETE</promise>
  superpowers:
    skills:
      - brainstorming
      - write-plan
      - execute-plan

responsibilities:
  - Receive initial project brief from human
  - Validate 12 Factors compliance
  - Manage phase transitions and gates
  - Delegate tasks to appropriate agents
  - Resolve conflicts between agents
  - Escalate to human when needed
  - Maintain project audit trail
  - Track user journey coverage

triggers:
  - human_request
  - phase_completion
  - gate_check_scheduled
  - agent_conflict
  - error_escalation

outputs:
  - .sdlc/workflow-state.json
  - .sdlc/agent-assignments.json
  - .sdlc/audit-log.json
EOF

# Agent 2: Requirements
cat > agents/requirements/agent.yaml << 'EOF'
agent:
  id: requirements
  name: "Requirements Agent"
  project: "studyabroad-v1"
  description: "Captures, structures, and manages requirements throughout project lifecycle"
  
skills:
  - REQ-001  # Requirements Elicitation
  - REQ-002  # User Story Writing
  - REQ-003  # Requirements Classification
  - REQ-004  # Ambiguity Detection
  - REQ-005  # Requirements Prioritization
  - REQ-006  # Dependency Mapping
  - REQ-007  # Change Impact Analysis
  - REQ-008  # Traceability Management
  - REQ-009  # Acceptance Criteria Writing
  - REQ-010  # NFR Quantification

frameworks:
  spec_kit:
    commands:
      - /speckit.specify
      - /speckit.clarify
  bmad:
    agents:
      - analyst
      - product-manager
  ralph:
    use_cases:
      - Iterative requirements elicitation until complete
      - Ambiguity resolution through multiple clarification rounds
      - User story refinement until acceptance criteria are testable
    example_prompt: |
      Elicit requirements for user profile management feature.
      1. Generate clarifying questions based on brief
      2. Document answers and refine understanding
      3. Write user stories with acceptance criteria
      4. Check for ambiguity - if found, generate more questions
      5. Repeat until all stories are clear and testable
      Output: <promise>REQUIREMENTS_COMPLETE</promise>

responsibilities:
  - Interview stakeholders for requirements
  - Generate clarifying questions
  - Structure requirements into standard formats
  - Maintain requirements database
  - Perform change impact analysis
  - Keep traceability matrix updated
  - Map requirements to user journey stages
  - Identify GDPR/privacy requirements

studyabroad_specific:
  user_journeys:
    - discovery
    - application
    - preparation
    - abroad
    - return
  personas:
    - prospective_student
    - current_student
    - study_abroad_advisor
    - administrator

outputs:
  - docs/requirements/requirements_spec.md
  - docs/requirements/user_stories.json
  - docs/requirements/nfr_matrix.md
  - docs/requirements/user_journeys/
EOF

# Agent 3: Architecture
cat > agents/architecture/agent.yaml << 'EOF'
agent:
  id: architecture
  name: "Architecture Agent"
  project: "studyabroad-v1"
  description: "Designs system architecture, selects technology, defines infrastructure"
  
skills:
  - ARCH-001  # Architecture Pattern Selection
  - ARCH-002  # Technology Evaluation
  - ARCH-003  # Database Design
  - ARCH-004  # API Architecture
  - ARCH-005  # Infrastructure Design
  - ARCH-006  # Security Architecture
  - ARCH-007  # Scalability Planning
  - ARCH-008  # Integration Architecture
  - ARCH-009  # Cost Estimation
  - ARCH-010  # ADR Writing
  - ARCH-011  # Diagram Generation
  - ARCH-012  # Environment Design

frameworks:
  spec_kit:
    commands:
      - /speckit.plan
  bmad:
    agents:
      - architect
  ralph:
    use_cases:
      - Architecture design with iterative refinement
      - ADR writing with review feedback incorporation
      - Database schema optimization through iteration
    example_prompt: |
      Design database schema for StudyAbroad user management.
      1. Analyze requirements for data entities
      2. Create initial schema design
      3. Review for normalization issues
      4. Check for GDPR compliance (PII handling)
      5. Optimize for expected query patterns
      6. Validate against requirements coverage
      Iterate until schema is optimal.
      Output: <promise>ARCHITECTURE_COMPLETE</promise>

responsibilities:
  - Analyze requirements for architectural implications
  - Research and evaluate technology options
  - Design system architecture with diagrams
  - Create database schema design
  - Design security architecture
  - Define environment configurations
  - Write Architecture Decision Records
  - Design external API integration architecture

studyabroad_specific:
  external_apis:
    - university_database
    - visa_services
    - housing_providers
    - payment_gateway
  considerations:
    - peak_load_during_application_deadlines
    - gdpr_compliant_data_storage
    - multi_region_for_students_abroad

outputs:
  - docs/architecture/architecture.md
  - docs/architecture/adrs/
  - docs/architecture/database_schema.sql
  - docs/architecture/c4_diagrams/
  - docs/architecture/integration_architecture.md
EOF

# Agent 4: Design
cat > agents/design/agent.yaml << 'EOF'
agent:
  id: design
  name: "Design Agent"
  project: "studyabroad-v1"
  description: "Creates detailed designs for modules, APIs, UI components"
  
skills:
  - DES-001  # Module Design
  - DES-002  # API Contract Design
  - DES-003  # UI/UX Design
  - DES-004  # Component Design
  - DES-005  # Data Flow Design
  - DES-006  # Error Handling Design
  - DES-007  # State Management Design
  - DES-008  # Integration Design
  - DES-009  # Validation Design
  - DES-010  # Wireframing

frameworks:
  bmad:
    agents:
      - designer
      - ux-designer
  ralph:
    use_cases:
      - OpenAPI spec iteration until validation passes
      - Wireframe refinement based on feedback
      - User flow optimization through iteration
    example_prompt: |
      Create OpenAPI specification for user profile endpoints.
      1. Define endpoints based on requirements
      2. Add request/response schemas
      3. Run OpenAPI validator
      4. Fix any validation errors
      5. Add error responses for all failure cases
      6. Validate against requirements coverage
      Iterate until spec validates and covers all requirements.
      Output: <promise>DESIGN_COMPLETE</promise>

responsibilities:
  - Decompose architecture into module designs
  - Create OpenAPI specifications
  - Design UI wireframes
  - Document user flows
  - Design error handling
  - Specify validation rules
  - Design external API integration contracts

outputs:
  - docs/design/openapi_spec.yaml
  - docs/design/module_designs/
  - docs/design/wireframes/
  - docs/design/user_flows/
  - docs/design/error_taxonomy.md
EOF

# Agent 5: Test Manager
cat > agents/test-manager/agent.yaml << 'EOF'
agent:
  id: test-manager
  name: "Test Manager"
  project: "studyabroad-v1"
  description: "Orchestrates all testing activities, maintains traceability, manages test lifecycle"
  
skills:
  - TEST-001  # Test Strategy Design
  - TEST-002  # Test Case Design
  - TEST-003  # Test Data Generation
  - TEST-004  # Coverage Analysis
  - TEST-005  # Traceability Management
  - TEST-006  # Impact Analysis
  - TEST-007  # Test Prioritization
  - TEST-008  # Defect Analysis
  - TEST-009  # Test Reporting
  - TEST-010  # Regression Management
  - TEST-011  # Test Environment Management
  - TEST-012  # Performance Test Design
  - TEST-013  # Security Test Design

frameworks:
  bmad:
    agents:
      - qa-tester
  ralph:
    use_cases:
      - Test case generation until coverage target met
      - Test data generation for edge cases
      - Regression suite optimization
    example_prompt: |
      Generate comprehensive test cases for user authentication.
      1. Analyze acceptance criteria
      2. Generate happy path test cases
      3. Generate edge case test cases
      4. Generate error handling test cases
      5. Check coverage against requirements
      6. Add missing test cases
      Iterate until 100% requirement coverage.
      Output: <promise>TESTS_COMPLETE</promise>
  superpowers:
    skills:
      - tdd
      - async-testing
      - testing-anti-patterns
      - verification-before-completion

responsibilities:
  - Create test strategy aligned with requirements
  - Design test cases from acceptance criteria
  - Maintain traceability matrix
  - Perform impact analysis on changes
  - Manage regression test suite
  - Generate test data (including mock external API responses)
  - Track and report coverage metrics
  - Coordinate with Developer on unit tests
  - Coordinate with Security on security tests

studyabroad_specific:
  test_areas:
    - user_authentication_oauth2
    - user_journey_flows
    - external_api_integration_mocks
    - gdpr_compliance_tests
    - accessibility_wcag_tests
  mock_apis:
    - university_api_mock
    - visa_service_mock
    - housing_api_mock

triggers:
  - requirement_added
  - requirement_modified
  - design_completed
  - code_changed
  - bug_reported
  - bug_fixed
  - release_preparation

outputs:
  - docs/testing/test_strategy.md
  - docs/testing/test_cases/
  - docs/testing/traceability_matrix.csv
  - docs/testing/coverage_reports/
  - docs/testing/api_mocks/
EOF

# Agent 6: Developer
cat > agents/developer/agent.yaml << 'EOF'
agent:
  id: developer
  name: "Developer Agent"
  project: "studyabroad-v1"
  description: "Implements code based on designs, writes unit tests, ensures code quality"
  
skills:
  - DEV-001  # Code Implementation
  - DEV-002  # Unit Test Writing
  - DEV-003  # API Implementation
  - DEV-004  # Database Integration
  - DEV-005  # Frontend Development
  - DEV-006  # Authentication Implementation
  - DEV-007  # Integration Implementation
  - DEV-008  # Error Handling
  - DEV-009  # Code Refactoring
  - DEV-010  # Bug Fixing
  - DEV-011  # Code Review
  - DEV-012  # Code Documentation
  - DEV-013  # Migration Writing
  - DEV-014  # Performance Optimization

frameworks:
  spec_kit:
    commands:
      - /speckit.implement
  bmad:
    agents:
      - developer
      - frontend-developer
      - backend-developer
  ralph:
    use_cases:
      - TDD implementation (RED-GREEN-REFACTOR loops)
      - Bug fixing until all tests pass
      - Feature implementation with iterative testing
      - Code refactoring with continuous test validation
    example_prompt: |
      Implement user profile API with TDD.
      1. Write failing test for GET /api/user/profile
      2. Implement minimal code to pass
      3. Refactor while keeping green
      4. Write failing test for PUT /api/user/profile
      5. Implement minimal code to pass
      6. Refactor while keeping green
      7. Ensure 80%+ code coverage
      8. Run linter and fix issues
      Iterate until all tests pass and coverage >= 80%.
      Output: <promise>IMPLEMENTATION_COMPLETE</promise>
  superpowers:
    skills:
      - tdd
      - code-review
      - systematic-debugging

responsibilities:
  - Implement features based on design specifications
  - Write unit tests (TDD approach)
  - Implement API endpoints per OpenAPI spec
  - Write database migrations
  - Implement authentication (OAuth2/SSO)
  - Integrate external APIs
  - Handle errors according to error taxonomy
  - Write code documentation
  - Participate in code review
  - Fix bugs

studyabroad_specific:
  tech_stack:
    frontend: "React + TypeScript"
    backend: "Node.js/Express or Python/FastAPI"
    database: "PostgreSQL"
    auth: "OAuth2 (Google, University SSO)"
  code_locations:
    frontend: "src/frontend/"
    backend: "src/backend/"
    database: "src/database/"

outputs:
  - src/frontend/
  - src/backend/
  - src/database/migrations/
  - tests/unit/
  - coverage_report.html
EOF

# Agent 7: Security
cat > agents/security/agent.yaml << 'EOF'
agent:
  id: security
  name: "Security Agent"
  project: "studyabroad-v1"
  description: "Ensures security throughout SDLC, from architecture to production"
  
skills:
  - SEC-001  # Security Architecture Review
  - SEC-002  # Threat Modeling
  - SEC-003  # Vulnerability Scanning
  - SEC-004  # Dependency Auditing
  - SEC-005  # Code Security Review
  - SEC-006  # Authentication Testing
  - SEC-007  # Authorization Testing
  - SEC-008  # Input Validation Testing
  - SEC-009  # Security Configuration
  - SEC-010  # Compliance Checking
  - SEC-011  # Penetration Testing
  - SEC-012  # Security Reporting
  - SEC-013  # Incident Analysis

frameworks:
  bmad:
    agents:
      - security-expert
  ralph:
    use_cases:
      - Vulnerability remediation until scan passes
      - Security issue fixing with continuous scanning
      - GDPR compliance fixes until audit passes
    example_prompt: |
      Fix security vulnerabilities in authentication module.
      1. Run security scan
      2. Identify highest severity issue
      3. Implement fix
      4. Run security scan again
      5. If issues remain, repeat from step 2
      6. Verify no regression in functionality
      Iterate until security scan shows zero critical/high issues.
      Output: <promise>SECURITY_CLEAN</promise>

responsibilities:
  - Review architecture for security concerns
  - Create threat models (STRIDE)
  - Run automated security scans
  - Audit dependencies for vulnerabilities
  - Review code for security issues
  - Test authentication and authorization
  - Test for OWASP Top 10 vulnerabilities
  - Verify GDPR compliance
  - Ensure PII protection
  - Provide security sign-off for releases

studyabroad_specific:
  compliance:
    - GDPR
    - FERPA (for academic records)
    - OWASP_Top_10
  focus_areas:
    - oauth2_sso_security
    - pii_encryption
    - third_party_api_security
    - student_data_protection

outputs:
  - docs/security/threat_model.md
  - docs/security/vulnerability_reports/
  - docs/security/compliance_checklist.md
  - docs/security/gdpr_assessment.md
EOF

# Agent 8: DevOps
cat > agents/devops/agent.yaml << 'EOF'
agent:
  id: devops
  name: "DevOps Agent"
  project: "studyabroad-v1"
  description: "Manages CI/CD, infrastructure, deployments"
  
skills:
  - OPS-001  # CI Pipeline Configuration
  - OPS-002  # CD Pipeline Configuration
  - OPS-003  # Infrastructure as Code
  - OPS-004  # Container Management
  - OPS-005  # Environment Configuration
  - OPS-006  # Secret Management
  - OPS-007  # Deployment Execution
  - OPS-008  # Rollback Management
  - OPS-009  # SSL/TLS Management
  - OPS-010  # DNS Management
  - OPS-011  # Monitoring Setup
  - OPS-012  # Log Management
  - OPS-013  # Backup Management
  - OPS-014  # Performance Tuning

frameworks:
  bmad:
    agents:
      - devops
      - database-admin
  ralph:
    use_cases:
      - CI/CD pipeline debugging until green
      - Infrastructure issue resolution
      - Deployment troubleshooting until successful
    example_prompt: |
      Fix CI pipeline failures.
      1. Run pipeline and capture errors
      2. Analyze failure cause
      3. Implement fix
      4. Run pipeline again
      5. If failures remain, repeat from step 1
      Iterate until pipeline passes all stages.
      Output: <promise>PIPELINE_WORKING</promise>

responsibilities:
  - Configure CI/CD pipelines
  - Write infrastructure as code
  - Create Docker configurations
  - Manage environment configs
  - Manage secrets securely
  - Execute deployments
  - Monitor deployment health
  - Execute rollbacks
  - Manage SSL certificates
  - Configure backups

studyabroad_specific:
  environments:
    - development
    - staging
    - production
  infrastructure:
    cloud_provider: "AWS/GCP/Azure (TBD)"
    containerization: "Docker"
    orchestration: "Kubernetes (optional)"
  considerations:
    - multi_region_for_students_abroad
    - peak_scaling_for_application_deadlines
    - gdpr_compliant_data_residency

outputs:
  - .github/workflows/
  - infrastructure/
  - docker-compose.yml
  - Dockerfile
  - docs/runbooks/deployment.md
EOF

# Agent 9: Documentation
cat > agents/documentation/agent.yaml << 'EOF'
agent:
  id: documentation
  name: "Documentation Agent"
  project: "studyabroad-v1"
  description: "Creates and maintains all project documentation"
  
skills:
  - DOC-001  # Technical Writing
  - DOC-002  # API Documentation
  - DOC-003  # Architecture Documentation
  - DOC-004  # User Documentation
  - DOC-005  # Runbook Writing
  - DOC-006  # README Creation
  - DOC-007  # Changelog Management
  - DOC-008  # Diagram Creation
  - DOC-009  # Documentation Review
  - DOC-010  # Documentation Versioning

frameworks:
  bmad:
    agents:
      - technical-writer
  ralph:
    use_cases:
      - Documentation completion until comprehensive
      - API documentation generation and validation
      - User guide writing with completeness checking
    example_prompt: |
      Create comprehensive API documentation for user endpoints.
      1. Extract endpoint definitions from OpenAPI spec
      2. Generate documentation for each endpoint
      3. Add request/response examples
      4. Add error handling documentation
      5. Validate against OpenAPI spec for completeness
      6. Add missing sections
      Iterate until documentation covers 100% of endpoints.
      Output: <promise>DOCS_COMPLETE</promise>

responsibilities:
  - Create and maintain README
  - Generate API documentation from OpenAPI
  - Document architecture decisions
  - Write operational runbooks
  - Maintain changelog
  - Create user documentation
  - Write privacy policy documentation
  - Create help content for users

studyabroad_specific:
  user_docs:
    - student_user_guide
    - advisor_admin_guide
    - faq
  legal_docs:
    - privacy_policy
    - terms_of_service
    - cookie_policy

outputs:
  - README.md
  - docs/api/
  - docs/user-guide/
  - docs/runbooks/
  - CHANGELOG.md
  - PRIVACY.md
EOF

# Agent 10: Operations
cat > agents/operations/agent.yaml << 'EOF'
agent:
  id: operations
  name: "Operations Agent"
  project: "studyabroad-v1"
  description: "Monitors production, handles incidents, maintains system health"
  
skills:
  - MON-001  # Monitoring Configuration
  - MON-002  # Log Analysis
  - MON-003  # Incident Detection
  - MON-004  # Incident Response
  - MON-005  # Root Cause Analysis
  - MON-006  # Performance Analysis
  - MON-007  # Capacity Planning
  - MON-008  # Health Checking
  - MON-009  # Alert Tuning
  - MON-010  # Post-Mortem Writing
  - MON-011  # SLA Monitoring
  - MON-012  # Cost Monitoring

frameworks:
  bmad:
    agents: []  # Custom implementation
  ralph:
    use_cases:
      - Incident resolution until service restored
      - Root cause analysis with iterative investigation
      - Alert tuning until noise reduced
    example_prompt: |
      Resolve production incident: high latency on user profile API.
      1. Check monitoring dashboards
      2. Identify potential causes
      3. Investigate most likely cause
      4. Implement fix or mitigation
      5. Verify latency improvement
      6. If issue persists, repeat from step 2
      7. Document root cause and fix
      Iterate until latency is within SLA.
      Output: <promise>INCIDENT_RESOLVED</promise>
  superpowers:
    skills:
      - systematic-debugging
      - root-cause-tracing

responsibilities:
  - Configure monitoring and alerting
  - Monitor system health
  - Respond to incidents
  - Perform root cause analysis
  - Write post-mortems
  - Track SLA compliance
  - Plan capacity for growth
  - Tune alerts
  - Escalate issues to development
  - Monitor costs

studyabroad_specific:
  critical_periods:
    - application_deadlines
    - enrollment_periods
    - start_of_semester
  key_metrics:
    - application_completion_rate
    - api_reliability
    - user_journey_completion
    - external_api_health

outputs:
  - docs/operations/monitoring_config/
  - docs/operations/runbooks/
  - docs/operations/post_mortems/
  - docs/operations/dashboards/
EOF
```

### Step 9.2: Create Agent Communication Protocol

```bash
cat > agents/PROTOCOL.md << 'EOF'
# Agent Communication Protocol
## StudyAbroad-v1

## Message Format

All inter-agent communication uses this format:

```json
{
  "message_id": "uuid",
  "timestamp": "ISO8601",
  "project": "studyabroad-v1",
  "from_agent": "agent_id",
  "to_agent": "agent_id",
  "message_type": "request|response|notification",
  "subject": "description",
  "payload": {},
  "requires_response": true|false,
  "priority": "high|medium|low",
  "context": {
    "phase": "current_sdlc_phase",
    "task_id": "related_task",
    "requirement_id": "related_requirement",
    "user_journey": "discovery|application|preparation|abroad|return"
  }
}
```

## Communication Patterns

### 1. Task Delegation (Orchestrator → Agent)
```json
{
  "message_type": "request",
  "subject": "task_assignment",
  "payload": {
    "task_id": "TASK-001",
    "description": "Implement user profile endpoint",
    "inputs": ["docs/design/openapi_spec.yaml"],
    "expected_outputs": ["src/backend/user/profile.ts"],
    "deadline": "ISO8601",
    "user_journey": "application"
  }
}
```

### 2. Change Notification (Any Agent → Test Manager)
```json
{
  "message_type": "notification",
  "subject": "artifact_changed",
  "payload": {
    "artifact_type": "requirement",
    "artifact_id": "REQ-015",
    "change_type": "modified",
    "change_summary": "Added document upload requirement",
    "affects_gdpr": true,
    "affects_external_api": false
  }
}
```

### 3. Security Review Request
```json
{
  "message_type": "request",
  "subject": "security_review",
  "payload": {
    "code_path": "src/backend/auth/",
    "change_description": "OAuth2 implementation",
    "pii_involved": true,
    "external_apis": ["university_sso"]
  }
}
```

## Agent Responsibilities Matrix

| From \ To | ORCH | REQ | ARCH | DES | TEST | DEV | SEC | OPS | DOC | MON |
|-----------|------|-----|------|-----|------|-----|-----|-----|-----|-----|
| ORCH      | -    | ✓   | ✓    | ✓   | ✓    | ✓   | ✓   | ✓   | ✓   | ✓   |
| REQ       | ✓    | -   | ✓    | ✓   | ✓    |     |     |     | ✓   |     |
| ARCH      | ✓    | ←   | -    | ✓   | ✓    | ✓   | ↔   | ✓   | ✓   |     |
| DES       | ✓    | ←   | ←    | -   | ✓    | ✓   | ←   |     | ✓   |     |
| TEST      | ✓    | ←   | ←    | ←   | -    | ↔   | ↔   |     | ✓   |     |
| DEV       | ✓    |     | ←    | ←   | ↔    | -   | ←   | ✓   | ✓   |     |
| SEC       | ✓    |     | ↔    | ✓   | ↔    | ✓   | -   | ✓   | ✓   | ←   |
| OPS-DEV   | ✓    |     | ←    |     |      | ←   | ←   | -   | ✓   | ✓   |
| DOC       | ✓    | ←   | ←    | ←   | ←    | ←   | ←   | ←   | -   | ←   |
| MON       | ✓    |     |      |     |      |     | ✓   | ←   | ✓   | -   |

Legend: ✓ = sends to, ← = receives from, ↔ = bidirectional
EOF

git add agents/
git commit -m "feat: create all 10 agent definitions for StudyAbroad-v1"
```

---

## 10. Phase 8: Creating Your 116 Skills

### Skill Ownership Pattern

Each skill follows a **1-to-many ownership pattern** where skills have a clear primary owner but can be invoked by collaborating agents:

```yaml
# Ownership Pattern Structure
skill:
  id: SKILL-XXX
  name: "skill-name"
  owner: primary-agent          # Has full authority and responsibility
  collaborators:                # Can invoke this skill for specific purposes
    - agent-name: purpose
  delegation_rules: |
    When and why other agents might use this skill
```

#### Ownership Principles

| Principle | Description |
|-----------|-------------|
| **Single Owner** | Every skill has exactly ONE primary owner agent |
| **Clear Accountability** | Owner is responsible for skill quality and outcomes |
| **Explicit Collaboration** | Collaborators are listed with their specific use cases |
| **Delegation Rules** | Document when/why cross-agent invocation is appropriate |

#### Cross-Cutting Skills

Some skills are legitimately used across multiple agents. These require explicit collaboration mapping:

```yaml
# Example: Code Review skill
DEV-011:
  name: code-review
  owner: developer-agent
  collaborators:
    - security-agent: "Security-focused code review"
    - architecture-agent: "Architectural compliance review"
  delegation_rules: |
    - Security-agent invokes for authentication/authorization code
    - Architecture-agent invokes for API design compliance
    - Developer-agent owns general code quality reviews
```

#### Cross-Cutting Skills Matrix

| Skill ID | Skill Name | Owner | Collaborators | Collaboration Purpose |
|----------|------------|-------|---------------|----------------------|
| DEV-011 | Code Review | developer | security, architecture | Security & architecture compliance |
| DEV-012 | Code Documentation | developer | documentation | API docs, user guides |
| TEST-005 | Traceability Management | test-manager | requirements | Requirements coverage |
| TEST-006 | Impact Analysis | test-manager | requirements, developer | Change impact assessment |
| SEC-005 | Code Security Review | security | developer | Security-focused code review |
| DOC-002 | API Documentation | documentation | developer, design | OpenAPI-based docs |
| ARCH-010 | ADR Writing | architecture | developer, security | Decision documentation |
| REQ-007 | Change Impact Analysis | requirements | test-manager, developer | Requirement change impact |

### Step 10.1: Create Skill Generation Script

```bash
cat > scripts/generate-skills.sh << 'EOF'
#!/bin/bash

# Generate all 116 skill files for StudyAbroad-v1
# Run from: ~/projects/studyabroad-v1

cd ~/projects/studyabroad-v1

echo "🚀 Generating 116 skills for StudyAbroad-v1..."
echo ""

# Function to generate skill file
generate_skill() {
  local skill_id=$1
  local skill_name=$2
  local description=$3
  local agent=$4
  local category=$5
  
  local dir="skills/${category}/${skill_name}"
  mkdir -p "$dir"
  
  cat > "$dir/SKILL.md" << SKILLEOF
---
name: ${skill_name}
description: ${description}
skill_id: ${skill_id}
owner: ${agent}
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: [Define specific conditions]
dependencies: []
---

# ${skill_name//-/ }

## Purpose
${description}

## Ownership
- **Owner:** ${agent}-agent (primary responsibility)
- **Collaborators:** None (or list agents that may invoke this skill)
- **Delegation Rules:** [When other agents should invoke this skill]

## When to Use
[Specific conditions when this skill should be activated]

## Prerequisites
- [List prerequisites]

## Process

### Step 1: [Step Name]
\`\`\`
[Instructions]
\`\`\`

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|

## Outputs
| Output | Type | Description |
|--------|------|-------------|

## StudyAbroad-Specific Considerations
- [Domain-specific notes]

## Integration Points
- [How this skill integrates with other agents/frameworks]

## Examples
[Example usage]

## Validation
[How to verify successful execution]
SKILLEOF

  echo "  ✅ Created: $dir/SKILL.md"
}

# Orchestrator Skills (8)
echo "📦 Generating Orchestrator skills (8)..."
generate_skill "ORCH-001" "workflow-management" "Manage SDLC workflow phases and transitions" "orchestrator" "orchestration"
generate_skill "ORCH-002" "task-decomposition" "Break down requirements into agent-assignable tasks" "orchestrator" "orchestration"
generate_skill "ORCH-003" "progress-tracking" "Monitor task completion and blockers" "orchestrator" "orchestration"
generate_skill "ORCH-004" "gate-validation" "Verify phase completion criteria" "orchestrator" "orchestration"
generate_skill "ORCH-005" "conflict-resolution" "Handle conflicting outputs from agents" "orchestrator" "orchestration"
generate_skill "ORCH-006" "priority-management" "Determine task urgency and sequencing" "orchestrator" "orchestration"
generate_skill "ORCH-007" "communication-routing" "Route information between agents" "orchestrator" "orchestration"
generate_skill "ORCH-008" "risk-assessment" "Identify project risks and mitigations" "orchestrator" "orchestration"

# Requirements Skills (10)
echo "📦 Generating Requirements skills (10)..."
generate_skill "REQ-001" "requirements-elicitation" "Extract requirements from descriptions" "requirements" "requirements"
generate_skill "REQ-002" "user-story-writing" "Create user stories with acceptance criteria" "requirements" "requirements"
generate_skill "REQ-003" "requirements-classification" "Categorize as functional, non-functional, constraint" "requirements" "requirements"
generate_skill "REQ-004" "ambiguity-detection" "Identify vague or conflicting requirements" "requirements" "requirements"
generate_skill "REQ-005" "requirements-prioritization" "Apply MoSCoW prioritization" "requirements" "requirements"
generate_skill "REQ-006" "dependency-mapping" "Identify requirement dependencies" "requirements" "requirements"
generate_skill "REQ-007" "change-impact-analysis" "Assess impact of requirement changes" "requirements" "requirements"
generate_skill "REQ-008" "traceability-management" "Maintain requirement IDs and relationships" "requirements" "requirements"
generate_skill "REQ-009" "acceptance-criteria-writing" "Define testable acceptance criteria" "requirements" "requirements"
generate_skill "REQ-010" "nfr-quantification" "Convert NFRs to measurable targets" "requirements" "requirements"

# Architecture Skills (12)
echo "📦 Generating Architecture skills (12)..."
generate_skill "ARCH-001" "architecture-pattern-selection" "Choose appropriate patterns" "architecture" "architecture"
generate_skill "ARCH-002" "technology-evaluation" "Assess and compare tech options" "architecture" "architecture"
generate_skill "ARCH-003" "database-design" "Design schemas and select database types" "architecture" "architecture"
generate_skill "ARCH-004" "api-architecture" "Design API structure and contracts" "architecture" "architecture"
generate_skill "ARCH-005" "infrastructure-design" "Cloud architecture and containerization" "architecture" "architecture"
generate_skill "ARCH-006" "security-architecture" "Auth flows, encryption, access control" "architecture" "architecture"
generate_skill "ARCH-007" "scalability-planning" "Design for growth and load" "architecture" "architecture"
generate_skill "ARCH-008" "integration-architecture" "External service integration patterns" "architecture" "architecture"
generate_skill "ARCH-009" "cost-estimation" "Estimate infrastructure costs" "architecture" "architecture"
generate_skill "ARCH-010" "adr-writing" "Document architecture decisions" "architecture" "architecture"
generate_skill "ARCH-011" "diagram-generation" "Create C4, sequence, ER diagrams" "architecture" "architecture"
generate_skill "ARCH-012" "environment-design" "Define dev, test, staging, prod environments" "architecture" "architecture"

# Design Skills (10)
echo "📦 Generating Design skills (10)..."
generate_skill "DES-001" "module-design" "Break architecture into modules" "design" "design"
generate_skill "DES-002" "api-contract-design" "Create OpenAPI specifications" "design" "design"
generate_skill "DES-003" "ui-ux-design" "Design user interfaces and flows" "design" "design"
generate_skill "DES-004" "component-design" "Design reusable components" "design" "design"
generate_skill "DES-005" "data-flow-design" "Design data transformations" "design" "design"
generate_skill "DES-006" "error-handling-design" "Design error taxonomy" "design" "design"
generate_skill "DES-007" "state-management-design" "Design application state" "design" "design"
generate_skill "DES-008" "integration-design" "Design external API integrations" "design" "design"
generate_skill "DES-009" "validation-design" "Design input validation rules" "design" "design"
generate_skill "DES-010" "wireframing" "Create UI wireframes and mockups" "design" "design"

# Test Manager Skills (13)
echo "📦 Generating Test Manager skills (13)..."
generate_skill "TEST-001" "test-strategy-design" "Create comprehensive test strategies" "test-manager" "testing"
generate_skill "TEST-002" "test-case-design" "Write test cases from requirements" "test-manager" "testing"
generate_skill "TEST-003" "test-data-generation" "Create appropriate test data" "test-manager" "testing"
generate_skill "TEST-004" "coverage-analysis" "Analyze requirement and code coverage" "test-manager" "testing"
generate_skill "TEST-005" "traceability-management" "Link tests to requirements" "test-manager" "testing"
generate_skill "TEST-006" "impact-analysis" "Identify tests affected by changes" "test-manager" "testing"
generate_skill "TEST-007" "test-prioritization" "Risk-based test selection" "test-manager" "testing"
generate_skill "TEST-008" "defect-analysis" "Analyze test failures and patterns" "test-manager" "testing"
generate_skill "TEST-009" "test-reporting" "Generate test status reports" "test-manager" "testing"
generate_skill "TEST-010" "regression-management" "Maintain regression test suites" "test-manager" "testing"
generate_skill "TEST-011" "test-environment-management" "Manage test env requirements" "test-manager" "testing"
generate_skill "TEST-012" "performance-test-design" "Design load and stress tests" "test-manager" "testing"
generate_skill "TEST-013" "security-test-design" "Design security test scenarios" "test-manager" "testing"

# Developer Skills (14)
echo "📦 Generating Developer skills (14)..."
generate_skill "DEV-001" "code-implementation" "Write production code from designs" "developer" "development"
generate_skill "DEV-002" "unit-test-writing" "Write comprehensive unit tests" "developer" "development"
generate_skill "DEV-003" "api-implementation" "Implement REST/GraphQL endpoints" "developer" "development"
generate_skill "DEV-004" "database-integration" "Implement data access layer" "developer" "development"
generate_skill "DEV-005" "frontend-development" "Implement UI components" "developer" "development"
generate_skill "DEV-006" "authentication-implementation" "Implement auth flows" "developer" "development"
generate_skill "DEV-007" "integration-implementation" "Implement external integrations" "developer" "development"
generate_skill "DEV-008" "error-handling" "Implement error handling patterns" "developer" "development"
generate_skill "DEV-009" "code-refactoring" "Improve code quality" "developer" "development"
generate_skill "DEV-010" "bug-fixing" "Diagnose and fix defects" "developer" "development"
generate_skill "DEV-011" "code-review" "Review code for quality" "developer" "development"
generate_skill "DEV-012" "code-documentation" "Write code documentation" "developer" "development"
generate_skill "DEV-013" "migration-writing" "Write database migrations" "developer" "development"
generate_skill "DEV-014" "performance-optimization" "Optimize code performance" "developer" "development"

# Security Skills (13)
echo "📦 Generating Security skills (13)..."
generate_skill "SEC-001" "security-architecture-review" "Review architecture for security" "security" "security"
generate_skill "SEC-002" "threat-modeling" "Identify threats using STRIDE" "security" "security"
generate_skill "SEC-003" "vulnerability-scanning" "Run automated security scans" "security" "security"
generate_skill "SEC-004" "dependency-auditing" "Check dependencies for vulnerabilities" "security" "security"
generate_skill "SEC-005" "code-security-review" "Review code for security issues" "security" "security"
generate_skill "SEC-006" "authentication-testing" "Test auth flows for weaknesses" "security" "security"
generate_skill "SEC-007" "authorization-testing" "Test permission boundaries" "security" "security"
generate_skill "SEC-008" "input-validation-testing" "Test for injection vulnerabilities" "security" "security"
generate_skill "SEC-009" "security-configuration" "Review and harden configurations" "security" "security"
generate_skill "SEC-010" "compliance-checking" "Verify compliance requirements" "security" "security"
generate_skill "SEC-011" "penetration-testing" "Conduct security testing" "security" "security"
generate_skill "SEC-012" "security-reporting" "Generate security reports" "security" "security"
generate_skill "SEC-013" "incident-analysis" "Analyze security incidents" "security" "security"

# DevOps Skills (14)
echo "📦 Generating DevOps skills (14)..."
generate_skill "OPS-001" "ci-pipeline-configuration" "Set up continuous integration" "devops" "devops"
generate_skill "OPS-002" "cd-pipeline-configuration" "Set up continuous deployment" "devops" "devops"
generate_skill "OPS-003" "infrastructure-as-code" "Write and manage IaC" "devops" "devops"
generate_skill "OPS-004" "container-management" "Docker and orchestration" "devops" "devops"
generate_skill "OPS-005" "environment-configuration" "Manage env-specific configs" "devops" "devops"
generate_skill "OPS-006" "secret-management" "Securely manage secrets" "devops" "devops"
generate_skill "OPS-007" "deployment-execution" "Execute deployments" "devops" "devops"
generate_skill "OPS-008" "rollback-management" "Execute and test rollbacks" "devops" "devops"
generate_skill "OPS-009" "ssl-tls-management" "Manage certificates" "devops" "devops"
generate_skill "OPS-010" "dns-management" "Configure DNS records" "devops" "devops"
generate_skill "OPS-011" "monitoring-setup" "Configure monitoring tools" "devops" "devops"
generate_skill "OPS-012" "log-management" "Set up log aggregation" "devops" "devops"
generate_skill "OPS-013" "backup-management" "Configure backups" "devops" "devops"
generate_skill "OPS-014" "performance-tuning" "Optimize infrastructure" "devops" "devops"

# Documentation Skills (10)
echo "📦 Generating Documentation skills (10)..."
generate_skill "DOC-001" "technical-writing" "Write clear technical documentation" "documentation" "documentation"
generate_skill "DOC-002" "api-documentation" "Generate and maintain API docs" "documentation" "documentation"
generate_skill "DOC-003" "architecture-documentation" "Document architecture decisions" "documentation" "documentation"
generate_skill "DOC-004" "user-documentation" "Write user guides" "documentation" "documentation"
generate_skill "DOC-005" "runbook-writing" "Create operational runbooks" "documentation" "documentation"
generate_skill "DOC-006" "readme-creation" "Write project READMEs" "documentation" "documentation"
generate_skill "DOC-007" "changelog-management" "Maintain changelogs" "documentation" "documentation"
generate_skill "DOC-008" "diagram-creation" "Create technical diagrams" "documentation" "documentation"
generate_skill "DOC-009" "documentation-review" "Review docs for accuracy" "documentation" "documentation"
generate_skill "DOC-010" "documentation-versioning" "Version documentation" "documentation" "documentation"

# Operations/Monitoring Skills (12)
echo "📦 Generating Operations skills (12)..."
generate_skill "MON-001" "monitoring-configuration" "Set up monitoring and alerting" "operations" "operations"
generate_skill "MON-002" "log-analysis" "Analyze logs for issues" "operations" "operations"
generate_skill "MON-003" "incident-detection" "Identify system issues" "operations" "operations"
generate_skill "MON-004" "incident-response" "Respond to alerts" "operations" "operations"
generate_skill "MON-005" "root-cause-analysis" "Determine incident causes" "operations" "operations"
generate_skill "MON-006" "performance-analysis" "Analyze system performance" "operations" "operations"
generate_skill "MON-007" "capacity-planning" "Plan for growth" "operations" "operations"
generate_skill "MON-008" "health-checking" "Verify system health" "operations" "operations"
generate_skill "MON-009" "alert-tuning" "Reduce noise, improve signals" "operations" "operations"
generate_skill "MON-010" "post-mortem-writing" "Document incidents" "operations" "operations"
generate_skill "MON-011" "sla-monitoring" "Track SLA compliance" "operations" "operations"
generate_skill "MON-012" "cost-monitoring" "Track infrastructure costs" "operations" "operations"

echo ""
echo "======================================"
echo "✅ Skill generation complete!"
echo ""
echo "Skills count by agent:"
echo "  Orchestrator:   8"
echo "  Requirements:   10"
echo "  Architecture:   12"
echo "  Design:         10"
echo "  Test Manager:   13"
echo "  Developer:      14"
echo "  Security:       13"
echo "  DevOps:         14"
echo "  Documentation:  10"
echo "  Operations:     12"
echo "  ─────────────────"
echo "  Total:          116"
echo ""
echo "Next: Update skills/SKILLS_INDEX.md to reflect generated files"
EOF

chmod +x scripts/generate-skills.sh
```

### Step 10.2: Run Skill Generation

```bash
cd ~/projects/studyabroad-v1
./scripts/generate-skills.sh

# Verify
find skills -name "SKILL.md" | wc -l
# Should output: 116

git add skills/ scripts/
git commit -m "feat: generate all 116 skill templates for StudyAbroad-v1"
```

---

## 11. Phase 9: Orchestrator Configuration

### Step 11.1: Create Orchestrator Main Configuration

```bash
cat > agents/orchestrator/orchestrator.yaml << 'EOF'
# Orchestrator Agent Configuration
# Project: StudyAbroad-v1

orchestrator:
  name: "SDLC Orchestrator"
  project: "studyabroad-v1"
  version: "1.0.0"
  
  # Startup behavior
  initialization:
    - load_workflow_state
    - load_12_factors
    - initialize_agents
    - check_pending_tasks
  
  # Agent registry
  agents:
    requirements:
      path: ../requirements/agent.yaml
      bmad_mapping: [analyst, product-manager]
      spec_kit_phase: specify
      
    architecture:
      path: ../architecture/agent.yaml
      bmad_mapping: [architect]
      spec_kit_phase: plan
      
    design:
      path: ../design/agent.yaml
      bmad_mapping: [designer, ux-designer]
      spec_kit_phase: plan
      
    test_manager:
      path: ../test-manager/agent.yaml
      bmad_mapping: [qa-tester]
      superpowers: [tdd, verification-before-completion]
      
    developer:
      path: ../developer/agent.yaml
      bmad_mapping: [developer, frontend-developer, backend-developer]
      superpowers: [tdd, code-review]
      spec_kit_phase: implement
      
    security:
      path: ../security/agent.yaml
      bmad_mapping: [security-expert]
      
    devops:
      path: ../devops/agent.yaml
      bmad_mapping: [devops, database-admin]
      
    documentation:
      path: ../documentation/agent.yaml
      bmad_mapping: [technical-writer]
      
    operations:
      path: ../operations/agent.yaml
      bmad_mapping: []
  
  # Workflow phases
  phases:
    - id: requirements
      name: "Requirements Capture"
      agents: [requirements]
      spec_kit_command: /speckit.specify
      gate:
        id: GATE-1
        checklist:
          - requirements_spec_complete
          - user_stories_have_acceptance_criteria
          - nfrs_quantified
          - user_journeys_documented
          - external_api_requirements_identified
          - gdpr_requirements_documented
          - human_approval
          
    - id: architecture
      name: "Architecture Design"
      agents: [architecture, security]
      spec_kit_command: /speckit.plan
      gate:
        id: GATE-2
        checklist:
          - architecture_documented
          - adrs_created
          - security_architecture_reviewed
          - tech_stack_decided
          - database_schema_defined
          - external_api_architecture_defined
          - scalability_plan_documented
          
    - id: design
      name: "Detailed Design"
      agents: [design]
      gate:
        id: GATE-3
        checklist:
          - openapi_spec_complete
          - module_designs_complete
          - wireframes_approved
          - error_taxonomy_defined
          - user_flows_complete
          
    - id: test_design
      name: "Test Design"
      agents: [test_manager]
      gate:
        id: GATE-4
        checklist:
          - test_strategy_approved
          - test_cases_written
          - traceability_matrix_complete
          - test_data_prepared
          - api_mocks_created
          
    - id: implementation
      name: "Implementation"
      agents: [developer, test_manager]
      spec_kit_command: /speckit.implement
      superpowers: [tdd]
      gate:
        id: GATE-5
        checklist:
          - all_code_implemented
          - unit_tests_pass
          - coverage_80_percent
          - code_reviewed
          - security_scan_clean
          
    - id: testing
      name: "Testing"
      agents: [test_manager, security]
      gate:
        id: GATE-6
        checklist:
          - integration_tests_pass
          - e2e_tests_pass
          - security_tests_pass
          - performance_tests_pass
          - accessibility_verified
          - external_api_tests_pass
          
    - id: validation
      name: "Independent Validation"
      agents: [test_manager, security]
      gate:
        id: GATE-7
        checklist:
          - all_requirements_traced
          - architecture_compliance_verified
          - security_sign_off
          - gdpr_compliance_verified
          
    - id: deployment
      name: "Deployment"
      agents: [devops]
      gate:
        id: GATE-8
        checklist:
          - staging_deployed
          - staging_tests_pass
          - production_deployed
          - post_deployment_verified
          
    - id: operations
      name: "Operations"
      agents: [operations]
      ongoing: true

  # 12 Factors enforcement
  twelve_factors:
    enabled: true
    config_path: ../../config/12-factors/factors.yaml
    enforcement_path: ../../config/12-factors/enforcement.yaml
    
  # State management
  state:
    workflow_state: .sdlc/workflow-state.json
    agent_assignments: .sdlc/agent-assignments.json
    audit_log: .sdlc/audit-log.json
    blockers: .sdlc/blockers.json
EOF
```

### Step 11.2: Create Orchestrator Commands Reference

```bash
cat > agents/orchestrator/commands.md << 'EOF'
# Orchestrator Commands
## StudyAbroad-v1

## Main Commands

### /orchestrate
Start the orchestrator for a new task or continue existing work.

```
/orchestrate [command] [options]
```

Commands:
- `start` - Start a new feature/project
- `status` - Show current workflow status
- `next` - Move to next phase (if gate passes)
- `assign` - Assign task to agent
- `validate` - Validate current gate
- `escalate` - Escalate issue to human

### /orchestrate start
```
/orchestrate start "Feature description"
```

Example:
```
/orchestrate start "Implement user profile management with document upload"
```

### /orchestrate status
Shows:
- Current phase
- Gate completion status
- Active tasks
- Blockers
- Agent assignments

### /orchestrate validate [gate-id]
```
/orchestrate validate GATE-1
```

### /orchestrate assign
```
/orchestrate assign [agent] [task-id] "task description"
```

Example:
```
/orchestrate assign developer TASK-001 "Implement OAuth2 login with Google"
```

## Integration Commands

### Spec Kit
```
/orchestrate specify    # → /speckit.specify
/orchestrate plan       # → /speckit.plan
/orchestrate tasks      # → /speckit.tasks
/orchestrate implement  # → /speckit.implement
```

### Superpowers
```
/orchestrate brainstorm    # → /superpowers:brainstorm
/orchestrate write-plan    # → /superpowers:write-plan
/orchestrate execute-plan  # → /superpowers:execute-plan
```

### BMAD
```
/orchestrate bmad analyst    # Activate BMAD analyst
/orchestrate bmad architect  # Activate BMAD architect
/orchestrate bmad dev        # Activate BMAD developer
```

### Ralph Wiggum (Autonomous Loops)
```
# Start autonomous loop for complex tasks
/ralph-loop "Implement user authentication with TDD" --max-iterations 30 --completion-promise "DONE"

# Cancel an active loop
/cancel-ralph

# Common use cases:
/ralph-loop "Fix all failing tests" --max-iterations 20 --completion-promise "TESTS_PASS"
/ralph-loop "Resolve security vulnerabilities" --max-iterations 25 --completion-promise "SECURITY_CLEAN"
/ralph-loop "Complete API documentation" --max-iterations 15 --completion-promise "DOCS_COMPLETE"
```

## Change Management

### New Requirement
```
/orchestrate change requirement "Add password reset feature"
```

Triggers:
1. Requirements Agent updates spec
2. Test Manager runs impact analysis
3. Affected tests flagged
4. Tasks created

### Bug Fix
```
/orchestrate bug "BUG-001" "Description"
```

### Hotfix
```
/orchestrate hotfix "Critical issue description"
```

## Daily Commands

```
/orchestrate status           # Current status
/orchestrate blockers         # Show blockers
/orchestrate agents tasks     # Agent workload
/orchestrate report daily     # Daily report
```
EOF

git add agents/orchestrator/
git commit -m "feat: configure orchestrator with commands for StudyAbroad-v1"
```

---

## 12. Phase 10: Testing the Integration

### Step 12.1: Create Integration Test Script

```bash
cat > scripts/test-integration.sh << 'EOF'
#!/bin/bash

echo "🧪 Testing SDLC Framework Integration"
echo "   Project: StudyAbroad-v1"
echo "======================================"
echo ""

cd ~/projects/studyabroad-v1

# Test 1: Verify directory structure
echo "1. Checking directory structure..."
REQUIRED_DIRS=(
  "agents"
  "skills"
  "config/spec-kit"
  "config/bmad"
  "config/ralph"
  "config/12-factors"
  ".specify"
  ".ralph"
  "src"
  "docs"
)

for dir in "${REQUIRED_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    echo "   ✅ $dir exists"
  else
    echo "   ❌ $dir missing!"
  fi
done
echo ""

# Test 2: Verify all 10 agent definitions
echo "2. Checking agent definitions..."
AGENTS=(orchestrator requirements architecture design test-manager developer security devops documentation operations)
for agent in "${AGENTS[@]}"; do
  if [ -f "agents/$agent/agent.yaml" ]; then
    echo "   ✅ $agent agent defined"
  else
    echo "   ❌ $agent agent missing!"
  fi
done
echo ""

# Test 3: Count skills
echo "3. Counting skills..."
SKILL_COUNT=$(find skills -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
echo "   Found $SKILL_COUNT skill files"
if [ "$SKILL_COUNT" -eq "116" ]; then
  echo "   ✅ All 116 skills present"
else
  echo "   ⚠️  Expected 116 skills, found $SKILL_COUNT"
fi
echo ""

# Test 4: Verify Spec Kit
echo "4. Checking Spec Kit..."
if command -v specify &> /dev/null; then
  echo "   ✅ Spec Kit CLI installed"
else
  echo "   ❌ Spec Kit CLI not found (run: uv tool install specify-cli)"
fi
if [ -f ".specify/constitution.md" ]; then
  echo "   ✅ Constitution defined"
else
  echo "   ❌ Constitution missing"
fi
echo ""

# Test 5: Verify BMAD
echo "5. Checking BMAD..."
if [ -d ".bmad" ]; then
  echo "   ✅ BMAD directory exists"
else
  echo "   ⚠️  BMAD not installed (run: npx bmad-method install)"
fi

# Test 6: Verify Ralph Wiggum
echo "6. Checking Ralph Wiggum..."
if [ -d ".ralph" ]; then
  echo "   ✅ Ralph configuration directory exists"
else
  echo "   ⚠️  Ralph not configured (run Phase 5 setup)"
fi

# Test Ralph plugin installation (requires Claude Code)
echo "   Checking Ralph plugin (run in Claude Code: /help to verify /ralph-loop command)"
echo ""

# Test 6: Check configuration files
echo "6. Checking configuration files..."
CONFIG_FILES=(
  "CLAUDE.md"
  "config/spec-kit/workflow.yaml"
  "config/bmad/agent-mapping.yaml"
  "config/ralph/config.yaml"
  "config/12-factors/factors.yaml"
  "config/12-factors/enforcement.yaml"
)
for file in "${CONFIG_FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "   ✅ $file exists"
  else
    echo "   ❌ $file missing!"
  fi
done
echo ""

# Test 7: Verify Claude Code
echo "7. Checking Claude Code..."
if command -v claude &> /dev/null; then
  echo "   ✅ Claude Code CLI installed"
  if [ -d "$HOME/.claude/plugins/cache/Superpowers" ]; then
    echo "   ✅ Superpowers plugin installed"
  else
    echo "   ⚠️  Superpowers not installed (install via Claude Code)"
  fi
else
  echo "   ❌ Claude Code not found"
fi
echo ""

echo "======================================"
echo "Integration test complete!"
echo ""
echo "Next steps:"
echo "  1. cd ~/projects/studyabroad-v1"
echo "  2. claude"
echo "  3. /orchestrate start \"Your first feature\""
EOF

chmod +x scripts/test-integration.sh
```

### Step 12.2: Run Integration Test

```bash
cd ~/projects/studyabroad-v1
./scripts/test-integration.sh
```

### Step 12.3: Create Initial Workflow State

```bash
mkdir -p .sdlc

cat > .sdlc/workflow-state.json << 'EOF'
{
  "project": "studyabroad-v1",
  "current_phase": "not_started",
  "phases_completed": [],
  "gates_passed": [],
  "created_at": "",
  "last_updated": ""
}
EOF

git add .sdlc/ scripts/
git commit -m "feat: add integration test and initial workflow state"
```

---

## 13. Phase 11: Production Workflow

### Step 12.1: Quick Start Guide

```bash
cat > docs/QUICK_START.md << 'EOF'
# StudyAbroad-v1 Quick Start Guide

## 🚀 Starting Development

### 1. Navigate to Project
```bash
cd ~/projects/studyabroad-v1
```

### 2. Start Claude Code
```bash
claude
```

### 3. Begin First Feature
```
/orchestrate start "Implement user registration with OAuth2"
```

## 📋 Main Commands

| Command | Purpose |
|---------|---------|
| `/orchestrate start "..."` | Begin new feature |
| `/orchestrate status` | View current status |
| `/orchestrate validate GATE-N` | Check gate requirements |
| `/orchestrate next` | Move to next phase |

## 🔄 Phase Flow

```
REQUIREMENTS → ARCHITECTURE → DESIGN → TEST DESIGN
     ↓              ↓           ↓          ↓
  GATE-1        GATE-2      GATE-3     GATE-4
     ↓              ↓           ↓          ↓
IMPLEMENTATION → TESTING → VALIDATION → DEPLOYMENT
     ↓              ↓           ↓          ↓
  GATE-5        GATE-6      GATE-7     GATE-8
```

## 👥 Your 10 Agents

| Agent | Purpose | Key Skills |
|-------|---------|------------|
| Orchestrator | Coordinates all | ORCH-001 to ORCH-008 |
| Requirements | Captures needs | REQ-001 to REQ-010 |
| Architecture | System design | ARCH-001 to ARCH-012 |
| Design | Detailed specs | DES-001 to DES-010 |
| **Test Manager** | Test orchestration | TEST-001 to TEST-013 |
| Developer | Implementation | DEV-001 to DEV-014 |
| Security | Security review | SEC-001 to SEC-013 |
| DevOps | CI/CD & deploy | OPS-001 to OPS-014 |
| Documentation | All docs | DOC-001 to DOC-010 |
| Operations | Monitoring | MON-001 to MON-012 |

## 📁 Key Directories

```
~/projects/studyabroad-v1/
├── src/              # Your application code
│   ├── frontend/
│   ├── backend/
│   └── database/
├── docs/             # Documentation
│   ├── requirements/
│   ├── architecture/
│   └── design/
├── agents/           # Agent definitions
├── skills/           # 116 skills
└── .sdlc/            # Workflow state
```

## ⚡ Common Workflows

### Handle Requirement Change
```
/orchestrate change requirement "Add feature X"
```

### Fix a Bug
```
/orchestrate bug "BUG-001" "Description of bug"
```

### Check Test Impact
```
Use TEST-006 Impact Analysis skill when code changes
```
EOF
```

### Step 12.2: Create Full Workflow Documentation

```bash
cat > docs/WORKFLOW.md << 'EOF'
# StudyAbroad-v1 Production Workflow Guide

## Starting Development

### Step 1: Start Claude Code
```bash
cd ~/projects/studyabroad-v1
claude
```

### Step 2: Begin Feature
```
/orchestrate start "Your feature description"
```

The orchestrator will guide you through each phase.

## Phase-by-Phase Guide

### Phase 1: Requirements
```
/orchestrate specify
```

Expected outputs in `docs/requirements/`:
- requirements_spec.md
- user_stories.json
- user_journeys/

Gate 1 validation:
```
/orchestrate validate GATE-1
```

### Phase 2: Architecture
```
/orchestrate plan
```

Expected outputs in `docs/architecture/`:
- architecture.md
- adrs/
- database_schema.sql

### Phase 3: Design
```
/orchestrate design
```

Expected outputs in `docs/design/`:
- openapi_spec.yaml
- wireframes/
- module_designs/

### Phase 4: Test Design
```
/orchestrate test-design
```

Expected outputs in `docs/testing/`:
- test_strategy.md
- test_cases/
- traceability_matrix.csv

### Phase 5: Implementation
```
/orchestrate implement
```

This uses TDD via Superpowers. Code goes in `src/`.

### Phase 6: Testing
```
/orchestrate test
```

Runs all test types.

### Phase 7-8: Validation & Deployment
```
/orchestrate validate-all
/orchestrate deploy staging
/orchestrate deploy production
```

## Handling Changes

### New Requirement
```
/orchestrate change requirement "Description"
```

This triggers:
1. Requirements Agent updates spec
2. Test Manager runs impact analysis (TEST-006)
3. Affected tests flagged

### Bug Fix
```
/orchestrate bug "BUG-001" "Description"
```

### Hotfix
```
/orchestrate hotfix "Critical issue"
```
EOF

git add docs/
git commit -m "docs: add quick start and workflow guides for StudyAbroad-v1"
```

---

## 13. Appendix: Reusing for Other Projects

When you want to use this framework for another project (e.g., `meal-planning`):

### Option 1: Copy Framework
```bash
# Create new project
mkdir -p ~/projects/meal-planning

# Copy framework files
cp -r ~/projects/studyabroad-v1/{agents,skills,config,scripts,.specify,CLAUDE.md} ~/projects/meal-planning/

# Create project-specific directories
mkdir -p ~/projects/meal-planning/{src,docs,.sdlc}

# Update CLAUDE.md for new project
# Update .specify/constitution.md for new project
# Update config files for new project
```

### Option 2: Create Shared Framework (Advanced)
```bash
# Create shared framework location
mkdir -p ~/sdlc-framework

# Move framework files there
mv ~/projects/studyabroad-v1/{agents,skills,config,scripts} ~/sdlc-framework/

# Create symlinks in each project
ln -s ~/sdlc-framework/agents ~/projects/studyabroad-v1/agents
ln -s ~/sdlc-framework/skills ~/projects/studyabroad-v1/skills
# etc.
```

---

## Final Directory Structure

```
~/projects/studyabroad-v1/
├── CLAUDE.md
├── .gitignore
├── .env.example
│
├── .specify/
│   ├── constitution.md
│   └── templates/
│
├── .bmad/
│   └── config.yaml
│
├── .ralph/
│   ├── config.yaml
│   └── prompts/
│
├── .sdlc/
│   ├── workflow-state.json
│   └── .gitkeep
│
├── agents/
│   ├── PROTOCOL.md
│   ├── orchestrator/
│   │   ├── agent.yaml
│   │   ├── orchestrator.yaml
│   │   └── commands.md
│   ├── requirements/
│   ├── architecture/
│   ├── design/
│   ├── test-manager/
│   ├── developer/
│   ├── security/
│   ├── devops/
│   ├── documentation/
│   └── operations/
│
├── skills/                    # 116 skills
│   ├── SKILLS_INDEX.md
│   ├── orchestration/         # 8 skills
│   ├── requirements/          # 10 skills
│   ├── architecture/          # 12 skills
│   ├── design/                # 10 skills
│   ├── testing/               # 13 skills
│   ├── development/           # 14 skills
│   ├── security/              # 13 skills
│   ├── devops/                # 14 skills
│   ├── documentation/         # 10 skills
│   └── operations/            # 12 skills
│
├── config/
│   ├── spec-kit/
│   │   └── workflow.yaml
│   ├── bmad/
│   │   └── agent-mapping.yaml
│   ├── ralph/
│   │   └── config.yaml
│   └── 12-factors/
│       ├── factors.yaml
│       └── enforcement.yaml
│
├── scripts/
│   ├── generate-skills.sh
│   └── test-integration.sh
│
├── docs/
│   ├── QUICK_START.md
│   ├── WORKFLOW.md
│   ├── requirements/
│   ├── architecture/
│   ├── design/
│   ├── testing/
│   └── runbooks/
│
└── src/                       # Your actual app code
    ├── frontend/
    ├── backend/
    └── database/
```

---

## Checklist: Implementation Progress

- [ ] Phase 1: Foundation Setup
- [ ] Phase 2: Spec Kit Installation
- [ ] Phase 3: Superpowers Installation
- [ ] Phase 4: BMAD Installation
- [ ] Phase 5: Ralph Wiggum Installation
- [ ] Phase 5: 12 Factors Configuration
- [ ] Phase 6: Agent Definitions
- [ ] Phase 7: Generate 116 Skills
- [ ] Phase 8: Orchestrator Configuration
- [ ] Phase 9: Integration Testing
- [ ] Phase 10: Start Using!

---

## Next Steps

1. **Execute Phase 1-9** in order
2. **Run integration test**: `./scripts/test-integration.sh`
3. **Start Claude Code**: `claude`
4. **Begin development**: `/orchestrate start "Your first feature"`

Good luck with StudyAbroad-v1! 🎓✈️

# Complete SDLC Skills Content Library
# Project: StudyAbroad-v1
# Total Skills: 116
#
# Ownership Pattern:
# - owner: Primary agent responsible for skill execution and quality
# - collaborators: Agents that may invoke this skill for specific purposes
# - Most skills are single-owner; cross-cutting skills list collaborators explicitly

# ============================================================================
# ORCHESTRATOR AGENT SKILLS (8 Skills: ORCH-001 to ORCH-008)
# ============================================================================

---
SKILL_ID: ORCH-001
SKILL_PATH: skills/orchestration/workflow-management/SKILL.md
---
name: workflow-management
description: Manage SDLC workflow phases, transitions, and agent coordination
skill_id: ORCH-001
owner: orchestrator
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Starting new features, phase transitions, daily standups, blocking issues
dependencies: []
---

# Workflow Management

## Purpose
Coordinate the complete SDLC workflow across all 10 agents for StudyAbroad-v1, managing phase transitions, enforcing gate validations, and ensuring smooth project progression from requirements to production.

## When to Use
- Starting a new feature or project
- Transitioning between SDLC phases
- Daily standup coordination
- When agents report completion or blocking issues
- Gate validation checkpoints
- Escalation decisions

## Prerequisites
- Project initialized with CLAUDE.md
- .sdlc/workflow-state.json exists
- All agent definitions loaded
- 12 Factors configuration available

## Process

### Step 1: Initialize Workflow State
```
1. Check if .sdlc/workflow-state.json exists
2. If new project, create initial state:
   {
     "project": "studyabroad-v1",
     "current_phase": "requirements",
     "phases_completed": [],
     "gates_passed": [],
     "active_tasks": [],
     "blockers": []
   }
3. Load 12 Factors enforcement rules
4. Initialize agent communication channels
```

### Step 2: Determine Current Phase
```
1. Read workflow-state.json
2. Identify current phase from:
   - requirements → architecture → design → test_design
   - implementation → testing → validation → deployment → operations
3. List pending gate requirements
4. Identify assigned agents for current phase
```

### Step 3: Coordinate Agent Activities
```
1. For current phase, activate relevant agents:
   - Requirements: requirements-agent
   - Architecture: architecture-agent, security-agent
   - Design: design-agent
   - Test Design: test-manager-agent
   - Implementation: developer-agent, test-manager-agent
   - Testing: test-manager-agent, security-agent
   - Deployment: devops-agent
   - Operations: operations-agent
2. Distribute tasks based on agent capabilities
3. Monitor progress and collect outputs
```

### Step 4: Validate Phase Gate
```
1. Collect all artifacts from current phase
2. Run gate checklist validation
3. Check all required approvals
4. Document validation results
5. If passed: transition to next phase
6. If failed: report blockers, assign remediation
```

### Step 5: Handle Phase Transition
```
1. Update workflow-state.json:
   - Move current phase to phases_completed
   - Add gate to gates_passed
   - Set new current_phase
2. Notify all agents of transition
3. Archive phase artifacts
4. Initialize next phase requirements
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| workflow-state.json | JSON | Yes | Current workflow state |
| project_brief | String | For new projects | Feature/project description |
| gate_id | String | For validation | Gate to validate (GATE-1 to GATE-8) |
| agent_report | JSON | For updates | Status report from agent |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| workflow-state.json | JSON | Updated workflow state |
| phase_report.md | Markdown | Summary of phase completion |
| gate_validation.json | JSON | Gate validation results |
| agent_assignments.json | JSON | Current task assignments |

## StudyAbroad-Specific Considerations
- User journey stages (discovery→application→preparation→abroad→return) map to feature groupings
- External API integrations require architecture review gate
- GDPR compliance checkpoint at design gate
- OAuth2/SSO implementation requires security sign-off

## Integration Points
- **Spec Kit**: /speckit.specify, /speckit.plan, /speckit.implement commands
- **BMAD**: Orchestrator and Scrum Master agent coordination
- **Ralph Wiggum**: /ralph-loop for autonomous task iteration until completion
- **Superpowers**: /superpowers:execute-plan for implementation
- **12 Factors**: Enforcement rules checked at each gate

## Examples
```
# Start new feature
/orchestrate start "Implement university search with filtering"

# Check status
/orchestrate status
> Current Phase: design
> Gate 2 (Architecture): PASSED
> Gate 3 (Design): 3/5 items complete
> Blockers: None
> Active Agents: design-agent

# Validate gate
/orchestrate validate GATE-3
> Checking Design Gate...
> ✓ OpenAPI spec complete
> ✓ Module designs documented
> ✗ Wireframes pending approval
> ✗ Error taxonomy incomplete
> Gate GATE-3: NOT PASSED (2 items remaining)
```

## Validation
- All phase artifacts exist in expected locations
- Gate checklist 100% complete
- No unresolved blockers
- Agent acknowledgment of phase transition
- Audit log updated with transition record

---
SKILL_ID: ORCH-002
SKILL_PATH: skills/orchestration/task-decomposition/SKILL.md
---
name: task-decomposition
description: Break down requirements into agent-assignable tasks
skill_id: ORCH-002
owner: orchestrator
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: After requirements approved, sprint planning, feature breakdown
dependencies: [ORCH-001]
---

# Task Decomposition

## Purpose
Transform high-level requirements and user stories into discrete, actionable tasks that can be assigned to specific agents, with clear dependencies, acceptance criteria, and effort estimates.

## When to Use
- After requirements phase completes (GATE-1 passed)
- Sprint planning sessions
- When new features are added mid-cycle
- Breaking down complex user stories
- Creating implementation roadmaps

## Prerequisites
- Approved requirements specification
- User stories with acceptance criteria
- Architecture decisions finalized
- Agent capabilities understood

## Process

### Step 1: Analyze Requirements
```
1. Load requirements_spec.md
2. Identify all user stories
3. Extract acceptance criteria for each
4. Note NFR constraints (performance, security)
5. Map to user journey stages
```

### Step 2: Identify Task Categories
```
For each requirement, identify needed tasks:
- ARCH: Architecture/design tasks
- API: Backend API implementation
- UI: Frontend/UI implementation
- DB: Database schema/migration
- TEST: Test creation tasks
- SEC: Security implementation
- DOC: Documentation tasks
- OPS: DevOps/deployment tasks
```

### Step 3: Create Task Breakdown
```
For each user story:
1. Create parent task (TASK-XXX)
2. Break into subtasks:
   - Design subtask → design-agent
   - API subtask → developer-agent (backend)
   - UI subtask → developer-agent (frontend)
   - Test subtask → test-manager-agent
   - Doc subtask → documentation-agent
3. Estimate effort (S/M/L/XL)
4. Identify dependencies between tasks
```

### Step 4: Assign to Agents
```
Task assignment rules:
- Architecture tasks → architecture-agent
- API design → design-agent
- API implementation → developer-agent
- UI implementation → developer-agent
- Test design → test-manager-agent
- Test implementation → developer-agent + test-manager-agent
- Security review → security-agent
- Documentation → documentation-agent
- Deployment → devops-agent
```

### Step 5: Create Dependency Graph
```
1. Map task dependencies (blocks/blocked-by)
2. Identify critical path
3. Flag parallelizable tasks
4. Note external dependencies (APIs, approvals)
5. Generate dependency_graph.json
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements_spec.md | Markdown | Yes | Approved requirements |
| user_stories.json | JSON | Yes | User stories with acceptance criteria |
| architecture.md | Markdown | Yes | Architecture decisions |
| team_capacity | JSON | Optional | Available agent capacity |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| task_breakdown.json | JSON | Complete task list with assignments |
| dependency_graph.json | JSON | Task dependencies |
| sprint_plan.md | Markdown | Organized sprint backlog |
| effort_estimate.md | Markdown | Time/effort estimates |

## StudyAbroad-Specific Considerations
- Group tasks by user journey stage for logical sprints
- External API integration tasks need architecture review first
- GDPR-related tasks (consent, data deletion) are high priority
- OAuth2 tasks should be early in implementation (other features depend on auth)

## Integration Points
- **Spec Kit**: /speckit.tasks command generates initial breakdown
- **BMAD**: Scrum Master agent assists with sprint planning
- **Ralph Wiggum**: Use /ralph-loop for iterative task refinement
- **Requirements Agent**: Provides user stories as input
- **All Agents**: Receive task assignments

## Examples
```
# User Story: REQ-005 - User Profile Management
# Decomposed into:

TASK-005-01: Design user profile API endpoints
  Agent: design-agent
  Effort: M
  Output: openapi_spec.yaml (profile section)
  
TASK-005-02: Design profile database schema
  Agent: architecture-agent
  Effort: S
  Depends: TASK-005-01
  Output: profile_schema.sql
  
TASK-005-03: Implement profile API
  Agent: developer-agent
  Effort: L
  Depends: TASK-005-01, TASK-005-02
  Output: src/backend/user/profile.ts
  
TASK-005-04: Write profile API tests
  Agent: test-manager-agent
  Effort: M
  Depends: TASK-005-01
  Output: tests/api/profile.test.ts
  
TASK-005-05: Implement profile UI
  Agent: developer-agent
  Effort: L
  Depends: TASK-005-03
  Output: src/frontend/components/Profile/
```

## Validation
- Every requirement has at least one task
- Every task has exactly one assigned agent
- No circular dependencies in graph
- All dependencies reference valid tasks
- Effort estimates provided for all tasks
- Critical path identified

---
SKILL_ID: ORCH-003
SKILL_PATH: skills/orchestration/progress-tracking/SKILL.md
---
name: progress-tracking
description: Monitor task completion, blockers, and overall project health
skill_id: ORCH-003
owner: orchestrator
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Daily standups, status checks, reporting, identifying delays
dependencies: [ORCH-001, ORCH-002]
---

# Progress Tracking

## Purpose
Monitor the completion status of all tasks across agents, identify blockers early, track project velocity, and provide visibility into overall project health.

## When to Use
- Daily standup coordination
- Status check requests
- Sprint reviews
- When delays are suspected
- Stakeholder reporting
- Resource reallocation decisions

## Prerequisites
- Task breakdown exists (task_breakdown.json)
- Agents actively working on tasks
- Workflow state initialized

## Process

### Step 1: Collect Agent Status
```
Poll each active agent for:
1. Tasks in progress
2. Tasks completed since last check
3. Blockers encountered
4. Estimated completion for current task
5. Questions/clarifications needed
```

### Step 2: Update Task Status
```
For each task, track:
- Status: not_started | in_progress | blocked | review | complete
- Progress percentage (0-100)
- Time spent vs estimate
- Blocker details (if any)
- Output artifacts produced
```

### Step 3: Calculate Metrics
```
Project metrics:
- Tasks complete / total tasks
- Story points complete / total points
- Blockers count (active)
- Average task completion time
- Velocity (tasks/day)
- Phase progress percentage
```

### Step 4: Identify Issues
```
Flag issues when:
- Task exceeds 150% of estimate
- Blocker unresolved > 24 hours
- Dependencies not met for scheduled task
- Agent idle with pending tasks
- Critical path task delayed
```

### Step 5: Generate Status Report
```
Daily status report includes:
- Overall progress summary
- Completed since last report
- In progress with ETA
- Blockers requiring attention
- Upcoming milestones
- Risk indicators
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| task_breakdown.json | JSON | Yes | Task list with assignments |
| agent_status_reports | JSON | Yes | Status from each agent |
| previous_report | JSON | Optional | Last status for comparison |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| progress_report.md | Markdown | Human-readable status |
| metrics.json | JSON | Quantitative metrics |
| blockers.json | JSON | Active blockers list |
| burndown_data.json | JSON | Data for burndown chart |

## StudyAbroad-Specific Considerations
- Track progress against user journey coverage
- Monitor external API integration status separately
- Flag GDPR-related tasks if delayed (compliance risk)
- Track OAuth2 implementation as critical path

## Integration Points
- **All Agents**: Submit status reports
- **BMAD Scrum Master**: Sprint tracking integration
- **Ralph Wiggum**: Autonomous progress checks via /ralph-loop
- **Documentation Agent**: Archive progress reports

## Examples
```
# Daily Status Report - StudyAbroad-v1
Date: 2024-01-15

## Summary
Phase: Implementation
Progress: 45% complete (27/60 tasks)
Velocity: 4.2 tasks/day
On Track: ⚠️ Minor delays

## Completed Today
- TASK-003-02: User registration API ✓
- TASK-003-04: Registration unit tests ✓
- TASK-007-01: Database migration script ✓

## In Progress
- TASK-003-05: Registration UI (75%, ETA: tomorrow)
- TASK-004-01: OAuth2 integration (30%, ETA: 2 days)

## Blockers
🔴 TASK-005-03: Waiting for university API credentials
   Owner: developer-agent
   Blocked: 2 days
   Action: Escalate to human

## Upcoming Milestones
- Gate 5 (Implementation): Jan 20
- User Auth Complete: Jan 18
```

## Validation
- All active tasks have recent status update
- No tasks stuck in same status > 3 days without note
- Blockers have assigned owners
- Metrics calculate correctly
- Report generated successfully

---
SKILL_ID: ORCH-004
SKILL_PATH: skills/orchestration/gate-validation/SKILL.md
---
name: gate-validation
description: Verify phase completion criteria before allowing transition
skill_id: ORCH-004
owner: orchestrator
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Phase completion, before transitions, quality checkpoints
dependencies: [ORCH-001]
---

# Gate Validation

## Purpose
Enforce quality gates between SDLC phases by verifying all required artifacts exist, meet quality standards, and have necessary approvals before allowing phase transitions.

## When to Use
- When phase completion is claimed
- Before transitioning to next phase
- Quality checkpoint verification
- Audit trail requirements
- Compliance verification

## Prerequisites
- Gate definitions configured
- Phase artifacts available
- Approval workflow defined
- 12 Factors enforcement rules loaded

## Process

### Step 1: Identify Gate Requirements
```
Load gate checklist for requested gate:

GATE-1 (Requirements → Architecture):
- [ ] requirements_spec.md complete
- [ ] All user stories have acceptance criteria
- [ ] NFRs quantified with metrics
- [ ] User journeys documented
- [ ] External API requirements listed
- [ ] GDPR requirements identified
- [ ] Human approval obtained

GATE-2 (Architecture → Design):
- [ ] architecture.md complete
- [ ] ADRs created for major decisions
- [ ] Database schema defined
- [ ] Security architecture documented
- [ ] Tech stack finalized
- [ ] External API architecture defined

(Continue for GATE-3 through GATE-8)
```

### Step 2: Verify Artifact Existence
```
For each required artifact:
1. Check file exists at expected path
2. Verify file is not empty
3. Check last modified date (recent)
4. Validate file format (parseable)
```

### Step 3: Validate Artifact Quality
```
Quality checks:
- Requirements: No TBD/TODO markers
- Architecture: All components defined
- Design: OpenAPI spec validates
- Tests: Coverage meets threshold
- Code: Linting passes
- Security: No critical findings
```

### Step 4: Check Approvals
```
For gates requiring human approval:
1. Check approval record exists
2. Verify approver authority
3. Confirm approval not expired
4. Document in audit trail
```

### Step 5: Generate Validation Report
```
Report includes:
- Gate ID and description
- Checklist with pass/fail status
- Missing items details
- Quality issues found
- Approval status
- Overall: PASS / FAIL
- Recommended actions if failed
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| gate_id | String | Yes | Gate to validate (GATE-1 to GATE-8) |
| phase_artifacts | Files | Yes | All artifacts from current phase |
| approval_records | JSON | If required | Human approval records |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| gate_validation.json | JSON | Detailed validation results |
| gate_report.md | Markdown | Human-readable report |
| audit_entry.json | JSON | Audit trail record |

## StudyAbroad-Specific Considerations
- GATE-2 must verify external API integration architecture
- GATE-3 requires GDPR compliance check on data flows
- GATE-5 must verify OAuth2 implementation security
- GATE-7 requires security sign-off for PII handling

## Integration Points
- **12 Factors**: Factor 6 (The Great Filter) enforcement
- **Security Agent**: Security-related gate checks
- **Test Manager**: Coverage verification
- **All Agents**: Artifact submission

## Examples
```
/orchestrate validate GATE-3

Gate Validation Report: GATE-3 (Design → Test Design)
=====================================================

Checklist Results:
✓ openapi_spec.yaml exists and validates
✓ Module designs complete (8/8 modules)
✓ Error taxonomy defined
✗ Wireframes: 3/5 screens approved
✗ User flow diagrams: Missing "forgot password" flow

Quality Checks:
✓ OpenAPI spec: Valid, no errors
✓ No TODO markers in designs
⚠ Warning: 2 endpoints missing error responses

Approvals:
✓ Design review: Approved by architecture-agent
✗ UX review: Pending

Overall Result: FAIL
Blocking Items: 2

Recommended Actions:
1. Complete wireframes for remaining 2 screens
2. Add "forgot password" user flow diagram
3. Obtain UX review approval

Retry validation after completing above items.
```

## Validation
- All checklist items evaluated
- No false positives (missing items marked as complete)
- Quality checks actually executed (not skipped)
- Approval verification accurate
- Audit trail properly recorded

---
SKILL_ID: ORCH-005
SKILL_PATH: skills/orchestration/conflict-resolution/SKILL.md
---
name: conflict-resolution
description: Handle conflicting outputs or recommendations from agents
skill_id: ORCH-005
owner: orchestrator
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Agent disagreements, contradictory outputs, decision deadlocks
dependencies: [ORCH-001]
---

# Conflict Resolution

## Purpose
Resolve conflicts when multiple agents produce contradictory outputs, have different recommendations, or when technical decisions require arbitration between competing approaches.

## When to Use
- Architecture vs Security agent disagreement
- Design conflicts between frontend/backend approaches
- Resource allocation disputes
- Technical approach disagreements
- Timeline vs quality tradeoffs
- Scope disagreements

## Prerequisites
- Conflicting positions documented
- Context for each position understood
- Decision criteria defined
- Escalation path available

## Process

### Step 1: Identify Conflict
```
Document the conflict:
1. Agents involved
2. Subject of disagreement
3. Each agent's position
4. Rationale for each position
5. Impact if each position is adopted
```

### Step 2: Gather Context
```
Collect supporting information:
- Requirements relevant to decision
- Constraints (technical, timeline, budget)
- Prior decisions (ADRs) affecting this
- Industry best practices
- Project priorities
```

### Step 3: Evaluate Options
```
For each position, assess:
- Alignment with requirements
- Technical feasibility
- Security implications
- Performance impact
- Maintenance burden
- Timeline impact
- Risk level
```

### Step 4: Apply Decision Framework
```
Decision hierarchy:
1. Security concerns override other factors
2. Requirements compliance is mandatory
3. Architecture decisions (ADRs) take precedence
4. Performance NFRs must be met
5. Prefer simpler solutions when equal
6. Consider future extensibility
```

### Step 5: Document Resolution
```
Create conflict resolution record:
- Conflict ID and description
- Positions considered
- Decision made
- Rationale
- Dissenting notes (if any)
- Action items
- Create ADR if architectural decision
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| conflict_report | JSON | Yes | Details of the conflict |
| agent_positions | JSON | Yes | Each agent's stance |
| project_context | JSON | Yes | Requirements, constraints |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| resolution_record.json | JSON | Decision documentation |
| adr_draft.md | Markdown | ADR if architectural decision |
| action_items.json | JSON | Tasks resulting from decision |

## StudyAbroad-Specific Considerations
- Security Agent has veto on PII/GDPR issues
- External API design conflicts defer to architecture-agent
- Performance vs feature scope: consult requirements priority
- OAuth2 approach: security-agent leads decision

## Integration Points
- **All Agents**: May be party to conflicts
- **Architecture Agent**: Creates ADRs for decisions
- **Human**: Escalation for unresolvable conflicts

## Examples
```
Conflict: REST vs GraphQL for University Search API

Positions:
- Developer Agent: GraphQL for flexible queries
- Architecture Agent: REST for simplicity/caching
- Security Agent: REST easier to secure

Resolution Process:
1. Requirements check: Need filtering, sorting, pagination
2. Performance: REST caching benefits high-traffic endpoint
3. Security: REST has simpler attack surface
4. Team familiarity: More REST experience

Decision: REST API
Rationale: Security preference + caching needs + team skills
ADR: ADR-007-university-search-api-rest.md

Action Items:
- Design Agent: Create OpenAPI spec for REST endpoints
- Developer Agent: Implement REST with proper caching
- Test Manager: Design REST API test cases
```

## Validation
- Both/all positions fairly considered
- Decision aligns with project priorities
- Resolution documented with rationale
- Affected agents acknowledge decision
- ADR created if needed

---
SKILL_ID: ORCH-006
SKILL_PATH: skills/orchestration/priority-management/SKILL.md
---
name: priority-management
description: Determine task urgency and optimal sequencing
skill_id: ORCH-006
owner: orchestrator
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Sprint planning, resource allocation, urgent requests, scope changes
dependencies: [ORCH-002]
---

# Priority Management

## Purpose
Determine the optimal sequence and priority of tasks based on dependencies, business value, risk, and resource availability to maximize project progress and value delivery.

## When to Use
- Sprint planning
- New urgent request arrives
- Resource constraints change
- Scope changes
- Blocker impacts schedule
- Stakeholder priority changes

## Prerequisites
- Task breakdown available
- Dependencies mapped
- Business value understood
- Resource availability known

## Process

### Step 1: Assess Task Attributes
```
For each task, evaluate:
- Business value (High/Medium/Low)
- Urgency (Critical/High/Normal/Low)
- Dependencies (blocking others?)
- Risk (technical uncertainty)
- Effort (S/M/L/XL)
- Required skills (which agent)
```

### Step 2: Apply Prioritization Matrix
```
Priority Score = (Value × 3) + (Urgency × 2) + (Blocking × 2) - (Risk × 1)

Where:
- Value: High=3, Medium=2, Low=1
- Urgency: Critical=4, High=3, Normal=2, Low=1
- Blocking: Blocks 3+=3, Blocks 1-2=2, Blocks 0=1
- Risk: High=3, Medium=2, Low=1
```

### Step 3: Consider Dependencies
```
Dependency rules:
1. Blocked tasks cannot be prioritized until blocker resolves
2. Tasks blocking many others get priority boost
3. External dependencies flagged for early start
4. Critical path tasks get highest attention
```

### Step 4: Balance Agent Workload
```
Distribution rules:
1. No agent > 3 concurrent tasks
2. Mix task sizes (not all XL)
3. Consider skill match
4. Allow slack for interrupts
```

### Step 5: Create Priority Queue
```
Output priority-sorted task list:
1. P0 - Critical: Do immediately
2. P1 - High: Do this sprint
3. P2 - Normal: Do when P0/P1 clear
4. P3 - Low: Backlog
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| task_breakdown.json | JSON | Yes | All tasks |
| dependency_graph.json | JSON | Yes | Task dependencies |
| agent_availability | JSON | Yes | Agent capacity |
| business_priorities | JSON | Optional | Stakeholder input |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| priority_queue.json | JSON | Sorted task list |
| sprint_backlog.md | Markdown | Sprint plan |
| agent_assignments.json | JSON | Task distribution |

## StudyAbroad-Specific Considerations
- Authentication tasks are P0 (blocks most features)
- GDPR compliance tasks are high priority (legal risk)
- User journey: Application flow > Discovery flow (core value)
- External API tasks: start early (dependency risk)

## Integration Points
- **BMAD Scrum Master**: Sprint planning coordination
- **Ralph Wiggum**: /ralph-loop for autonomous task execution
- **All Agents**: Receive prioritized task assignments
- **Test Manager**: Test priority aligned with implementation

## Examples
```
Priority Queue - Sprint 3

P0 - Critical (Do Now):
├─ TASK-004-01: OAuth2 implementation [Blocks: 12 tasks]
└─ TASK-010-03: Fix login security vulnerability

P1 - High (This Sprint):
├─ TASK-005-01: User profile API [Blocks: 4 tasks]
├─ TASK-005-03: Profile database migration
├─ TASK-006-01: University search API
└─ TASK-012-01: GDPR consent mechanism

P2 - Normal (If Capacity):
├─ TASK-007-02: Email notification service
├─ TASK-008-01: Application status dashboard
└─ TASK-009-01: Document upload feature

P3 - Backlog:
├─ TASK-015-01: Dark mode UI
└─ TASK-016-01: Analytics integration
```

## Validation
- All tasks have priority assigned
- No circular priority dependencies
- Critical path tasks are P0/P1
- Agent workload balanced
- Sprint capacity not exceeded

---
SKILL_ID: ORCH-007
SKILL_PATH: skills/orchestration/communication-routing/SKILL.md
---
name: communication-routing
description: Route information and requests between agents efficiently
skill_id: ORCH-007
owner: orchestrator
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Agent needs information from another, cross-functional coordination
dependencies: [ORCH-001]
---

# Communication Routing

## Purpose
Ensure efficient information flow between agents by routing requests, sharing artifacts, broadcasting updates, and maintaining communication records for audit and context.

## When to Use
- Agent requests information from another agent
- Artifact handoffs between phases
- Broadcast announcements needed
- Cross-functional coordination required
- Context sharing for related tasks

## Prerequisites
- Agent registry loaded
- Communication protocols defined
- Message queue available
- Audit logging enabled

## Process

### Step 1: Receive Communication Request
```
Parse incoming message:
- Source agent
- Target agent(s) or broadcast
- Message type (request/response/notification)
- Subject and payload
- Priority level
- Response required (Y/N)
```

### Step 2: Validate Routing
```
Validation checks:
1. Source agent authorized to send
2. Target agent exists and active
3. Message type appropriate
4. Required fields present
5. Payload format valid
```

### Step 3: Determine Route
```
Routing rules:
- Direct: Single target agent
- Multicast: Specific agent group
- Broadcast: All agents
- Escalation: Human involvement

Route selection based on:
- Message type
- Target specification
- Urgency level
```

### Step 4: Deliver Message
```
Delivery process:
1. Add routing metadata
2. Log message in audit trail
3. Deliver to target(s)
4. Confirm receipt
5. Track response if required
```

### Step 5: Handle Response
```
If response required:
1. Set response timeout
2. Monitor for response
3. Route response to original sender
4. Escalate if timeout exceeded
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| message | JSON | Yes | Communication content |
| source_agent | String | Yes | Sending agent ID |
| target | String/Array | Yes | Recipient(s) |
| priority | String | Optional | urgent/normal/low |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| delivery_confirmation | JSON | Delivery status |
| audit_record | JSON | Communication log |
| response | JSON | If response received |

## StudyAbroad-Specific Considerations
- Security agent notifications are always high priority
- External API changes broadcast to architecture + developer
- GDPR-related communications logged for compliance
- Test manager receives all requirement changes

## Integration Points
- **All Agents**: Send and receive communications
- **Audit System**: Log all communications
- **Human**: Escalation endpoint

## Examples
```
# Developer needs API spec from Design Agent
Message:
{
  "from": "developer-agent",
  "to": "design-agent",
  "type": "request",
  "subject": "OpenAPI spec for profile endpoints",
  "payload": {
    "endpoints": ["/api/user/profile", "/api/user/settings"],
    "format": "yaml"
  },
  "priority": "normal",
  "response_required": true
}

Routing:
→ Validated: developer-agent authorized
→ Route: Direct to design-agent
→ Delivered: 2024-01-15T10:30:00Z
→ Response received: 2024-01-15T10:32:15Z
→ Routed response to developer-agent

# Broadcast: Requirement change
Message:
{
  "from": "requirements-agent",
  "to": "broadcast",
  "type": "notification",
  "subject": "REQ-015 modified",
  "payload": {
    "requirement_id": "REQ-015",
    "change_type": "acceptance_criteria_updated",
    "summary": "Added email verification step"
  }
}

Routing:
→ Broadcast to: all agents
→ Special routing: test-manager (impact analysis trigger)
```

## Validation
- All messages logged in audit trail
- Delivery confirmation received
- No messages lost or undelivered
- Response timeouts handled
- Routing rules correctly applied

---
SKILL_ID: ORCH-008
SKILL_PATH: skills/orchestration/risk-assessment/SKILL.md
---
name: risk-assessment
description: Identify project risks and define mitigation strategies
skill_id: ORCH-008
owner: orchestrator
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Project planning, phase reviews, when issues emerge, external changes
dependencies: [ORCH-001, ORCH-003]
---

# Risk Assessment

## Purpose
Proactively identify risks that could impact project success, assess their likelihood and impact, define mitigation strategies, and monitor risk indicators throughout the project lifecycle.

## When to Use
- Project kickoff
- Phase transitions
- When blockers emerge
- External factor changes
- Sprint retrospectives
- Stakeholder concerns raised

## Prerequisites
- Project scope understood
- Technical architecture defined
- Dependencies identified
- Team capacity known

## Process

### Step 1: Identify Risks
```
Risk categories:
- Technical: Technology choices, complexity, unknowns
- Resource: Capacity, skills, availability
- Schedule: Timeline pressures, dependencies
- External: APIs, third parties, regulations
- Security: Vulnerabilities, compliance
- Quality: Technical debt, testing gaps
```

### Step 2: Assess Each Risk
```
For each risk, determine:
- Likelihood: High (>70%) / Medium (30-70%) / Low (<30%)
- Impact: Critical / High / Medium / Low
- Risk Score: Likelihood × Impact
- Detection: How will we know if it happens?
```

### Step 3: Prioritize Risks
```
Risk priority matrix:
- Critical: Immediate action required
- High: Active mitigation needed
- Medium: Monitor closely
- Low: Accept or defer
```

### Step 4: Define Mitigations
```
For each significant risk:
- Mitigation strategy (avoid/reduce/transfer/accept)
- Specific actions
- Owner (which agent)
- Timeline
- Success criteria
- Contingency plan if risk materializes
```

### Step 5: Create Risk Register
```
Maintain living risk register:
- Risk ID and description
- Category and severity
- Mitigation status
- Current indicators
- Last review date
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| project_scope | Markdown | Yes | Project definition |
| architecture | Markdown | Yes | Technical decisions |
| task_breakdown | JSON | Yes | Work breakdown |
| progress_report | JSON | Yes | Current status |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| risk_register.json | JSON | Complete risk list |
| risk_report.md | Markdown | Summary for review |
| mitigation_tasks | JSON | Risk mitigation tasks |

## StudyAbroad-Specific Considerations
- External API reliability risk (university, visa services)
- GDPR compliance risk (legal/financial impact)
- OAuth2 implementation security risk
- Peak load during application deadlines
- Multi-region deployment complexity

## Integration Points
- **Security Agent**: Security risk identification
- **Architecture Agent**: Technical risk assessment
- **DevOps Agent**: Infrastructure risks
- **All Agents**: Risk indicator monitoring

## Examples
```
Risk Register - StudyAbroad-v1

RISK-001: University API Reliability
Category: External
Likelihood: Medium (40%)
Impact: High
Score: 6/10
Description: University API may have downtime during peak enrollment
Mitigation: 
  - Implement caching layer
  - Add circuit breaker pattern
  - Create fallback UI for degraded mode
Owner: architecture-agent
Status: Mitigation in progress

RISK-002: GDPR Non-Compliance
Category: Regulatory
Likelihood: Low (20%)
Impact: Critical
Score: 8/10
Description: Potential GDPR violations in user data handling
Mitigation:
  - Security agent audit all data flows
  - Implement consent management
  - Data retention automation
  - Right-to-deletion feature
Owner: security-agent
Status: Mitigation planned

RISK-003: OAuth2 Security Vulnerability
Category: Security
Likelihood: Medium (35%)
Impact: Critical
Score: 7/10
Description: OAuth2 implementation may have security flaws
Mitigation:
  - Security-focused code review
  - Penetration testing
  - Use established library (not custom)
Owner: security-agent, developer-agent
Status: Monitoring
```

## Validation
- All major risk categories covered
- Risk scores accurately calculated
- Mitigations defined for high/critical risks
- Risk register updated regularly
- Triggers identified for risk monitoring


# ============================================================================
# REQUIREMENTS AGENT SKILLS (10 Skills: REQ-001 to REQ-010)
# ============================================================================

---
SKILL_ID: REQ-001
SKILL_PATH: skills/requirements/elicitation/SKILL.md
---
name: requirements-elicitation
description: Extract requirements from stakeholders and project descriptions
skill_id: REQ-001
owner: requirements
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Project start, new feature requests, clarifying ambiguous needs
dependencies: []
---

# Requirements Elicitation

## Purpose
Systematically extract, clarify, and document requirements from stakeholders, project briefs, and domain analysis to establish a complete understanding of what the system must do.

## When to Use
- Project initiation
- New feature requests
- Stakeholder interviews
- Analyzing competitor products
- Domain exploration

## Prerequisites
- Access to stakeholders or project brief
- Understanding of project domain
- Elicitation techniques knowledge

## Process

### Step 1: Gather Initial Input
```
Collect from available sources:
- Project brief/description
- Stakeholder requests
- Existing documentation
- Competitor analysis
- Domain research
```

### Step 2: Apply Elicitation Techniques
```
Techniques to use:
1. Questioning: Who, What, When, Where, Why, How
2. Scenarios: Walk through user journeys
3. Personas: Define user types and goals
4. Constraints: Identify limitations
5. Edge cases: What if X happens?
```

### Step 3: Generate Clarifying Questions
```
For each vague or incomplete requirement:
- What is the expected behavior?
- Who is the primary user?
- What triggers this action?
- What is the success criteria?
- What happens in error cases?
- Are there constraints (time, data, access)?
```

### Step 4: Document Raw Requirements
```
For each requirement capture:
- Source (who requested)
- Description (what is needed)
- Rationale (why it's needed)
- Priority indication
- Related requirements
- Open questions
```

### Step 5: Validate Understanding
```
Confirm requirements by:
- Restating in different words
- Providing examples
- Identifying edge cases
- Checking against constraints
- Getting stakeholder confirmation
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| project_brief | String | Yes | Initial project description |
| stakeholder_input | String | Optional | Direct stakeholder requests |
| domain_context | String | Optional | Industry/domain information |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| raw_requirements.md | Markdown | Unstructured requirements |
| clarifying_questions.md | Markdown | Questions needing answers |
| personas.md | Markdown | User personas identified |
| domain_glossary.md | Markdown | Domain terms defined |

## StudyAbroad-Specific Considerations
- User types: Prospective student, Current student, Advisor, Admin
- Journey stages: Discovery, Application, Preparation, Abroad, Return
- External integrations: Universities, visa services, housing
- Compliance: GDPR for EU students, FERPA for academic records
- Peak usage: Application deadlines, enrollment periods

## Integration Points
- **Orchestrator**: Receives project brief
- **Spec Kit**: /speckit.specify command integration
- **BMAD Analyst**: Elicitation patterns
- **Ralph Wiggum**: /ralph-loop for iterative elicitation until requirements complete

## Examples
```
Project Brief: "Build a study abroad application platform"

Elicitation Questions Generated:

Users:
- Q1: Who are the primary users? (Students, advisors, admins?)
- Q2: What student types? (Undergrad, grad, exchange?)
- Q3: Do advisors manage multiple students?

Features:
- Q4: What does "application" include? (Forms, documents, payments?)
- Q5: Is there a matching/recommendation system?
- Q6: How do students discover programs?

Integrations:
- Q7: Which university databases to integrate?
- Q8: Is visa status tracking needed?
- Q9: Housing search integration needed?

Constraints:
- Q10: What regions/countries supported?
- Q11: Mobile app or web only?
- Q12: Offline functionality needed?

Compliance:
- Q13: GDPR compliance required?
- Q14: Document retention policies?
- Q15: Data residency requirements?
```

## Validation
- All ambiguous terms clarified
- No TBD items in final requirements
- Stakeholder sign-off on understanding
- Domain terms defined in glossary
- User personas documented

---
SKILL_ID: REQ-002
SKILL_PATH: skills/requirements/user-stories/SKILL.md
---
name: user-story-writing
description: Create user stories with clear acceptance criteria
skill_id: REQ-002
owner: requirements
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Converting requirements to actionable stories, sprint planning input
dependencies: [REQ-001]
---

# User Story Writing

## Purpose
Transform elicited requirements into well-structured user stories following the standard format with clear acceptance criteria that can be implemented and tested.

## When to Use
- After requirements elicitation
- Converting features to backlog items
- Preparing for sprint planning
- Breaking down epics

## Prerequisites
- Requirements elicited and documented
- User personas defined
- Domain glossary available
- Acceptance criteria patterns known

## Process

### Step 1: Identify Story Scope
```
Determine story boundaries:
- One user goal per story
- INVEST criteria: Independent, Negotiable, 
  Valuable, Estimable, Small, Testable
- Can be completed in one sprint
```

### Step 2: Write Story Statement
```
Format:
As a [persona]
I want to [goal/action]
So that [benefit/value]

Example:
As a prospective study abroad student
I want to search universities by country and program
So that I can find programs matching my interests
```

### Step 3: Define Acceptance Criteria
```
Use Given-When-Then format:
Given [precondition/context]
When [action performed]
Then [expected outcome]

Include:
- Happy path scenarios
- Edge cases
- Error conditions
- Validation rules
```

### Step 4: Add Story Metadata
```
Complete story record:
- Story ID (e.g., US-001)
- Title (short description)
- Persona
- Priority (MoSCoW)
- Story points (effort)
- Dependencies
- Related requirements (REQ-xxx)
```

### Step 5: Review and Refine
```
Quality checklist:
- [ ] Persona is valid and defined
- [ ] Goal is clear and single-focused
- [ ] Benefit explains the "why"
- [ ] Acceptance criteria are testable
- [ ] No implementation details in story
- [ ] Size is appropriate (not epic)
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements | Markdown | Yes | Elicited requirements |
| personas | Markdown | Yes | User persona definitions |
| priority_guidance | String | Optional | Stakeholder priorities |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| user_stories.json | JSON | Structured stories |
| user_stories.md | Markdown | Human-readable format |
| story_map.md | Markdown | Stories organized by journey |

## StudyAbroad-Specific Considerations
- Map stories to user journey stages
- Include persona: student, advisor, admin
- Tag stories with external API dependencies
- Flag GDPR-relevant stories (user data)

## Integration Points
- **Spec Kit**: Story generation during /speckit.specify
- **Test Manager**: Stories become test case basis
- **BMAD PM**: Story refinement
- **Ralph Wiggum**: /ralph-loop for iterative story refinement until testable

## Examples
```
US-012: University Search

As a prospective study abroad student
I want to search universities by country, program type, and language
So that I can find programs that match my academic goals and preferences

Acceptance Criteria:

AC1: Search by country
Given I am on the university search page
When I select "France" from the country filter
Then I see only universities in France
And the result count updates to show French universities

AC2: Multiple filters
Given I am on the university search page
When I select country "Germany" AND program "Computer Science"
Then I see only German universities offering Computer Science

AC3: No results handling
Given I am on the university search page
When my filter combination returns no results
Then I see a "No programs found" message
And I see suggestions to broaden my search

AC4: Search performance
Given I am on the university search page
When I apply any filter combination
Then results load within 2 seconds

Metadata:
- ID: US-012
- Priority: Must Have
- Story Points: 5
- Journey Stage: Discovery
- External API: University Database API
- Related: REQ-007, REQ-008
```

## Validation
- All requirements have at least one story
- Every story has 3+ acceptance criteria
- All criteria are testable (Given-When-Then)
- No duplicate stories
- Stories traced to requirements

---
SKILL_ID: REQ-003
SKILL_PATH: skills/requirements/classification/SKILL.md
---
name: requirements-classification
description: Categorize requirements as functional, non-functional, or constraints
skill_id: REQ-003
owner: requirements
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Organizing requirements, separating concerns, architecture input
dependencies: [REQ-001]
---

# Requirements Classification

## Purpose
Categorize requirements into functional (what system does), non-functional (how system performs), and constraints (limitations) to ensure complete coverage and proper handling by different agents.

## When to Use
- After requirements elicitation
- Organizing requirement documents
- Preparing architecture input
- Identifying NFR gaps

## Prerequisites
- Raw requirements available
- Classification categories defined
- Domain understanding

## Process

### Step 1: Identify Functional Requirements
```
Functional requirements describe WHAT the system does:
- Features and capabilities
- User interactions
- Data processing
- Business rules
- Integrations

Pattern: "The system shall [do something]"
```

### Step 2: Identify Non-Functional Requirements
```
NFR categories:
- Performance: Response time, throughput
- Scalability: User capacity, data volume
- Security: Authentication, authorization, encryption
- Reliability: Uptime, fault tolerance
- Usability: Accessibility, ease of use
- Maintainability: Code quality, documentation
- Portability: Platform support

Pattern: "The system shall [do something] within [constraint]"
```

### Step 3: Identify Constraints
```
Constraint types:
- Technical: Technology stack, platforms
- Business: Budget, timeline, regulations
- Legal: Compliance (GDPR, FERPA)
- Operational: Hosting, support hours
- Integration: API limitations, data formats

Pattern: "The system must/must not [constraint]"
```

### Step 4: Tag and Organize
```
For each requirement:
1. Assign category: FR/NFR/CON
2. Assign subcategory
3. Link related requirements
4. Identify stakeholder/owner
5. Note dependencies
```

### Step 5: Validate Coverage
```
Check completeness:
- All FR have corresponding NFR (performance)
- Security NFR exist for sensitive FR
- Constraints don't contradict FR
- NFR are measurable (not vague)
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| raw_requirements | Markdown | Yes | Unclassified requirements |
| domain_context | String | Optional | Industry standards |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| functional_requirements.md | Markdown | FR list |
| nfr_matrix.md | Markdown | NFR with metrics |
| constraints.md | Markdown | System constraints |
| requirements_spec.md | Markdown | Complete organized spec |

## StudyAbroad-Specific Considerations
- GDPR is a constraint affecting many FRs
- Performance NFRs critical during application deadlines
- External API limitations are constraints
- Accessibility (WCAG) is NFR requirement

## Integration Points
- **Architecture Agent**: NFRs drive architecture decisions
- **Security Agent**: Security NFRs coordination
- **Test Manager**: NFRs become test scenarios

## Examples
```
Classified Requirements:

FUNCTIONAL (FR):
- FR-001: User registration with email/OAuth2
- FR-002: University search with filters
- FR-003: Application form submission
- FR-004: Document upload and storage
- FR-005: Application status tracking

NON-FUNCTIONAL (NFR):
- NFR-001 [Performance]: Page load < 3 seconds
- NFR-002 [Performance]: Search results < 2 seconds
- NFR-003 [Scalability]: Support 10,000 concurrent users
- NFR-004 [Security]: All data encrypted at rest
- NFR-005 [Availability]: 99.5% uptime SLA
- NFR-006 [Accessibility]: WCAG 2.1 AA compliance

CONSTRAINTS (CON):
- CON-001 [Legal]: GDPR compliance required
- CON-002 [Technical]: Must use PostgreSQL database
- CON-003 [Integration]: University API rate limit: 100/min
- CON-004 [Timeline]: MVP by Q2 2024
- CON-005 [Platform]: Web-first, mobile responsive
```

## Validation
- All requirements classified
- NFRs have measurable metrics
- Constraints are specific
- No orphan requirements
- Categories don't overlap

---
SKILL_ID: REQ-004
SKILL_PATH: skills/requirements/ambiguity-detection/SKILL.md
---
name: ambiguity-detection
description: Identify vague, incomplete, or conflicting requirements
skill_id: REQ-004
owner: requirements
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Requirements review, quality assurance, before sign-off
dependencies: [REQ-001, REQ-002]
---

# Ambiguity Detection

## Purpose
Identify vague, incomplete, contradictory, or untestable requirements before they cause downstream problems in design and implementation.

## When to Use
- Before requirements sign-off
- When reviewing new requirements
- During requirements quality review
- Before GATE-1 validation

## Prerequisites
- Requirements documented
- Ambiguity patterns known
- Domain glossary available

## Process

### Step 1: Check for Vague Terms
```
Flag these vague terms:
- "User-friendly"
- "Fast/Quick"
- "Easy to use"
- "Flexible"
- "Robust"
- "Scalable" (without numbers)
- "Secure" (without specifics)
- "Efficient"
- "Modern"
- "Intuitive"

Replace with measurable criteria.
```

### Step 2: Check for Incompleteness
```
Missing information flags:
- No error handling specified
- No boundary conditions
- No user role specified
- No data validation rules
- No success criteria
- "TBD" or "TODO" present
- Placeholder text
- Missing acceptance criteria
```

### Step 3: Check for Conflicts
```
Conflict types:
- Contradictory requirements
- Impossible combinations
- Conflicting priorities
- Inconsistent terminology
- Incompatible constraints
```

### Step 4: Check Testability
```
Testability issues:
- Can't verify if implemented
- No measurable outcome
- Subjective success criteria
- Missing Given-When-Then
```

### Step 5: Generate Ambiguity Report
```
For each issue found:
- Requirement ID
- Issue type (vague/incomplete/conflict/untestable)
- Specific problem
- Suggested resolution
- Clarifying question
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements_spec | Markdown | Yes | All requirements |
| user_stories | JSON | Yes | User stories with AC |
| glossary | Markdown | Optional | Term definitions |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| ambiguity_report.md | Markdown | Issues found |
| clarifying_questions.md | Markdown | Questions for resolution |
| requirements_quality_score | Number | Quality percentage |

## StudyAbroad-Specific Considerations
- "User" must specify which persona
- "Application" could mean platform or submission
- "Fast" must have specific latency targets
- GDPR terms must reference specific articles

## Integration Points
- **Spec Kit**: Quality check before proceeding
- **Orchestrator**: GATE-1 quality validation

## Examples
```
Ambiguity Report

ISSUE-001: Vague term
Requirement: REQ-012 "The system should be user-friendly"
Problem: "User-friendly" is subjective
Suggestion: Replace with specific usability criteria
Question: What specific usability metrics? (Task completion time, error rate, SUS score?)

ISSUE-002: Incomplete
Requirement: US-015 "User can upload documents"
Problem: Missing constraints
Questions:
- What file types allowed?
- What is max file size?
- What happens if upload fails?
- How many files per application?

ISSUE-003: Conflict
Requirements: REQ-020 and REQ-022
Conflict: REQ-020 says "email is optional"
         REQ-022 says "send email notifications"
Resolution: Clarify notification preferences

ISSUE-004: Untestable
Requirement: NFR-007 "System should be reliable"
Problem: No measurable criteria
Suggestion: Specify uptime SLA (e.g., 99.9%)

Quality Score: 78% (17 issues in 75 requirements)
```

## Validation
- All requirements scanned
- Issues have specific references
- Suggestions are actionable
- No false positives (valid requirements flagged)
- Quality score calculated

---
SKILL_ID: REQ-005
SKILL_PATH: skills/requirements/prioritization/SKILL.md
---
name: requirements-prioritization
description: Apply MoSCoW or other prioritization frameworks
skill_id: REQ-005
owner: requirements
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Scope definition, MVP planning, resource allocation decisions
dependencies: [REQ-001, REQ-003]
---

# Requirements Prioritization

## Purpose
Prioritize requirements using MoSCoW (Must/Should/Could/Won't) or other frameworks to define MVP scope, guide implementation order, and make resource allocation decisions.

## When to Use
- Defining MVP scope
- Sprint planning
- Scope negotiation
- Resource constraints
- Timeline pressure

## Prerequisites
- Requirements complete and classified
- Stakeholder input available
- Business value understood
- Dependencies mapped

## Process

### Step 1: Apply MoSCoW Framework
```
Categories:
MUST HAVE: Core functionality, MVP-critical
- Without these, system doesn't work
- Regulatory/compliance requirements
- Core user journey enablers

SHOULD HAVE: Important but not critical
- Significant value but workarounds exist
- Important for user experience
- Expected by most users

COULD HAVE: Nice to have
- Enhances experience
- Not critical for launch
- Can be deferred

WON'T HAVE (this release): Out of scope
- Future consideration
- Low value/high effort
- Not aligned with current goals
```

### Step 2: Gather Prioritization Inputs
```
Consider factors:
- Business value (revenue, users)
- User impact (how many affected)
- Technical risk (complexity)
- Dependencies (enables other features)
- Compliance (legal requirements)
- Competitive advantage
- Stakeholder requests
```

### Step 3: Score Each Requirement
```
Scoring matrix:
- Business Value: 1-5
- User Impact: 1-5
- Implementation Risk: 1-5 (inverted - lower is better)
- Dependency Score: +2 if enables others

Priority Score = (Value × 2) + (Impact × 2) - Risk + Dependency
```

### Step 4: Assign MoSCoW Category
```
Based on scores:
- Score > 15: MUST
- Score 10-15: SHOULD
- Score 5-10: COULD
- Score < 5: WON'T
```

### Step 5: Validate and Adjust
```
Validation checks:
- MUST items fit in MVP timeline
- Dependencies respected
- Stakeholder agreement
- Technical feasibility
- No must have > 40% of scope
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements_spec | Markdown | Yes | All requirements |
| stakeholder_priorities | JSON | Optional | Business priorities |
| technical_assessment | JSON | Optional | Feasibility input |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| prioritized_requirements.md | Markdown | MoSCoW sorted list |
| mvp_scope.md | Markdown | Must-have items |
| priority_matrix.json | JSON | Detailed scoring |

## StudyAbroad-Specific Considerations
- Authentication is always MUST (blocks other features)
- GDPR compliance is MUST (legal requirement)
- University search is MUST (core value prop)
- Advanced analytics is COULD/WON'T for MVP
- Dark mode is WON'T for initial release

## Integration Points
- **Orchestrator**: Priority queue input
- **BMAD PM**: Priority discussions
- **Ralph Wiggum**: Autonomous priority re-evaluation loops
- **Architecture Agent**: Dependency impact

## Examples
```
Prioritized Requirements - StudyAbroad-v1

MUST HAVE (MVP Critical):
├─ REQ-001: User registration/authentication
├─ REQ-002: User profile management
├─ REQ-003: University search
├─ REQ-004: Application submission
├─ REQ-005: Document upload
├─ REQ-006: Application tracking
├─ REQ-010: GDPR consent management
├─ REQ-011: Data export (GDPR)
└─ REQ-012: Account deletion (GDPR)

SHOULD HAVE (High Value):
├─ REQ-007: University recommendations
├─ REQ-008: Application deadline reminders
├─ REQ-009: Email notifications
├─ REQ-015: Advisor portal
└─ REQ-016: Application analytics

COULD HAVE (Nice to Have):
├─ REQ-020: Social sharing
├─ REQ-021: Student testimonials
├─ REQ-022: Chat with advisors
└─ REQ-023: Mobile app push notifications

WON'T HAVE (Future):
├─ REQ-030: AI program matching
├─ REQ-031: Visa application tracking
├─ REQ-032: Housing marketplace
└─ REQ-033: Currency converter
```

## Validation
- All requirements prioritized
- MoSCoW categories balanced
- Dependencies don't conflict with priorities
- Stakeholder sign-off obtained
- MVP scope is achievable

---
SKILL_ID: REQ-006
SKILL_PATH: skills/requirements/dependency-mapping/SKILL.md
---
name: dependency-mapping
description: Identify dependencies between requirements
skill_id: REQ-006
owner: requirements
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Implementation planning, sequencing, impact analysis
dependencies: [REQ-001]
---

# Dependency Mapping

## Purpose
Identify and document dependencies between requirements to enable proper sequencing, impact analysis, and prevent blocked work during implementation.

## When to Use
- After requirements documented
- Implementation planning
- Sprint planning
- Impact analysis
- Risk assessment

## Prerequisites
- Requirements enumerated with IDs
- Requirements understood
- Technical context available

## Process

### Step 1: Identify Dependency Types
```
Dependency categories:
- Requires: REQ-A requires REQ-B to exist first
- Enhances: REQ-A enhances/extends REQ-B
- Conflicts: REQ-A conflicts with REQ-B
- Related: REQ-A and REQ-B share components
- External: REQ-A depends on external system
```

### Step 2: Map Each Requirement
```
For each requirement:
1. What must exist before this can work?
2. What does this enable?
3. Are there shared components?
4. Are there conflicts?
5. External dependencies?
```

### Step 3: Create Dependency Graph
```
Document as:
- Directed graph (A → B means A depends on B)
- Identify root nodes (no dependencies)
- Identify leaf nodes (nothing depends on them)
- Find critical paths
- Detect cycles (error!)
```

### Step 4: Identify Implementation Order
```
Topological sort:
1. Implement root nodes first
2. Then nodes whose dependencies are met
3. Continue until all implemented
4. Flag parallel opportunities
```

### Step 5: Document Dependency Matrix
```
Matrix format:
          | REQ-A | REQ-B | REQ-C |
REQ-A     |   -   |   →   |       |
REQ-B     |   ←   |   -   |   →   |
REQ-C     |       |   ←   |   -   |

→ = depends on
← = depended upon by
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements_spec | Markdown | Yes | All requirements |
| architecture | Markdown | Optional | Technical dependencies |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| dependency_map.json | JSON | Complete dependency data |
| dependency_graph.mermaid | Mermaid | Visual graph |
| implementation_order.md | Markdown | Suggested sequence |

## StudyAbroad-Specific Considerations
- Authentication is foundational (most features depend on it)
- University API must work before search features
- Profile must exist before application features
- GDPR features required across all data handling

## Integration Points
- **Orchestrator**: Task sequencing
- **Test Manager**: Test order planning
- **Architecture Agent**: Technical dependency validation

## Examples
```
Dependency Graph - StudyAbroad-v1

graph TD
    REQ-001[User Auth] --> REQ-002[Profile]
    REQ-001 --> REQ-003[Search]
    REQ-002 --> REQ-004[Application]
    REQ-003 --> REQ-004
    REQ-004 --> REQ-005[Documents]
    REQ-004 --> REQ-006[Tracking]
    REQ-001 --> REQ-010[GDPR Consent]
    REQ-002 --> REQ-011[Data Export]
    REQ-002 --> REQ-012[Account Delete]

Implementation Order:
1. REQ-001 (Auth) - Foundation
2. REQ-010 (GDPR Consent) - Required with auth
3. REQ-002 (Profile) - After auth
4. REQ-003 (Search) - After auth
5. REQ-011, REQ-012 (GDPR) - After profile
6. REQ-004 (Application) - After profile & search
7. REQ-005 (Documents) - After application
8. REQ-006 (Tracking) - After application

Parallel Opportunities:
- REQ-002 and REQ-003 can parallel after REQ-001
- REQ-005 and REQ-006 can parallel after REQ-004
```

## Validation
- All requirements in dependency map
- No circular dependencies
- Root nodes identified
- Implementation order valid
- External dependencies flagged

---
SKILL_ID: REQ-007
SKILL_PATH: skills/requirements/change-impact/SKILL.md
---
name: change-impact-analysis
description: Assess impact of requirement changes on project
skill_id: REQ-007
owner: requirements
collaborators: [test-manager, developer]
collaboration_rules: |
  - test-manager-agent: Invokes when analyzing test impacts from requirement changes
  - developer-agent: Invokes when estimating code changes needed for requirement modifications
project: studyabroad-v1
version: 1.0.0
when_to_use: When requirements change, scope adjustments, new feature requests
dependencies: [REQ-006, REQ-008]
---

# Change Impact Analysis

## Purpose
Assess the impact of requirement changes on schedule, scope, architecture, and downstream artifacts to enable informed decisions about accepting or rejecting changes.

## When to Use
- New requirement requested
- Existing requirement modified
- Requirement removed
- Scope change discussion
- Mid-sprint changes

## Prerequisites
- Existing requirements documented
- Dependencies mapped
- Traceability matrix available
- Current project status known

## Process

### Step 1: Document the Change
```
Change record:
- Change ID
- Change type: Add/Modify/Remove
- Requirement affected
- Change description
- Requester
- Urgency
```

### Step 2: Analyze Direct Impact
```
Direct impacts:
- Which artifacts change?
- Which agents affected?
- Effort estimate for change
- Schedule impact
- Cost impact
```

### Step 3: Analyze Downstream Impact
```
Using traceability:
- Design documents affected
- Test cases needing update
- Code modules to modify
- Documentation updates
- Deployment changes
```

### Step 4: Analyze Dependencies
```
Dependency cascade:
- Requirements that depend on changed item
- Requirements that changed item depends on
- External system impacts
```

### Step 5: Generate Impact Report
```
Report includes:
- Change summary
- Impact assessment (Low/Medium/High)
- Affected artifacts list
- Effort estimate
- Schedule impact
- Risk assessment
- Recommendation (Accept/Reject/Defer)
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| change_request | JSON | Yes | Proposed change details |
| traceability_matrix | CSV | Yes | Current traceability |
| dependency_map | JSON | Yes | Requirement dependencies |
| project_status | JSON | Yes | Current progress |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| impact_report.md | Markdown | Complete analysis |
| affected_artifacts.json | JSON | List of artifacts |
| effort_estimate.json | JSON | Estimated work |

## StudyAbroad-Specific Considerations
- Auth changes cascade to most features
- GDPR changes may require legal review
- External API changes affect integration layer
- UI changes may affect accessibility compliance

## Integration Points
- **Orchestrator**: Change decision input
- **Test Manager**: Test impact analysis (TEST-006)
- **All Agents**: Artifact impact notification

## Examples
```
Change Impact Analysis

Change Request: CR-005
Description: Add "Compare Programs" feature
Type: NEW REQUIREMENT
Urgency: Normal

Direct Impact:
- New requirement: REQ-025 (Compare Programs)
- Design: New UI component, new API endpoint
- Effort: 2 sprints estimated

Downstream Impact:
- Design: Add to openapi_spec.yaml
- Tests: 5-8 new test cases
- Documentation: Update user guide
- Code: New backend service, new React component

Dependencies:
- Depends on: REQ-003 (University Search) - EXISTS
- Blocks: Nothing

Impact Assessment: MEDIUM
- Moderate scope increase
- No architectural changes
- Fits within release timeline

Schedule Impact:
- Adds 2 weeks if added now
- Could parallelize with REQ-015

Risk Assessment: LOW
- No technical unknowns
- No external dependencies
- Similar patterns exist

Recommendation: ACCEPT
- High user value
- Manageable effort
- No conflicts
```

## Validation
- All downstream impacts identified
- Effort estimate reasonable
- Dependencies checked
- Recommendation justified
- Stakeholder review complete

---
SKILL_ID: REQ-008
SKILL_PATH: skills/requirements/traceability/SKILL.md
---
name: traceability-management
description: Maintain requirement IDs and relationships to downstream artifacts
skill_id: REQ-008
owner: requirements
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Throughout project, artifact creation, validation, audits
dependencies: [REQ-001]
---

# Traceability Management

## Purpose
Maintain bidirectional traceability between requirements and all downstream artifacts (designs, tests, code) to ensure complete coverage and enable impact analysis.

## When to Use
- When creating any artifact
- Validation and verification
- Impact analysis
- Audit and compliance
- Coverage gap analysis

## Prerequisites
- Requirements documented with IDs
- Artifact naming conventions defined
- Traceability matrix template ready

## Process

### Step 1: Establish ID Scheme
```
ID formats:
- Requirements: REQ-XXX
- User Stories: US-XXX
- Design: DES-XXX
- Test Cases: TC-XXX
- Code: file path
- ADRs: ADR-XXX
```

### Step 2: Create Forward Traceability
```
From requirement forward:
REQ-001 → 
  ├── DES-001 (Design)
  ├── US-001, US-002 (Stories)
  ├── TC-001, TC-002 (Tests)
  ├── src/auth/*.ts (Code)
  └── ADR-001 (Decision)
```

### Step 3: Create Backward Traceability
```
From artifact back to requirement:
src/auth/login.ts →
  └── Tests: TC-001, TC-005
      └── Stories: US-001
          └── Requirement: REQ-001
```

### Step 4: Maintain Traceability Matrix
```
Matrix format:
| REQ ID | Design | Stories | Tests | Code | Status |
|--------|--------|---------|-------|------|--------|
| REQ-001 | DES-001 | US-001,2 | TC-001-5 | auth/* | Complete |
| REQ-002 | DES-002 | US-003 | TC-010 | user/* | In Progress |
```

### Step 5: Verify Coverage
```
Coverage checks:
- Every REQ has at least one US
- Every US has at least one TC
- Every TC traces to code
- No orphan artifacts
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements | Markdown | Yes | All requirements |
| artifacts | Various | Yes | Designs, tests, code |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| traceability_matrix.csv | CSV | Complete matrix |
| coverage_report.md | Markdown | Coverage analysis |
| orphan_report.md | Markdown | Unlinked artifacts |

## StudyAbroad-Specific Considerations
- GDPR requirements must trace to specific code/tests
- External API requirements trace to integration code
- Security requirements trace to security tests
- Accessibility requirements trace to UI tests

## Integration Points
- **Test Manager**: Test traceability (TEST-005)
- **All Agents**: Artifact linking
- **Orchestrator**: Coverage validation

## Examples
```
Traceability Matrix (Excerpt)

REQ_ID,Design,User_Stories,Test_Cases,Code_Paths,Status
REQ-001,DES-001,"US-001,US-002","TC-001,TC-002,TC-003",src/backend/auth/,Complete
REQ-002,DES-002,US-003,"TC-010,TC-011",src/backend/user/profile.ts,Complete
REQ-003,"DES-003,DES-004","US-004,US-005","TC-020,TC-021,TC-022",src/backend/search/,In Progress
REQ-010,DES-010,"US-020,US-021","TC-100,TC-101",src/backend/gdpr/,Complete

Coverage Report:
- Requirements coverage: 100% (25/25 have designs)
- Test coverage: 92% (23/25 have tests)
- Code coverage: 88% (22/25 implemented)

Gaps Identified:
- REQ-023: No test cases defined
- REQ-024: No code implemented yet
```

## Validation
- Matrix complete for all requirements
- No orphan artifacts
- Bidirectional links verified
- Coverage meets thresholds
- Regular updates maintained

---
SKILL_ID: REQ-009
SKILL_PATH: skills/requirements/acceptance-criteria/SKILL.md
---
name: acceptance-criteria-writing
description: Define testable acceptance criteria for user stories
skill_id: REQ-009
owner: requirements
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: User story refinement, test case basis, definition of done
dependencies: [REQ-002]
---

# Acceptance Criteria Writing

## Purpose
Write clear, specific, and testable acceptance criteria that define exactly when a user story is complete and can be used directly for test case creation.

## When to Use
- User story creation
- Story refinement sessions
- Before sprint commitment
- Test case planning

## Prerequisites
- User story defined
- Domain understanding
- Edge cases identified
- Error scenarios known

## Process

### Step 1: Identify Scenarios
```
For each user story, identify:
- Happy path (main success scenario)
- Alternative paths (valid variations)
- Error paths (invalid inputs, failures)
- Edge cases (boundaries, limits)
```

### Step 2: Use Given-When-Then Format
```
Structure:
GIVEN [precondition/context]
  AND [additional context]
WHEN [action is performed]
  AND [additional action]
THEN [expected outcome]
  AND [additional outcome]
```

### Step 3: Make Criteria Testable
```
Testable criteria:
✓ "Search results appear within 2 seconds"
✗ "Search is fast"

✓ "Error message displays: 'Invalid email format'"
✗ "Appropriate error is shown"

✓ "User receives email within 5 minutes"
✗ "User is notified"
```

### Step 4: Cover All Paths
```
Checklist:
- [ ] Happy path covered
- [ ] All input validations
- [ ] All error conditions
- [ ] Boundary values tested
- [ ] Security scenarios (if applicable)
- [ ] Accessibility requirements (if UI)
```

### Step 5: Review and Validate
```
Quality checks:
- Each AC is independently testable
- No ambiguous terms
- Specific expected outcomes
- Covers acceptance by stakeholder
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| user_story | Markdown | Yes | Story to detail |
| domain_rules | Markdown | Optional | Business rules |
| similar_stories | JSON | Optional | Reference patterns |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| acceptance_criteria | Markdown | GWT format criteria |
| test_case_outline | Markdown | Ready for test creation |

## StudyAbroad-Specific Considerations
- Include GDPR consent in user registration AC
- Specify OAuth2 flows in authentication AC
- Include accessibility checks in UI stories
- Specify file types/sizes in upload stories

## Integration Points
- **Test Manager**: AC becomes test cases
- **Developer**: AC is definition of done
- **BMAD QA**: Validation reference
- **Ralph Wiggum**: /ralph-loop for iterative AC refinement until testable

## Examples
```
User Story: US-005 - Document Upload

As a study abroad applicant
I want to upload required documents
So that I can complete my application

Acceptance Criteria:

AC1: Successful upload
GIVEN I am logged in and on my application page
  AND I have a PDF document under 10MB
WHEN I click "Upload Document" and select the file
THEN the document uploads successfully
  AND I see a success message "Document uploaded"
  AND the document appears in my documents list
  AND the upload timestamp is displayed

AC2: File type validation
GIVEN I am on the document upload page
WHEN I attempt to upload a file that is not PDF, JPG, or PNG
THEN the upload is rejected
  AND I see error "Invalid file type. Please upload PDF, JPG, or PNG"
  AND no file is stored

AC3: File size limit
GIVEN I am on the document upload page
WHEN I attempt to upload a file larger than 10MB
THEN the upload is rejected
  AND I see error "File too large. Maximum size is 10MB"

AC4: Upload progress
GIVEN I am uploading a document
WHEN the upload is in progress
THEN I see a progress indicator
  AND the upload button is disabled
  AND I can cancel the upload

AC5: Duplicate handling
GIVEN I have already uploaded a document named "transcript.pdf"
WHEN I upload another file named "transcript.pdf"
THEN I am prompted to confirm replacement
  AND previous version is retained until confirmed

AC6: Upload failure recovery
GIVEN my upload fails due to network error
WHEN the connection is restored
THEN I can retry the upload
  AND partial uploads are cleaned up
```

## Validation
- All scenarios covered (happy, error, edge)
- Given-When-Then format used
- Specific measurable outcomes
- No ambiguous language
- Traceable to requirements

---
SKILL_ID: REQ-010
SKILL_PATH: skills/requirements/nfr-quantification/SKILL.md
---
name: nfr-quantification
description: Convert non-functional requirements to measurable metrics
skill_id: REQ-010
owner: requirements
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Defining NFRs, architecture input, SLA definition
dependencies: [REQ-003]
---

# NFR Quantification

## Purpose
Transform vague non-functional requirements into specific, measurable metrics that can be tested, monitored, and used as acceptance criteria.

## When to Use
- NFR definition
- SLA discussions
- Architecture decisions
- Performance targets
- Monitoring setup

## Prerequisites
- NFR categories identified
- Business context understood
- Industry benchmarks available

## Process

### Step 1: Identify NFR Categories
```
Categories to quantify:
- Performance (response time, throughput)
- Scalability (users, data volume)
- Availability (uptime, recovery)
- Security (compliance, encryption)
- Usability (accessibility, satisfaction)
- Reliability (error rates, MTBF)
- Maintainability (code quality, documentation)
```

### Step 2: Define Specific Metrics
```
For each NFR, specify:
- Metric name
- Unit of measurement
- Target value
- Acceptable range
- Measurement method
- Monitoring frequency
```

### Step 3: Set Realistic Targets
```
Consider:
- Industry benchmarks
- Competitor analysis
- User expectations
- Technical feasibility
- Cost implications
- Current baseline (if exists)
```

### Step 4: Create NFR Matrix
```
Matrix format:
| NFR ID | Category | Metric | Target | Min | Max | Method |
|--------|----------|--------|--------|-----|-----|--------|
| NFR-001 | Perf | Response | 2s | 1s | 3s | APM |
```

### Step 5: Define Measurement Plan
```
For each metric:
- How is it measured?
- When is it measured?
- Who reviews results?
- What triggers alerts?
- What is the escalation path?
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| raw_nfrs | Markdown | Yes | Unquantified NFRs |
| benchmarks | JSON | Optional | Industry standards |
| constraints | Markdown | Optional | System constraints |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| nfr_matrix.md | Markdown | Quantified NFRs |
| monitoring_plan.md | Markdown | Measurement approach |
| sla_targets.md | Markdown | SLA definition |

## StudyAbroad-Specific Considerations
- Peak load during application deadlines
- GDPR compliance metrics (response times for data requests)
- External API dependency SLAs
- Multi-region latency targets

## Integration Points
- **Architecture Agent**: NFRs drive design
- **DevOps Agent**: Monitoring implementation
- **Operations Agent**: SLA tracking
- **Test Manager**: Performance test design

## Examples
```
NFR Quantification Matrix - StudyAbroad-v1

PERFORMANCE:
| ID | Metric | Target | Threshold | Critical |
|----|--------|--------|-----------|----------|
| NFR-P01 | Page load time | < 2s | < 3s | < 5s |
| NFR-P02 | API response | < 500ms | < 1s | < 2s |
| NFR-P03 | Search results | < 2s | < 3s | < 5s |
| NFR-P04 | File upload (10MB) | < 30s | < 60s | < 120s |

SCALABILITY:
| ID | Metric | Target | Notes |
|----|--------|--------|-------|
| NFR-S01 | Concurrent users | 10,000 | Normal load |
| NFR-S02 | Peak users | 25,000 | Deadline periods |
| NFR-S03 | Applications/day | 5,000 | Processing capacity |
| NFR-S04 | Storage growth | 100GB/month | Document uploads |

AVAILABILITY:
| ID | Metric | Target | Recovery |
|----|--------|--------|----------|
| NFR-A01 | Uptime | 99.5% | Monthly measure |
| NFR-A02 | RTO | 4 hours | Max recovery time |
| NFR-A03 | RPO | 1 hour | Max data loss |

SECURITY:
| ID | Metric | Target |
|----|--------|--------|
| NFR-SEC01 | Encryption | AES-256 at rest |
| NFR-SEC02 | TLS | TLS 1.3 minimum |
| NFR-SEC03 | Password hash | bcrypt, cost 12 |
| NFR-SEC04 | Session timeout | 30 min inactive |

GDPR COMPLIANCE:
| ID | Metric | Target |
|----|--------|--------|
| NFR-G01 | Data access request | < 30 days |
| NFR-G02 | Deletion request | < 72 hours |
| NFR-G03 | Breach notification | < 72 hours |
```

## Validation
- All NFRs have measurable metrics
- Targets are realistic and achievable
- Measurement method defined
- Monitoring plan in place
- Stakeholder agreement on targets


# ============================================================================
# ARCHITECTURE AGENT SKILLS (12 Skills: ARCH-001 to ARCH-012)
# ============================================================================

---
SKILL_ID: ARCH-001
SKILL_PATH: skills/architecture/architecture-pattern-selection/SKILL.md
---
name: architecture-pattern-selection
description: Choose appropriate architectural patterns for the system
skill_id: ARCH-001
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: System design, major feature additions, scalability decisions
dependencies: []
---

# Architecture Pattern Selection

## Purpose
Select appropriate architectural patterns (monolith, microservices, event-driven, etc.) based on requirements, constraints, and trade-offs to create a sustainable system design.

## When to Use
- New project architecture design
- Major system evolution
- Scalability challenges
- Technology modernization

## Prerequisites
- Requirements understood
- NFRs quantified
- Constraints identified
- Team capabilities known

## Process

### Step 1: Analyze Requirements
```
Key questions:
- What are the scalability needs?
- How complex is the domain?
- What are the deployment constraints?
- What is the team's experience?
- What are the performance requirements?
```

### Step 2: Evaluate Pattern Options
```
Common patterns:
- Monolithic: Simple, single deployment
- Layered: Separation of concerns
- Microservices: Independent scaling
- Event-Driven: Async, loose coupling
- Serverless: Pay-per-use, managed
- CQRS: Read/write optimization
```

### Step 3: Apply Selection Criteria
```
Selection matrix:
| Criteria | Monolith | Microservices | Serverless |
|----------|----------|---------------|------------|
| Complexity | Low | High | Medium |
| Scalability | Limited | High | High |
| Team size | Small | Large | Any |
| Time to market | Fast | Slow | Fast |
| Operational cost | Low | High | Variable |
```

### Step 4: Document Decision
```
Create ADR with:
- Context and requirements
- Options considered
- Decision and rationale
- Trade-offs accepted
- Consequences
```

### Step 5: Define Pattern Implementation
```
For chosen pattern:
- Component boundaries
- Communication patterns
- Data management approach
- Deployment strategy
- Evolution path
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements_spec | Markdown | Yes | System requirements |
| nfr_matrix | Markdown | Yes | Performance/scale needs |
| constraints | Markdown | Yes | Technical constraints |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| architecture_pattern.md | Markdown | Pattern decision |
| ADR-001 | Markdown | Architecture decision record |
| component_diagram | Mermaid | High-level components |

## StudyAbroad-Specific Considerations
- Modular monolith recommended for MVP (team size, time to market)
- Event-driven for external API integrations
- Consider serverless for document processing
- Plan for future microservices extraction

## Integration Points
- **Requirements Agent**: NFRs input
- **Security Agent**: Security architecture patterns
- **DevOps Agent**: Deployment patterns

## Examples
```
Architecture Pattern Decision - StudyAbroad-v1

Context:
- MVP timeline: 6 months
- Team size: Small (2-3 developers)
- Scale: 10K concurrent users (peak)
- Domain: Moderately complex

Options Evaluated:
1. Monolithic - Fast development, limited scale
2. Modular Monolith - Balanced approach
3. Microservices - Overkill for MVP

Decision: Modular Monolith

Rationale:
- Faster time to market
- Sufficient for initial scale
- Clear module boundaries for future extraction
- Team can manage single deployment

Modules Identified:
├── User Module (auth, profile)
├── University Module (search, details)
├── Application Module (forms, documents)
├── Notification Module (email, alerts)
└── Integration Module (external APIs)

Evolution Path:
- Phase 1: Modular monolith (MVP)
- Phase 2: Extract Integration Module (if API scaling needed)
- Phase 3: Consider microservices for high-traffic modules
```

## Validation
- Pattern aligns with requirements
- Team can implement pattern
- Scalability needs addressed
- ADR documented
- Evolution path defined

---
SKILL_ID: ARCH-002
SKILL_PATH: skills/architecture/technology-evaluation/SKILL.md
---
name: technology-evaluation
description: Assess and compare technology options for the stack
skill_id: ARCH-002
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Tech stack selection, library choices, tool evaluation
dependencies: [ARCH-001]
---

# Technology Evaluation

## Purpose
Systematically evaluate and compare technology options (frameworks, languages, databases, tools) to make informed decisions that balance functionality, team capability, and long-term sustainability.

## When to Use
- Initial tech stack selection
- Adding new components
- Replacing existing technology
- Evaluating new libraries

## Prerequisites
- Requirements understood
- Constraints identified
- Team skills inventory
- Budget constraints known

## Process

### Step 1: Define Evaluation Criteria
```
Common criteria:
- Functionality fit (does it solve the problem?)
- Performance (meets NFRs?)
- Team familiarity (learning curve)
- Community/support (ecosystem health)
- Cost (licensing, infrastructure)
- Security (known vulnerabilities)
- Longevity (active maintenance)
- Integration (works with other choices)
```

### Step 2: Identify Candidates
```
For each component:
- Research leading options
- Include open-source and commercial
- Check minimum 3 alternatives
- Include "build custom" option if relevant
```

### Step 3: Create Comparison Matrix
```
| Criteria | Weight | Option A | Option B | Option C |
|----------|--------|----------|----------|----------|
| Feature fit | 25% | 4/5 | 5/5 | 3/5 |
| Performance | 20% | 4/5 | 4/5 | 5/5 |
| Team skill | 20% | 5/5 | 3/5 | 2/5 |
| Community | 15% | 5/5 | 4/5 | 3/5 |
| Cost | 10% | 5/5 | 3/5 | 4/5 |
| Security | 10% | 4/5 | 4/5 | 4/5 |
| WEIGHTED | 100% | 4.35 | 3.85 | 3.25 |
```

### Step 4: Perform POC (if needed)
```
For close decisions:
- Build minimal proof of concept
- Test critical functionality
- Measure performance
- Evaluate developer experience
```

### Step 5: Document Decision
```
Create ADR including:
- Options evaluated
- Evaluation criteria and weights
- Scores and analysis
- Decision and rationale
- Risks and mitigations
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements | Markdown | Yes | Feature requirements |
| nfr_matrix | Markdown | Yes | Performance needs |
| team_skills | JSON | Optional | Team capabilities |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| tech_evaluation.md | Markdown | Comparison analysis |
| tech_stack_decision.md | Markdown | Final decisions |
| ADR-xxx | Markdown | Decision records |

## StudyAbroad-Specific Considerations
- OAuth2 library selection critical for security
- ORM that handles PostgreSQL well
- Frontend framework with good form handling
- File upload library for documents
- Consider i18n support for multi-language

## Integration Points
- **Developer Agent**: Team skill input
- **Security Agent**: Security evaluation
- **DevOps Agent**: Deployment compatibility

## Examples
```
Tech Stack Evaluation - StudyAbroad-v1

BACKEND FRAMEWORK:
| Criteria | Express | NestJS | FastAPI |
|----------|---------|--------|---------|
| Team skill | 5 | 4 | 3 |
| TypeScript | 4 | 5 | 3 |
| Performance | 4 | 4 | 5 |
| Structure | 3 | 5 | 4 |
| Ecosystem | 5 | 4 | 4 |

Decision: NestJS
Rationale: Better structure for larger app,
           TypeScript-first, good for team growth

DATABASE:
| Criteria | PostgreSQL | MySQL | MongoDB |
|----------|------------|-------|---------|
| ACID | 5 | 5 | 3 |
| JSON support | 5 | 4 | 5 |
| Team skill | 4 | 5 | 3 |
| Hosting options | 5 | 5 | 4 |

Decision: PostgreSQL
Rationale: ACID compliance, JSON support,
           excellent hosting options

Final Tech Stack:
- Frontend: React + TypeScript
- Backend: NestJS (Node.js)
- Database: PostgreSQL
- ORM: Prisma
- Auth: Passport.js with OAuth2
- Cache: Redis
- File Storage: AWS S3
- Search: PostgreSQL full-text (initially)
```

## Validation
- All major components evaluated
- Criteria weights agreed with team
- No conflicting technology choices
- ADRs created for major decisions
- POCs completed for risky choices

---
SKILL_ID: ARCH-003
SKILL_PATH: skills/architecture/database-design/SKILL.md
---
name: database-design
description: Design database schemas and select appropriate database types
skill_id: ARCH-003
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: System design, data modeling, schema changes
dependencies: [ARCH-001, ARCH-002]
---

# Database Design

## Purpose
Design database schemas that efficiently support application requirements, ensure data integrity, optimize for query patterns, and scale appropriately.

## When to Use
- Initial database design
- New feature requiring schema changes
- Performance optimization
- Data model evolution

## Prerequisites
- Domain entities understood
- Data relationships identified
- Query patterns known
- Performance requirements defined

## Process

### Step 1: Identify Entities
```
From requirements, identify:
- Core entities (users, programs, applications)
- Relationships (user applies to program)
- Attributes for each entity
- Required vs optional fields
```

### Step 2: Define Relationships
```
Relationship types:
- One-to-One (User ↔ Profile)
- One-to-Many (User → Applications)
- Many-to-Many (Users ↔ Programs via Favorites)

For each relationship:
- Cardinality
- Required/optional
- Cascade behavior
```

### Step 3: Create Entity-Relationship Diagram
```
ERD showing:
- All entities as boxes
- Attributes listed
- Relationships as lines
- Cardinality notation
- Primary keys highlighted
```

### Step 4: Define Schema Details
```
For each table:
- Column names and types
- Primary key
- Foreign keys
- Indexes
- Constraints (unique, check, not null)
- Default values
```

### Step 5: Optimize for Queries
```
Optimization steps:
- Identify hot query paths
- Add indexes for common filters
- Consider denormalization for read-heavy
- Plan partitioning for large tables
- Design for common JOINs
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements | Markdown | Yes | Data requirements |
| domain_model | Markdown | Optional | Domain entities |
| query_patterns | Markdown | Optional | Expected queries |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| database_schema.sql | SQL | DDL statements |
| erd.mermaid | Mermaid | ER diagram |
| index_strategy.md | Markdown | Indexing plan |

## StudyAbroad-Specific Considerations
- User PII requires encryption notation
- Application status history (audit trail)
- Document storage references (S3 URLs)
- External IDs for university/program mapping
- GDPR deletion requirements (soft delete vs hard delete)

## Integration Points
- **Developer Agent**: Migration implementation
- **Security Agent**: PII field identification
- **DevOps Agent**: Database provisioning

## Examples
```
Database Schema - StudyAbroad-v1

-- Users (PII - encrypted fields marked)
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL, -- PII
  email_verified BOOLEAN DEFAULT FALSE,
  password_hash VARCHAR(255), -- nullable for OAuth
  first_name VARCHAR(100), -- PII
  last_name VARCHAR(100), -- PII
  date_of_birth DATE, -- PII
  nationality VARCHAR(100), -- PII
  gdpr_consent BOOLEAN DEFAULT FALSE,
  gdpr_consent_date TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP -- soft delete for GDPR
);

-- Universities (external data)
CREATE TABLE universities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  external_id VARCHAR(100) UNIQUE, -- from API
  name VARCHAR(255) NOT NULL,
  country VARCHAR(100) NOT NULL,
  city VARCHAR(100),
  website_url VARCHAR(500),
  logo_url VARCHAR(500),
  data_source VARCHAR(50), -- which API
  last_synced_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Programs
CREATE TABLE programs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  university_id UUID REFERENCES universities(id),
  external_id VARCHAR(100),
  name VARCHAR(255) NOT NULL,
  degree_level VARCHAR(50), -- bachelor, master, etc
  field_of_study VARCHAR(100),
  duration_months INTEGER,
  language VARCHAR(50),
  tuition_amount DECIMAL(10,2),
  tuition_currency VARCHAR(3),
  application_deadline DATE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Applications
CREATE TABLE applications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  program_id UUID REFERENCES programs(id),
  status VARCHAR(50) DEFAULT 'draft',
  submitted_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, program_id)
);

-- Application Status History (audit trail)
CREATE TABLE application_status_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  application_id UUID REFERENCES applications(id),
  old_status VARCHAR(50),
  new_status VARCHAR(50) NOT NULL,
  changed_by UUID REFERENCES users(id),
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Documents
CREATE TABLE documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  application_id UUID REFERENCES applications(id),
  document_type VARCHAR(50) NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  file_size INTEGER,
  mime_type VARCHAR(100),
  storage_url VARCHAR(500) NOT NULL, -- S3 URL
  uploaded_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_programs_university ON programs(university_id);
CREATE INDEX idx_programs_country ON programs(university_id, field_of_study);
CREATE INDEX idx_applications_user ON applications(user_id);
CREATE INDEX idx_applications_status ON applications(status);
CREATE INDEX idx_documents_application ON documents(application_id);
```

## Validation
- All entities from requirements represented
- Relationships correctly modeled
- Primary and foreign keys defined
- Indexes cover main query patterns
- PII fields identified
- GDPR compliance considered (soft delete)

---
SKILL_ID: ARCH-004
SKILL_PATH: skills/architecture/api-architecture/SKILL.md
---
name: api-architecture
description: Design API structure, versioning, and contracts
skill_id: ARCH-004
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: API design, integration planning, contract definition
dependencies: [ARCH-001]
---

# API Architecture

## Purpose
Design the overall API architecture including style (REST/GraphQL), versioning strategy, authentication flow, and high-level endpoint structure.

## When to Use
- System API design
- Integration architecture
- API versioning decisions
- Authentication design

## Prerequisites
- Requirements understood
- Consumers identified (web, mobile, third-party)
- Security requirements known

## Process

### Step 1: Choose API Style
```
Options:
- REST: Resource-based, HTTP verbs, stateless
- GraphQL: Flexible queries, single endpoint
- gRPC: High performance, binary protocol

Selection criteria:
- Consumer needs (flexibility vs simplicity)
- Team experience
- Performance requirements
- Tooling needs
```

### Step 2: Define Resource Structure
```
For REST:
- Identify resources (nouns)
- Define URL hierarchy
- Map HTTP verbs to operations
- Plan query parameters
- Design response formats
```

### Step 3: Design Authentication Flow
```
Common patterns:
- Session-based: Server-side session
- JWT: Stateless token
- OAuth2: Third-party auth
- API Keys: Service-to-service

For StudyAbroad:
- User auth: OAuth2 (Google, University SSO)
- API auth: JWT tokens
- Refresh token rotation
```

### Step 4: Plan Versioning Strategy
```
Options:
- URL versioning: /api/v1/users
- Header versioning: Accept-Version: v1
- Query param: /api/users?version=1

Recommendation: URL versioning
- Clear and visible
- Easy to route
- Cache-friendly
```

### Step 5: Define API Standards
```
Standards to document:
- Request/response formats (JSON)
- Error response structure
- Pagination approach
- Filtering syntax
- Rate limiting
- CORS policy
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements | Markdown | Yes | Feature requirements |
| consumers | Markdown | Yes | Who will use API |
| security_reqs | Markdown | Yes | Auth requirements |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| api_architecture.md | Markdown | Overall API design |
| auth_flow.md | Markdown | Authentication design |
| api_standards.md | Markdown | API conventions |

## StudyAbroad-Specific Considerations
- REST API for simplicity
- OAuth2 with Google + University SSO
- JWT for API authentication
- Rate limiting for external API calls
- Versioning for future compatibility

## Integration Points
- **Design Agent**: Creates OpenAPI spec
- **Security Agent**: Auth flow review
- **Developer Agent**: Implementation

## Examples
```
API Architecture - StudyAbroad-v1

Style: REST
Base URL: https://api.studyabroad.com
Version: /api/v1/

Resource Hierarchy:
/api/v1/
├── /auth
│   ├── POST /login
│   ├── POST /logout
│   ├── POST /refresh
│   └── GET /oauth/{provider}/callback
├── /users
│   ├── GET /me
│   ├── PUT /me
│   └── DELETE /me (GDPR)
├── /universities
│   ├── GET / (search, paginated)
│   └── GET /{id}
├── /programs
│   ├── GET / (search, filtered)
│   ├── GET /{id}
│   └── GET /{id}/requirements
├── /applications
│   ├── GET / (user's applications)
│   ├── POST /
│   ├── GET /{id}
│   ├── PUT /{id}
│   └── POST /{id}/submit
├── /documents
│   ├── POST /upload
│   ├── GET /{id}
│   └── DELETE /{id}
└── /gdpr
    ├── GET /export
    └── POST /delete-request

Authentication Flow:
1. User clicks "Login with Google"
2. Redirect to Google OAuth
3. Callback with auth code
4. Exchange for tokens
5. Create/update user
6. Issue JWT (15min) + Refresh (7days)
7. Return tokens to client

Standard Response Format:
{
  "success": true,
  "data": { ... },
  "meta": {
    "page": 1,
    "total": 100,
    "request_id": "uuid"
  }
}

Error Response Format:
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "details": [
      { "field": "email", "issue": "invalid format" }
    ]
  },
  "meta": {
    "request_id": "uuid"
  }
}
```

## Validation
- API style matches requirements
- All resources mapped
- Auth flow secured
- Versioning planned
- Standards documented

---
SKILL_ID: ARCH-005
SKILL_PATH: skills/architecture/infrastructure-design/SKILL.md
---
name: infrastructure-design
description: Design cloud architecture and containerization strategy
skill_id: ARCH-005
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Infrastructure planning, cloud migration, scaling design
dependencies: [ARCH-001, ARCH-002]
---

# Infrastructure Design

## Purpose
Design the infrastructure architecture including cloud services, containerization, networking, and deployment topology to support application requirements.

## When to Use
- Initial infrastructure design
- Cloud provider selection
- Scaling architecture
- Cost optimization

## Prerequisites
- Application architecture defined
- NFRs (especially scalability)
- Budget constraints
- Team DevOps capabilities

## Process

### Step 1: Define Infrastructure Requirements
```
From NFRs, determine:
- Compute needs (CPU, memory)
- Storage needs (type, size)
- Network needs (bandwidth, latency)
- Availability requirements (SLA)
- Geographic distribution
- Compliance requirements (data residency)
```

### Step 2: Select Cloud Provider
```
Evaluation criteria:
- Service availability
- Pricing model
- Team familiarity
- Compliance certifications
- Regional presence
- Managed service quality
```

### Step 3: Design Compute Architecture
```
Options:
- VMs: Full control, more management
- Containers: Portable, efficient
- Serverless: Pay-per-use, limited control
- Managed services: Less control, less ops

For each tier:
- Web tier
- Application tier
- Database tier
- Background workers
```

### Step 4: Design Networking
```
Network components:
- VPC/Virtual Network
- Subnets (public/private)
- Load balancers
- CDN for static assets
- DNS configuration
- Firewall rules
```

### Step 5: Create Infrastructure Diagram
```
Document:
- All components
- Network topology
- Data flow
- Failover paths
- External integrations
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| application_architecture | Markdown | Yes | App design |
| nfr_matrix | Markdown | Yes | Scale requirements |
| budget | JSON | Optional | Cost constraints |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| infrastructure_design.md | Markdown | Complete design |
| infrastructure_diagram | Image/Mermaid | Visual topology |
| cost_estimate.md | Markdown | Expected costs |

## StudyAbroad-Specific Considerations
- GDPR: EU data residency for EU users
- Peak load: Application deadline periods
- Document storage: S3 with CDN
- Database: Managed PostgreSQL for reliability

## Integration Points
- **DevOps Agent**: Implementation
- **Security Agent**: Network security review
- **Operations Agent**: Monitoring setup

## Examples
```
Infrastructure Design - StudyAbroad-v1

Cloud Provider: AWS (EU-WEST-1 primary for GDPR)

Architecture:
┌─────────────────────────────────────────────────────────┐
│                    CloudFront CDN                        │
│                 (Static assets, caching)                 │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│              Application Load Balancer                   │
│                    (HTTPS only)                          │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                    ECS Fargate                           │
│     ┌─────────────┐  ┌─────────────┐  ┌─────────────┐   │
│     │  API (x3)   │  │  API (x3)   │  │ Worker (x2) │   │
│     └─────────────┘  └─────────────┘  └─────────────┘   │
└─────────────────────────────────────────────────────────┘
                           │
            ┌──────────────┼──────────────┐
            ▼              ▼              ▼
     ┌──────────┐   ┌──────────┐   ┌──────────┐
     │   RDS    │   │ElastiCache│  │    S3    │
     │PostgreSQL│   │  Redis    │   │Documents │
     │ (Multi-AZ)│   │          │   │          │
     └──────────┘   └──────────┘   └──────────┘

Environments:
- Production: Full redundancy
- Staging: Reduced capacity (same architecture)
- Development: Minimal (single instances)

Cost Estimate (Monthly):
- Compute (ECS): $200
- Database (RDS): $150
- Cache (Redis): $50
- Storage (S3): $30
- Network (ALB, CDN): $50
- Total: ~$480/month (staging adds ~$150)
```

## Validation
- Meets availability requirements
- Scales to NFR targets
- Within budget constraints
- GDPR compliance addressed
- Diagram is complete and accurate

---
SKILL_ID: ARCH-006
SKILL_PATH: skills/architecture/security-architecture/SKILL.md
---
name: security-architecture
description: Design authentication, authorization, and encryption architecture
skill_id: ARCH-006
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Security design, auth flows, data protection planning
dependencies: [ARCH-001, ARCH-004]
---

# Security Architecture

## Purpose
Design comprehensive security architecture covering authentication, authorization, encryption, and security controls to protect the application and user data.

## When to Use
- Initial security design
- Authentication implementation
- Data protection planning
- Compliance requirements

## Prerequisites
- Application architecture defined
- Security requirements known
- Compliance needs (GDPR)
- Threat model available

## Process

### Step 1: Design Authentication
```
Authentication components:
- Identity providers (Google, University SSO)
- Local auth (if needed)
- Token management (JWT)
- Session handling
- MFA (if required)
```

### Step 2: Design Authorization
```
Authorization model:
- Role definitions (student, advisor, admin)
- Permission matrix
- Resource-level access
- Row-level security (users see only their data)
```

### Step 3: Plan Data Protection
```
Data protection layers:
- Encryption in transit (TLS 1.3)
- Encryption at rest (AES-256)
- PII handling
- Key management
- Data masking/anonymization
```

### Step 4: Define Security Controls
```
Control categories:
- Input validation
- Output encoding
- Rate limiting
- CORS policy
- Security headers
- Audit logging
```

### Step 5: Document Security Architecture
```
Create:
- Auth flow diagrams
- Permission matrices
- Encryption topology
- Security control checklist
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| threat_model | Markdown | Optional | Identified threats |
| compliance_reqs | Markdown | Yes | GDPR, etc. |
| user_roles | JSON | Yes | Role definitions |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| security_architecture.md | Markdown | Complete design |
| auth_flow_diagram | Mermaid | Auth sequences |
| permission_matrix.md | Markdown | RBAC matrix |

## StudyAbroad-Specific Considerations
- OAuth2 with Google and University SSO
- GDPR requires consent management
- PII encryption for user data
- Student data is sensitive (FERPA-like)
- Document access controls

## Integration Points
- **Security Agent**: Review and validation
- **Developer Agent**: Implementation
- **Test Manager**: Security test design

## Examples
```
Security Architecture - StudyAbroad-v1

AUTHENTICATION:

OAuth2 Flow:
┌──────┐      ┌──────────┐      ┌──────────┐
│Client│      │ API      │      │ Google   │
└──┬───┘      └────┬─────┘      └────┬─────┘
   │ 1. Login      │                 │
   │──────────────>│                 │
   │ 2. Redirect   │                 │
   │<──────────────│                 │
   │ 3. Auth Request                 │
   │────────────────────────────────>│
   │ 4. Consent & Code               │
   │<────────────────────────────────│
   │ 5. Code                         │
   │──────────────>│                 │
   │               │ 6. Exchange     │
   │               │────────────────>│
   │               │ 7. Tokens       │
   │               │<────────────────│
   │ 8. JWT + Refresh                │
   │<──────────────│                 │

Token Strategy:
- Access Token: JWT, 15 min expiry
- Refresh Token: Opaque, 7 day expiry, rotation
- Storage: httpOnly cookies (not localStorage)

AUTHORIZATION:

Role Hierarchy:
- Admin > Advisor > Student > Guest

Permission Matrix:
| Resource | Student | Advisor | Admin |
|----------|---------|---------|-------|
| Own profile | RW | RW | RW |
| Own applications | RW | R | RW |
| All applications | - | R (assigned) | RW |
| Universities | R | R | RW |
| User management | - | - | RW |

DATA PROTECTION:

Encryption:
- In Transit: TLS 1.3 (enforced)
- At Rest: AES-256 (RDS, S3)
- PII Fields: Application-level encryption
- Secrets: AWS Secrets Manager

PII Fields (encrypted at application level):
- users.email (searchable encryption)
- users.first_name
- users.last_name
- users.date_of_birth
- users.nationality

SECURITY CONTROLS:

Headers:
- Strict-Transport-Security
- X-Content-Type-Options: nosniff
- X-Frame-Options: DENY
- Content-Security-Policy
- X-XSS-Protection

Rate Limiting:
- Auth endpoints: 10/min per IP
- API endpoints: 100/min per user
- Public search: 30/min per IP
```

## Validation
- Auth flow covers all scenarios
- RBAC matrix complete
- Encryption strategy defined
- Security controls documented
- GDPR compliance addressed

---
SKILL_ID: ARCH-007
SKILL_PATH: skills/architecture/scalability-planning/SKILL.md
---
name: scalability-planning
description: Design system for growth in users, data, and traffic
skill_id: ARCH-007
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Capacity planning, scaling design, performance architecture
dependencies: [ARCH-001, ARCH-005]
---

# Scalability Planning

## Purpose
Design the system to handle growth in users, data volume, and traffic while maintaining performance, availability, and cost efficiency.

## When to Use
- Initial architecture design
- Anticipating growth
- Performance issues
- Capacity planning

## Prerequisites
- NFR scalability targets
- Growth projections
- Current/expected load patterns
- Budget constraints

## Process

### Step 1: Define Scalability Requirements
```
From NFRs:
- Peak concurrent users
- Requests per second
- Data growth rate
- Response time SLAs
- Geographic distribution
```

### Step 2: Identify Scaling Dimensions
```
Dimensions to scale:
- Compute: More/larger instances
- Database: Read replicas, sharding
- Storage: Tiered storage, CDN
- Network: Load balancing, CDN
- Background: Worker scaling
```

### Step 3: Choose Scaling Strategies
```
Strategies:
- Vertical: Bigger machines (limit exists)
- Horizontal: More machines (preferred)
- Auto-scaling: Demand-based
- Caching: Reduce backend load
- CDN: Geographic distribution
- Async: Queue-based processing
```

### Step 4: Design for Scale
```
Design patterns:
- Stateless services (enable horizontal)
- Connection pooling
- Caching layers
- Database read replicas
- Message queues for async
- Event-driven architecture
```

### Step 5: Plan Scaling Triggers
```
Auto-scaling rules:
- CPU > 70% → add instance
- Response time > 2s → add instance
- Queue depth > 100 → add worker
- Min/max bounds defined
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| nfr_matrix | Markdown | Yes | Scale targets |
| growth_projections | JSON | Optional | Expected growth |
| current_metrics | JSON | Optional | Baseline |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| scalability_plan.md | Markdown | Scaling strategy |
| auto_scaling_config | YAML | Scaling rules |
| capacity_model.md | Markdown | Capacity calculations |

## StudyAbroad-Specific Considerations
- Peak load during application deadlines
- Seasonal patterns (enrollment periods)
- Document uploads spike with deadlines
- University API rate limits constrain scaling

## Integration Points
- **DevOps Agent**: Auto-scaling implementation
- **Operations Agent**: Capacity monitoring

## Examples
```
Scalability Plan - StudyAbroad-v1

TARGETS:
- Normal: 5,000 concurrent users
- Peak: 25,000 concurrent users (deadline days)
- API: 500 req/sec normal, 2,000 peak
- Data: 100GB growth/month

SCALING STRATEGY:

Application Layer:
- Container-based (ECS Fargate)
- Horizontal scaling 2-10 instances
- Auto-scale on CPU > 70% or response > 2s
- Stateless design (session in Redis)

Database Layer:
- RDS PostgreSQL with read replica
- Connection pooling (PgBouncer)
- Read replica for search queries
- Consider read replicas in EU-WEST-2

Caching Layer:
- Redis for sessions
- Redis for university/program cache (1hr TTL)
- CDN for static assets

Storage Layer:
- S3 for documents
- CloudFront CDN
- Lifecycle policies for old documents

Background Processing:
- SQS queues for async tasks
- Email queue
- Document processing queue
- Auto-scaling workers 1-5

AUTO-SCALING RULES:

API Service:
- Min: 2 instances
- Max: 10 instances
- Scale up: CPU > 70% for 3 min
- Scale up: Response p95 > 2s
- Scale down: CPU < 30% for 10 min

Workers:
- Min: 1 instance
- Max: 5 instances
- Scale up: Queue depth > 100
- Scale down: Queue empty for 10 min

PEAK PREPARATION:
Before application deadlines:
1. Pre-scale to 5 API instances
2. Pre-scale to 3 workers
3. Warm database connection pools
4. Clear non-essential caches
5. Enable enhanced monitoring
```

## Validation
- Meets NFR scale targets
- Auto-scaling rules defined
- Peak handling planned
- Cost implications understood
- Bottlenecks identified

---
SKILL_ID: ARCH-008
SKILL_PATH: skills/architecture/integration-architecture/SKILL.md
---
name: integration-architecture
description: Design external service integration patterns
skill_id: ARCH-008
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: External API integration, third-party services, B2B connections
dependencies: [ARCH-001, ARCH-004]
---

# Integration Architecture

## Purpose
Design robust integration patterns for external services, APIs, and third-party systems with proper error handling, resilience, and data synchronization.

## When to Use
- External API integration
- Third-party service connections
- B2B data exchange
- Service mesh design

## Prerequisites
- External services identified
- API documentation available
- SLAs and rate limits known
- Data mapping requirements

## Process

### Step 1: Catalog External Services
```
For each service:
- Service name and purpose
- API type (REST, SOAP, etc.)
- Authentication method
- Rate limits
- SLA/availability
- Data format
```

### Step 2: Design Integration Patterns
```
Pattern options:
- Direct sync: Real-time API calls
- Async queue: Message-based
- Webhook: Event-driven
- Batch: Scheduled sync
- Cache-first: Read from cache
```

### Step 3: Plan Resilience
```
Resilience patterns:
- Circuit breaker
- Retry with backoff
- Timeout configuration
- Fallback responses
- Bulkhead isolation
```

### Step 4: Design Data Mapping
```
For each integration:
- External → internal mapping
- Data transformation rules
- Validation requirements
- Error handling
- Conflict resolution
```

### Step 5: Document Integration Contracts
```
Contract includes:
- Endpoint details
- Request/response schemas
- Error codes
- Rate limits
- SLA expectations
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| external_apis | JSON | Yes | Service catalog |
| requirements | Markdown | Yes | Integration needs |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| integration_architecture.md | Markdown | Integration design |
| service_contracts | YAML | API contracts |
| data_mapping.md | Markdown | Field mappings |

## StudyAbroad-Specific Considerations
- University databases: Batch sync recommended
- Visa services: Async queue-based
- Housing APIs: Cache-first pattern
- Rate limits vary by provider

## Integration Points
- **Developer Agent**: Implementation
- **Test Manager**: Integration test design
- **Operations Agent**: Health monitoring

## Examples
```
Integration Architecture - StudyAbroad-v1

EXTERNAL SERVICES:

1. University Database API
   Type: REST API
   Auth: API Key
   Rate limit: 100 req/min
   SLA: 99.0%
   Pattern: Batch sync (nightly) + cache
   
2. Visa Service API
   Type: REST API
   Auth: OAuth2
   Rate limit: 50 req/min
   SLA: 99.5%
   Pattern: Async (queue-based)
   
3. Housing Provider API
   Type: GraphQL
   Auth: API Key
   Rate limit: 200 req/min
   SLA: 99.0%
   Pattern: Cache-first (1hr TTL)

INTEGRATION PATTERNS:

University Sync:
┌──────────┐     ┌──────────┐     ┌──────────┐
│ Scheduler│────>│ Sync Job │────>│University│
│ (nightly)│     │ Worker   │     │   API    │
└──────────┘     └────┬─────┘     └──────────┘
                      │
                      ▼
                ┌──────────┐
                │ Database │
                │ (upsert) │
                └──────────┘

Visa Status Check (Async):
┌──────────┐     ┌──────────┐     ┌──────────┐
│ User     │────>│   SQS    │────>│  Worker  │
│ Request  │     │  Queue   │     │          │
└──────────┘     └──────────┘     └────┬─────┘
                                       │
                      ┌────────────────┘
                      ▼
                ┌──────────┐     ┌──────────┐
                │  Visa    │────>│ Webhook/ │
                │  API     │     │ Callback │
                └──────────┘     └──────────┘

RESILIENCE:

Circuit Breaker Config:
- Failure threshold: 5 failures
- Recovery timeout: 30 seconds
- Half-open max calls: 3

Retry Policy:
- Max retries: 3
- Initial delay: 1 second
- Backoff multiplier: 2
- Max delay: 10 seconds

Fallback Strategies:
- University API down: Serve cached data
- Visa API down: Queue request, notify user
- Housing API down: Show "temporarily unavailable"
```

## Validation
- All external services cataloged
- Integration patterns defined
- Resilience mechanisms designed
- Data mappings documented
- SLAs understood and planned for

---
SKILL_ID: ARCH-009
SKILL_PATH: skills/architecture/cost-estimation/SKILL.md
---
name: cost-estimation
description: Estimate infrastructure and operational costs
skill_id: ARCH-009
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Budget planning, architecture decisions, scaling projections
dependencies: [ARCH-005]
---

# Cost Estimation

## Purpose
Estimate infrastructure costs, operational expenses, and total cost of ownership to support budget planning and architecture decisions.

## When to Use
- Architecture planning
- Budget approval
- Scaling decisions
- Cost optimization
- Vendor comparison

## Prerequisites
- Infrastructure design defined
- Expected usage patterns
- Cloud provider pricing
- Operational requirements

## Process

### Step 1: Identify Cost Components
```
Categories:
- Compute (VMs, containers, serverless)
- Database (instances, storage, backup)
- Storage (object, block, backup)
- Network (transfer, CDN, load balancer)
- Third-party services
- Licenses
- Operational (monitoring, logging)
```

### Step 2: Estimate Usage
```
For each component:
- Baseline usage
- Growth rate
- Peak vs normal
- Seasonal variation
```

### Step 3: Calculate Costs
```
For each component:
- Unit cost (from pricing)
- Estimated units
- Monthly cost
- Annual cost
- Growth projection
```

### Step 4: Consider Optimizations
```
Cost reduction options:
- Reserved instances
- Spot instances
- Right-sizing
- Auto-scaling
- Caching
- CDN
- Storage tiers
```

### Step 5: Create Cost Model
```
Model includes:
- Itemized costs
- Monthly totals
- Annual projections
- Growth scenarios
- Optimization opportunities
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| infrastructure_design | Markdown | Yes | Architecture |
| usage_projections | JSON | Yes | Expected usage |
| pricing | JSON | Optional | Provider pricing |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| cost_estimate.md | Markdown | Detailed estimate |
| cost_model.xlsx | Spreadsheet | Calculations |
| optimization_recommendations | Markdown | Cost savings |

## StudyAbroad-Specific Considerations
- Document storage grows linearly
- Peak costs during deadline periods
- External API costs (if metered)
- GDPR compliance may add costs

## Integration Points
- **DevOps Agent**: Infrastructure implementation
- **Operations Agent**: Cost monitoring

## Examples
```
Cost Estimate - StudyAbroad-v1 (AWS, EU-WEST-1)

MONTHLY COST BREAKDOWN:

COMPUTE:
| Component | Spec | Qty | Monthly |
|-----------|------|-----|---------|
| API (ECS) | 0.5 vCPU, 1GB | 2-10 | $80-400 |
| Workers | 0.5 vCPU, 1GB | 1-5 | $40-200 |
| Average | | | $180 |

DATABASE:
| Component | Spec | Qty | Monthly |
|-----------|------|-----|---------|
| RDS PostgreSQL | db.t3.medium | 1 | $100 |
| RDS Storage | 100GB | 1 | $25 |
| Read Replica | db.t3.small | 1 | $50 |
| Backup | 100GB | 1 | $10 |
| Total | | | $185 |

CACHE:
| Component | Spec | Monthly |
|-----------|------|---------|
| ElastiCache | cache.t3.micro | $15 |

STORAGE:
| Component | Spec | Monthly |
|-----------|------|---------|
| S3 (documents) | 500GB | $12 |
| S3 (requests) | 1M req | $5 |
| CloudFront | 100GB transfer | $10 |
| Total | | $27 |

NETWORK:
| Component | Monthly |
|-----------|---------|
| ALB | $20 |
| Data Transfer | $30 |
| Total | $50 |

OTHER:
| Component | Monthly |
|-----------|---------|
| Secrets Manager | $5 |
| CloudWatch | $20 |
| Route53 | $5 |
| Total | $30 |

SUMMARY:
| Category | Monthly | Annual |
|----------|---------|--------|
| Compute | $180 | $2,160 |
| Database | $185 | $2,220 |
| Cache | $15 | $180 |
| Storage | $27 | $324 |
| Network | $50 | $600 |
| Other | $30 | $360 |
| TOTAL | $487 | $5,844 |

With reserved instances (1yr): ~$4,200/year
Peak months (add 50%): ~$730/month

GROWTH PROJECTION:
| Year | Users | Monthly Cost |
|------|-------|--------------|
| Y1 | 5K | $500 |
| Y2 | 15K | $800 |
| Y3 | 30K | $1,200 |
```

## Validation
- All components included
- Pricing is current
- Usage estimates reasonable
- Growth scenarios modeled
- Optimization identified

---
SKILL_ID: ARCH-010
SKILL_PATH: skills/architecture/adr-writing/SKILL.md
---
name: adr-writing
description: Document architecture decisions using ADR format
skill_id: ARCH-010
owner: architecture
collaborators: [developer, security]
collaboration_rules: |
  - developer-agent: Invokes when implementation decisions require ADR documentation
  - security-agent: Invokes when security decisions need formal ADR record
project: studyabroad-v1
version: 1.0.0
when_to_use: Major architecture decisions, technology choices, pattern selections
dependencies: []
---

# ADR Writing

## Purpose
Document significant architecture decisions in a consistent format that captures context, decision rationale, and consequences for future reference.

## When to Use
- Technology selection decisions
- Pattern choices
- Major trade-off decisions
- Breaking changes
- Deprecation decisions

## Prerequisites
- Decision context understood
- Options evaluated
- Stakeholder input gathered
- Consequences analyzed

## Process

### Step 1: Determine if ADR Needed
```
Write ADR when:
- Decision affects structure significantly
- Multiple valid alternatives exist
- Decision is hard to reverse
- Team disagreed on approach
- Decision involves trade-offs
```

### Step 2: Gather Context
```
Document:
- What prompted the decision
- Business/technical drivers
- Constraints that apply
- Prior decisions affecting this
```

### Step 3: Document Options
```
For each alternative:
- Description
- Pros and cons
- Why considered
- Why rejected (if not chosen)
```

### Step 4: Write ADR
```
ADR sections:
- Title and status
- Context
- Decision
- Consequences
- Alternatives considered
```

### Step 5: Review and Store
```
Process:
- Peer review for accuracy
- Stakeholder review if needed
- Store in docs/architecture/adrs/
- Number sequentially
- Update status as needed
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| decision_context | String | Yes | What's being decided |
| options | JSON | Yes | Alternatives considered |
| evaluation | Markdown | Yes | Analysis results |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| ADR-XXX.md | Markdown | Decision record |

## StudyAbroad-Specific Considerations
- Reference GDPR compliance implications
- Note external API dependency impacts
- Consider multi-region implications

## Integration Points
- **All Agents**: Reference ADRs for context
- **Documentation Agent**: ADR maintenance

## Examples
```
# ADR-003: Use PostgreSQL for Primary Database

## Status
Accepted

## Date
2024-01-10

## Context
StudyAbroad-v1 needs a primary database for storing user data,
applications, and program information. We need ACID compliance
for transactional data, support for complex queries, and good
JSON capabilities for flexible program attributes.

## Decision
We will use PostgreSQL as our primary database.

## Consequences

### Positive
- Strong ACID compliance for financial/application data
- Excellent JSON/JSONB support for flexible schemas
- Mature ecosystem with good tooling
- Team has strong PostgreSQL experience
- Good managed options (RDS, Cloud SQL)
- Built-in full-text search for program search

### Negative
- Horizontal scaling more complex than NoSQL
- May need to add search engine later for advanced search
- Connection management requires pooling

### Risks
- Large table performance may need partitioning
- Read scaling requires replica management

## Alternatives Considered

### MySQL
- Similar relational capability
- Slightly less JSON support
- Team has less experience
- Rejected: PostgreSQL better fit for JSON needs

### MongoDB
- Native JSON document storage
- Easy horizontal scaling
- Less ACID guarantee
- Rejected: Need strong ACID for applications

### DynamoDB
- Serverless, auto-scaling
- Limited query flexibility
- Rejected: Query patterns too rigid

## Related
- Requires: None
- Enables: ADR-004 (ORM Selection)
- Related: REQ-003 (University search needs)
```

## Validation
- Context clearly explains the need
- Decision is unambiguous
- Consequences are realistic
- Alternatives were genuinely considered
- Format is consistent with other ADRs

---
SKILL_ID: ARCH-011
SKILL_PATH: skills/architecture/diagram-generation/SKILL.md
---
name: diagram-generation
description: Create C4, sequence, and ER diagrams
skill_id: ARCH-011
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Architecture documentation, design communication, reviews
dependencies: [ARCH-001]
---

# Diagram Generation

## Purpose
Create clear, consistent architectural diagrams (C4 model, sequence diagrams, ER diagrams) to communicate system design to technical and non-technical stakeholders.

## When to Use
- Architecture documentation
- Design reviews
- Stakeholder communication
- Onboarding materials
- Change impact visualization

## Prerequisites
- Architecture defined
- Diagram type selected
- Audience identified
- Tool selected (Mermaid, PlantUML)

## Process

### Step 1: Select Diagram Type
```
Diagram types:
- C4 Context: System and external actors
- C4 Container: Major components
- C4 Component: Internal structure
- Sequence: Interaction flows
- ER Diagram: Data model
- Deployment: Infrastructure
```

### Step 2: Identify Scope
```
For each diagram:
- What level of detail?
- Which components included?
- What story does it tell?
- Who is the audience?
```

### Step 3: Create Diagram
```
Using Mermaid syntax:
- Use consistent naming
- Group related elements
- Add clear labels
- Include legend if needed
```

### Step 4: Add Documentation
```
With each diagram:
- Title and purpose
- Key for any abbreviations
- Version/date
- Related diagrams
```

### Step 5: Review and Iterate
```
Quality checks:
- Accurate representation
- Appropriate detail level
- Consistent styling
- Clear legend/labels
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| architecture | Markdown | Yes | Architecture docs |
| diagram_type | String | Yes | Type requested |
| audience | String | Optional | Technical/business |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| diagrams/*.mermaid | Mermaid | Source files |
| diagrams/*.png | Image | Rendered diagrams |

## StudyAbroad-Specific Considerations
- Show external university API clearly
- Highlight GDPR data flows
- Include OAuth2 providers
- Show document storage path

## Integration Points
- **Documentation Agent**: Diagram maintenance
- **All Agents**: Reference diagrams

## Examples
```
C4 Context Diagram - StudyAbroad-v1

```mermaid
graph TB
    subgraph External
        Student[Student<br/>Study abroad applicant]
        Advisor[Advisor<br/>University staff]
        Admin[Admin<br/>System administrator]
    end
    
    subgraph StudyAbroad System
        WebApp[StudyAbroad<br/>Web Application]
    end
    
    subgraph External Systems
        Google[Google OAuth<br/>Authentication]
        UniAPI[University Database<br/>Program data]
        VisaAPI[Visa Service<br/>Status checking]
        Email[Email Service<br/>Notifications]
    end
    
    Student --> WebApp
    Advisor --> WebApp
    Admin --> WebApp
    
    WebApp --> Google
    WebApp --> UniAPI
    WebApp --> VisaAPI
    WebApp --> Email
```

C4 Container Diagram:

```mermaid
graph TB
    subgraph Client
        Browser[Web Browser<br/>React SPA]
    end
    
    subgraph API Layer
        ALB[Load Balancer<br/>AWS ALB]
        API[API Service<br/>NestJS]
    end
    
    subgraph Data Layer
        DB[(PostgreSQL<br/>Primary DB)]
        Cache[(Redis<br/>Cache/Sessions)]
        S3[(S3<br/>Documents)]
    end
    
    subgraph Background
        Worker[Worker Service<br/>Async tasks]
        Queue[SQS<br/>Job queue]
    end
    
    Browser --> ALB
    ALB --> API
    API --> DB
    API --> Cache
    API --> S3
    API --> Queue
    Queue --> Worker
    Worker --> DB
```

Sequence Diagram - OAuth Login:

```mermaid
sequenceDiagram
    participant U as User
    participant F as Frontend
    participant A as API
    participant G as Google
    participant D as Database
    
    U->>F: Click "Login with Google"
    F->>A: GET /auth/google
    A->>F: Redirect URL
    F->>G: Authorization request
    G->>U: Show consent screen
    U->>G: Grant consent
    G->>F: Redirect with code
    F->>A: POST /auth/callback?code=xxx
    A->>G: Exchange code for tokens
    G->>A: Access token + ID token
    A->>D: Find/create user
    D->>A: User record
    A->>A: Generate JWT
    A->>F: JWT + Refresh token
    F->>U: Logged in
```
```

## Validation
- Diagrams match architecture
- Appropriate detail level
- Consistent naming
- Legend provided
- Version tracked

---
SKILL_ID: ARCH-012
SKILL_PATH: skills/architecture/environment-design/SKILL.md
---
name: environment-design
description: Define development, test, staging, and production environments
skill_id: ARCH-012
owner: architecture
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Environment planning, CI/CD setup, deployment strategy
dependencies: [ARCH-005]
---

# Environment Design

## Purpose
Define consistent environment configurations for development, testing, staging, and production to ensure reliable deployments and proper isolation between environments.

## When to Use
- Project setup
- CI/CD pipeline design
- Deployment planning
- Environment troubleshooting

## Prerequisites
- Infrastructure design complete
- Deployment needs understood
- Testing strategy defined
- Cost constraints known

## Process

### Step 1: Identify Environments
```
Standard environments:
- Development: Local/shared dev
- Testing: Automated test execution
- Staging: Pre-production validation
- Production: Live system
```

### Step 2: Define Environment Purposes
```
For each environment:
- Primary use case
- Who has access
- Data characteristics
- Uptime expectations
- Cost constraints
```

### Step 3: Specify Configuration
```
For each environment define:
- Infrastructure (scale, redundancy)
- Data (real, synthetic, anonymized)
- Integrations (mocked, sandbox, production)
- Secrets management
- Monitoring level
```

### Step 4: Plan Data Management
```
Data strategy:
- Development: Seed data, minimal
- Testing: Fixtures, automated reset
- Staging: Anonymized production copy
- Production: Real data, protected
```

### Step 5: Document Environment Matrix
```
Create matrix showing:
- All configuration parameters
- Values per environment
- Parity indicators
- Differences and reasons
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| infrastructure_design | Markdown | Yes | Production architecture |
| testing_strategy | Markdown | Yes | Test environment needs |
| cost_constraints | JSON | Optional | Budget per environment |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| environments.md | Markdown | Environment definitions |
| env_config/ | Files | Environment configs |
| env_matrix.md | Markdown | Configuration matrix |

## StudyAbroad-Specific Considerations
- External API sandboxes for testing
- Anonymized GDPR data for staging
- Separate OAuth apps per environment
- Document storage isolation

## Integration Points
- **DevOps Agent**: Environment provisioning
- **Developer Agent**: Local setup
- **Test Manager**: Test environment needs

## Examples
```
Environment Matrix - StudyAbroad-v1

| Config | Development | Testing | Staging | Production |
|--------|-------------|---------|---------|------------|
| Purpose | Local dev | CI/CD tests | UAT/QA | Live |
| URL | localhost:3000 | test.internal | staging.studyabroad.com | studyabroad.com |
| API instances | 1 | 1 | 2 | 2-10 |
| Database | Local PG / Docker | Docker PG | RDS small | RDS medium |
| Cache | Local Redis | Docker Redis | ElastiCache | ElastiCache |
| Storage | Local / MinIO | MinIO | S3 (staging) | S3 (prod) |
| Data | Seed data | Fixtures | Anonymized copy | Real |
| Ext APIs | Mocked | Sandbox | Sandbox | Production |
| OAuth | Dev app | Test app | Staging app | Prod app |
| Secrets | .env file | CI secrets | AWS Secrets | AWS Secrets |
| Monitoring | Console | Minimal | Full | Full + alerts |
| Cost/month | $0 | ~$20 | ~$150 | ~$500 |

ENVIRONMENT PURPOSES:

Development:
- Individual developer machines
- Docker Compose for dependencies
- Seed data for common scenarios
- All external APIs mocked
- Fast feedback loop

Testing:
- CI/CD pipeline execution
- Automated test suites
- Ephemeral (created/destroyed per run)
- Sandbox API connections
- Fixtures for consistent tests

Staging:
- Pre-production validation
- UAT testing
- Production-like infrastructure (smaller)
- Anonymized data snapshot
- Sandbox APIs (or production with test data)
- Manual testing by QA/stakeholders

Production:
- Live user traffic
- Full redundancy
- Real data with backups
- Production API connections
- 24/7 monitoring and alerts
- Change management required

DATA MANAGEMENT:

Development → Testing:
- Fixtures in version control
- npm run seed for setup

Production → Staging (weekly):
1. pg_dump from production
2. Run anonymization script
3. Restore to staging
4. Clear sensitive documents
5. Reset OAuth tokens
```

## Validation
- All environments defined
- Clear purpose for each
- Data strategy documented
- Cost estimates included
- Parity with production clear

###DIFFBREAK###
# Complete SDLC Skills Content Library - Part 2 Continued
# Project: StudyAbroad-v1
# Test Manager Agent Skills (continued)

---
SKILL_ID: TEST-001
SKILL_PATH: skills/testing/test-strategy/SKILL.md
---
name: test-strategy-design
description: Create comprehensive test strategies aligned with requirements
skill_id: TEST-001
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Project start, major releases, test planning
dependencies: []
---

# Test Strategy Design

## Purpose
Create a comprehensive test strategy that defines testing objectives, scope, types, tools, environments, and success criteria aligned with project requirements and quality goals.

## When to Use
- Project initiation
- Major release planning
- Test approach changes
- Quality gate definition

## Prerequisites
- Requirements documented
- NFRs defined
- Architecture understood
- Risk assessment available

## Process

### Step 1: Define Test Objectives
```
Objectives:
- Quality goals
- Risk mitigation
- Compliance requirements
- Coverage targets
```

### Step 2: Determine Test Scope
```
In scope:
- Features to test
- Test types required
- Environments needed

Out of scope:
- Explicitly excluded items
- Deferred testing
```

### Step 3: Select Test Types
```
Test pyramid:
- Unit tests (70%)
- Integration tests (20%)
- E2E tests (10%)

Additional:
- Security testing
- Performance testing
- Accessibility testing
- Compatibility testing
```

### Step 4: Define Test Environment
```
Environments:
- Local development
- CI/CD pipeline
- Staging
- Production smoke
```

### Step 5: Create Strategy Document
```
Document includes:
- Objectives and scope
- Test types and coverage
- Tools and frameworks
- Environment strategy
- Success criteria
- Roles and responsibilities
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements_spec | Markdown | Yes | Requirements |
| nfr_matrix | Markdown | Yes | Non-functional requirements |
| risk_assessment | Markdown | Optional | Project risks |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| test_strategy.md | Markdown | Complete strategy |
| coverage_targets.md | Markdown | Coverage goals |
| tool_selection.md | Markdown | Test tools |

## StudyAbroad-Specific Considerations
- GDPR compliance testing required
- External API mocking essential
- OAuth2 flow testing
- Multi-step form testing
- Document upload testing

## Integration Points
- **Orchestrator**: Gate validation input
- **Developer Agent**: Test implementation coordination
- **Security Agent**: Security test planning

## Examples
```
Test Strategy - StudyAbroad-v1

1. OBJECTIVES
   - Ensure 80% code coverage minimum
   - Zero critical/high severity bugs in production
   - GDPR compliance verification
   - Performance meets NFRs (page load <3s, API <500ms)
   - Accessibility WCAG 2.1 AA compliance

2. TEST SCOPE

   In Scope:
   - All user-facing features
   - API endpoints
   - Database operations
   - Authentication flows
   - External API integrations
   - GDPR features
   
   Out of Scope:
   - Third-party library internals
   - External API internal behavior
   - Admin features (Phase 2)

3. TEST TYPES

   Test Pyramid:
   ┌─────────────┐
   │    E2E     │ 10% - Critical user journeys
   │    (10)    │
   ├─────────────┤
   │ Integration │ 20% - API, database, services
   │    (50)     │
   ├─────────────┤
   │    Unit     │ 70% - Components, functions
   │   (200+)    │
   └─────────────┘

   Additional Testing:
   - Security: OWASP Top 10, auth testing
   - Performance: Load testing (10K concurrent)
   - Accessibility: Automated + manual audit
   - Compatibility: Chrome, Firefox, Safari, Edge

4. TEST TOOLS

   | Type | Tool | Purpose |
   |------|------|---------|
   | Unit | Jest | JS/TS unit tests |
   | Component | Testing Library | React components |
   | Integration | Supertest | API testing |
   | E2E | Playwright | Browser automation |
   | Security | OWASP ZAP | Security scanning |
   | Performance | k6 | Load testing |
   | Accessibility | axe-core | A11y testing |
   | Mocking | MSW | API mocking |

5. ENVIRONMENTS

   | Env | Purpose | Data |
   |-----|---------|------|
   | Local | Development | Fixtures |
   | CI | Automated tests | Fixtures |
   | Staging | Integration | Anonymized |
   | Prod | Smoke tests | Production |

6. SUCCESS CRITERIA

   Gate Requirements:
   - GATE-5: 80% unit coverage, all unit tests pass
   - GATE-6: All integration/E2E pass, security scan clean
   - GATE-7: Performance NFRs met, accessibility audit pass

7. ROLES

   - Test Manager: Strategy, planning, reporting
   - Developer Agent: Unit tests, integration tests
   - Security Agent: Security test execution
   - DevOps Agent: CI/CD test integration
```

## Validation
- All requirements have test approach
- Coverage targets defined
- Tools selected and justified
- Environments specified
- Success criteria measurable

---
SKILL_ID: TEST-002
SKILL_PATH: skills/testing/test-case-design/SKILL.md
---
name: test-case-design
description: Write test cases from requirements and acceptance criteria
skill_id: TEST-002
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Test planning, requirement coverage, QA preparation
dependencies: [TEST-001]
---

# Test Case Design

## Purpose
Design comprehensive test cases from requirements and acceptance criteria that cover functional, negative, boundary, and edge case scenarios.

## When to Use
- After requirements approved
- After acceptance criteria written
- Test planning phase
- Regression suite expansion

## Prerequisites
- User stories with acceptance criteria
- Test strategy defined
- Domain understanding

## Process

### Step 1: Analyze Acceptance Criteria
```
For each AC:
- Identify testable conditions
- Extract expected outcomes
- Note preconditions
- Find boundaries
```

### Step 2: Design Test Scenarios
```
Scenario types:
- Happy path (success)
- Negative (invalid inputs)
- Boundary (limits)
- Edge cases (unusual situations)
- Error handling
```

### Step 3: Write Test Cases
```
Test case structure:
- ID and title
- Preconditions
- Test steps
- Expected results
- Test data
- Priority
```

### Step 4: Create Test Data
```
Data requirements:
- Valid data sets
- Invalid data sets
- Boundary values
- Special characters
- Empty/null values
```

### Step 5: Review and Trace
```
Quality checks:
- Full AC coverage
- Traceability maintained
- No redundant tests
- Priorities assigned
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| user_stories | JSON | Yes | Stories with AC |
| requirements | Markdown | Yes | Requirement details |
| test_strategy | Markdown | Yes | Testing approach |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| test_cases/ | Markdown | Test case files |
| test_data/ | JSON | Test data sets |
| coverage_matrix.csv | CSV | AC to TC mapping |

## StudyAbroad-Specific Considerations
- Multi-step form scenarios
- OAuth2 flow variations
- File upload edge cases
- Application state transitions
- External API response scenarios

## Integration Points
- **Requirements Agent**: Receives AC
- **Developer Agent**: Test implementation
- **Traceability**: Linked to requirements

## Examples
```
Test Cases for US-005: Document Upload

TC-005-001: Successful PDF Upload
Priority: High
Preconditions:
  - User is logged in
  - User has an application in draft status
Steps:
  1. Navigate to application documents section
  2. Click "Upload Document"
  3. Select a valid PDF file (5MB)
  4. Select document type "Transcript"
  5. Click "Upload"
Expected Results:
  - Upload progress bar appears
  - Success message displays
  - Document appears in document list
  - Document shows correct name, size, type
Test Data:
  - File: transcript_valid.pdf (5MB)
  - Type: application/pdf

TC-005-002: Reject Oversized File
Priority: High
Preconditions:
  - User is logged in
Steps:
  1. Navigate to document upload
  2. Select file larger than 10MB
  3. Attempt upload
Expected Results:
  - Upload is rejected before starting
  - Error message: "File must be under 10MB"
  - No file appears in list
Test Data:
  - File: large_file.pdf (15MB)

TC-005-003: Reject Invalid File Type
Priority: High
Preconditions:
  - User is logged in
Steps:
  1. Navigate to document upload
  2. Select .exe file
  3. Attempt upload
Expected Results:
  - Upload is rejected
  - Error message: "Only PDF, JPG, PNG files allowed"
Test Data:
  - File: malware.exe

TC-005-004: Handle Upload Interruption
Priority: Medium
Preconditions:
  - User is logged in
  - Network is unstable
Steps:
  1. Start uploading large file
  2. Simulate network interruption at 50%
  3. Wait for timeout
Expected Results:
  - Error message displayed
  - Retry button available
  - Partial upload cleaned up
  - Can retry successfully

TC-005-005: Boundary - Exactly 10MB File
Priority: Medium
Steps:
  1. Upload file exactly 10MB
Expected Results:
  - Upload succeeds (10MB is allowed)
Test Data:
  - File: exactly_10mb.pdf (10,485,760 bytes)

TC-005-006: Special Characters in Filename
Priority: Low
Steps:
  1. Upload file with special characters: "tëst döc (1).pdf"
Expected Results:
  - Upload succeeds
  - Filename displayed correctly
  - Download works

Test Coverage Matrix:
| AC | Test Cases |
|----|------------|
| AC1: Successful upload | TC-005-001 |
| AC2: File type validation | TC-005-003 |
| AC3: File size limit | TC-005-002, TC-005-005 |
| AC4: Upload progress | TC-005-001, TC-005-004 |
| AC5: Duplicate handling | TC-005-007 |
| AC6: Upload failure | TC-005-004 |
```

## Validation
- All AC covered by test cases
- Positive and negative scenarios
- Boundary values tested
- Test data specified
- Priorities assigned

---
SKILL_ID: TEST-003
SKILL_PATH: skills/testing/test-data/SKILL.md
---
name: test-data-generation
description: Create appropriate test data for various scenarios
skill_id: TEST-003
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Test preparation, fixture creation, data setup
dependencies: [TEST-002]
---

# Test Data Generation

## Purpose
Create comprehensive test data sets including valid data, boundary values, invalid data, and realistic scenarios that support thorough testing.

## When to Use
- Test case implementation
- Fixture creation
- Database seeding
- Performance test data

## Prerequisites
- Data models understood
- Validation rules known
- Test cases designed
- Privacy requirements known

## Process

### Step 1: Identify Data Needs
```
Data categories:
- Entity data (users, applications)
- Reference data (countries, programs)
- State data (statuses, dates)
- File data (documents)
```

### Step 2: Design Data Sets
```
Set types:
- Minimal valid set
- Full valid set
- Boundary values
- Invalid values
- Edge cases
```

### Step 3: Generate Data
```
Generation approaches:
- Static fixtures (JSON/SQL)
- Factory patterns
- Faker libraries
- Anonymized production data
```

### Step 4: Handle Sensitive Data
```
Privacy considerations:
- No real PII in tests
- Anonymization rules
- Fake but realistic
- GDPR compliant
```

### Step 5: Document and Version
```
Documentation:
- Data structure
- Generation scripts
- Refresh procedures
- Data relationships
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| data_models | TypeScript | Yes | Entity definitions |
| validation_rules | Markdown | Yes | Field constraints |
| test_cases | Markdown | Yes | Data requirements |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| fixtures/ | JSON | Static test data |
| factories/ | TypeScript | Data factories |
| seeds/ | SQL | Database seeds |

## StudyAbroad-Specific Considerations
- Fake but realistic student data
- Program deadlines (past, future, today)
- Various application statuses
- Document file fixtures
- University/program relationships

## Integration Points
- **Developer Agent**: Uses fixtures
- **DevOps Agent**: Seed scripts
- **Security Agent**: PII handling verification

## Examples
```
Test Data - StudyAbroad-v1

1. USER DATA FACTORY

```typescript
// factories/user.factory.ts
import { faker } from '@faker-js/faker'

export const createUser = (overrides = {}) => ({
  id: faker.string.uuid(),
  email: faker.internet.email(),
  firstName: faker.person.firstName(),
  lastName: faker.person.lastName(),
  dateOfBirth: faker.date.birthdate({ min: 18, max: 30, mode: 'age' }),
  nationality: faker.helpers.arrayElement(['US', 'GB', 'DE', 'FR', 'IN']),
  createdAt: faker.date.past(),
  ...overrides
})

export const createUsers = (count: number) => 
  Array.from({ length: count }, () => createUser())

// Specific user scenarios
export const userScenarios = {
  newUser: createUser({ createdAt: new Date() }),
  userWithApplications: createUser({ id: 'user-with-apps' }),
  euUser: createUser({ nationality: 'DE' }), // For GDPR tests
  minorUser: createUser({ 
    dateOfBirth: faker.date.birthdate({ min: 16, max: 17, mode: 'age' })
  })
}
```

2. APPLICATION TEST DATA

```typescript
// fixtures/applications.ts
export const applicationFixtures = {
  // Status variations
  draftApplication: {
    id: 'app-draft-001',
    userId: 'user-001',
    programId: 'prog-001',
    status: 'draft',
    progress: 40,
    submittedAt: null
  },
  
  submittedApplication: {
    id: 'app-submitted-001',
    userId: 'user-001',
    programId: 'prog-002',
    status: 'submitted',
    progress: 100,
    submittedAt: '2024-01-10T10:00:00Z'
  },
  
  // Deadline scenarios
  applicationNearDeadline: {
    id: 'app-urgent',
    programId: 'prog-deadline-soon',
    status: 'draft',
    // Program deadline is in 3 days
  },
  
  applicationPastDeadline: {
    id: 'app-late',
    programId: 'prog-deadline-passed',
    status: 'draft',
    // Program deadline was yesterday
  }
}
```

3. UNIVERSITY/PROGRAM DATA

```json
// fixtures/universities.json
{
  "universities": [
    {
      "id": "uni-001",
      "externalId": "EXT-TUM",
      "name": "Technical University of Munich",
      "country": "DE",
      "city": "Munich",
      "programCount": 3
    },
    {
      "id": "uni-002",
      "externalId": "EXT-UVA",
      "name": "University of Amsterdam",
      "country": "NL",
      "city": "Amsterdam",
      "programCount": 2
    }
  ],
  "programs": [
    {
      "id": "prog-001",
      "universityId": "uni-001",
      "name": "MSc Computer Science",
      "degreeLevel": "master",
      "language": "English",
      "deadline": "2024-03-15",
      "tuitionAmount": 1500,
      "tuitionCurrency": "EUR"
    },
    {
      "id": "prog-deadline-soon",
      "universityId": "uni-001",
      "name": "MSc Data Science",
      "deadline": "{{TODAY+3}}"
    },
    {
      "id": "prog-deadline-passed",
      "universityId": "uni-002",
      "name": "BA Economics",
      "deadline": "{{TODAY-1}}"
    }
  ]
}
```

4. DOCUMENT TEST FILES

```
fixtures/documents/
├── valid/
│   ├── transcript_small.pdf (500KB)
│   ├── transcript_medium.pdf (5MB)
│   ├── transcript_max.pdf (10MB)
│   ├── photo.jpg (2MB)
│   └── certificate.png (1MB)
├── invalid/
│   ├── too_large.pdf (15MB)
│   ├── wrong_type.exe
│   ├── wrong_type.docx
│   └── corrupted.pdf
└── edge/
    ├── unicode_名前.pdf
    ├── spaces in name.pdf
    └── special(chars)[1].pdf
```

5. DATABASE SEED SCRIPT

```sql
-- seeds/01_users.sql
INSERT INTO users (id, email, first_name, last_name, nationality, gdpr_consent)
VALUES
  ('user-001', 'john@test.com', 'John', 'Doe', 'US', true),
  ('user-002', 'jane@test.com', 'Jane', 'Smith', 'GB', true),
  ('user-eu-001', 'hans@test.de', 'Hans', 'Mueller', 'DE', true);

-- seeds/02_applications.sql
INSERT INTO applications (id, user_id, program_id, status)
VALUES
  ('app-001', 'user-001', 'prog-001', 'draft'),
  ('app-002', 'user-001', 'prog-002', 'submitted');
```

6. EXTERNAL API MOCK DATA

```typescript
// mocks/university-api.ts
export const universityApiResponses = {
  searchSuccess: {
    universities: [
      { id: 'EXT-TUM', name: 'TU Munich', country_code: 'DE' },
      { id: 'EXT-LMU', name: 'LMU Munich', country_code: 'DE' }
    ],
    pagination: { page: 1, total: 2, hasMore: false }
  },
  
  searchEmpty: {
    universities: [],
    pagination: { page: 1, total: 0, hasMore: false }
  },
  
  rateLimited: {
    error: 'rate_limited',
    message: 'Too many requests',
    retryAfter: 60
  },
  
  serverError: {
    error: 'server_error',
    message: 'Internal server error'
  }
}
```
```

## Validation
- All test scenarios have data
- Boundary values included
- No real PII used
- Relationships maintained
- Data documented

---
SKILL_ID: TEST-004
SKILL_PATH: skills/testing/coverage-analysis/SKILL.md
---
name: coverage-analysis
description: Analyze test coverage against requirements and code
skill_id: TEST-004
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Quality assessment, gap identification, gate validation
dependencies: [TEST-002, TEST-005]
---

# Coverage Analysis

## Purpose
Analyze and measure test coverage at multiple levels (requirements, code, features) to identify gaps and ensure adequate testing before release.

## When to Use
- Gate validation
- Sprint review
- Release assessment
- Quality reporting

## Prerequisites
- Test cases executed
- Code coverage tools configured
- Traceability matrix available

## Process

### Step 1: Measure Code Coverage
```
Coverage metrics:
- Line coverage
- Branch coverage
- Function coverage
- Statement coverage
```

### Step 2: Measure Requirement Coverage
```
Requirement coverage:
- Requirements with tests
- Requirements without tests
- Test pass rate per requirement
```

### Step 3: Analyze Coverage Gaps
```
Gap identification:
- Untested code paths
- Untested requirements
- Low coverage modules
- Missing negative tests
```

### Step 4: Assess Risk
```
Risk assessment:
- Critical features coverage
- Security features coverage
- High-risk changes coverage
```

### Step 5: Generate Report
```
Coverage report:
- Summary metrics
- Gap details
- Risk assessment
- Recommendations
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| test_results | JSON | Yes | Test execution results |
| coverage_data | JSON | Yes | Code coverage output |
| traceability_matrix | CSV | Yes | Req-to-test mapping |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| coverage_report.md | Markdown | Analysis report |
| coverage_gaps.json | JSON | Identified gaps |
| risk_assessment.md | Markdown | Risk analysis |

## StudyAbroad-Specific Considerations
- GDPR features must have 100% coverage
- OAuth2 flows need complete coverage
- External API integration coverage
- Application state transitions

## Integration Points
- **Orchestrator**: Gate validation
- **Developer Agent**: Gap remediation
- **Security Agent**: Security coverage

## Examples
```
Coverage Analysis Report - StudyAbroad-v1
Sprint 5

SUMMARY:
┌─────────────────────────────────────┐
│ Overall Code Coverage: 82%         │
│ Requirement Coverage: 95%          │
│ Critical Path Coverage: 100%       │
└─────────────────────────────────────┘

CODE COVERAGE BY MODULE:

| Module | Lines | Branches | Functions |
|--------|-------|----------|-----------|
| auth | 91% | 85% | 100% |
| user | 88% | 82% | 95% |
| application | 79% | 71% | 90% |
| university | 85% | 78% | 92% |
| document | 76% | 68% | 88% |
| gdpr | 95% | 92% | 100% |
| integration | 72% | 65% | 85% |

REQUIREMENT COVERAGE:

| Priority | Total | Covered | % |
|----------|-------|---------|---|
| Must Have | 15 | 15 | 100% |
| Should Have | 12 | 11 | 92% |
| Could Have | 8 | 5 | 63% |
| Total | 35 | 31 | 89% |

COVERAGE GAPS:

Critical Gaps (Must Fix):
- None ✓

High Priority Gaps:
1. application/submit.ts lines 45-52
   - Error handling for concurrent submissions
   - Risk: Race condition possible
   - Action: Add test TC-APP-015

2. integration/university-sync.ts lines 120-135
   - Retry logic after circuit breaker opens
   - Risk: Sync failures not tested
   - Action: Add integration test

Medium Priority Gaps:
1. document/upload.ts lines 88-95
   - Virus scan timeout handling
   - Action: Add mock timeout test

2. REQ-023 (Email notifications)
   - No test cases written
   - Action: Create TC-NOTIF-001 to TC-NOTIF-005

Low Priority Gaps:
1. user/preferences.ts
   - Dark mode toggle (cosmetic)
   - Defer to Phase 2

UNCOVERED REQUIREMENTS:

| REQ ID | Description | Priority | Action |
|--------|-------------|----------|--------|
| REQ-023 | Email notifications | Should | Create tests |
| REQ-028 | Export to PDF | Could | Defer |
| REQ-029 | Social sharing | Could | Defer |
| REQ-031 | Chat support | Could | Out of scope |

RISK ASSESSMENT:

| Area | Coverage | Risk | Mitigation |
|------|----------|------|------------|
| Authentication | 91% | Low | Acceptable |
| Application Submit | 79% | Medium | Add gap tests |
| GDPR | 95% | Low | Acceptable |
| External APIs | 72% | Medium | Add mock tests |
| Document Upload | 76% | Medium | Add edge cases |

RECOMMENDATIONS:

1. Add 3 test cases for application submission edge cases
2. Increase integration module coverage to 80%
3. Create notification test suite
4. Review document upload error scenarios

GATE-6 STATUS: ⚠️ CONDITIONAL PASS
- Code coverage: 82% ✓ (target: 80%)
- Requirement coverage: 89% ⚠️ (target: 95%)
- Critical coverage: 100% ✓
- Action: Add REQ-023 tests before release
```

## Validation
- All coverage metrics calculated
- Gaps clearly identified
- Risks assessed
- Recommendations actionable
- Report is current

---
SKILL_ID: TEST-005
SKILL_PATH: skills/testing/traceability-management/SKILL.md
---
name: traceability-management
description: Maintain links between requirements, tests, and code
skill_id: TEST-005
owner: test-manager
collaborators: [requirements]
collaboration_rules: |
  - requirements-agent: Invokes when verifying requirement coverage or updating traceability matrix
project: studyabroad-v1
version: 1.0.0
when_to_use: Throughout project, artifact linking, coverage tracking
dependencies: []
---

# Traceability Management

## Purpose
Maintain bidirectional traceability between requirements, design, test cases, and code to ensure complete coverage and enable impact analysis.

## When to Use
- Test case creation
- Requirement changes
- Coverage analysis
- Audit preparation

## Prerequisites
- ID conventions established
- Artifacts created
- Matrix template ready

## Process

### Step 1: Establish ID Scheme
```
ID formats:
- Requirements: REQ-XXX
- User Stories: US-XXX
- Test Cases: TC-XXX-YYY
- Code: file paths
- Bugs: BUG-XXX
```

### Step 2: Create Forward Links
```
Forward traceability:
REQ → US → TC → Code

Each test case must link to:
- Requirement(s) it verifies
- User story/acceptance criteria
```

### Step 3: Create Backward Links
```
Backward traceability:
Code → TC → US → REQ

Each code file should link to:
- Tests that cover it
- Requirements it implements
```

### Step 4: Maintain Matrix
```
Matrix columns:
- Requirement ID
- User Story ID
- Design ID
- Test Case IDs
- Code Paths
- Status
- Last Updated
```

### Step 5: Validate Traceability
```
Validation checks:
- All REQs have tests
- All tests link to REQs
- No orphan artifacts
- Links are current
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| requirements | JSON | Yes | All requirements |
| test_cases | JSON | Yes | All test cases |
| code_map | JSON | Yes | Code file list |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| traceability_matrix.csv | CSV | Complete matrix |
| orphan_report.md | Markdown | Unlinked items |
| coverage_by_req.json | JSON | Coverage per REQ |

## StudyAbroad-Specific Considerations
- GDPR requirements must have complete trace
- External API requirements trace to mock tests
- Security requirements trace to security tests

## Integration Points
- **Requirements Agent**: REQ traceability
- **Developer Agent**: Code linking
- **Impact Analysis**: Change queries

## Examples
```
Traceability Matrix - StudyAbroad-v1

CSV Format:
req_id,user_story,design,test_cases,code_paths,status,last_updated
REQ-001,US-001,DES-001,"TC-001-001,TC-001-002,TC-001-003",src/auth/,Complete,2024-01-15
REQ-002,US-002,DES-002,"TC-002-001,TC-002-002",src/user/profile.ts,Complete,2024-01-15
REQ-003,"US-003,US-004",DES-003,"TC-003-001 to TC-003-010",src/university/,Complete,2024-01-14
REQ-005,US-005,DES-005,"TC-005-001 to TC-005-008",src/document/,Complete,2024-01-15
REQ-010,US-010,DES-010,"TC-010-001 to TC-010-005",src/gdpr/,Complete,2024-01-15
REQ-023,US-023,-,-,-,No Tests,2024-01-15

Visual Trace Example:

REQ-005: Document Upload
    │
    ├──► US-005: User can upload documents
    │       │
    │       ├──► AC1: Successful upload
    │       │       └──► TC-005-001: PDF upload success
    │       │       └──► TC-005-006: Special characters
    │       │
    │       ├──► AC2: File type validation
    │       │       └──► TC-005-003: Invalid type rejected
    │       │
    │       ├──► AC3: Size limit
    │       │       └──► TC-005-002: Oversized rejected
    │       │       └──► TC-005-005: Boundary 10MB
    │       │
    │       └──► AC4: Error recovery
    │               └──► TC-005-004: Network interruption
    │
    └──► Code: src/document/
            ├── upload.service.ts
            ├── upload.controller.ts
            └── upload.test.ts

Orphan Report:

Tests without Requirements:
- TC-MISC-001: Health check endpoint
  Action: Link to NFR-005 (Availability)

Requirements without Tests:
- REQ-023: Email notifications
  Action: Create test suite

Code without Tests:
- src/utils/date-helpers.ts (utility functions)
  Action: Add unit tests or mark as coverage exception
```

## Validation
- All requirements linked
- All tests have REQ reference
- Matrix is current
- Orphans identified
- Regular updates scheduled

---
SKILL_ID: TEST-006
SKILL_PATH: skills/testing/impact-analysis/SKILL.md
---
name: impact-analysis
description: Identify tests affected by changes for regression management
skill_id: TEST-006
owner: test-manager
collaborators: [requirements, developer]
collaboration_rules: |
  - requirements-agent: Invokes when requirement changes need test impact assessment
  - developer-agent: Invokes when code changes need affected test identification
project: studyabroad-v1
version: 1.0.0
when_to_use: Requirement changes, code changes, bug fixes
dependencies: [TEST-005]
---

# Impact Analysis

## Purpose
Analyze the impact of changes (requirements, design, code) on existing tests to identify which tests need to be updated, added, or re-executed.

## When to Use
- Requirement added/modified/removed
- Code changes
- Bug fixes
- Design changes
- External API changes

## Prerequisites
- Traceability matrix current
- Change details available
- Test inventory known

## Process

### Step 1: Identify Change Type
```
Change categories:
- Requirement change
- Design change
- Code change
- Bug fix
- External API change
- Configuration change
```

### Step 2: Query Traceability
```
Using matrix, find:
- Direct test links
- Dependent tests
- Related requirements
- Affected code paths
```

### Step 3: Categorize Impact
```
Impact categories:
- MUST_UPDATE: Test logic invalid
- MUST_REVIEW: May need changes
- MUST_RUN: Re-execute to verify
- NO_IMPACT: Unaffected
```

### Step 4: Assess Risk
```
Risk factors:
- Criticality of changed area
- Test coverage of change
- Dependencies affected
- User impact
```

### Step 5: Generate Impact Report
```
Report includes:
- Change summary
- Affected tests by category
- Risk assessment
- Recommended actions
- Effort estimate
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| change_request | JSON | Yes | Change details |
| traceability_matrix | CSV | Yes | Current traceability |
| test_inventory | JSON | Yes | All tests |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| impact_report.md | Markdown | Analysis results |
| affected_tests.json | JSON | Test list |
| action_items.json | JSON | Required actions |

## StudyAbroad-Specific Considerations
- Auth changes cascade widely
- GDPR changes need legal review
- External API changes affect mocks
- UI changes affect E2E tests

## Integration Points
- **Requirements Agent**: Change notifications
- **Developer Agent**: Code change info
- **Orchestrator**: Change coordination

## Examples
```
Impact Analysis Report

CHANGE REQUEST: CR-007
Type: Requirement Modified
Requirement: REQ-005 (Document Upload)
Change: Add virus scan before storage
Requested by: security-agent
Date: 2024-01-15

CHANGE SUMMARY:
- Add virus scanning step after upload
- Block infected files
- Add new error type: VIRUS_DETECTED
- Update upload flow with scan status

TRACEABILITY QUERY:
REQ-005 links to:
├── Design: DES-005
├── Tests: TC-005-001 to TC-005-008
├── Code: src/document/upload.*
└── Related: REQ-004 (Application), NFR-004 (Security)

AFFECTED TESTS:

MUST_UPDATE (Test logic will be invalid):
| Test ID | Reason | Action |
|---------|--------|--------|
| TC-005-001 | Success flow changes | Add scan step verification |
| TC-005-004 | Error handling | Add scan failure scenario |

MUST_ADD (New scenarios needed):
| Test ID | Description |
|---------|-------------|
| TC-005-009 | Virus detected - file rejected |
| TC-005-010 | Scan timeout handling |
| TC-005-011 | Scan service unavailable |

MUST_REVIEW (May need changes):
| Test ID | Reason |
|---------|--------|
| TC-005-002 | Size check still before scan? |
| TC-005-005 | Boundary test timing |

MUST_RUN (Regression verification):
| Test ID | Reason |
|---------|--------|
| TC-005-003 | Verify type check still works |
| TC-005-006 | Verify special chars still work |
| TC-004-* | Application tests (uses upload) |

NO_IMPACT:
- All tests outside document module
- University tests
- User tests

RISK ASSESSMENT:

| Factor | Level | Notes |
|--------|-------|-------|
| Change scope | Medium | Single module |
| Test coverage | High | Well covered area |
| User impact | Medium | Upload flow visible |
| Security | High | Security feature |

Overall Risk: MEDIUM

RECOMMENDATIONS:

1. Update TC-005-001 with scan verification
2. Create 3 new test cases for scan scenarios
3. Update test data with test virus file (EICAR)
4. Add mock for virus scan service
5. Run full document module regression
6. Run application submission E2E tests

EFFORT ESTIMATE:
- Test updates: 4 hours
- New test cases: 4 hours
- Mock creation: 2 hours
- Regression run: 1 hour
- Total: ~11 hours

TRACEABILITY UPDATE:
- Add TC-005-009 to TC-005-011 to matrix
- Update DES-005 with scan flow
- Add NFR-004 link to TC-005-009
```

## Validation
- All affected tests identified
- Categories correctly assigned
- Risk assessment complete
- Actions are specific
- Effort estimated

---
SKILL_ID: TEST-007
SKILL_PATH: skills/testing/prioritization/SKILL.md
---
name: test-prioritization
description: Prioritize tests based on risk and impact
skill_id: TEST-007
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Time-constrained testing, regression selection, smoke test design
dependencies: [TEST-004, TEST-006]
---

# Test Prioritization

## Purpose
Prioritize test execution based on risk, impact, and constraints to maximize defect detection within available time and resources.

## When to Use
- Limited testing time
- Regression test selection
- Smoke test suite design
- Risk-based testing

## Prerequisites
- Test inventory available
- Risk assessment done
- Change information available
- Historical data (optional)

## Process

### Step 1: Define Prioritization Criteria
```
Criteria:
- Business criticality
- Change frequency
- Defect history
- User impact
- Complexity
- Dependencies
```

### Step 2: Score Each Test
```
Scoring model:
Priority = (Criticality × 3) + 
           (Recent Change × 2) + 
           (Defect History × 2) + 
           (User Impact × 1)
```

### Step 3: Apply Constraints
```
Constraints:
- Available time
- Environment availability
- Data dependencies
- Execution order
```

### Step 4: Create Prioritized List
```
Priority levels:
- P0: Always run (critical path)
- P1: Run for all releases
- P2: Run for major releases
- P3: Run periodically
```

### Step 5: Generate Test Suite
```
Suite types:
- Smoke (P0 only)
- Regression (P0 + P1)
- Full (All)
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| test_inventory | JSON | Yes | All tests |
| risk_matrix | JSON | Yes | Risk by feature |
| change_log | JSON | Optional | Recent changes |
| defect_history | JSON | Optional | Past defects |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| prioritized_tests.json | JSON | Sorted test list |
| smoke_suite.json | JSON | Smoke tests |
| regression_suite.json | JSON | Regression tests |

## StudyAbroad-Specific Considerations
- Authentication always P0
- Application submission P0
- GDPR features P0/P1
- Search features P1
- UI cosmetic tests P3

## Integration Points
- **Developer Agent**: Change info
- **DevOps Agent**: CI/CD suite selection
- **Operations Agent**: Production issues

## Examples
```
Test Prioritization - StudyAbroad-v1

PRIORITIZATION CRITERIA:

| Criterion | Weight | Description |
|-----------|--------|-------------|
| Business Critical | 3 | Revenue/core function |
| Recently Changed | 2 | Changed in last sprint |
| Defect History | 2 | Had bugs before |
| User Impact | 1 | Affects many users |
| Complexity | 1 | Complex code path |

SCORING EXAMPLE:

TC-001-001: User Login
- Business Critical: 3 (auth is critical)
- Recently Changed: 0 (no recent changes)
- Defect History: 1 (one bug last quarter)
- User Impact: 3 (all users)
- Complexity: 2 (OAuth flows)

Score = (3×3) + (0×2) + (1×2) + (3×1) + (2×1) = 16

Priority: P0

PRIORITIZED TEST SUITES:

P0 - Smoke Suite (Always Run):
Run Time: ~10 minutes
| Test | Feature | Score |
|------|---------|-------|
| TC-001-001 | Login | 16 |
| TC-001-003 | Logout | 14 |
| TC-004-010 | Application Submit | 15 |
| TC-010-001 | GDPR Export | 14 |
| TC-003-001 | University Search | 13 |

P1 - Core Regression (Every Release):
Run Time: ~45 minutes
- All P0 tests +
| Test | Feature | Score |
|------|---------|-------|
| TC-002-* | User Profile (all) | 10-12 |
| TC-003-* | Search (all) | 9-13 |
| TC-004-* | Application (all) | 11-15 |
| TC-005-001-003 | Document Upload | 10-12 |
| TC-010-* | GDPR (all) | 12-14 |

P2 - Extended Regression (Major Releases):
Run Time: ~2 hours
- All P1 tests +
| Test | Feature | Score |
|------|---------|-------|
| TC-005-* | Documents (all) | 8-12 |
| TC-006-* | Notifications | 7-9 |
| TC-007-* | University Details | 6-8 |
| TC-E2E-* | E2E flows | 8-11 |

P3 - Full Suite (Periodic):
Run Time: ~4 hours
- All tests
- Run weekly or before major milestones

CI/CD CONFIGURATION:

```yaml
# .github/workflows/test.yml
jobs:
  smoke:
    # Run on every PR
    runs-on: ubuntu-latest
    steps:
      - run: npm test -- --suite=smoke

  regression:
    # Run on merge to main
    if: github.ref == 'refs/heads/main'
    steps:
      - run: npm test -- --suite=regression

  full:
    # Run weekly
    schedule:
      - cron: '0 2 * * 0'
    steps:
      - run: npm test -- --suite=full
```

DYNAMIC PRIORITIZATION:

When code changes detected:
1. Find affected tests (impact analysis)
2. Boost priority of affected tests
3. Include related regression tests
4. Generate custom suite for PR

Example PR Suite for auth changes:
- All TC-001-* (directly affected)
- TC-004-010 (submit uses auth)
- TC-010-001 (export uses auth)
- Execution time: ~15 minutes
```

## Validation
- All tests have priority
- Scoring is consistent
- Suites fit time constraints
- Critical tests always included
- Regular review scheduled

---
SKILL_ID: TEST-008
SKILL_PATH: skills/testing/defect-analysis/SKILL.md
---
name: defect-analysis
description: Analyze test failures and defect patterns
skill_id: TEST-008
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Test failure triage, quality trends, root cause analysis
dependencies: []
---

# Defect Analysis

## Purpose
Analyze test failures and defects to identify patterns, root causes, and quality trends that inform testing strategy and development practices.

## When to Use
- Test failure triage
- Sprint retrospectives
- Quality reviews
- Process improvement

## Prerequisites
- Defect tracking system
- Test execution results
- Historical data available

## Process

### Step 1: Collect Defect Data
```
Data points:
- Defect ID and description
- Severity and priority
- Component/module
- Root cause category
- Detection phase
- Resolution time
```

### Step 2: Categorize Defects
```
Categories:
- Functional bugs
- Integration issues
- Performance problems
- Security vulnerabilities
- UI/UX issues
- Data issues
```

### Step 3: Identify Patterns
```
Pattern analysis:
- Hot spots (problem areas)
- Common root causes
- Detection trends
- Escape analysis
```

### Step 4: Calculate Metrics
```
Quality metrics:
- Defect density
- Defect removal efficiency
- Mean time to detect
- Mean time to resolve
- Escape rate
```

### Step 5: Generate Insights
```
Insights:
- Problem areas
- Process gaps
- Test coverage gaps
- Training needs
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| defect_log | JSON | Yes | Defect records |
| test_results | JSON | Yes | Test execution data |
| code_metrics | JSON | Optional | Complexity data |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| defect_analysis.md | Markdown | Analysis report |
| quality_metrics.json | JSON | Calculated metrics |
| recommendations.md | Markdown | Improvement actions |

## StudyAbroad-Specific Considerations
- Track OAuth integration issues
- Monitor external API failures
- Document upload edge cases
- Multi-step form issues

## Integration Points
- **Developer Agent**: Root cause info
- **Orchestrator**: Quality reporting
- **Operations Agent**: Production defects

## Examples
```
Defect Analysis Report - StudyAbroad-v1
Period: Sprint 4-6 (6 weeks)

SUMMARY:
Total Defects: 34
- Critical: 2
- High: 8
- Medium: 16
- Low: 8

Defect Removal Efficiency: 92%
(31 found in test, 3 escaped to production)

DEFECT DISTRIBUTION BY MODULE:

```
Module          | Count | % of Total
----------------|-------|----------
Application     | 12    | 35%
Document Upload | 8     | 24%
Authentication  | 5     | 15%
University      | 4     | 12%
User Profile    | 3     | 9%
Other           | 2     | 6%
```

ROOT CAUSE ANALYSIS:

| Root Cause | Count | % |
|------------|-------|---|
| Logic error | 10 | 29% |
| Missing validation | 8 | 24% |
| Integration issue | 6 | 18% |
| Edge case missed | 5 | 15% |
| Concurrency | 3 | 9% |
| Configuration | 2 | 6% |

PATTERN ANALYSIS:

Hot Spots Identified:
1. Application Module (35% of defects)
   - Form validation issues
   - State management bugs
   - Action: Increase unit tests, add state diagrams

2. Document Upload (24% of defects)
   - File type edge cases
   - Network timeout handling
   - Action: Add more boundary tests

Common Patterns:
1. Form validation bypass (5 instances)
   - Client-side only validation
   - Action: Mandate server-side validation

2. Async operation failures (4 instances)
   - Missing error handling in promises
   - Action: Async testing patterns training

DETECTION PHASE:

| Phase | Found | Should Find |
|-------|-------|-------------|
| Unit Test | 12 | 15 |
| Integration Test | 10 | 12 |
| E2E Test | 6 | 5 |
| Code Review | 3 | 3 |
| Production | 3 | 0 |

Gap: 3 defects escaped that should have been caught in unit/integration tests

ESCAPED DEFECTS (Production):

BUG-034: OAuth token refresh race condition
- Severity: Critical
- Detection: User report
- Root cause: Concurrency
- Prevention: Add integration test for concurrent refresh

BUG-029: Unicode filename display
- Severity: Low
- Detection: User report
- Root cause: Edge case
- Prevention: Add unicode test data

BUG-031: Application deadline timezone
- Severity: High
- Detection: Monitoring alert
- Root cause: Logic error
- Prevention: Add timezone test cases

QUALITY METRICS:

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Defect Density | 2.8/KLOC | <5 | ✓ |
| Critical Escape | 1 | 0 | ✗ |
| MTTR (Critical) | 4 hours | <8 hours | ✓ |
| Test Coverage | 82% | 80% | ✓ |

RECOMMENDATIONS:

1. Application Module
   - Add state transition tests
   - Review form validation patterns
   - Priority: High

2. Document Upload
   - Expand edge case test data
   - Add network failure simulations
   - Priority: High

3. Testing Process
   - Add concurrency testing to strategy
   - Mandate timezone test cases
   - Add unicode to standard test data
   - Priority: Medium

4. Training
   - Async error handling patterns
   - Server-side validation importance
   - Priority: Medium
```

## Validation
- All defects categorized
- Patterns identified
- Metrics calculated
- Actionable recommendations
- Trends tracked

---
SKILL_ID: TEST-009
SKILL_PATH: skills/testing/reporting/SKILL.md
---
name: test-reporting
description: Generate test status and quality reports
skill_id: TEST-009
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Sprint reviews, gate validation, stakeholder updates
dependencies: [TEST-004, TEST-008]
---

# Test Reporting

## Purpose
Generate clear, actionable test reports that communicate quality status, coverage, and risks to stakeholders at various levels.

## When to Use
- Sprint reviews
- Gate validations
- Release decisions
- Stakeholder updates

## Prerequisites
- Test execution complete
- Coverage data available
- Defect data available

## Process

### Step 1: Determine Audience
```
Report types by audience:
- Executive: High-level summary
- Technical: Detailed metrics
- Development: Actionable items
- Compliance: Audit trail
```

### Step 2: Collect Data
```
Data sources:
- Test execution results
- Code coverage reports
- Defect tracking
- Traceability matrix
```

### Step 3: Calculate Metrics
```
Key metrics:
- Pass/fail rates
- Coverage percentages
- Defect counts
- Trend data
```

### Step 4: Analyze Results
```
Analysis:
- Quality assessment
- Risk identification
- Blockers
- Recommendations
```

### Step 5: Generate Report
```
Report sections:
- Executive summary
- Test execution
- Coverage analysis
- Defects
- Risks
- Recommendations
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| test_results | JSON | Yes | Execution data |
| coverage_data | JSON | Yes | Coverage metrics |
| defect_data | JSON | Yes | Defect information |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| test_report.md | Markdown | Full report |
| executive_summary.md | Markdown | Summary view |
| dashboard_data.json | JSON | Dashboard metrics |

## StudyAbroad-Specific Considerations
- GDPR compliance status
- External API test results
- Performance test results
- Accessibility status

## Integration Points
- **Orchestrator**: Gate reports
- **Documentation Agent**: Report archiving
- **DevOps Agent**: CI/CD dashboards

## Examples
```
Test Report - StudyAbroad-v1
Sprint 6 Release Candidate

═══════════════════════════════════════════════════════
EXECUTIVE SUMMARY
═══════════════════════════════════════════════════════

Quality Status: ✅ READY FOR RELEASE

Key Metrics:
┌────────────────────────────────────────────┐
│ Tests Passed: 247/252 (98.0%)             │
│ Code Coverage: 83.2%                       │
│ Critical Bugs: 0                           │
│ Open High Bugs: 1 (non-blocking)          │
└────────────────────────────────────────────┘

Recommendation: Proceed with release
Conditions: Monitor BUG-042 in production

═══════════════════════════════════════════════════════
TEST EXECUTION SUMMARY
═══════════════════════════════════════════════════════

By Test Type:
| Type | Total | Pass | Fail | Skip | Rate |
|------|-------|------|------|------|------|
| Unit | 189 | 187 | 2 | 0 | 98.9% |
| Integration | 43 | 42 | 1 | 0 | 97.7% |
| E2E | 15 | 13 | 0 | 2 | 100%* |
| Security | 5 | 5 | 0 | 0 | 100% |
| Total | 252 | 247 | 3 | 2 | 98.0% |

*E2E skip: Environment issue, manual verified

By Feature:
| Feature | Tests | Pass | Status |
|---------|-------|------|--------|
| Authentication | 28 | 28 | ✅ |
| User Profile | 22 | 22 | ✅ |
| University Search | 35 | 35 | ✅ |
| Application | 58 | 55 | ⚠️ |
| Documents | 32 | 32 | ✅ |
| GDPR | 18 | 18 | ✅ |
| Notifications | 12 | 10 | ⚠️ |

Failed Tests:
| Test ID | Feature | Reason | Impact |
|---------|---------|--------|--------|
| TC-APP-045 | Application | Race condition | BUG-042 |
| TC-APP-046 | Application | Flaky, retry pass | Low |
| TC-NOTIF-008 | Notification | Timing issue | BUG-043 |

═══════════════════════════════════════════════════════
COVERAGE ANALYSIS
═══════════════════════════════════════════════════════

Code Coverage: 83.2% (Target: 80%) ✅

By Module:
| Module | Lines | Branch | Status |
|--------|-------|--------|--------|
| auth | 92% | 88% | ✅ |
| user | 89% | 84% | ✅ |
| application | 81% | 74% | ✅ |
| document | 78% | 71% | ⚠️ |
| gdpr | 94% | 91% | ✅ |

Requirement Coverage: 97% (33/34 requirements)
- Missing: REQ-034 (deferred to Phase 2)

═══════════════════════════════════════════════════════
DEFECT STATUS
═══════════════════════════════════════════════════════

Open Defects:
| Severity | Count | In Sprint | Status |
|----------|-------|-----------|--------|
| Critical | 0 | - | ✅ |
| High | 1 | BUG-042 | ⚠️ |
| Medium | 3 | - | Deferred |
| Low | 5 | - | Deferred |

BUG-042: Application submission timeout
- Status: Known issue, workaround available
- Impact: <1% of submissions
- Mitigation: Retry mechanism added
- Plan: Fix in Sprint 7

Defects Fixed This Sprint: 12
Defect Escape Rate: 0 (no production issues)

═══════════════════════════════════════════════════════
RISK ASSESSMENT
═══════════════════════════════════════════════════════

| Risk | Level | Mitigation |
|------|-------|------------|
| BUG-042 timeout | Medium | Retry + monitoring |
| Document coverage | Low | Added to Sprint 7 |
| E2E env stability | Low | Infra improvements |

═══════════════════════════════════════════════════════
RECOMMENDATIONS
═══════════════════════════════════════════════════════

Release Recommendation: ✅ APPROVE

Conditions:
1. Deploy with enhanced monitoring for submissions
2. Alert threshold for timeout errors
3. Plan BUG-042 fix for Sprint 7

Post-Release:
1. Monitor submission success rate
2. Watch notification delivery metrics
3. Continue E2E stability improvements

═══════════════════════════════════════════════════════
SIGN-OFF
═══════════════════════════════════════════════════════

Test Manager: Approved
Date: 2024-01-15
Next Review: Sprint 7 Planning
```

## Validation
- All data sources included
- Metrics accurately calculated
- Clear recommendation
- Risks identified
- Actionable items listed

---
SKILL_ID: TEST-010
SKILL_PATH: skills/testing/regression-management/SKILL.md
---
name: regression-management
description: Maintain and optimize regression test suites
skill_id: TEST-010
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Suite maintenance, test optimization, suite expansion
dependencies: [TEST-002, TEST-007]
---

# Regression Management

## Purpose
Maintain effective regression test suites that catch regressions efficiently while minimizing execution time and maintenance burden.

## When to Use
- Suite maintenance
- After feature completion
- Performance optimization
- Suite health review

## Prerequisites
- Test inventory exists
- Execution history available
- Prioritization criteria defined

## Process

### Step 1: Assess Current Suite
```
Suite assessment:
- Total test count
- Execution time
- Pass rate history
- Flaky test rate
- Coverage overlap
```

### Step 2: Identify Optimization Opportunities
```
Optimization areas:
- Remove redundant tests
- Fix flaky tests
- Consolidate similar tests
- Parallelize execution
- Improve data setup
```

### Step 3: Manage Suite Growth
```
Addition criteria:
- Bug fix → regression test
- New feature → suite inclusion
- Critical path → P0 suite

Removal criteria:
- Feature removed
- Redundant coverage
- Consistently passing (risk-based)
```

### Step 4: Organize Suite Structure
```
Suite organization:
- By feature/module
- By priority level
- By execution time
- By dependency
```

### Step 5: Monitor Suite Health
```
Health metrics:
- Execution time trend
- Flaky test rate
- Failure patterns
- Maintenance effort
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| test_inventory | JSON | Yes | All tests |
| execution_history | JSON | Yes | Past results |
| feature_map | JSON | Yes | Feature to test mapping |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| regression_suite.json | JSON | Curated suite |
| suite_health.md | Markdown | Health report |
| optimization_plan.md | Markdown | Improvement plan |

## StudyAbroad-Specific Considerations
- OAuth regression tests essential
- Document upload regressions
- Application workflow regressions
- GDPR regression mandatory

## Integration Points
- **Developer Agent**: Regression additions
- **DevOps Agent**: Suite execution
- **Orchestrator**: Gate validation

## Examples
```
Regression Suite Management - StudyAbroad-v1

CURRENT SUITE STATUS:

Suite Overview:
| Suite | Tests | Time | Pass Rate |
|-------|-------|------|-----------|
| Smoke | 15 | 5 min | 100% |
| Core Regression | 85 | 25 min | 98.5% |
| Full Regression | 180 | 55 min | 97.2% |
| Nightly | 252 | 90 min | 96.8% |

Health Metrics:
- Flaky Tests: 5 (2.0%)
- Redundant Tests: 8 (estimated)
- Avg Maintenance: 4 hrs/sprint
- Test Growth: +12 tests/sprint

FLAKY TESTS:

| Test ID | Module | Flake Rate | Cause | Action |
|---------|--------|------------|-------|--------|
| TC-E2E-003 | App | 15% | Timing | Fix wait |
| TC-INT-022 | API | 10% | DB state | Isolate data |
| TC-E2E-008 | Upload | 8% | Network | Mock network |
| TC-UNIT-145 | Async | 5% | Race | Fix async |
| TC-E2E-012 | Search | 5% | Index | Wait for index |

Action Plan:
1. TC-E2E-003: Add explicit wait - Sprint 7
2. TC-INT-022: Transaction isolation - Sprint 7
3. Others: Batch fix in Sprint 8

REDUNDANCY ANALYSIS:

Potentially Redundant:
| Tests | Coverage | Recommendation |
|-------|----------|----------------|
| TC-003-001, TC-003-002 | Same path | Merge into 1 |
| TC-005-002, TC-005-005 | Similar boundary | Keep both |
| TC-UNIT-050-055 | Overlapping | Remove 3 |

Action: Review and merge 5 tests → Save 3 min

SUITE OPTIMIZATION PLAN:

Current: 55 min (full regression)
Target: 40 min

Optimizations:
1. Fix flaky tests: -5 min (no reruns)
2. Remove redundant: -3 min
3. Parallelize E2E: -10 min
4. Optimize data setup: -5 min
Projected: 32 min ✓

REGRESSION ADDITION QUEUE:

New Tests Pending Addition:
| Test | Feature | Priority | Sprint |
|------|---------|----------|--------|
| TC-SCAN-001 | Virus scan | P1 | 7 |
| TC-SCAN-002 | Scan timeout | P1 | 7 |
| TC-NOTIF-010 | Email retry | P2 | 7 |

Bug Fix Regressions:
| Bug | Test | Suite |
|-----|------|-------|
| BUG-034 | TC-REG-034 | Core |
| BUG-042 | TC-REG-042 | Core |

SUITE STRUCTURE:

```
regression/
├── smoke/                    # 5 min, always run
│   ├── auth.smoke.ts
│   ├── application.smoke.ts
│   └── search.smoke.ts
├── core/                     # 25 min, every merge
│   ├── auth/
│   ├── user/
│   ├── application/
│   ├── document/
│   └── gdpr/
├── extended/                 # 30 min, nightly
│   ├── university/
│   ├── notifications/
│   └── integrations/
└── e2e/                      # 20 min, parallel
    ├── user-journey/
    ├── admin-journey/
    └── error-flows/
```

MAINTENANCE SCHEDULE:

Weekly:
- Review flaky test alerts
- Triage new failures

Sprint End:
- Add feature regression tests
- Add bug fix regressions
- Review redundancy

Quarterly:
- Full suite review
- Performance optimization
- Archive obsolete tests
```

## Validation
- Suite execution time acceptable
- Flaky rate < 5%
- No redundant tests
- All critical paths covered
- Maintenance sustainable

---
SKILL_ID: TEST-011
SKILL_PATH: skills/testing/environment-management/SKILL.md
---
name: test-environment-management
description: Manage test environment setup and data
skill_id: TEST-011
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Test setup, environment configuration, data management
dependencies: [TEST-003]
---

# Test Environment Management

## Purpose
Manage test environments including setup, configuration, data management, and external service mocking to ensure reliable and reproducible test execution.

## When to Use
- Test environment setup
- CI/CD configuration
- Data refresh planning
- Mock service management

## Prerequisites
- Infrastructure available
- Test data ready
- Mock requirements known

## Process

### Step 1: Define Environment Requirements
```
Requirements:
- Compute resources
- Database instances
- External service mocks
- Network configuration
- Data requirements
```

### Step 2: Configure Environments
```
Environment types:
- Local: Developer machines
- CI: Ephemeral containers
- Staging: Persistent shared
- Performance: Scaled infrastructure
```

### Step 3: Setup Data Management
```
Data management:
- Seed scripts
- Fixture loading
- Data reset procedures
- Anonymization rules
```

### Step 4: Configure Mocks
```
Mock services:
- External APIs
- Email services
- File storage
- Payment gateways
```

### Step 5: Document Procedures
```
Documentation:
- Setup instructions
- Reset procedures
- Troubleshooting
- Access management
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| infrastructure_design | Markdown | Yes | Architecture |
| test_requirements | Markdown | Yes | What's needed |
| external_apis | JSON | Yes | APIs to mock |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| environment_config | YAML | Configuration files |
| setup_scripts/ | Bash | Setup automation |
| mock_services/ | Code | Mock implementations |

## StudyAbroad-Specific Considerations
- University API mocks
- OAuth provider mocks
- Document storage mocks
- Email service mocks

## Integration Points
- **DevOps Agent**: Infrastructure
- **Developer Agent**: Local setup
- **Security Agent**: Environment security

## Examples
```
Test Environment Management - StudyAbroad-v1

ENVIRONMENT MATRIX:

| Aspect | Local | CI | Staging |
|--------|-------|-----|---------|
| Database | Docker PG | Docker PG | RDS |
| Cache | Docker Redis | Docker Redis | ElastiCache |
| Storage | MinIO | MinIO | S3 Staging |
| External APIs | MSW mocks | MSW mocks | Sandbox |
| Email | Mailhog | None | Mailhog |
| OAuth | Mock provider | Mock provider | Test apps |

LOCAL SETUP:

```bash
# docker-compose.test.yml
services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: studyabroad_test
      POSTGRES_USER: test
      POSTGRES_PASSWORD: test
    ports:
      - "5433:5432"
  
  redis:
    image: redis:7
    ports:
      - "6380:6379"
  
  minio:
    image: minio/minio
    command: server /data
    environment:
      MINIO_ROOT_USER: minioadmin
      MINIO_ROOT_PASSWORD: minioadmin
    ports:
      - "9000:9000"
  
  mailhog:
    image: mailhog/mailhog
    ports:
      - "8025:8025"
      - "1025:1025"
```

CI ENVIRONMENT:

```yaml
# .github/workflows/test.yml
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_DB: test
          POSTGRES_PASSWORD: test
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
      redis:
        image: redis:7
        options: >-
          --health-cmd "redis-cli ping"
    
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node
        uses: actions/setup-node@v3
      - name: Install
        run: npm ci
      - name: Run migrations
        run: npm run db:migrate:test
      - name: Seed data
        run: npm run db:seed:test
      - name: Run tests
        run: npm test
```

MOCK SERVICES:

```typescript
// mocks/handlers.ts
import { http, HttpResponse } from 'msw'

export const handlers = [
  // University API
  http.get('https://api.universitydb.com/v2/universities', ({ request }) => {
    const url = new URL(request.url)
    const country = url.searchParams.get('country')
    
    return HttpResponse.json({
      universities: mockUniversities.filter(
        u => !country || u.country === country
      ),
      pagination: { page: 1, total: 10 }
    })
  }),
  
  // OAuth
  http.post('https://oauth2.googleapis.com/token', () => {
    return HttpResponse.json({
      access_token: 'mock-access-token',
      id_token: 'mock-id-token',
      expires_in: 3600
    })
  }),
  
  // Virus scan
  http.post('https://scan.example.com/scan', async ({ request }) => {
    const body = await request.formData()
    const file = body.get('file') as File
    
    // Simulate scan delay
    await new Promise(r => setTimeout(r, 100))
    
    // EICAR test file triggers virus detection
    if (file.name.includes('eicar')) {
      return HttpResponse.json({ 
        clean: false, 
        threat: 'EICAR-Test-File' 
      })
    }
    
    return HttpResponse.json({ clean: true })
  })
]
```

DATA MANAGEMENT:

```typescript
// scripts/seed-test-data.ts
import { prisma } from './client'
import { userFixtures, universityFixtures } from '../fixtures'

async function seedTestData() {
  // Clear existing data
  await prisma.$transaction([
    prisma.application.deleteMany(),
    prisma.document.deleteMany(),
    prisma.user.deleteMany(),
    prisma.program.deleteMany(),
    prisma.university.deleteMany()
  ])
  
  // Seed reference data
  await prisma.university.createMany({
    data: universityFixtures
  })
  
  // Seed test users
  await prisma.user.createMany({
    data: userFixtures
  })
  
  console.log('Test data seeded successfully')
}

// Reset between test suites
export async function resetTestData() {
  await prisma.application.deleteMany()
  await prisma.document.deleteMany()
}
```

ENVIRONMENT VARIABLES:

```bash
# .env.test
DATABASE_URL=postgresql://test:test@localhost:5433/studyabroad_test
REDIS_URL=redis://localhost:6380
S3_ENDPOINT=http://localhost:9000
S3_BUCKET=test-documents
SMTP_HOST=localhost
SMTP_PORT=1025

# Mock external services
UNIVERSITY_API_URL=https://api.universitydb.com/v2
OAUTH_MOCK=true

# Test configuration
NODE_ENV=test
LOG_LEVEL=error
```

TROUBLESHOOTING:

| Issue | Cause | Solution |
|-------|-------|----------|
| DB connection fail | Container not ready | Add health check wait |
| Mock not intercepting | MSW not started | Start in setupTests |
| Flaky async tests | Race conditions | Use waitFor utilities |
| Stale data | Incomplete reset | Reset in beforeEach |
```

## Validation
- All environments documented
- Setup scripts work
- Mocks are reliable
- Data reset works
- Team can use locally

---
SKILL_ID: TEST-012
SKILL_PATH: skills/testing/performance-test/SKILL.md
---
name: performance-test-design
description: Design load and performance test scenarios
skill_id: TEST-012
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Performance planning, load testing, NFR validation
dependencies: [TEST-001]
---

# Performance Test Design

## Purpose
Design performance tests that validate NFRs including response time, throughput, scalability, and system behavior under load.

## When to Use
- NFR validation
- Scalability testing
- Pre-release validation
- Capacity planning

## Prerequisites
- NFRs defined with metrics
- Architecture understood
- Test environment available
- Baseline established

## Process

### Step 1: Define Test Objectives
```
Objectives:
- Response time validation
- Throughput measurement
- Scalability limits
- Breaking point identification
- Endurance verification
```

### Step 2: Identify Test Scenarios
```
Scenario types:
- Load test (expected load)
- Stress test (beyond capacity)
- Spike test (sudden load)
- Endurance test (sustained load)
```

### Step 3: Design Test Cases
```
For each scenario:
- User journey simulation
- Load profile
- Success criteria
- Metrics to capture
```

### Step 4: Create Load Profiles
```
Profile elements:
- Virtual users
- Ramp-up pattern
- Steady state duration
- Think times
- Data distribution
```

### Step 5: Document Test Plan
```
Plan includes:
- Scenarios and scripts
- Environment requirements
- Success criteria
- Execution schedule
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| nfr_matrix | Markdown | Yes | Performance NFRs |
| user_journeys | Markdown | Yes | Key user flows |
| architecture | Markdown | Yes | System design |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| performance_test_plan.md | Markdown | Test plan |
| load_scripts/ | k6/JMeter | Test scripts |
| baseline_metrics.json | JSON | Baseline data |

## StudyAbroad-Specific Considerations
- Application deadline peak load
- University search performance
- Document upload under load
- Concurrent application submissions

## Integration Points
- **DevOps Agent**: Environment scaling
- **Operations Agent**: Monitoring
- **Architecture Agent**: Capacity review

## Examples
```
Performance Test Plan - StudyAbroad-v1

OBJECTIVES:
1. Validate NFR-P01: Page load < 3s at normal load
2. Validate NFR-P02: API response < 500ms
3. Validate NFR-S01: Support 10,000 concurrent users
4. Validate NFR-S02: Support 25,000 peak users
5. Identify system breaking point

TEST SCENARIOS:

Scenario 1: Baseline Load Test
- Users: 1,000 concurrent
- Duration: 30 minutes
- Ramp-up: 5 minutes
- Purpose: Establish baseline metrics

Scenario 2: Normal Load Test
- Users: 5,000 concurrent
- Duration: 1 hour
- Ramp-up: 10 minutes
- Purpose: Validate normal operation

Scenario 3: Peak Load Test
- Users: 10,000 concurrent
- Duration: 30 minutes
- Ramp-up: 15 minutes
- Purpose: Validate peak capacity

Scenario 4: Stress Test
- Users: 15,000 → 25,000
- Duration: 30 minutes
- Ramp-up: Stepped (5K increments)
- Purpose: Find breaking point

Scenario 5: Spike Test
- Users: 5,000 → 15,000 → 5,000
- Spike duration: 5 minutes
- Purpose: Test auto-scaling

Scenario 6: Endurance Test
- Users: 3,000 constant
- Duration: 8 hours
- Purpose: Detect memory leaks

USER JOURNEYS:

Journey 1: University Search (40% of load)
1. Home page load
2. Search with filters
3. View university details
4. View program details
5. Add to favorites

Journey 2: Application Flow (30% of load)
1. Login
2. Dashboard
3. Start application
4. Fill 5 form steps
5. Upload document
6. Submit

Journey 3: Status Check (20% of load)
1. Login
2. Dashboard
3. View application
4. Check status

Journey 4: Browse Only (10% of load)
1. Home page
2. Random navigation
3. Search

LOAD SCRIPT (k6):

```javascript
// scripts/load-test.js
import http from 'k6/http'
import { check, sleep } from 'k6'
import { Rate, Trend } from 'k6/metrics'

const errorRate = new Rate('errors')
const searchDuration = new Trend('search_duration')

export const options = {
  scenarios: {
    normal_load: {
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: '5m', target: 1000 },
        { duration: '30m', target: 5000 },
        { duration: '5m', target: 0 }
      ]
    }
  },
  thresholds: {
    http_req_duration: ['p(95)<500'],
    errors: ['rate<0.01']
  }
}

export default function() {
  // Journey selection based on weights
  const journey = selectJourney()
  
  if (journey === 'search') {
    universitySearchJourney()
  } else if (journey === 'application') {
    applicationJourney()
  }
  // ...
}

function universitySearchJourney() {
  // Home page
  let res = http.get(`${BASE_URL}/`)
  check(res, { 'home ok': r => r.status === 200 })
  sleep(2) // Think time
  
  // Search
  const start = Date.now()
  res = http.get(`${BASE_URL}/api/v1/universities?country=DE`)
  searchDuration.add(Date.now() - start)
  check(res, { 'search ok': r => r.status === 200 })
  
  if (res.status !== 200) {
    errorRate.add(1)
    return
  }
  
  // View details
  const universities = JSON.parse(res.body).data
  if (universities.length > 0) {
    const id = universities[0].id
    res = http.get(`${BASE_URL}/api/v1/universities/${id}`)
    check(res, { 'detail ok': r => r.status === 200 })
  }
  
  sleep(3)
}
```

SUCCESS CRITERIA:

| Metric | Baseline | Normal | Peak | Threshold |
|--------|----------|--------|------|-----------|
| Response p95 | <300ms | <500ms | <1s | <2s |
| Error rate | <0.1% | <0.5% | <1% | <2% |
| Throughput | 500 rps | 2000 rps | 4000 rps | N/A |

ENVIRONMENT:

Performance test environment:
- 4x API instances (vs 2 prod)
- Production-equivalent database
- Isolated network
- Full monitoring stack

Schedule:
- Baseline: Weekly
- Full suite: Pre-release
- Endurance: Monthly
```

## Validation
- All NFRs have tests
- Scenarios cover user journeys
- Thresholds defined
- Scripts executable
- Environment specified

---
SKILL_ID: TEST-013
SKILL_PATH: skills/testing/security-test/SKILL.md
---
name: security-test-design
description: Design security test scenarios and validation
skill_id: TEST-013
owner: test-manager
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Security validation, compliance testing, vulnerability assessment
dependencies: [TEST-001]
---

# Security Test Design

## Purpose
Design security tests that validate security controls, identify vulnerabilities, and ensure compliance with security requirements.

## When to Use
- Security validation
- Compliance audits
- Pre-release security review
- After security architecture changes

## Prerequisites
- Security requirements defined
- Threat model available
- Security architecture documented

## Process

### Step 1: Identify Security Requirements
```
Requirement sources:
- Security NFRs
- Compliance requirements (GDPR)
- OWASP guidelines
- Threat model mitigations
```

### Step 2: Define Test Categories
```
Categories:
- Authentication testing
- Authorization testing
- Input validation
- Cryptography verification
- Session management
- API security
```

### Step 3: Design Test Cases
```
For each category:
- Positive tests (controls work)
- Negative tests (attacks blocked)
- Boundary tests
- Compliance checks
```

### Step 4: Select Tools
```
Tool categories:
- Static analysis (SAST)
- Dynamic analysis (DAST)
- Dependency scanning
- Manual testing
```

### Step 5: Create Test Plan
```
Plan includes:
- Test scenarios
- Tools and methods
- Execution frequency
- Remediation process
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| security_requirements | Markdown | Yes | Security NFRs |
| threat_model | Markdown | Yes | Threat analysis |
| compliance_reqs | Markdown | Yes | GDPR, etc. |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| security_test_plan.md | Markdown | Test plan |
| security_tests/ | Code | Test scripts |
| compliance_checklist.md | Markdown | Compliance checks |

## StudyAbroad-Specific Considerations
- OAuth2 security testing
- GDPR compliance validation
- PII protection verification
- Document access control

## Integration Points
- **Security Agent**: Test collaboration
- **Developer Agent**: Remediation
- **DevOps Agent**: CI/CD security

## Examples
```
Security Test Plan - StudyAbroad-v1

SECURITY REQUIREMENTS:

| ID | Requirement | Test Category |
|----|-------------|---------------|
| SEC-001 | OAuth2 secure implementation | Auth |
| SEC-002 | JWT token security | Session |
| SEC-003 | OWASP Top 10 protection | Multiple |
| SEC-004 | PII encryption | Crypto |
| SEC-005 | GDPR compliance | Compliance |

TEST CATEGORIES:

1. AUTHENTICATION TESTING

TC-SEC-AUTH-001: OAuth2 Token Validation
- Verify valid tokens accepted
- Verify expired tokens rejected
- Verify tampered tokens rejected
- Verify token refresh works

TC-SEC-AUTH-002: Session Security
- Verify httpOnly cookie flag
- Verify secure cookie flag
- Verify session timeout
- Verify concurrent session limits

TC-SEC-AUTH-003: OAuth Flow Security
- Verify state parameter validation
- Verify PKCE implementation
- Verify redirect URI validation

2. AUTHORIZATION TESTING

TC-SEC-AUTHZ-001: Horizontal Access Control
- User A cannot access User B's applications
- User A cannot access User B's documents
- Verify 403 for unauthorized access

TC-SEC-AUTHZ-002: Vertical Access Control
- Student cannot access admin endpoints
- Advisor limited to assigned students
- Verify role escalation blocked

TC-SEC-AUTHZ-003: API Authorization
- All endpoints require authentication (except public)
- Verify middleware protection
- Test direct URL access

3. INPUT VALIDATION

TC-SEC-INPUT-001: SQL Injection
- Test all input fields
- Test URL parameters
- Test JSON body fields
- Verify parameterized queries

TC-SEC-INPUT-002: XSS Prevention
- Test text inputs
- Test file names
- Test error messages
- Verify output encoding

TC-SEC-INPUT-003: File Upload Security
- Test file type bypass attempts
- Test malicious file names
- Test oversized files
- Verify virus scanning

4. CRYPTOGRAPHY

TC-SEC-CRYPTO-001: TLS Configuration
- Verify TLS 1.3 minimum
- Verify strong cipher suites
- Verify certificate validity
- Test with SSL Labs

TC-SEC-CRYPTO-002: Data Encryption
- Verify PII encrypted at rest
- Verify password hashing (bcrypt)
- Verify no secrets in code/logs

5. GDPR COMPLIANCE

TC-SEC-GDPR-001: Consent
- Verify consent collection
- Verify consent recorded
- Verify opt-out works

TC-SEC-GDPR-002: Data Rights
- Verify data export works
- Verify data deletion works
- Verify within time limits

AUTOMATED SECURITY TESTS:

```typescript
// tests/security/auth.security.test.ts
describe('Authentication Security', () => {
  describe('Token Validation', () => {
    it('should reject expired tokens', async () => {
      const expiredToken = generateExpiredToken()
      const response = await request(app)
        .get('/api/v1/users/me')
        .set('Authorization', `Bearer ${expiredToken}`)
      
      expect(response.status).toBe(401)
      expect(response.body.error.code).toBe('AUTH_TOKEN_EXPIRED')
    })
    
    it('should reject tampered tokens', async () => {
      const tamperedToken = validToken.slice(0, -5) + 'xxxxx'
      const response = await request(app)
        .get('/api/v1/users/me')
        .set('Authorization', `Bearer ${tamperedToken}`)
      
      expect(response.status).toBe(401)
    })
  })
  
  describe('SQL Injection', () => {
    const sqlPayloads = [
      "'; DROP TABLE users; --",
      "1' OR '1'='1",
      "1; SELECT * FROM users"
    ]
    
    sqlPayloads.forEach(payload => {
      it(`should safely handle: ${payload}`, async () => {
        const response = await request(app)
          .get(`/api/v1/universities`)
          .query({ search: payload })
        
        // Should not error, should return safe results
        expect(response.status).toBe(200)
        // Verify no data leak
        expect(response.body.data).not.toContainEqual(
          expect.objectContaining({ password: expect.anything() })
        )
      })
    })
  })
})
```

CI/CD INTEGRATION:

```yaml
security:
  - name: Dependency Audit
    run: npm audit --production
    frequency: every-build
    
  - name: SAST Scan
    run: npm run security:sast
    frequency: every-build
    
  - name: DAST Scan
    run: npm run security:dast
    frequency: nightly
    
  - name: Secret Scan
    uses: trufflesecurity/trufflehog@main
    frequency: every-build
```

TOOLS:

| Tool | Purpose | Frequency |
|------|---------|-----------|
| npm audit | Dependency vulnerabilities | Every build |
| ESLint security | Code patterns | Every build |
| OWASP ZAP | Dynamic scanning | Nightly |
| Snyk | Dependency + code | Weekly |
| truffleHog | Secret detection | Every commit |

COMPLIANCE CHECKLIST:

GDPR:
☐ Consent mechanism implemented
☐ Data export within 30 days
☐ Data deletion within 72 hours
☐ Breach notification process
☐ Privacy policy accessible
☐ Cookie consent implemented

OWASP Top 10:
☐ A01: Broken Access Control - Tested
☐ A02: Cryptographic Failures - Tested
☐ A03: Injection - Tested
☐ A04: Insecure Design - Reviewed
☐ A05: Security Misconfiguration - Tested
☐ A06: Vulnerable Components - Scanned
☐ A07: Auth Failures - Tested
☐ A08: Integrity Failures - Tested
☐ A09: Logging Failures - Verified
☐ A10: SSRF - Tested
```

## Validation
- All security requirements tested
- OWASP coverage complete
- Tools integrated in CI/CD
- Compliance checklist verified
- Regular execution scheduled

###DIFFBREAK###
# Complete SDLC Skills Content Library - Part 3
# Project: StudyAbroad-v1
# Developer Agent (14) + Security Agent (13)

# ============================================================================
# DEVELOPER AGENT SKILLS (14 Skills: DEV-001 to DEV-014)
# ============================================================================

---
SKILL_ID: DEV-001
SKILL_PATH: skills/development/code-implementation/SKILL.md
---
name: code-implementation
description: Write production code following designs and best practices
skill_id: DEV-001
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Feature implementation, coding tasks
dependencies: []
---

# Code Implementation

## Purpose
Write clean, maintainable, production-quality code that implements designs, follows coding standards, and adheres to project conventions.

## When to Use
- Feature implementation
- Bug fixes
- Refactoring
- Technical debt reduction

## Prerequisites
- Design specifications available
- Coding standards defined
- Development environment ready
- Tests defined (TDD)

## Process

### Step 1: Understand Requirements
```
Before coding:
- Review design documents
- Understand acceptance criteria
- Identify dependencies
- Clarify ambiguities
```

### Step 2: Plan Implementation
```
Planning:
- Break into small increments
- Identify interfaces
- Consider edge cases
- Plan for testability
```

### Step 3: Write Code (TDD)
```
TDD cycle:
1. Write failing test
2. Write minimum code to pass
3. Refactor for quality
4. Repeat
```

### Step 4: Follow Standards
```
Standards:
- Naming conventions
- File organization
- Code formatting
- Documentation
- Error handling
```

### Step 5: Review and Refine
```
Quality checks:
- Self-review
- Lint/format
- Tests pass
- Documentation complete
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| design_spec | Markdown | Yes | Design document |
| test_cases | Markdown | Yes | Test requirements |
| coding_standards | Markdown | Yes | Project conventions |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| source_code | TypeScript | Implementation |
| tests | TypeScript | Unit tests |
| documentation | Markdown | Code docs |

## StudyAbroad-Specific Considerations
- TypeScript strict mode
- NestJS/React patterns
- Prisma for database
- Error handling patterns

## Integration Points
- **Design Agent**: Receives specs
- **Test Manager**: TDD coordination
- **Security Agent**: Security review

## Examples
```typescript
// Example: Implementing University Search Service

// 1. First, write the test (RED)
// src/university/university.service.spec.ts
describe('UniversityService', () => {
  describe('search', () => {
    it('should return universities filtered by country', async () => {
      const result = await service.search({ country: 'DE' })
      
      expect(result.data).toHaveLength(2)
      expect(result.data.every(u => u.country === 'DE')).toBe(true)
    })
    
    it('should return empty array for no matches', async () => {
      const result = await service.search({ country: 'XX' })
      
      expect(result.data).toHaveLength(0)
    })
    
    it('should paginate results', async () => {
      const result = await service.search({ page: 1, limit: 10 })
      
      expect(result.meta.page).toBe(1)
      expect(result.meta.limit).toBe(10)
      expect(result.data.length).toBeLessThanOrEqual(10)
    })
  })
})

// 2. Write implementation (GREEN)
// src/university/university.service.ts
import { Injectable } from '@nestjs/common'
import { PrismaService } from '../prisma/prisma.service'
import { SearchUniversitiesDto } from './dto/search-universities.dto'
import { PaginatedResponse } from '../common/types'
import { University } from './entities/university.entity'

@Injectable()
export class UniversityService {
  constructor(private readonly prisma: PrismaService) {}

  async search(dto: SearchUniversitiesDto): Promise<PaginatedResponse<University>> {
    const { country, query, page = 1, limit = 20 } = dto
    
    // Build where clause
    const where: Prisma.UniversityWhereInput = {}
    
    if (country) {
      where.country = country
    }
    
    if (query) {
      where.OR = [
        { name: { contains: query, mode: 'insensitive' } },
        { city: { contains: query, mode: 'insensitive' } }
      ]
    }
    
    // Execute queries
    const [data, total] = await Promise.all([
      this.prisma.university.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { name: 'asc' }
      }),
      this.prisma.university.count({ where })
    ])
    
    return {
      data,
      meta: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit)
      }
    }
  }
}

// 3. Refactor (REFACTOR)
// - Extract pagination logic to utility
// - Add caching
// - Improve types
```

## Validation
- All tests pass
- Code meets standards
- No linting errors
- Documentation complete
- PR ready for review

---
SKILL_ID: DEV-002
SKILL_PATH: skills/development/unit-testing/SKILL.md
---
name: unit-test-writing
description: Write comprehensive unit tests with good coverage
skill_id: DEV-002
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Test-driven development, code coverage
dependencies: [DEV-001]
---

# Unit Test Writing

## Purpose
Write effective unit tests that verify individual components work correctly in isolation, catch regressions, and document expected behavior.

## When to Use
- TDD (before implementation)
- After implementation (coverage)
- Bug reproduction
- Refactoring safety net

## Prerequisites
- Testing framework configured
- Mocking utilities available
- Code to test (or spec for TDD)

## Process

### Step 1: Identify Test Cases
```
Case categories:
- Happy path (normal operation)
- Edge cases (boundaries)
- Error cases (exceptions)
- Null/undefined handling
```

### Step 2: Structure Tests
```
Test organization:
- describe() for grouping
- it() for individual cases
- beforeEach() for setup
- afterEach() for cleanup
```

### Step 3: Write Tests
```
AAA pattern:
- Arrange: Set up test data
- Act: Execute the code
- Assert: Verify results
```

### Step 4: Use Mocking
```
Mock strategies:
- Mock dependencies
- Mock external services
- Spy on functions
- Stub data
```

### Step 5: Verify Coverage
```
Coverage goals:
- Line coverage > 80%
- Branch coverage > 75%
- Function coverage > 90%
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| code_under_test | TypeScript | Yes | Implementation |
| requirements | Markdown | Yes | Expected behavior |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| test_files | TypeScript | Unit tests |
| coverage_report | HTML | Coverage data |

## StudyAbroad-Specific Considerations
- Mock Prisma client
- Mock external APIs
- Test validation logic
- Test error handling

## Integration Points
- **Test Manager**: Coverage reporting
- **DevOps Agent**: CI integration

## Examples
```typescript
// src/application/application.service.spec.ts
import { Test, TestingModule } from '@nestjs/testing'
import { ApplicationService } from './application.service'
import { PrismaService } from '../prisma/prisma.service'
import { BadRequestException, NotFoundException } from '@nestjs/common'

describe('ApplicationService', () => {
  let service: ApplicationService
  let prisma: jest.Mocked<PrismaService>

  // Test fixtures
  const mockUser = { id: 'user-1', email: 'test@test.com' }
  const mockProgram = { 
    id: 'prog-1', 
    deadline: new Date('2024-12-31'),
    universityId: 'uni-1'
  }
  const mockApplication = {
    id: 'app-1',
    userId: 'user-1',
    programId: 'prog-1',
    status: 'draft'
  }

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ApplicationService,
        {
          provide: PrismaService,
          useValue: {
            application: {
              create: jest.fn(),
              findUnique: jest.fn(),
              findMany: jest.fn(),
              update: jest.fn()
            },
            program: {
              findUnique: jest.fn()
            }
          }
        }
      ]
    }).compile()

    service = module.get<ApplicationService>(ApplicationService)
    prisma = module.get(PrismaService)
  })

  describe('create', () => {
    it('should create an application for valid program', async () => {
      // Arrange
      prisma.program.findUnique.mockResolvedValue(mockProgram)
      prisma.application.create.mockResolvedValue(mockApplication)

      // Act
      const result = await service.create(mockUser.id, { 
        programId: mockProgram.id 
      })

      // Assert
      expect(result).toEqual(mockApplication)
      expect(prisma.application.create).toHaveBeenCalledWith({
        data: {
          userId: mockUser.id,
          programId: mockProgram.id,
          status: 'draft'
        }
      })
    })

    it('should throw if program not found', async () => {
      // Arrange
      prisma.program.findUnique.mockResolvedValue(null)

      // Act & Assert
      await expect(
        service.create(mockUser.id, { programId: 'invalid' })
      ).rejects.toThrow(NotFoundException)
    })

    it('should throw if deadline passed', async () => {
      // Arrange
      const expiredProgram = {
        ...mockProgram,
        deadline: new Date('2020-01-01')
      }
      prisma.program.findUnique.mockResolvedValue(expiredProgram)

      // Act & Assert
      await expect(
        service.create(mockUser.id, { programId: mockProgram.id })
      ).rejects.toThrow(BadRequestException)
    })
  })

  describe('submit', () => {
    it('should submit a complete draft application', async () => {
      // Arrange
      const completeApp = { ...mockApplication, progress: 100 }
      prisma.application.findUnique.mockResolvedValue(completeApp)
      prisma.application.update.mockResolvedValue({
        ...completeApp,
        status: 'submitted',
        submittedAt: expect.any(Date)
      })

      // Act
      const result = await service.submit('app-1', mockUser.id)

      // Assert
      expect(result.status).toBe('submitted')
      expect(prisma.application.update).toHaveBeenCalledWith({
        where: { id: 'app-1' },
        data: {
          status: 'submitted',
          submittedAt: expect.any(Date)
        }
      })
    })

    it('should throw if application incomplete', async () => {
      // Arrange
      const incompleteApp = { ...mockApplication, progress: 60 }
      prisma.application.findUnique.mockResolvedValue(incompleteApp)

      // Act & Assert
      await expect(
        service.submit('app-1', mockUser.id)
      ).rejects.toThrow(BadRequestException)
    })

    it('should throw if not owner', async () => {
      // Arrange
      prisma.application.findUnique.mockResolvedValue(mockApplication)

      // Act & Assert
      await expect(
        service.submit('app-1', 'other-user')
      ).rejects.toThrow(NotFoundException)
    })

    it('should throw if already submitted', async () => {
      // Arrange
      const submittedApp = { ...mockApplication, status: 'submitted' }
      prisma.application.findUnique.mockResolvedValue(submittedApp)

      // Act & Assert
      await expect(
        service.submit('app-1', mockUser.id)
      ).rejects.toThrow(BadRequestException)
    })
  })
})
```

## Validation
- All test cases covered
- Tests are isolated
- Mocks properly configured
- Coverage meets threshold
- Tests run quickly

---
SKILL_ID: DEV-003
SKILL_PATH: skills/development/api-implementation/SKILL.md
---
name: api-implementation
description: Implement REST/GraphQL API endpoints
skill_id: DEV-003
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Backend API development
dependencies: [DEV-001, DEV-002]
---

# API Implementation

## Purpose
Implement API endpoints that follow the OpenAPI specification, handle requests properly, validate inputs, and return consistent responses.

## When to Use
- New endpoint development
- API modifications
- Integration development

## Prerequisites
- OpenAPI specification
- Data models defined
- Authentication configured
- Validation rules known

## Process

### Step 1: Review API Contract
```
From OpenAPI spec:
- HTTP method
- URL path
- Request parameters
- Request body schema
- Response schemas
- Error responses
```

### Step 2: Create DTOs
```
Data Transfer Objects:
- Request DTOs with validation
- Response DTOs
- Query parameter DTOs
```

### Step 3: Implement Controller
```
Controller responsibilities:
- Route handling
- Request parsing
- Call service layer
- Format response
```

### Step 4: Implement Service
```
Service responsibilities:
- Business logic
- Data access
- External calls
- Error handling
```

### Step 5: Add Validation & Guards
```
Request validation:
- Input validation
- Authentication
- Authorization
- Rate limiting
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| openapi_spec | YAML | Yes | API contract |
| design_spec | Markdown | Yes | Design details |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| controller | TypeScript | Route handlers |
| service | TypeScript | Business logic |
| dtos | TypeScript | Request/response types |

## StudyAbroad-Specific Considerations
- JWT authentication
- Role-based authorization
- Consistent error format
- Pagination patterns

## Integration Points
- **Design Agent**: OpenAPI spec source
- **Test Manager**: API tests
- **Security Agent**: Auth review

## Examples
```typescript
// src/application/dto/create-application.dto.ts
import { IsUUID, IsNotEmpty } from 'class-validator'
import { ApiProperty } from '@nestjs/swagger'

export class CreateApplicationDto {
  @ApiProperty({ 
    description: 'Program ID to apply for',
    example: '123e4567-e89b-12d3-a456-426614174000'
  })
  @IsUUID()
  @IsNotEmpty()
  programId: string
}

// src/application/dto/application-response.dto.ts
export class ApplicationResponseDto {
  @ApiProperty()
  id: string

  @ApiProperty()
  programId: string

  @ApiProperty({ enum: ['draft', 'submitted', 'under_review', 'accepted', 'rejected'] })
  status: string

  @ApiProperty({ required: false })
  submittedAt?: Date

  @ApiProperty()
  createdAt: Date

  @ApiProperty({ type: () => ProgramSummaryDto })
  program?: ProgramSummaryDto
}

// src/application/application.controller.ts
import { 
  Controller, Get, Post, Put, Param, Body, 
  UseGuards, Request, Query, HttpStatus
} from '@nestjs/common'
import { 
  ApiTags, ApiOperation, ApiResponse, 
  ApiBearerAuth, ApiQuery 
} from '@nestjs/swagger'
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard'
import { ApplicationService } from './application.service'
import { CreateApplicationDto } from './dto/create-application.dto'
import { ApplicationResponseDto } from './dto/application-response.dto'
import { ApiPaginatedResponse } from '../common/decorators/api-paginated-response'

@ApiTags('Applications')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('applications')
export class ApplicationController {
  constructor(private readonly applicationService: ApplicationService) {}

  @Post()
  @ApiOperation({ summary: 'Create new application' })
  @ApiResponse({ 
    status: HttpStatus.CREATED, 
    type: ApplicationResponseDto,
    description: 'Application created successfully'
  })
  @ApiResponse({ 
    status: HttpStatus.BAD_REQUEST, 
    description: 'Deadline passed or already applied' 
  })
  @ApiResponse({ 
    status: HttpStatus.NOT_FOUND, 
    description: 'Program not found' 
  })
  async create(
    @Request() req,
    @Body() createDto: CreateApplicationDto
  ): Promise<ApplicationResponseDto> {
    return this.applicationService.create(req.user.id, createDto)
  }

  @Get()
  @ApiOperation({ summary: 'Get user applications' })
  @ApiPaginatedResponse(ApplicationResponseDto)
  @ApiQuery({ name: 'status', required: false, enum: ['draft', 'submitted'] })
  async findAll(
    @Request() req,
    @Query('status') status?: string,
    @Query('page') page = 1,
    @Query('limit') limit = 20
  ) {
    return this.applicationService.findByUser(req.user.id, {
      status,
      page: Number(page),
      limit: Number(limit)
    })
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get application by ID' })
  @ApiResponse({ status: HttpStatus.OK, type: ApplicationResponseDto })
  @ApiResponse({ status: HttpStatus.NOT_FOUND })
  async findOne(
    @Request() req,
    @Param('id') id: string
  ): Promise<ApplicationResponseDto> {
    return this.applicationService.findOne(id, req.user.id)
  }

  @Post(':id/submit')
  @ApiOperation({ summary: 'Submit application' })
  @ApiResponse({ 
    status: HttpStatus.OK, 
    type: ApplicationResponseDto,
    description: 'Application submitted successfully'
  })
  @ApiResponse({ 
    status: HttpStatus.BAD_REQUEST, 
    description: 'Application incomplete or already submitted' 
  })
  async submit(
    @Request() req,
    @Param('id') id: string
  ): Promise<ApplicationResponseDto> {
    return this.applicationService.submit(id, req.user.id)
  }
}

// src/application/application.service.ts
@Injectable()
export class ApplicationService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly eventEmitter: EventEmitter2
  ) {}

  async create(
    userId: string, 
    dto: CreateApplicationDto
  ): Promise<ApplicationResponseDto> {
    // Check program exists and deadline not passed
    const program = await this.prisma.program.findUnique({
      where: { id: dto.programId }
    })

    if (!program) {
      throw new NotFoundException('Program not found')
    }

    if (new Date() > program.deadline) {
      throw new BadRequestException('Application deadline has passed')
    }

    // Check for existing application
    const existing = await this.prisma.application.findFirst({
      where: { userId, programId: dto.programId }
    })

    if (existing) {
      throw new BadRequestException('Already applied to this program')
    }

    // Create application
    const application = await this.prisma.application.create({
      data: {
        userId,
        programId: dto.programId,
        status: 'draft'
      },
      include: { program: true }
    })

    return this.toResponseDto(application)
  }

  async submit(id: string, userId: string): Promise<ApplicationResponseDto> {
    const application = await this.prisma.application.findFirst({
      where: { id, userId }
    })

    if (!application) {
      throw new NotFoundException('Application not found')
    }

    if (application.status !== 'draft') {
      throw new BadRequestException('Application already submitted')
    }

    // Validate completeness
    const isComplete = await this.validateCompleteness(id)
    if (!isComplete) {
      throw new BadRequestException('Application is incomplete')
    }

    // Submit
    const updated = await this.prisma.application.update({
      where: { id },
      data: {
        status: 'submitted',
        submittedAt: new Date()
      },
      include: { program: true }
    })

    // Emit event for notifications
    this.eventEmitter.emit('application.submitted', { 
      applicationId: id, 
      userId 
    })

    return this.toResponseDto(updated)
  }
}
```

## Validation
- Matches OpenAPI spec
- Validation working
- Auth/authz in place
- Error handling complete
- Tests passing

---
SKILL_ID: DEV-004
SKILL_PATH: skills/development/database-integration/SKILL.md
---
name: database-integration
description: Implement data access layer and database operations
skill_id: DEV-004
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Database operations, ORM usage, query optimization
dependencies: [DEV-001]
---

# Database Integration

## Purpose
Implement reliable and efficient database operations using the ORM, including queries, transactions, and migrations.

## When to Use
- Data model implementation
- Query optimization
- Transaction handling
- Migration writing

## Prerequisites
- Database schema defined
- ORM configured (Prisma)
- Connection pooling set up

## Process

### Step 1: Define Schema
```
Prisma schema:
- Models
- Relations
- Indexes
- Constraints
```

### Step 2: Generate Client
```
Commands:
- prisma generate
- prisma migrate dev
```

### Step 3: Implement Repository
```
Repository pattern:
- CRUD operations
- Complex queries
- Transactions
```

### Step 4: Optimize Queries
```
Optimization:
- Select only needed fields
- Use indexes
- Avoid N+1 queries
- Use transactions
```

### Step 5: Handle Errors
```
Error handling:
- Constraint violations
- Connection errors
- Deadlocks
- Timeouts
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| database_schema | SQL | Yes | Schema design |
| queries | Markdown | Yes | Required queries |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| schema.prisma | Prisma | Schema definition |
| migrations/ | SQL | Migration files |
| repositories/ | TypeScript | Data access |

## StudyAbroad-Specific Considerations
- User data privacy
- Application audit trail
- Soft deletes for GDPR
- Efficient search queries

## Integration Points
- **Architecture Agent**: Schema design
- **Security Agent**: Data protection
- **DevOps Agent**: Migrations

## Examples
```prisma
// prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id            String    @id @default(uuid())
  email         String    @unique
  passwordHash  String?
  firstName     String
  lastName      String
  dateOfBirth   DateTime?
  nationality   String?
  gdprConsent   Boolean   @default(false)
  gdprConsentAt DateTime?
  createdAt     DateTime  @default(now())
  updatedAt     DateTime  @updatedAt
  deletedAt     DateTime? // Soft delete for GDPR

  applications  Application[]
  documents     Document[]
  oauthAccounts OAuthAccount[]

  @@index([email])
  @@index([deletedAt])
}

model Application {
  id          String    @id @default(uuid())
  userId      String
  programId   String
  status      String    @default("draft")
  progress    Int       @default(0)
  submittedAt DateTime?
  createdAt   DateTime  @default(now())
  updatedAt   DateTime  @updatedAt

  user        User      @relation(fields: [userId], references: [id])
  program     Program   @relation(fields: [programId], references: [id])
  documents   Document[]
  statusHistory ApplicationStatusHistory[]

  @@unique([userId, programId])
  @@index([userId])
  @@index([status])
}

model ApplicationStatusHistory {
  id            String   @id @default(uuid())
  applicationId String
  oldStatus     String?
  newStatus     String
  changedBy     String?
  notes         String?
  createdAt     DateTime @default(now())

  application   Application @relation(fields: [applicationId], references: [id])

  @@index([applicationId])
}
```

```typescript
// src/prisma/prisma.service.ts
import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common'
import { PrismaClient, Prisma } from '@prisma/client'

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  constructor() {
    super({
      log: [
        { emit: 'event', level: 'query' },
        { emit: 'stdout', level: 'error' },
        { emit: 'stdout', level: 'warn' }
      ]
    })
  }

  async onModuleInit() {
    await this.$connect()
    
    // Soft delete middleware
    this.$use(async (params, next) => {
      if (params.model === 'User') {
        if (params.action === 'delete') {
          params.action = 'update'
          params.args['data'] = { deletedAt: new Date() }
        }
        if (params.action === 'deleteMany') {
          params.action = 'updateMany'
          if (params.args.data !== undefined) {
            params.args.data['deletedAt'] = new Date()
          } else {
            params.args['data'] = { deletedAt: new Date() }
          }
        }
        // Filter out soft-deleted by default
        if (params.action === 'findUnique' || params.action === 'findFirst') {
          params.action = 'findFirst'
          params.args.where['deletedAt'] = null
        }
        if (params.action === 'findMany') {
          if (params.args.where) {
            if (params.args.where.deletedAt === undefined) {
              params.args.where['deletedAt'] = null
            }
          } else {
            params.args['where'] = { deletedAt: null }
          }
        }
      }
      return next(params)
    })
  }

  async onModuleDestroy() {
    await this.$disconnect()
  }

  // Transaction helper
  async executeInTransaction<T>(
    fn: (prisma: Prisma.TransactionClient) => Promise<T>
  ): Promise<T> {
    return this.$transaction(fn, {
      maxWait: 5000,
      timeout: 10000,
      isolationLevel: Prisma.TransactionIsolationLevel.Serializable
    })
  }
}

// src/application/application.repository.ts
@Injectable()
export class ApplicationRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findByUserWithPrograms(
    userId: string,
    options: { status?: string; page: number; limit: number }
  ) {
    const { status, page, limit } = options
    const where: Prisma.ApplicationWhereInput = { userId }
    
    if (status) {
      where.status = status
    }

    const [applications, total] = await Promise.all([
      this.prisma.application.findMany({
        where,
        include: {
          program: {
            include: {
              university: true
            }
          },
          documents: {
            select: { id: true, documentType: true, fileName: true }
          }
        },
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: 'desc' }
      }),
      this.prisma.application.count({ where })
    ])

    return { applications, total }
  }

  async submitWithHistory(
    id: string,
    userId: string
  ): Promise<Application> {
    return this.prisma.executeInTransaction(async (tx) => {
      // Get current application
      const application = await tx.application.findFirst({
        where: { id, userId }
      })

      if (!application) {
        throw new NotFoundException()
      }

      // Update status
      const updated = await tx.application.update({
        where: { id },
        data: {
          status: 'submitted',
          submittedAt: new Date()
        }
      })

      // Create history record
      await tx.applicationStatusHistory.create({
        data: {
          applicationId: id,
          oldStatus: application.status,
          newStatus: 'submitted',
          changedBy: userId
        }
      })

      return updated
    })
  }
}
```

## Validation
- Schema matches design
- Migrations run cleanly
- Queries are efficient
- Transactions used correctly
- Errors handled properly

---
SKILL_ID: DEV-005
SKILL_PATH: skills/development/frontend-development/SKILL.md
---
name: frontend-development
description: Implement React UI components and pages
skill_id: DEV-005
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: UI implementation, component development
dependencies: [DEV-001, DEV-002]
---

# Frontend Development

## Purpose
Implement React components and pages that follow designs, handle state properly, and provide good user experience.

## When to Use
- UI component development
- Page implementation
- State management
- Form handling

## Prerequisites
- Wireframes/designs available
- Component specs defined
- API contracts known
- Design system (if any)

## Process

### Step 1: Review Design
```
Understand:
- Layout requirements
- Component breakdown
- Interactions
- Responsive behavior
```

### Step 2: Implement Components
```
Component structure:
- Props interface
- State management
- Event handlers
- Render logic
```

### Step 3: Handle State
```
State patterns:
- Local state (useState)
- Server state (React Query)
- Form state (React Hook Form)
- Global state (Context/Zustand)
```

### Step 4: Style Components
```
Styling approach:
- Tailwind CSS
- Component library
- Responsive design
- Accessibility
```

### Step 5: Write Tests
```
Test types:
- Unit tests (logic)
- Component tests (rendering)
- Integration tests (flows)
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| wireframes | Images | Yes | UI designs |
| component_specs | Markdown | Yes | Component details |
| api_spec | YAML | Yes | API contracts |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| components/ | TSX | React components |
| pages/ | TSX | Page components |
| hooks/ | TypeScript | Custom hooks |

## StudyAbroad-Specific Considerations
- Multi-step application form
- Search with filters
- Document upload UI
- Status dashboards

## Integration Points
- **Design Agent**: UI specifications
- **Test Manager**: Component tests
- **API Implementation**: Data fetching

## Examples
```typescript
// src/components/ApplicationCard/ApplicationCard.tsx
import { FC } from 'react'
import { Link } from 'react-router-dom'
import { Application } from '@/types'
import { StatusBadge } from '../StatusBadge'
import { ProgressBar } from '../ProgressBar'
import { formatDate, daysUntil } from '@/utils/date'

interface ApplicationCardProps {
  application: Application
  variant?: 'full' | 'compact'
}

export const ApplicationCard: FC<ApplicationCardProps> = ({ 
  application, 
  variant = 'full' 
}) => {
  const { program, status, progress, submittedAt } = application
  const daysLeft = program.deadline ? daysUntil(program.deadline) : null
  const isUrgent = daysLeft !== null && daysLeft <= 7 && status === 'draft'

  if (variant === 'compact') {
    return (
      <Link 
        to={`/applications/${application.id}`}
        className="flex items-center justify-between p-4 bg-white rounded-lg 
                   shadow-sm hover:shadow-md transition-shadow"
      >
        <div className="flex items-center gap-3">
          <span className="text-2xl">🎓</span>
          <div>
            <p className="font-medium">{program.name}</p>
            <p className="text-sm text-gray-500">{program.university.name}</p>
          </div>
        </div>
        <div className="flex items-center gap-4">
          {status === 'draft' && (
            <span className="text-sm text-gray-500">{progress}%</span>
          )}
          <StatusBadge status={status} />
        </div>
      </Link>
    )
  }

  return (
    <div className="bg-white rounded-lg shadow-sm border p-6">
      <div className="flex items-start justify-between mb-4">
        <div className="flex items-center gap-3">
          <span className="text-3xl">🎓</span>
          <div>
            <h3 className="font-semibold text-lg">{program.university.name}</h3>
            <p className="text-gray-600">{program.name}</p>
            <p className="text-sm text-gray-500">{program.degreeLevel}</p>
          </div>
        </div>
        <StatusBadge status={status} />
      </div>

      {status === 'draft' && (
        <div className="mb-4">
          <div className="flex justify-between text-sm mb-1">
            <span className="text-gray-600">Progress</span>
            <span className="font-medium">{progress}%</span>
          </div>
          <ProgressBar value={progress} />
        </div>
      )}

      <div className="flex items-center justify-between text-sm">
        {status === 'draft' && daysLeft !== null && (
          <p className={isUrgent ? 'text-red-600 font-medium' : 'text-gray-500'}>
            {isUrgent && '⚠️ '}
            Deadline: {formatDate(program.deadline)} ({daysLeft} days)
          </p>
        )}
        {status === 'submitted' && submittedAt && (
          <p className="text-gray-500">
            Submitted: {formatDate(submittedAt)}
          </p>
        )}
        
        <div className="flex gap-2">
          {status === 'draft' ? (
            <Link
              to={`/applications/${application.id}/edit`}
              className="px-4 py-2 bg-blue-600 text-white rounded-lg 
                         hover:bg-blue-700 transition-colors"
            >
              Continue
            </Link>
          ) : (
            <>
              <Link
                to={`/applications/${application.id}`}
                className="px-4 py-2 border border-gray-300 rounded-lg 
                           hover:bg-gray-50 transition-colors"
              >
                View
              </Link>
              <Link
                to={`/applications/${application.id}/status`}
                className="px-4 py-2 border border-gray-300 rounded-lg 
                           hover:bg-gray-50 transition-colors"
              >
                Track Status
              </Link>
            </>
          )}
        </div>
      </div>
    </div>
  )
}

// src/components/ApplicationCard/ApplicationCard.test.tsx
import { render, screen } from '@testing-library/react'
import { BrowserRouter } from 'react-router-dom'
import { ApplicationCard } from './ApplicationCard'

const mockApplication = {
  id: 'app-1',
  status: 'draft',
  progress: 60,
  program: {
    name: 'MSc Computer Science',
    degreeLevel: 'master',
    deadline: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
    university: { name: 'TU Munich' }
  }
}

const renderCard = (props = {}) => {
  return render(
    <BrowserRouter>
      <ApplicationCard application={mockApplication} {...props} />
    </BrowserRouter>
  )
}

describe('ApplicationCard', () => {
  it('renders university and program name', () => {
    renderCard()
    
    expect(screen.getByText('TU Munich')).toBeInTheDocument()
    expect(screen.getByText('MSc Computer Science')).toBeInTheDocument()
  })

  it('shows progress bar for draft applications', () => {
    renderCard()
    
    expect(screen.getByText('60%')).toBeInTheDocument()
    expect(screen.getByRole('progressbar')).toHaveAttribute('aria-valuenow', '60')
  })

  it('shows Continue button for draft', () => {
    renderCard()
    
    expect(screen.getByRole('link', { name: /continue/i })).toBeInTheDocument()
  })

  it('shows View and Track buttons for submitted', () => {
    renderCard({ 
      application: { ...mockApplication, status: 'submitted', progress: 100 } 
    })
    
    expect(screen.getByRole('link', { name: /view/i })).toBeInTheDocument()
    expect(screen.getByRole('link', { name: /track status/i })).toBeInTheDocument()
  })

  it('shows urgent warning when deadline is soon', () => {
    renderCard()
    
    expect(screen.getByText(/⚠️/)).toBeInTheDocument()
  })
})
```

## Validation
- Matches wireframes
- Components tested
- Responsive design
- Accessibility compliant
- State managed properly

---
SKILL_ID: DEV-006
SKILL_PATH: skills/development/authentication/SKILL.md
---
name: authentication-implementation
description: Implement authentication flows including OAuth2
skill_id: DEV-006
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Auth system development, OAuth integration
dependencies: [DEV-003]
---

# Authentication Implementation

## Purpose
Implement secure authentication including OAuth2 flows, JWT token management, and session handling.

## When to Use
- Auth system setup
- OAuth provider integration
- Token management
- Session handling

## Prerequisites
- Security architecture defined
- OAuth credentials available
- Token strategy decided

## Process

### Step 1: Configure OAuth Providers
```
OAuth setup:
- Register applications
- Configure redirect URIs
- Store credentials securely
```

### Step 2: Implement OAuth Flow
```
Flow steps:
- Authorization redirect
- Callback handling
- Token exchange
- User creation/lookup
```

### Step 3: Implement JWT
```
JWT implementation:
- Token generation
- Token validation
- Refresh token flow
- Token revocation
```

### Step 4: Secure Endpoints
```
Security:
- Auth guards
- Role guards
- Token refresh
- Logout
```

### Step 5: Handle Sessions
```
Session management:
- Cookie configuration
- Session storage
- Concurrent sessions
- Session invalidation
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| security_arch | Markdown | Yes | Auth design |
| oauth_config | JSON | Yes | Provider settings |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| auth_module | TypeScript | Auth implementation |
| strategies/ | TypeScript | Passport strategies |
| guards/ | TypeScript | Auth guards |

## StudyAbroad-Specific Considerations
- Google OAuth
- University SSO (future)
- JWT with refresh tokens
- Cookie-based token storage

## Integration Points
- **Security Agent**: Security review
- **Test Manager**: Auth testing

## Examples
```typescript
// src/auth/strategies/google.strategy.ts
import { Injectable } from '@nestjs/common'
import { PassportStrategy } from '@nestjs/passport'
import { Strategy, VerifyCallback } from 'passport-google-oauth20'
import { ConfigService } from '@nestjs/config'
import { AuthService } from '../auth.service'

@Injectable()
export class GoogleStrategy extends PassportStrategy(Strategy, 'google') {
  constructor(
    private configService: ConfigService,
    private authService: AuthService
  ) {
    super({
      clientID: configService.get('GOOGLE_CLIENT_ID'),
      clientSecret: configService.get('GOOGLE_CLIENT_SECRET'),
      callbackURL: configService.get('GOOGLE_CALLBACK_URL'),
      scope: ['email', 'profile']
    })
  }

  async validate(
    accessToken: string,
    refreshToken: string,
    profile: any,
    done: VerifyCallback
  ): Promise<any> {
    const { emails, name, photos } = profile
    
    const user = await this.authService.findOrCreateOAuthUser({
      email: emails[0].value,
      firstName: name.givenName,
      lastName: name.familyName,
      provider: 'google',
      providerId: profile.id,
      avatar: photos[0]?.value
    })

    done(null, user)
  }
}

// src/auth/auth.service.ts
@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
    private configService: ConfigService
  ) {}

  async findOrCreateOAuthUser(data: OAuthUserData): Promise<User> {
    // Find existing OAuth account
    const oauthAccount = await this.prisma.oAuthAccount.findUnique({
      where: {
        provider_providerId: {
          provider: data.provider,
          providerId: data.providerId
        }
      },
      include: { user: true }
    })

    if (oauthAccount) {
      return oauthAccount.user
    }

    // Check if user exists with this email
    let user = await this.prisma.user.findUnique({
      where: { email: data.email }
    })

    if (!user) {
      // Create new user
      user = await this.prisma.user.create({
        data: {
          email: data.email,
          firstName: data.firstName,
          lastName: data.lastName,
          emailVerified: true // OAuth emails are verified
        }
      })
    }

    // Link OAuth account
    await this.prisma.oAuthAccount.create({
      data: {
        userId: user.id,
        provider: data.provider,
        providerId: data.providerId
      }
    })

    return user
  }

  generateTokens(user: User): AuthTokens {
    const payload = { sub: user.id, email: user.email }

    const accessToken = this.jwtService.sign(payload, {
      secret: this.configService.get('JWT_SECRET'),
      expiresIn: '15m'
    })

    const refreshToken = this.jwtService.sign(
      { sub: user.id, type: 'refresh' },
      {
        secret: this.configService.get('JWT_REFRESH_SECRET'),
        expiresIn: '7d'
      }
    )

    return { accessToken, refreshToken }
  }

  async refreshTokens(refreshToken: string): Promise<AuthTokens> {
    try {
      const payload = this.jwtService.verify(refreshToken, {
        secret: this.configService.get('JWT_REFRESH_SECRET')
      })

      if (payload.type !== 'refresh') {
        throw new UnauthorizedException('Invalid token type')
      }

      const user = await this.prisma.user.findUnique({
        where: { id: payload.sub }
      })

      if (!user) {
        throw new UnauthorizedException('User not found')
      }

      return this.generateTokens(user)
    } catch (error) {
      throw new UnauthorizedException('Invalid refresh token')
    }
  }
}

// src/auth/auth.controller.ts
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Get('google')
  @UseGuards(AuthGuard('google'))
  async googleAuth() {
    // Redirect to Google
  }

  @Get('google/callback')
  @UseGuards(AuthGuard('google'))
  async googleCallback(@Request() req, @Response() res) {
    const tokens = this.authService.generateTokens(req.user)
    
    // Set cookies
    res.cookie('access_token', tokens.accessToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 15 * 60 * 1000 // 15 minutes
    })

    res.cookie('refresh_token', tokens.refreshToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      path: '/auth/refresh',
      maxAge: 7 * 24 * 60 * 60 * 1000 // 7 days
    })

    res.redirect(process.env.FRONTEND_URL + '/dashboard')
  }

  @Post('refresh')
  async refresh(@Request() req, @Response() res) {
    const refreshToken = req.cookies['refresh_token']
    
    if (!refreshToken) {
      throw new UnauthorizedException('No refresh token')
    }

    const tokens = await this.authService.refreshTokens(refreshToken)
    
    res.cookie('access_token', tokens.accessToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 15 * 60 * 1000
    })

    return { success: true }
  }

  @Post('logout')
  @UseGuards(JwtAuthGuard)
  async logout(@Response() res) {
    res.clearCookie('access_token')
    res.clearCookie('refresh_token', { path: '/auth/refresh' })
    return { success: true }
  }
}
```

## Validation
- OAuth flow works
- Tokens generated correctly
- Refresh flow works
- Logout clears session
- Security reviewed

---
SKILL_ID: DEV-007
SKILL_PATH: skills/development/integration-implementation/SKILL.md
---
name: integration-implementation
description: Implement external service integrations
skill_id: DEV-007
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Third-party API integration
dependencies: [DEV-001, DEV-003]
---

# Integration Implementation

## Purpose
Implement robust integrations with external services including proper error handling, retries, and circuit breakers.

## When to Use
- External API integration
- Third-party service connection
- Webhook implementation

## Prerequisites
- Integration design complete
- API documentation available
- Credentials configured
- Error handling patterns

## Process

### Step 1: Create Service Adapter
```
Adapter pattern:
- Interface definition
- Implementation
- Configuration
- Dependency injection
```

### Step 2: Implement API Client
```
Client features:
- Request building
- Authentication
- Response parsing
- Error mapping
```

### Step 3: Add Resilience
```
Resilience patterns:
- Retry with backoff
- Circuit breaker
- Timeout handling
- Fallback behavior
```

### Step 4: Implement Data Mapping
```
Data transformation:
- External → internal
- Internal → external
- Validation
- Defaults
```

### Step 5: Add Monitoring
```
Observability:
- Request logging
- Metrics
- Error tracking
- Health checks
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| integration_spec | Markdown | Yes | Integration design |
| api_docs | Markdown | Yes | External API docs |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| services/ | TypeScript | Service adapters |
| clients/ | TypeScript | API clients |
| mappers/ | TypeScript | Data mappers |

## StudyAbroad-Specific Considerations
- University database API
- Rate limiting handling
- Caching responses
- Sync job implementation

## Integration Points
- **Architecture Agent**: Integration design
- **Test Manager**: Integration tests
- **Operations Agent**: Monitoring

## Examples
```typescript
// src/integrations/university-api/university-api.client.ts
import { Injectable, Logger } from '@nestjs/common'
import { ConfigService } from '@nestjs/config'
import { HttpService } from '@nestjs/axios'
import { CircuitBreaker, CircuitBreakerState } from './circuit-breaker'
import { RetryPolicy } from './retry-policy'
import { 
  UniversityApiResponse, 
  UniversitySearchParams 
} from './types'

@Injectable()
export class UniversityApiClient {
  private readonly logger = new Logger(UniversityApiClient.name)
  private readonly baseUrl: string
  private readonly apiKey: string
  private readonly circuitBreaker: CircuitBreaker
  private readonly retryPolicy: RetryPolicy

  constructor(
    private httpService: HttpService,
    private configService: ConfigService
  ) {
    this.baseUrl = this.configService.get('UNIVERSITY_API_URL')
    this.apiKey = this.configService.get('UNIVERSITY_API_KEY')
    
    this.circuitBreaker = new CircuitBreaker({
      failureThreshold: 5,
      recoveryTimeout: 30000,
      halfOpenMaxCalls: 3
    })
    
    this.retryPolicy = new RetryPolicy({
      maxRetries: 3,
      initialDelay: 1000,
      maxDelay: 10000,
      backoffMultiplier: 2
    })
  }

  async searchUniversities(
    params: UniversitySearchParams
  ): Promise<UniversityApiResponse> {
    return this.circuitBreaker.execute(async () => {
      return this.retryPolicy.execute(async () => {
        const response = await this.httpService.axiosRef.get(
          `${this.baseUrl}/universities`,
          {
            params: {
              country: params.country,
              name: params.query,
              page: params.page,
              limit: params.limit
            },
            headers: {
              'X-API-Key': this.apiKey
            },
            timeout: 10000
          }
        )

        return response.data
      })
    })
  }

  async getUniversity(externalId: string): Promise<UniversityApiResponse> {
    return this.circuitBreaker.execute(async () => {
      const response = await this.httpService.axiosRef.get(
        `${this.baseUrl}/universities/${externalId}`,
        {
          headers: { 'X-API-Key': this.apiKey },
          timeout: 10000
        }
      )

      return response.data
    })
  }

  getCircuitState(): CircuitBreakerState {
    return this.circuitBreaker.getState()
  }
}

// src/integrations/university-api/circuit-breaker.ts
export class CircuitBreaker {
  private state: CircuitBreakerState = 'closed'
  private failureCount = 0
  private lastFailureTime: number = 0
  private halfOpenCalls = 0

  constructor(private config: CircuitBreakerConfig) {}

  async execute<T>(fn: () => Promise<T>): Promise<T> {
    if (this.state === 'open') {
      if (Date.now() - this.lastFailureTime > this.config.recoveryTimeout) {
        this.state = 'half-open'
        this.halfOpenCalls = 0
      } else {
        throw new CircuitOpenError('Circuit breaker is open')
      }
    }

    if (this.state === 'half-open') {
      if (this.halfOpenCalls >= this.config.halfOpenMaxCalls) {
        throw new CircuitOpenError('Circuit breaker half-open limit reached')
      }
      this.halfOpenCalls++
    }

    try {
      const result = await fn()
      this.onSuccess()
      return result
    } catch (error) {
      this.onFailure()
      throw error
    }
  }

  private onSuccess(): void {
    this.failureCount = 0
    if (this.state === 'half-open') {
      this.state = 'closed'
    }
  }

  private onFailure(): void {
    this.failureCount++
    this.lastFailureTime = Date.now()

    if (this.failureCount >= this.config.failureThreshold) {
      this.state = 'open'
    }
  }

  getState(): CircuitBreakerState {
    return this.state
  }
}

// src/integrations/university-api/university.mapper.ts
import { University, Program } from '@prisma/client'
import { 
  ExternalUniversity, 
  ExternalProgram 
} from './types'

export class UniversityMapper {
  static toInternal(external: ExternalUniversity): Partial<University> {
    return {
      externalId: external.id,
      name: external.name,
      country: this.mapCountryCode(external.country_code),
      city: external.location?.city || 'Unknown',
      website: external.website_url,
      logoUrl: external.logo?.url,
      lastSyncedAt: new Date()
    }
  }

  static programToInternal(external: ExternalProgram): Partial<Program> {
    return {
      externalId: external.id,
      name: external.name,
      degreeLevel: this.mapDegreeLevel(external.level),
      fieldOfStudy: external.field,
      language: external.language || 'English',
      durationMonths: external.duration_months,
      tuitionAmount: external.tuition?.amount,
      tuitionCurrency: external.tuition?.currency || 'EUR',
      applicationDeadline: external.deadline 
        ? new Date(external.deadline) 
        : null
    }
  }

  private static mapCountryCode(code: string): string {
    // Map 2-letter to country name if needed
    const countries: Record<string, string> = {
      'DE': 'Germany',
      'NL': 'Netherlands',
      'FR': 'France'
      // ... more mappings
    }
    return countries[code] || code
  }

  private static mapDegreeLevel(level: string): string {
    const levels: Record<string, string> = {
      'bachelor': 'Bachelor',
      'master': 'Master',
      'phd': 'PhD',
      'mba': 'MBA'
    }
    return levels[level.toLowerCase()] || level
  }
}

// src/integrations/university-api/university-sync.service.ts
@Injectable()
export class UniversitySyncService {
  private readonly logger = new Logger(UniversitySyncService.name)

  constructor(
    private universityApiClient: UniversityApiClient,
    private prisma: PrismaService
  ) {}

  @Cron('0 2 * * *') // Run at 2 AM daily
  async syncUniversities(): Promise<SyncResult> {
    this.logger.log('Starting university sync')
    
    const result: SyncResult = {
      created: 0,
      updated: 0,
      errors: []
    }

    try {
      let page = 1
      let hasMore = true

      while (hasMore) {
        const response = await this.universityApiClient.searchUniversities({
          page,
          limit: 100
        })

        for (const external of response.universities) {
          try {
            const data = UniversityMapper.toInternal(external)
            
            await this.prisma.university.upsert({
              where: { externalId: external.id },
              create: data as any,
              update: data
            })

            // Sync programs for this university
            await this.syncPrograms(external.id)
            
            result.updated++
          } catch (error) {
            result.errors.push({
              externalId: external.id,
              error: error.message
            })
          }
        }

        hasMore = response.pagination.hasMore
        page++
      }

      this.logger.log(`Sync complete: ${result.updated} updated, ${result.errors.length} errors`)
    } catch (error) {
      this.logger.error('Sync failed', error)
      throw error
    }

    return result
  }
}
```

## Validation
- API calls work correctly
- Error handling complete
- Circuit breaker tested
- Data mapping accurate
- Sync job runs successfully

---
SKILL_ID: DEV-008
SKILL_PATH: skills/development/error-handling/SKILL.md
---
name: error-handling
description: Implement consistent error handling patterns
skill_id: DEV-008
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Exception handling, error responses
dependencies: [DEV-001]
---

# Error Handling Implementation

## Purpose
Implement consistent error handling that provides meaningful messages, proper logging, and follows the error taxonomy.

## When to Use
- All code implementation
- API error responses
- Validation errors
- External service errors

## Prerequisites
- Error taxonomy defined
- Logging configured
- Error response format defined

## Process

### Step 1: Create Error Classes
```
Custom exceptions:
- Extend base exceptions
- Include error codes
- Add context data
```

### Step 2: Implement Error Filters
```
Global error handling:
- Exception filters
- Error transformation
- Response formatting
```

### Step 3: Add Error Logging
```
Logging strategy:
- Log level by severity
- Include context
- Sanitize sensitive data
```

### Step 4: Handle Specific Cases
```
Case handling:
- Validation errors
- Auth errors
- Not found
- External service errors
- Unexpected errors
```

### Step 5: Test Error Scenarios
```
Error testing:
- Unit test exceptions
- Integration test responses
- Error message verification
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| error_taxonomy | Markdown | Yes | Error definitions |
| logging_config | YAML | Yes | Logging setup |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| exceptions/ | TypeScript | Custom exceptions |
| filters/ | TypeScript | Error filters |
| interceptors/ | TypeScript | Error interceptors |

## StudyAbroad-Specific Considerations
- Validation error details
- External API error mapping
- GDPR error handling
- User-friendly messages

## Integration Points
- **Design Agent**: Error taxonomy
- **Operations Agent**: Error monitoring

## Examples
```typescript
// src/common/exceptions/app.exception.ts
export class AppException extends Error {
  constructor(
    public readonly code: string,
    public readonly message: string,
    public readonly statusCode: number,
    public readonly details?: any
  ) {
    super(message)
    this.name = 'AppException'
  }
}

// src/common/exceptions/index.ts
export class ValidationException extends AppException {
  constructor(details: ValidationError[]) {
    super(
      'VAL_INVALID_INPUT',
      'Validation failed',
      400,
      details
    )
  }
}

export class UnauthorizedException extends AppException {
  constructor(message = 'Authentication required') {
    super('AUTH_UNAUTHORIZED', message, 401)
  }
}

export class ForbiddenException extends AppException {
  constructor(message = 'Access denied') {
    super('AUTHZ_FORBIDDEN', message, 403)
  }
}

export class NotFoundException extends AppException {
  constructor(resource: string) {
    super('NF_RESOURCE', `${resource} not found`, 404)
  }
}

export class BusinessException extends AppException {
  constructor(code: string, message: string) {
    super(code, message, 400)
  }
}

export class ExternalServiceException extends AppException {
  constructor(service: string, originalError?: Error) {
    super(
      'EXT_SERVICE_ERROR',
      `${service} is temporarily unavailable`,
      503,
      { service, originalError: originalError?.message }
    )
  }
}

// src/common/filters/all-exceptions.filter.ts
import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  Logger
} from '@nestjs/common'
import { Request, Response } from 'express'
import { AppException } from '../exceptions/app.exception'

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  private readonly logger = new Logger('ExceptionFilter')

  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp()
    const response = ctx.getResponse<Response>()
    const request = ctx.getRequest<Request>()

    const errorResponse = this.buildErrorResponse(exception, request)
    
    // Log error
    this.logError(exception, request, errorResponse)

    response
      .status(errorResponse.statusCode)
      .json(errorResponse.body)
  }

  private buildErrorResponse(exception: unknown, request: Request) {
    const requestId = request.headers['x-request-id'] || 
                      crypto.randomUUID()

    // Handle our custom exceptions
    if (exception instanceof AppException) {
      return {
        statusCode: exception.statusCode,
        body: {
          success: false,
          error: {
            code: exception.code,
            message: exception.message,
            details: exception.details
          },
          meta: {
            requestId,
            timestamp: new Date().toISOString()
          }
        }
      }
    }

    // Handle NestJS HTTP exceptions
    if (exception instanceof HttpException) {
      const response = exception.getResponse() as any
      return {
        statusCode: exception.getStatus(),
        body: {
          success: false,
          error: {
            code: this.mapHttpStatusToCode(exception.getStatus()),
            message: response.message || exception.message,
            details: response.errors
          },
          meta: {
            requestId,
            timestamp: new Date().toISOString()
          }
        }
      }
    }

    // Handle validation pipe errors
    if (this.isValidationError(exception)) {
      return {
        statusCode: 400,
        body: {
          success: false,
          error: {
            code: 'VAL_INVALID_INPUT',
            message: 'Validation failed',
            details: this.formatValidationErrors(exception)
          },
          meta: {
            requestId,
            timestamp: new Date().toISOString()
          }
        }
      }
    }

    // Unknown errors - don't expose details
    return {
      statusCode: 500,
      body: {
        success: false,
        error: {
          code: 'SYS_INTERNAL_ERROR',
          message: 'An unexpected error occurred'
        },
        meta: {
          requestId,
          timestamp: new Date().toISOString()
        }
      }
    }
  }

  private logError(
    exception: unknown, 
    request: Request, 
    errorResponse: any
  ) {
    const logData = {
      requestId: errorResponse.body.meta.requestId,
      method: request.method,
      path: request.url,
      statusCode: errorResponse.statusCode,
      errorCode: errorResponse.body.error.code,
      userId: (request as any).user?.id
    }

    if (errorResponse.statusCode >= 500) {
      this.logger.error(
        `${logData.method} ${logData.path} - ${errorResponse.statusCode}`,
        exception instanceof Error ? exception.stack : String(exception),
        logData
      )
    } else if (errorResponse.statusCode >= 400) {
      this.logger.warn(
        `${logData.method} ${logData.path} - ${errorResponse.statusCode}`,
        logData
      )
    }
  }

  private mapHttpStatusToCode(status: number): string {
    const mapping: Record<number, string> = {
      400: 'VAL_BAD_REQUEST',
      401: 'AUTH_UNAUTHORIZED',
      403: 'AUTHZ_FORBIDDEN',
      404: 'NF_NOT_FOUND',
      409: 'BIZ_CONFLICT',
      429: 'SYS_RATE_LIMITED'
    }
    return mapping[status] || 'SYS_ERROR'
  }
}

// Usage in service
async submitApplication(id: string, userId: string) {
  const application = await this.findOne(id, userId)
  
  if (!application) {
    throw new NotFoundException('Application')
  }

  if (application.status !== 'draft') {
    throw new BusinessException(
      'BIZ_ALREADY_SUBMITTED',
      'Application has already been submitted'
    )
  }

  if (application.progress < 100) {
    throw new BusinessException(
      'BIZ_INCOMPLETE',
      'Please complete all required sections before submitting'
    )
  }

  // ... submit logic
}
```

## Validation
- All errors handled consistently
- Error codes match taxonomy
- Logging appropriate
- User messages helpful
- No sensitive data leaked

---
SKILL_ID: DEV-009
SKILL_PATH: skills/development/refactoring/SKILL.md
---
name: code-refactoring
description: Improve code quality through refactoring
skill_id: DEV-009
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Code improvement, technical debt reduction
dependencies: [DEV-001, DEV-002]
---

# Code Refactoring

## Purpose
Improve code quality, readability, and maintainability without changing external behavior, ensuring tests continue to pass.

## When to Use
- After feature completion
- Technical debt reduction
- Before major changes
- Code review feedback

## Prerequisites
- Tests covering code to refactor
- Code review or analysis identifying issues
- Clear improvement goals

## Process

### Step 1: Identify Refactoring Targets
```
Code smells:
- Long methods
- Duplicate code
- Large classes
- Complex conditionals
- Deep nesting
- Poor naming
```

### Step 2: Ensure Test Coverage
```
Before refactoring:
- Run existing tests
- Add tests if needed
- Verify coverage
```

### Step 3: Apply Refactoring
```
Common refactorings:
- Extract method
- Extract class
- Rename
- Simplify conditionals
- Remove duplication
- Introduce patterns
```

### Step 4: Run Tests
```
After each change:
- Run unit tests
- Run integration tests
- Verify behavior unchanged
```

### Step 5: Review and Document
```
Completion:
- Self-review changes
- Update documentation
- Commit with clear message
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| code_to_refactor | TypeScript | Yes | Target code |
| test_suite | TypeScript | Yes | Existing tests |
| issues | Markdown | Optional | Known problems |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| refactored_code | TypeScript | Improved code |
| updated_tests | TypeScript | Updated tests if needed |

## StudyAbroad-Specific Considerations
- Maintain API compatibility
- Don't break form validation
- Keep error handling consistent
- Document architectural changes

## Integration Points
- **Test Manager**: Test verification
- **Security Agent**: No security regressions

## Examples
```typescript
// BEFORE: Long method with multiple responsibilities
class ApplicationService {
  async submitApplication(id: string, userId: string) {
    // Find application
    const application = await this.prisma.application.findFirst({
      where: { id, userId },
      include: { documents: true, program: true }
    })

    if (!application) {
      throw new NotFoundException('Application')
    }

    // Check status
    if (application.status !== 'draft') {
      throw new BusinessException('BIZ_ALREADY_SUBMITTED', 'Already submitted')
    }

    // Check deadline
    if (new Date() > application.program.deadline) {
      throw new BusinessException('BIZ_DEADLINE_PASSED', 'Deadline passed')
    }

    // Validate completeness
    const requiredDocs = ['transcript', 'passport', 'motivation_letter']
    const uploadedTypes = application.documents.map(d => d.documentType)
    const missingDocs = requiredDocs.filter(t => !uploadedTypes.includes(t))
    
    if (missingDocs.length > 0) {
      throw new BusinessException(
        'BIZ_INCOMPLETE',
        `Missing documents: ${missingDocs.join(', ')}`
      )
    }

    // Update status
    const updated = await this.prisma.application.update({
      where: { id },
      data: {
        status: 'submitted',
        submittedAt: new Date()
      }
    })

    // Create history
    await this.prisma.applicationStatusHistory.create({
      data: {
        applicationId: id,
        oldStatus: 'draft',
        newStatus: 'submitted',
        changedBy: userId
      }
    })

    // Send notification
    await this.emailService.sendApplicationSubmitted(
      application.userId,
      application.program.name
    )

    return updated
  }
}

// AFTER: Refactored with extracted methods and single responsibility
class ApplicationService {
  async submitApplication(id: string, userId: string) {
    const application = await this.findUserApplication(id, userId)
    
    this.validateCanSubmit(application)
    
    const updated = await this.executeSubmission(application, userId)
    
    await this.notifySubmission(application)
    
    return updated
  }

  private async findUserApplication(id: string, userId: string) {
    const application = await this.prisma.application.findFirst({
      where: { id, userId },
      include: { documents: true, program: true }
    })

    if (!application) {
      throw new NotFoundException('Application')
    }

    return application
  }

  private validateCanSubmit(application: ApplicationWithRelations): void {
    this.validateStatus(application)
    this.validateDeadline(application)
    this.validateDocuments(application)
  }

  private validateStatus(application: ApplicationWithRelations): void {
    if (application.status !== 'draft') {
      throw new BusinessException(
        'BIZ_ALREADY_SUBMITTED',
        'Application has already been submitted'
      )
    }
  }

  private validateDeadline(application: ApplicationWithRelations): void {
    if (new Date() > application.program.deadline) {
      throw new BusinessException(
        'BIZ_DEADLINE_PASSED',
        'The application deadline has passed'
      )
    }
  }

  private validateDocuments(application: ApplicationWithRelations): void {
    const missingDocs = this.findMissingDocuments(application)
    
    if (missingDocs.length > 0) {
      throw new BusinessException(
        'BIZ_INCOMPLETE',
        `Please upload the following documents: ${missingDocs.join(', ')}`
      )
    }
  }

  private findMissingDocuments(application: ApplicationWithRelations): string[] {
    const requiredDocuments = ['transcript', 'passport', 'motivation_letter']
    const uploadedTypes = new Set(
      application.documents.map(d => d.documentType)
    )
    
    return requiredDocuments.filter(type => !uploadedTypes.has(type))
  }

  private async executeSubmission(
    application: ApplicationWithRelations,
    userId: string
  ) {
    return this.prisma.$transaction(async (tx) => {
      const updated = await tx.application.update({
        where: { id: application.id },
        data: {
          status: 'submitted',
          submittedAt: new Date()
        }
      })

      await tx.applicationStatusHistory.create({
        data: {
          applicationId: application.id,
          oldStatus: application.status,
          newStatus: 'submitted',
          changedBy: userId
        }
      })

      return updated
    })
  }

  private async notifySubmission(
    application: ApplicationWithRelations
  ): Promise<void> {
    // Fire and forget - don't fail submission if notification fails
    this.emailService
      .sendApplicationSubmitted(
        application.userId,
        application.program.name
      )
      .catch(error => {
        this.logger.error('Failed to send submission email', error)
      })
  }
}
```

## Validation
- All tests still pass
- Code coverage maintained
- No functional changes
- Improved readability
- Documented changes

---
SKILL_ID: DEV-010
SKILL_PATH: skills/development/bug-fixing/SKILL.md
---
name: bug-fixing
description: Diagnose and fix software defects
skill_id: DEV-010
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Bug resolution, defect fixing
dependencies: [DEV-001, DEV-002]
---

# Bug Fixing

## Purpose
Systematically diagnose, fix, and verify resolution of software defects while preventing regression.

## When to Use
- Bug reports
- Test failures
- Production issues
- User-reported problems

## Prerequisites
- Bug report with steps to reproduce
- Access to relevant code
- Testing capability

## Process

### Step 1: Understand the Bug
```
Gather information:
- Expected behavior
- Actual behavior
- Steps to reproduce
- Environment details
- Error messages/logs
```

### Step 2: Reproduce the Bug
```
Reproduction:
- Follow reported steps
- Verify bug exists
- Identify minimal reproduction
- Document reproduction steps
```

### Step 3: Locate the Cause
```
Debugging:
- Analyze stack traces
- Add logging
- Use debugger
- Review recent changes
- Check related code
```

### Step 4: Write Failing Test
```
Test first:
- Write test that fails
- Covers the bug scenario
- Will pass when fixed
```

### Step 5: Implement Fix
```
Fix approach:
- Minimal change
- Don't introduce new issues
- Consider edge cases
- Update related code
```

### Step 6: Verify Fix
```
Verification:
- New test passes
- All existing tests pass
- Manual verification
- No regression
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| bug_report | Markdown | Yes | Bug details |
| related_code | TypeScript | Yes | Affected code |
| logs | Text | Optional | Error logs |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| fix_code | TypeScript | Code changes |
| regression_test | TypeScript | Test for bug |
| fix_notes | Markdown | Documentation |

## StudyAbroad-Specific Considerations
- Check form validation edge cases
- Verify OAuth flow
- Test deadline calculations
- Check timezone handling

## Integration Points
- **Test Manager**: Regression test addition
- **Operations Agent**: Production issue info

## Examples
```typescript
// BUG-042: Application submission timeout for concurrent requests

// Step 1: Bug Report
/*
 * Title: Submission fails with timeout for rapid double-click
 * Steps:
 * 1. Fill out application completely
 * 2. Click Submit button twice rapidly
 * 3. First request succeeds, second times out
 * 4. User sees error even though submission worked
 * 
 * Expected: Second click should be ignored or show "already submitting"
 * Actual: Error message shown, user confused about status
 */

// Step 2: Reproduce - confirmed in development

// Step 3: Root Cause
/*
 * The submit endpoint doesn't handle concurrent requests from same user.
 * Both requests try to update status to 'submitted'.
 * Second request fails because status is no longer 'draft'.
 * Error handling shows generic error instead of "already submitted".
 */

// Step 4: Write failing test
describe('ApplicationService - concurrent submission', () => {
  it('should handle concurrent submit requests gracefully', async () => {
    const application = await createDraftApplication()
    
    // Simulate concurrent requests
    const results = await Promise.allSettled([
      service.submit(application.id, userId),
      service.submit(application.id, userId)
    ])

    // One should succeed
    const successes = results.filter(r => r.status === 'fulfilled')
    expect(successes).toHaveLength(1)

    // Other should fail with specific error, not generic
    const failures = results.filter(r => r.status === 'rejected')
    expect(failures).toHaveLength(1)
    expect(failures[0].reason.code).toBe('BIZ_ALREADY_SUBMITTED')
  })

  it('should return existing submission if already submitted', async () => {
    const application = await createDraftApplication()
    
    // First submit
    const first = await service.submit(application.id, userId)
    expect(first.status).toBe('submitted')

    // Second submit should return same result, not error
    await expect(
      service.submit(application.id, userId)
    ).rejects.toThrow(BusinessException)
    
    // Verify the error is user-friendly
    try {
      await service.submit(application.id, userId)
    } catch (e) {
      expect(e.message).toContain('already been submitted')
    }
  })
})

// Step 5: Implement fix
class ApplicationService {
  async submit(id: string, userId: string) {
    // Use transaction with locking to prevent race condition
    return this.prisma.$transaction(async (tx) => {
      // Lock the row for update
      const application = await tx.$queryRaw`
        SELECT * FROM applications 
        WHERE id = ${id} AND user_id = ${userId}
        FOR UPDATE
      `

      if (!application) {
        throw new NotFoundException('Application')
      }

      // Handle already submitted case with clear message
      if (application.status === 'submitted') {
        throw new BusinessException(
          'BIZ_ALREADY_SUBMITTED',
          'This application has already been submitted successfully. ' +
          'You can view its status in your dashboard.'
        )
      }

      if (application.status !== 'draft') {
        throw new BusinessException(
          'BIZ_INVALID_STATUS',
          `Application cannot be submitted from ${application.status} status`
        )
      }

      // ... rest of submission logic
    }, {
      isolationLevel: 'Serializable',
      timeout: 10000
    })
  }
}

// Frontend fix - disable button during submission
function SubmitButton({ applicationId }) {
  const [isSubmitting, setIsSubmitting] = useState(false)
  const submit = useSubmitApplication()

  const handleSubmit = async () => {
    if (isSubmitting) return // Prevent double-click
    
    setIsSubmitting(true)
    try {
      await submit.mutateAsync(applicationId)
      toast.success('Application submitted successfully!')
    } catch (error) {
      if (error.code === 'BIZ_ALREADY_SUBMITTED') {
        // Not really an error - show success
        toast.info(error.message)
      } else {
        toast.error(error.message)
      }
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <button 
      onClick={handleSubmit}
      disabled={isSubmitting}
      className={isSubmitting ? 'opacity-50 cursor-not-allowed' : ''}
    >
      {isSubmitting ? 'Submitting...' : 'Submit Application'}
    </button>
  )
}

// Step 6: Verify
// - All new tests pass ✓
// - All existing tests pass ✓
// - Manual test: double-click no longer causes error ✓
// - Manual test: shows appropriate message ✓
```

## Validation
- Bug is fixed
- Regression test added
- No new issues introduced
- All tests pass
- Fix documented

---
SKILL_ID: DEV-011 to DEV-014
---

[Due to length, I'll provide brief templates for remaining developer skills]

# DEV-011: Code Review
Purpose: Review code for quality, security, and standards compliance
Key activities: Review PRs, provide feedback, verify fixes, approve changes

# DEV-012: Code Documentation  
Purpose: Write inline documentation, JSDoc comments, README files
Key activities: Document functions, add examples, maintain README

# DEV-013: Migration Writing
Purpose: Create database migrations for schema changes
Key activities: Write migrations, handle data transforms, rollback plans

# DEV-014: Performance Optimization
Purpose: Improve code performance and efficiency
Key activities: Profile code, optimize queries, reduce bundle size


# ============================================================================
# SECURITY AGENT SKILLS (13 Skills: SEC-001 to SEC-013)
# ============================================================================

---
SKILL_ID: SEC-001
SKILL_PATH: skills/security/security-architecture-review/SKILL.md
---
name: security-architecture-review
description: Review system architecture for security concerns
skill_id: SEC-001
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Architecture review, security assessment
dependencies: []
---

# Security Architecture Review

## Purpose
Review system architecture to identify security weaknesses, validate security controls, and ensure security requirements are properly addressed.

## When to Use
- After architecture design
- Before implementation
- Major architectural changes
- Security audit preparation

## Prerequisites
- Architecture documentation
- Security requirements
- Threat model (if available)

## Process

### Step 1: Review Architecture Components
```
Components to review:
- Authentication mechanisms
- Authorization model
- Data protection
- Network security
- Integration points
- Infrastructure
```

### Step 2: Identify Security Concerns
```
Concern categories:
- Authentication weaknesses
- Authorization gaps
- Data exposure risks
- Injection points
- Configuration issues
- Third-party risks
```

### Step 3: Validate Security Controls
```
Control validation:
- Are controls appropriate?
- Are controls sufficient?
- Are controls properly placed?
- Defense in depth?
```

### Step 4: Document Findings
```
Finding format:
- Issue description
- Risk level
- Affected component
- Recommendation
```

### Step 5: Provide Recommendations
```
Recommendations:
- Required changes
- Suggested improvements
- Best practices
- Implementation guidance
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| architecture_docs | Markdown | Yes | System design |
| security_reqs | Markdown | Yes | Security requirements |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| security_review.md | Markdown | Review findings |
| recommendations.md | Markdown | Security recommendations |

## StudyAbroad-Specific Considerations
- OAuth2 implementation review
- PII data flow analysis
- External API security
- Document storage security

## Integration Points
- **Architecture Agent**: Design feedback
- **Developer Agent**: Implementation guidance

## Examples
```markdown
# Security Architecture Review - StudyAbroad-v1

## Review Scope
- Authentication and authorization
- Data protection
- API security
- Infrastructure security

## Findings

### HIGH: JWT Token Storage
**Issue**: JWT stored in localStorage is vulnerable to XSS attacks
**Component**: Frontend authentication
**Risk**: High - Token theft enables account takeover
**Recommendation**: 
- Store tokens in httpOnly cookies
- Implement CSRF protection
- Use short-lived access tokens (15 min)

### MEDIUM: API Rate Limiting
**Issue**: No rate limiting on authentication endpoints
**Component**: API Gateway
**Risk**: Medium - Brute force attacks possible
**Recommendation**:
- Implement rate limiting (10 req/min for auth)
- Add exponential backoff on failures
- Log and alert on suspicious activity

### MEDIUM: PII Encryption
**Issue**: PII fields not encrypted at application level
**Component**: Database
**Risk**: Medium - Database breach exposes plaintext PII
**Recommendation**:
- Implement field-level encryption for PII
- Use AWS KMS for key management
- Consider searchable encryption for email

### LOW: CORS Configuration
**Issue**: CORS allows all origins in development
**Component**: API server
**Risk**: Low - Only in development, but could leak to production
**Recommendation**:
- Environment-specific CORS config
- Whitelist specific origins in production
- Add pre-commit hook to prevent * origin

## Summary

| Severity | Count | Action Required |
|----------|-------|-----------------|
| Critical | 0 | - |
| High | 1 | Before launch |
| Medium | 2 | Before launch |
| Low | 1 | Soon |

## Approval Status
Architecture security: **CONDITIONAL APPROVAL**
Conditions: Address High and Medium findings before launch
```

## Validation
- All components reviewed
- Findings documented
- Recommendations actionable
- Risk levels assigned
- Follow-up tracked

---
SKILL_ID: SEC-002
SKILL_PATH: skills/security/threat-modeling/SKILL.md
---
name: threat-modeling
description: Identify security threats using STRIDE methodology
skill_id: SEC-002
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Security design, risk identification
dependencies: []
---

# Threat Modeling

## Purpose
Systematically identify security threats to the system using STRIDE methodology and define appropriate mitigations.

## When to Use
- System design phase
- Before implementation
- Major feature additions
- Security assessment

## Prerequisites
- System architecture
- Data flow diagrams
- Asset inventory

## Process

### Step 1: Define Scope
```
Scope definition:
- System boundaries
- Components included
- Trust boundaries
- Data flows
```

### Step 2: Create Data Flow Diagram
```
DFD elements:
- External entities
- Processes
- Data stores
- Data flows
- Trust boundaries
```

### Step 3: Apply STRIDE
```
For each component:
- Spoofing: Identity threats
- Tampering: Data modification
- Repudiation: Deniability
- Information Disclosure: Data leaks
- Denial of Service: Availability
- Elevation of Privilege: Access
```

### Step 4: Document Threats
```
Threat documentation:
- Threat ID
- Category (STRIDE)
- Description
- Affected component
- Likelihood
- Impact
- Mitigation
```

### Step 5: Define Mitigations
```
Mitigation planning:
- Control type
- Implementation
- Owner
- Priority
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| architecture | Markdown | Yes | System design |
| dfd | Mermaid | Yes | Data flow diagram |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| threat_model.md | Markdown | Complete analysis |
| threat_matrix.csv | CSV | Threat inventory |
| mitigation_plan.md | Markdown | Mitigation actions |

## StudyAbroad-Specific Considerations
- User authentication threats
- Application data tampering
- Document confidentiality
- GDPR compliance threats

## Integration Points
- **Architecture Agent**: DFD input
- **Developer Agent**: Mitigation implementation

## Examples
[See detailed example in Part 1 - skills-content-part1.md under SEC-002]

## Validation
- All components analyzed
- STRIDE applied comprehensively
- Mitigations defined
- Priorities assigned
- Stakeholders reviewed

---
SKILL_ID: SEC-003 to SEC-013
---

[Brief descriptions for remaining security skills]

# SEC-003: Vulnerability Scanning
Purpose: Run automated security scans to identify vulnerabilities
Activities: SAST, DAST, dependency scanning, configuration scanning

# SEC-004: Dependency Auditing
Purpose: Check third-party dependencies for known vulnerabilities
Activities: npm audit, Snyk scans, license checking, update planning

# SEC-005: Code Security Review
Purpose: Manual security review of code for vulnerabilities
Activities: Review auth code, input handling, crypto usage, secrets

# SEC-006: Authentication Testing
Purpose: Test authentication mechanisms for weaknesses
Activities: Test login, OAuth, session, token refresh, password reset

# SEC-007: Authorization Testing
Purpose: Test authorization controls and access policies
Activities: Test RBAC, resource access, privilege escalation

# SEC-008: Input Validation Testing
Purpose: Test input validation for injection vulnerabilities
Activities: SQL injection, XSS, command injection, file upload

# SEC-009: Security Configuration
Purpose: Review and harden security configurations
Activities: Headers, CORS, TLS, cookie settings, CSP

# SEC-010: Compliance Checking
Purpose: Verify compliance with security standards
Activities: GDPR, OWASP, PCI-DSS, accessibility

# SEC-011: Penetration Testing
Purpose: Conduct security penetration testing
Activities: Recon, scanning, exploitation, reporting

# SEC-012: Security Reporting
Purpose: Generate security status reports
Activities: Vulnerability reports, compliance status, remediation tracking

# SEC-013: Incident Analysis
Purpose: Analyze security incidents for root cause
Activities: Log analysis, timeline reconstruction, impact assessment

###DIFFBREAK###
# Complete SDLC Skills Content Library - Part 4-6
# Project: StudyAbroad-v1
# DevOps (14) + Documentation (10) + Operations (12)

# ============================================================================
# DEVOPS AGENT SKILLS (14 Skills: OPS-001 to OPS-014)
# ============================================================================

---
SKILL_ID: OPS-001
SKILL_PATH: skills/devops/cicd-pipeline/SKILL.md
---
name: cicd-pipeline-design
description: Design and implement CI/CD pipelines for automated testing and deployment
skill_id: OPS-001
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Pipeline setup, automation, deployment automation
dependencies: []

## Process
1. Define pipeline stages (lint, test, build, deploy)
2. Configure triggers (push, PR, schedule)
3. Set up environments and secrets
4. Implement quality gates
5. Add notifications and monitoring

## StudyAbroad-Specific
- Multi-stage builds for frontend/backend
- Database migrations in deployment
- E2E tests on staging before production
- Slack notifications for deployments

---
SKILL_ID: OPS-002
SKILL_PATH: skills/devops/containerization/SKILL.md
---
name: containerization
description: Create optimized Docker images and container configurations
skill_id: OPS-002
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Docker setup, image optimization, development environments
dependencies: []

## Process
1. Select base image (node:20-alpine)
2. Multi-stage builds for size optimization
3. Security hardening (non-root user)
4. Health checks configuration
5. Docker Compose for local development

## StudyAbroad-Specific
- Prisma client generation in build
- Static asset handling
- Environment variable injection
- MinIO for local S3 replacement

---
SKILL_ID: OPS-003
SKILL_PATH: skills/devops/infrastructure-as-code/SKILL.md
---
name: infrastructure-as-code
description: Define infrastructure using Terraform for reproducible deployments
skill_id: OPS-003
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Infrastructure provisioning, environment replication
dependencies: []

## Process
1. Define module structure
2. Create reusable modules (VPC, ECS, RDS)
3. Configure per-environment variables
4. Implement state management (S3 + DynamoDB)
5. Plan and apply workflow

## StudyAbroad-Specific
- EU region (eu-west-1) for GDPR
- Multi-AZ RDS for availability
- ECS Fargate for serverless containers
- S3 with encryption for documents

---
SKILL_ID: OPS-004
SKILL_PATH: skills/devops/deployment-strategy/SKILL.md
---
name: deployment-strategy
description: Implement blue-green and canary deployment strategies
skill_id: OPS-004
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Production deployments, zero-downtime releases
dependencies: [OPS-001, OPS-003]

## Process
1. Choose strategy (rolling/blue-green/canary)
2. Configure target groups and routing
3. Implement health validation
4. Define rollback triggers
5. Monitor deployment metrics

## StudyAbroad-Specific
- Blue-green for major releases
- Canary (10%) for feature rollouts
- Database migration handling
- Session continuity during deployment

---
SKILL_ID: OPS-005
SKILL_PATH: skills/devops/environment-configuration/SKILL.md
---
name: environment-configuration
description: Manage environment variables and secrets securely
skill_id: OPS-005
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Configuration management, secret handling
dependencies: []

## Process
1. Categorize config (public vs secrets)
2. Use AWS Secrets Manager for secrets
3. Validate configuration on startup
4. Document all required variables
5. Implement rotation for credentials

## StudyAbroad-Specific
- OAuth credentials (Google)
- Database connection strings
- JWT secrets (32+ chars)
- External API keys

---
SKILL_ID: OPS-006
SKILL_PATH: skills/devops/database-operations/SKILL.md
---
name: database-operations
description: Manage database migrations, backups, and maintenance
skill_id: OPS-006
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Schema changes, data operations, maintenance
dependencies: []

## Process
1. Write migrations with Prisma
2. Test migrations in staging first
3. Run migrations in deployment pipeline
4. Configure automated backups
5. Plan point-in-time recovery

## StudyAbroad-Specific
- Daily RDS snapshots (7-day retention)
- Cross-region backup for DR
- Maintenance windows (Sunday 3-4 AM)
- Connection pooling with PgBouncer

---
SKILL_ID: OPS-007
SKILL_PATH: skills/devops/monitoring-setup/SKILL.md
---
name: monitoring-setup
description: Configure comprehensive application and infrastructure monitoring
skill_id: OPS-007
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Observability setup, alerting configuration
dependencies: []

## Process
1. Instrument application (metrics, traces)
2. Configure CloudWatch dashboards
3. Set up alerting rules
4. Integrate with Sentry for errors
5. Create runbooks for alerts

## StudyAbroad-Specific
- Application submission success rate
- External API response times
- Authentication failure monitoring
- GDPR request processing times

---
SKILL_ID: OPS-008
SKILL_PATH: skills/devops/log-management/SKILL.md
---
name: log-management
description: Implement centralized logging and analysis
skill_id: OPS-008
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Logging infrastructure, troubleshooting
dependencies: []

## Process
1. Implement structured logging (JSON)
2. Ship logs to CloudWatch Logs
3. Set up log insights queries
4. Configure retention policies
5. Create log-based alerts

## StudyAbroad-Specific
- Mask PII in logs
- Request correlation IDs
- GDPR audit logging
- Log retention: 90 days

---
SKILL_ID: OPS-009
SKILL_PATH: skills/devops/auto-scaling/SKILL.md
---
name: auto-scaling-configuration
description: Configure auto-scaling for compute resources
skill_id: OPS-009
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Capacity management, cost optimization
dependencies: [OPS-003]

## Process
1. Define scaling metrics (CPU, requests)
2. Set target tracking policies
3. Configure min/max instances
4. Set up scheduled scaling
5. Test scaling behavior

## StudyAbroad-Specific
- Scale on CPU > 70%
- Min 2, max 10 instances
- Pre-scale before application deadlines
- Scale workers on queue depth

---
SKILL_ID: OPS-010
SKILL_PATH: skills/devops/load-balancing/SKILL.md
---
name: load-balancing
description: Configure load balancers and traffic distribution
skill_id: OPS-010
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Traffic management, high availability
dependencies: [OPS-003]

## Process
1. Set up ALB with HTTPS
2. Configure health checks
3. Set up SSL termination
4. Configure routing rules
5. Enable access logging

## StudyAbroad-Specific
- Path-based routing (/api/*)
- Health check: /health endpoint
- Sticky sessions for WebSocket (future)
- WAF integration for security

---
SKILL_ID: OPS-011
SKILL_PATH: skills/devops/ssl-management/SKILL.md
---
name: ssl-tls-management
description: Manage SSL certificates and TLS configuration
skill_id: OPS-011
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Certificate management, security configuration
dependencies: []

## Process
1. Provision certificates (ACM)
2. Configure auto-renewal
3. Set TLS 1.3 minimum
4. Enable HSTS
5. Configure cipher suites

## StudyAbroad-Specific
- ACM certificates for *.studyabroad.com
- HSTS max-age: 1 year
- TLS 1.3 only in production
- Certificate transparency logging

---
SKILL_ID: OPS-012
SKILL_PATH: skills/devops/backup-recovery/SKILL.md
---
name: backup-and-recovery
description: Implement backup strategies and disaster recovery
skill_id: OPS-012
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Data protection, disaster recovery planning
dependencies: []

## Process
1. Define RPO/RTO objectives
2. Configure automated backups
3. Set up cross-region replication
4. Document recovery procedures
5. Test recovery regularly

## StudyAbroad-Specific
- RPO: 1 hour, RTO: 4 hours
- RDS: Daily snapshots, 7-day retention
- S3: Cross-region replication for documents
- Quarterly DR testing

---
SKILL_ID: OPS-013
SKILL_PATH: skills/devops/performance-tuning/SKILL.md
---
name: performance-tuning
description: Optimize infrastructure and application performance
skill_id: OPS-013
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Performance optimization, cost efficiency
dependencies: []

## Process
1. Profile resource usage
2. Right-size compute instances
3. Optimize database queries
4. Configure CDN caching
5. Enable compression

## StudyAbroad-Specific
- CloudFront for static assets
- Redis caching for university data
- Database connection pooling
- Gzip compression for API responses

---
SKILL_ID: OPS-014
SKILL_PATH: skills/devops/cost-optimization/SKILL.md
---
name: cost-optimization
description: Optimize cloud infrastructure costs
skill_id: OPS-014
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Budget management, resource optimization
dependencies: []

## Process
1. Analyze current spending
2. Identify unused resources
3. Implement reserved instances
4. Configure cost alerts
5. Regular cost reviews

## StudyAbroad-Specific
- Reserved RDS instances (1-year)
- Spot instances for workers (non-critical)
- S3 lifecycle policies for old documents
- Dev/staging shutdown schedules


# ============================================================================
# DOCUMENTATION AGENT SKILLS (10 Skills: DOC-001 to DOC-010)
# ============================================================================

---
SKILL_ID: DOC-001
SKILL_PATH: skills/documentation/technical-writing/SKILL.md
---
name: technical-writing
description: Write clear technical documentation for developers and users
skill_id: DOC-001
owner: documentation
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Documentation creation, user guides, technical specs
dependencies: []

## Process
1. Identify audience (developer/user/admin)
2. Outline document structure
3. Write clear, concise content
4. Add examples and diagrams
5. Review and iterate

## StudyAbroad-Specific
- API documentation for integrations
- User guides for students/advisors
- Admin documentation
- Developer onboarding

---
SKILL_ID: DOC-002
SKILL_PATH: skills/documentation/api-documentation/SKILL.md
---
name: api-documentation
description: Generate and maintain API documentation
skill_id: DOC-002
owner: documentation
collaborators: [developer, design]
collaboration_rules: |
  - developer-agent: Invokes when API implementation needs documentation updates
  - design-agent: Invokes when OpenAPI spec changes require doc regeneration
project: studyabroad-v1
version: 1.0.0
when_to_use: API reference, integration guides
dependencies: []

## Process
1. Generate from OpenAPI spec
2. Add usage examples
3. Document authentication
4. Include error responses
5. Publish to documentation site

## StudyAbroad-Specific
- Swagger UI at /api/docs
- Authentication flow examples
- Rate limit documentation
- Webhook documentation (future)

---
SKILL_ID: DOC-003
SKILL_PATH: skills/documentation/code-documentation/SKILL.md
---
name: code-documentation
description: Write inline code documentation and comments
skill_id: DOC-003
owner: documentation
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Code commenting, JSDoc, inline docs
dependencies: []

## Process
1. Document public interfaces
2. Write JSDoc comments
3. Add inline comments for complex logic
4. Generate documentation from code
5. Keep docs in sync with code

## StudyAbroad-Specific
- JSDoc for all public functions
- README per module
- Type documentation
- Example usage in comments

---
SKILL_ID: DOC-004
SKILL_PATH: skills/documentation/user-guides/SKILL.md
---
name: user-guide-writing
description: Create end-user documentation and guides
skill_id: DOC-004
owner: documentation
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: User manuals, how-to guides, FAQs
dependencies: []

## Process
1. Identify user tasks
2. Write step-by-step instructions
3. Add screenshots/videos
4. Create FAQ section
5. Localize if needed

## StudyAbroad-Specific
- Application submission guide
- Document upload guide
- Profile management
- GDPR rights guide

---
SKILL_ID: DOC-005
SKILL_PATH: skills/documentation/architecture-documentation/SKILL.md
---
name: architecture-documentation
description: Document system architecture and design decisions
skill_id: DOC-005
owner: documentation
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Architecture docs, ADRs, system overview
dependencies: []

## Process
1. Create system overview
2. Document component interactions
3. Maintain ADRs
4. Update diagrams
5. Version documentation

## StudyAbroad-Specific
- C4 diagrams
- Data flow documentation
- Integration architecture
- Security architecture

---
SKILL_ID: DOC-006
SKILL_PATH: skills/documentation/runbook-writing/SKILL.md
---
name: runbook-writing
description: Create operational runbooks for incident response
skill_id: DOC-006
owner: documentation
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Operations documentation, incident response
dependencies: []

## Process
1. Identify operational scenarios
2. Document step-by-step procedures
3. Include troubleshooting steps
4. Add escalation paths
5. Test and validate

## StudyAbroad-Specific
- Database recovery runbook
- External API outage response
- Authentication issues
- High load response

---
SKILL_ID: DOC-007
SKILL_PATH: skills/documentation/changelog-management/SKILL.md
---
name: changelog-management
description: Maintain changelogs and release notes
skill_id: DOC-007
owner: documentation
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Release documentation, version tracking
dependencies: []

## Process
1. Follow Keep a Changelog format
2. Categorize changes (Added, Changed, Fixed)
3. Link to issues/PRs
4. Generate from commits
5. Publish with releases

## StudyAbroad-Specific
- CHANGELOG.md in repo
- Release notes for users
- Migration guides for breaking changes
- API version changes

---
SKILL_ID: DOC-008
SKILL_PATH: skills/documentation/onboarding-documentation/SKILL.md
---
name: onboarding-documentation
description: Create developer onboarding materials
skill_id: DOC-008
owner: documentation
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: New developer setup, team onboarding
dependencies: []

## Process
1. Document development setup
2. Explain project structure
3. List coding conventions
4. Provide starter tasks
5. Include architecture overview

## StudyAbroad-Specific
- Local environment setup
- Docker Compose quickstart
- Project structure guide
- Contributing guidelines

---
SKILL_ID: DOC-009
SKILL_PATH: skills/documentation/compliance-documentation/SKILL.md
---
name: compliance-documentation
description: Document compliance requirements and procedures
skill_id: DOC-009
owner: documentation
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: GDPR documentation, audit preparation
dependencies: []

## Process
1. Document data processing activities
2. Create privacy documentation
3. Maintain audit trails
4. Document security controls
5. Prepare audit materials

## StudyAbroad-Specific
- GDPR compliance documentation
- Data processing records
- Privacy policy
- Data retention documentation

---
SKILL_ID: DOC-010
SKILL_PATH: skills/documentation/diagram-creation/SKILL.md
---
name: diagram-creation
description: Create technical diagrams and visualizations
skill_id: DOC-010
owner: documentation
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Visual documentation, architecture diagrams
dependencies: []

## Process
1. Choose diagram type
2. Use Mermaid for version control
3. Keep diagrams current
4. Include in documentation
5. Generate from code when possible

## StudyAbroad-Specific
- System context diagram
- Container diagram
- Sequence diagrams for flows
- ER diagrams for database


# ============================================================================
# OPERATIONS AGENT SKILLS (12 Skills: MON-001 to MON-012)
# ============================================================================

---
SKILL_ID: MON-001
SKILL_PATH: skills/operations/system-monitoring/SKILL.md
---
name: system-monitoring
description: Monitor system health and performance metrics
skill_id: MON-001
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Production monitoring, health tracking
dependencies: []

## Process
1. Define key metrics
2. Configure dashboards
3. Set up health checks
4. Monitor trends
5. Generate reports

## StudyAbroad-Specific
- API response times
- Database connections
- Memory/CPU usage
- External API health

---
SKILL_ID: MON-002
SKILL_PATH: skills/operations/alerting-management/SKILL.md
---
name: alerting-management
description: Configure and manage alerting rules
skill_id: MON-002
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Alert configuration, incident detection
dependencies: [MON-001]

## Process
1. Define alert thresholds
2. Configure notification channels
3. Set up escalation policies
4. Reduce alert fatigue
5. Review and tune alerts

## StudyAbroad-Specific
- Error rate > 1% → Warning
- Error rate > 5% → Critical
- Response time > 2s → Warning
- External API down → Critical

---
SKILL_ID: MON-003
SKILL_PATH: skills/operations/incident-response/SKILL.md
---
name: incident-response
description: Handle production incidents and outages
skill_id: MON-003
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Production issues, outages, emergencies
dependencies: []

## Process
1. Detect and acknowledge
2. Assess severity
3. Communicate status
4. Investigate and mitigate
5. Document and review

## StudyAbroad-Specific
- On-call rotation setup
- Status page updates
- User communication templates
- Post-incident reviews

---
SKILL_ID: MON-004
SKILL_PATH: skills/operations/capacity-planning/SKILL.md
---
name: capacity-planning
description: Plan infrastructure capacity for growth
skill_id: MON-004
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Growth planning, resource forecasting
dependencies: [MON-001]

## Process
1. Analyze current usage
2. Project growth trends
3. Identify constraints
4. Plan capacity increases
5. Budget for growth

## StudyAbroad-Specific
- User growth projections
- Application deadline peaks
- Document storage growth
- Database scaling plans

---
SKILL_ID: MON-005
SKILL_PATH: skills/operations/sla-management/SKILL.md
---
name: sla-management
description: Monitor and report on SLA compliance
skill_id: MON-005
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: SLA tracking, availability reporting
dependencies: [MON-001]

## Process
1. Define SLA metrics
2. Configure tracking
3. Generate reports
4. Identify violations
5. Plan improvements

## StudyAbroad-Specific
- 99.5% uptime target
- API response < 500ms (p95)
- GDPR request response times
- Support response SLAs

---
SKILL_ID: MON-006
SKILL_PATH: skills/operations/security-monitoring/SKILL.md
---
name: security-monitoring
description: Monitor for security threats and anomalies
skill_id: MON-006
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Security operations, threat detection
dependencies: []

## Process
1. Configure security logging
2. Set up anomaly detection
3. Monitor auth failures
4. Track suspicious activity
5. Alert on security events

## StudyAbroad-Specific
- Failed login monitoring
- API abuse detection
- Data access logging
- GDPR access monitoring

---
SKILL_ID: MON-007
SKILL_PATH: skills/operations/performance-monitoring/SKILL.md
---
name: performance-monitoring
description: Track application and infrastructure performance
skill_id: MON-007
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Performance tracking, bottleneck identification
dependencies: [MON-001]

## Process
1. Define performance baselines
2. Track key metrics
3. Set up APM tools
4. Identify bottlenecks
5. Report on trends

## StudyAbroad-Specific
- Page load times
- API latency percentiles
- Database query times
- External API performance

---
SKILL_ID: MON-008
SKILL_PATH: skills/operations/log-analysis/SKILL.md
---
name: log-analysis
description: Analyze logs for troubleshooting and insights
skill_id: MON-008
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Troubleshooting, pattern identification
dependencies: []

## Process
1. Centralize logs
2. Create analysis queries
3. Build dashboards
4. Set up log alerts
5. Archive for compliance

## StudyAbroad-Specific
- Error pattern analysis
- User journey tracking
- API usage analysis
- GDPR audit logging

---
SKILL_ID: MON-009
SKILL_PATH: skills/operations/availability-management/SKILL.md
---
name: availability-management
description: Ensure system availability and uptime
skill_id: MON-009
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Uptime management, availability planning
dependencies: []

## Process
1. Track availability metrics
2. Plan maintenance windows
3. Implement redundancy
4. Test failover
5. Report on uptime

## StudyAbroad-Specific
- Multi-AZ deployment
- Database failover
- CDN redundancy
- Maintenance window: Sunday 3-4 AM UTC

---
SKILL_ID: MON-010
SKILL_PATH: skills/operations/change-management/SKILL.md
---
name: change-management
description: Manage production changes safely
skill_id: MON-010
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Production changes, configuration updates
dependencies: []

## Process
1. Document change request
2. Assess risk
3. Plan rollback
4. Execute change
5. Verify and close

## StudyAbroad-Specific
- Change freeze before deadlines
- Database migration procedures
- Configuration change process
- Emergency change procedures

---
SKILL_ID: MON-011
SKILL_PATH: skills/operations/disaster-recovery/SKILL.md
---
name: disaster-recovery
description: Plan and execute disaster recovery procedures
skill_id: MON-011
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: DR planning, recovery testing
dependencies: []

## Process
1. Define RTO/RPO
2. Document DR procedures
3. Test recovery regularly
4. Maintain DR environment
5. Update plans

## StudyAbroad-Specific
- RTO: 4 hours, RPO: 1 hour
- Cross-region database restore
- Document storage recovery
- Communication plan

---
SKILL_ID: MON-012
SKILL_PATH: skills/operations/reporting/SKILL.md
---
name: operations-reporting
description: Generate operational reports and metrics
skill_id: MON-012
owner: operations
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Status reporting, metric summaries
dependencies: [MON-001, MON-005]

## Process
1. Define report metrics
2. Automate data collection
3. Generate visualizations
4. Schedule distribution
5. Review with stakeholders

## StudyAbroad-Specific
- Weekly availability report
- Monthly performance summary
- Incident summary
- Capacity utilization report
# Complete SDLC Skills Content Library - Design Skills
# Project: StudyAbroad-v1
# Design Agent (10 Skills: DES-001 to DES-010)

---
SKILL_ID: DES-001
SKILL_PATH: skills/design/module-design/SKILL.md
---
name: module-design
description: Break architecture into implementable modules with clear interfaces
skill_id: DES-001
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: After architecture, before implementation
dependencies: []
---

# Module Design

## Purpose
Break down system architecture into discrete, implementable modules with well-defined boundaries, interfaces, and responsibilities.

## When to Use
- After architecture design approved
- Before development starts
- When planning sprint work
- For complex feature decomposition

## Prerequisites
- Architecture documentation
- Component diagrams
- Data models defined

## Process

### Step 1: Identify Module Boundaries
```
Boundary criteria:
- Single responsibility
- High cohesion within
- Low coupling between
- Clear ownership
```

### Step 2: Define Module Interfaces
```
Interface definition:
- Public API (exposed functions)
- Events emitted/consumed
- Data contracts
- Dependencies
```

### Step 3: Create Module Specification
```
Specification includes:
- Purpose and scope
- Public interface
- Internal structure
- Dependencies
- Testing approach
```

### Step 4: Validate Design
```
Validation:
- Meets requirements
- Fits architecture
- Testable
- Maintainable
```

### Step 5: Document Design Decisions
```
Documentation:
- Design rationale
- Alternatives considered
- Trade-offs made
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| architecture_doc | Markdown | Yes | System architecture |
| requirements | Markdown | Yes | Feature requirements |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| module_specs/ | Markdown | Module specifications |
| interface_docs/ | Markdown | API definitions |

## StudyAbroad-Specific Considerations
- University module (search, details, sync)
- Application module (CRUD, workflow, validation)
- Document module (upload, storage, retrieval)
- User module (profile, preferences, GDPR)
- Auth module (OAuth, JWT, sessions)

## Integration Points
- **Architecture Agent**: Receives architecture
- **Developer Agent**: Implements modules
- **Test Manager**: Test planning

## Examples
```
Module: Application

Purpose: Manage study abroad applications through their lifecycle

Public Interface:
  - createApplication(userId, programId): Application
  - updateApplication(id, data): Application
  - submitApplication(id): Application
  - getApplication(id): Application
  - getUserApplications(userId, filters): Application[]
  - cancelApplication(id): void

Events:
  - application.created
  - application.submitted
  - application.statusChanged

Dependencies:
  - User module (user data)
  - University module (program validation)
  - Document module (attachments)
  - Notification module (emails)

Internal Structure:
  src/application/
  ├── application.module.ts
  ├── application.controller.ts
  ├── application.service.ts
  ├── application.repository.ts
  ├── dto/
  │   ├── create-application.dto.ts
  │   ├── update-application.dto.ts
  │   └── application-response.dto.ts
  ├── entities/
  │   └── application.entity.ts
  ├── events/
  │   └── application.events.ts
  └── __tests__/
      ├── application.service.spec.ts
      └── application.controller.spec.ts
```

## Validation
- All requirements mapped to modules
- Interfaces clearly defined
- Dependencies documented
- No circular dependencies
- Testability verified

---
SKILL_ID: DES-002
SKILL_PATH: skills/design/api-contracts/SKILL.md
---
name: api-contract-design
description: Design API contracts using OpenAPI specification
skill_id: DES-002
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Before API implementation, for external integrations
dependencies: [DES-001]
---

# API Contract Design

## Purpose
Define clear, consistent API contracts using OpenAPI 3.0 specification that serve as the source of truth for implementation.

## When to Use
- Before API implementation
- For external integrations
- When documenting existing APIs
- API versioning

## Prerequisites
- Module design complete
- Data models defined
- Authentication approach known

## Process

### Step 1: Define Resources
```
Resource identification:
- Core entities (users, applications)
- Sub-resources (application documents)
- Actions (submit, approve)
```

### Step 2: Design Endpoints
```
RESTful design:
- GET /resources - list
- GET /resources/:id - get one
- POST /resources - create
- PUT /resources/:id - update
- DELETE /resources/:id - delete
- POST /resources/:id/action - actions
```

### Step 3: Define Request/Response Schemas
```
Schema design:
- Request DTOs
- Response DTOs
- Error responses
- Pagination
```

### Step 4: Document Authentication
```
Auth documentation:
- Auth methods
- Required scopes
- Token format
```

### Step 5: Write OpenAPI Spec
```
Specification includes:
- Info and servers
- Paths and operations
- Schemas
- Security
- Examples
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| module_specs | Markdown | Yes | Module designs |
| data_models | TypeScript | Yes | Entity definitions |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| openapi.yaml | YAML | API specification |
| api_docs/ | Markdown | Additional docs |

## StudyAbroad-Specific Considerations
- JWT Bearer authentication
- Consistent error format
- Pagination for lists
- Versioning (/api/v1/)

## Integration Points
- **Developer Agent**: Implementation guide
- **Test Manager**: Contract testing
- **Documentation Agent**: API docs

## Examples
```yaml
openapi: 3.0.3
info:
  title: StudyAbroad API
  version: 1.0.0
  description: API for study abroad application management

servers:
  - url: https://api.studyabroad.com/v1
    description: Production

security:
  - bearerAuth: []

paths:
  /applications:
    get:
      summary: List user's applications
      tags: [Applications]
      parameters:
        - name: status
          in: query
          schema:
            type: string
            enum: [draft, submitted, under_review, accepted, rejected]
        - $ref: '#/components/parameters/Page'
        - $ref: '#/components/parameters/Limit'
      responses:
        '200':
          description: List of applications
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ApplicationListResponse'
        '401':
          $ref: '#/components/responses/Unauthorized'

    post:
      summary: Create new application
      tags: [Applications]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateApplicationRequest'
      responses:
        '201':
          description: Application created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ApplicationResponse'
        '400':
          $ref: '#/components/responses/BadRequest'

components:
  schemas:
    Application:
      type: object
      properties:
        id:
          type: string
          format: uuid
        programId:
          type: string
          format: uuid
        status:
          type: string
          enum: [draft, submitted, under_review, accepted, rejected]
        progress:
          type: integer
          minimum: 0
          maximum: 100
        submittedAt:
          type: string
          format: date-time
          nullable: true
        createdAt:
          type: string
          format: date-time

    ErrorResponse:
      type: object
      properties:
        success:
          type: boolean
          example: false
        error:
          type: object
          properties:
            code:
              type: string
              example: VAL_INVALID_INPUT
            message:
              type: string
            details:
              type: array
              items:
                type: object

  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
```

## Validation
- All endpoints documented
- Schemas complete
- Examples provided
- Consistent naming
- Error responses defined

---
SKILL_ID: DES-003
SKILL_PATH: skills/design/ui-ux/SKILL.md
---
name: ui-ux-design
description: Design user interfaces and user experience flows
skill_id: DES-003
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Before frontend implementation, user flow design
dependencies: []
---

# UI/UX Design

## Purpose
Design intuitive user interfaces and seamless user experiences that meet user needs and align with business goals.

## When to Use
- New feature design
- User flow optimization
- Usability improvements
- Accessibility enhancements

## Prerequisites
- User requirements
- User personas
- Business goals

## Process

### Step 1: Define User Flows
```
Flow mapping:
- Entry points
- Decision points
- Success paths
- Error paths
- Exit points
```

### Step 2: Create Wireframes
```
Wireframe levels:
- Low-fidelity (structure)
- Medium-fidelity (layout)
- High-fidelity (detail)
```

### Step 3: Design Components
```
Component design:
- Reusable patterns
- States (default, hover, active, disabled)
- Responsive behavior
- Accessibility
```

### Step 4: Define Interactions
```
Interaction patterns:
- Form behavior
- Navigation
- Feedback (loading, success, error)
- Animations
```

### Step 5: Validate Design
```
Validation methods:
- User testing
- Accessibility audit
- Stakeholder review
```

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| user_requirements | Markdown | Yes | User needs |
| brand_guidelines | PDF | Optional | Visual guidelines |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| wireframes/ | Images | UI wireframes |
| user_flows/ | Mermaid | Flow diagrams |
| component_specs/ | Markdown | Component details |

## StudyAbroad-Specific Considerations
- Multi-step application wizard
- University search and filters
- Document upload interface
- Progress tracking dashboard
- Mobile-responsive design

## Integration Points
- **Developer Agent**: Implementation specs
- **Test Manager**: Usability testing
- **Accessibility**: WCAG compliance

## Examples
```
User Flow: Application Submission

[Start] → [Dashboard]
    ↓
[Select Program] → Program Search
    ↓                   ↓
[Start Application] ← [View Program Details]
    ↓
[Step 1: Personal Info]
    ↓ (Next)
[Step 2: Academic History]
    ↓ (Next)
[Step 3: Documents]
    ↓ (Upload required docs)
[Step 4: Statement]
    ↓ (Next)
[Step 5: Review]
    ↓ (Submit)
[Confirmation] → [Dashboard with updated status]

Navigation:
- Back button on each step
- Progress indicator
- Save draft at any step
- Exit with confirmation

States:
- Step complete: ✓ checkmark
- Current step: highlighted
- Future steps: dimmed
- Invalid: red indicator
```

## Validation
- User flows complete
- All states designed
- Accessibility considered
- Responsive design
- Stakeholder approved

---
SKILL_ID: DES-004
SKILL_PATH: skills/design/components/SKILL.md
---
name: component-design
description: Design reusable UI components with variants and states
skill_id: DES-004
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Building component library, UI standardization
dependencies: [DES-003]
---

# Component Design

## Purpose
Design reusable UI components that provide consistency, accessibility, and maintainability across the application.

## When to Use
- Building design system
- New component needs
- Component refactoring
- Consistency improvements

## Process

### Step 1: Identify Component Needs
### Step 2: Define Props and Variants  
### Step 3: Design All States
### Step 4: Document Usage Guidelines
### Step 5: Create Component Spec

## StudyAbroad-Specific Considerations
- ApplicationCard component
- StatusBadge variants
- ProgressBar component
- DocumentUpload component
- UniversityCard component

## Examples
```typescript
// Component Specification: StatusBadge

interface StatusBadgeProps {
  status: 'draft' | 'submitted' | 'under_review' | 'accepted' | 'rejected'
  size?: 'sm' | 'md' | 'lg'
}

// Variants by status:
// draft: gray background, "Draft" text
// submitted: blue background, "Submitted" text
// under_review: yellow background, "Under Review" text
// accepted: green background, "Accepted" text
// rejected: red background, "Rejected" text
```

---
SKILL_ID: DES-005
SKILL_PATH: skills/design/data-flow/SKILL.md
---
name: data-flow-design
description: Design data flow patterns including state management and caching
skill_id: DES-005
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: State management design, data architecture
dependencies: [DES-001]
---

# Data Flow Design

## Purpose
Design how data flows through the application, including state management, caching, and synchronization strategies.

## When to Use
- Application architecture
- State management decisions
- Cache strategy design
- Real-time features

## Process

### Step 1: Identify Data Categories
### Step 2: Choose State Management
### Step 3: Design Cache Strategy
### Step 4: Plan Data Synchronization
### Step 5: Document Data Flow

## StudyAbroad-Specific Considerations
- React Query for server state
- Zustand for UI state
- Redis for API caching
- Optimistic updates for forms

---
SKILL_ID: DES-006
SKILL_PATH: skills/design/error-handling/SKILL.md
---
name: error-handling-design
description: Design error taxonomy and handling patterns
skill_id: DES-006
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Error strategy design, user feedback patterns
dependencies: []
---

# Error Handling Design

## Purpose
Design a comprehensive error handling strategy including error taxonomy, user-facing messages, and recovery patterns.

## When to Use
- System design phase
- Error experience improvement
- Consistency standardization

## Process

### Step 1: Create Error Taxonomy
### Step 2: Design Error Response Format
### Step 3: Define User-Facing Messages
### Step 4: Plan Recovery Strategies
### Step 5: Document Error Handling

## StudyAbroad-Specific Considerations
- Validation errors with field details
- Deadline passed errors
- External API errors (graceful degradation)
- Document upload errors

## Examples
```
Error Taxonomy:

VAL_* - Validation errors (400)
  VAL_INVALID_INPUT - General validation failure
  VAL_MISSING_FIELD - Required field missing
  VAL_INVALID_FORMAT - Wrong format

AUTH_* - Authentication errors (401)
  AUTH_UNAUTHORIZED - Not authenticated
  AUTH_TOKEN_EXPIRED - Token expired

BIZ_* - Business logic errors (400)
  BIZ_DEADLINE_PASSED - Application deadline passed
  BIZ_ALREADY_SUBMITTED - Already submitted
  BIZ_INCOMPLETE - Application incomplete

NF_* - Not found errors (404)
  NF_RESOURCE - Resource not found

EXT_* - External service errors (502/503)
  EXT_SERVICE_ERROR - External service unavailable
```

---
SKILL_ID: DES-007
SKILL_PATH: skills/design/state-management/SKILL.md
---
name: state-management-design
description: Design application state management architecture
skill_id: DES-007
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Frontend architecture, complex state needs
dependencies: [DES-005]
---

# State Management Design

## Purpose
Design state management architecture that handles local, server, and global state effectively.

## Process
1. Categorize state types
2. Select management tools
3. Design state structure
4. Plan state synchronization
5. Document patterns

## StudyAbroad-Specific Considerations
- Server state: React Query (applications, universities)
- UI state: Zustand (modals, filters, preferences)
- Form state: React Hook Form
- URL state: React Router (search params)

---
SKILL_ID: DES-008
SKILL_PATH: skills/design/integration-design/SKILL.md
---
name: integration-design
description: Design external API integration patterns
skill_id: DES-008
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Third-party integrations, external API connections
dependencies: [DES-001]
---

# Integration Design

## Purpose
Design robust integration patterns for external APIs including adapters, error handling, and resilience.

## Process
1. Analyze external API
2. Design adapter layer
3. Plan error handling
4. Implement resilience patterns
5. Define sync strategy

## StudyAbroad-Specific Considerations
- University database API (rate-limited)
- OAuth providers (Google)
- Document scanning service
- Email service

## Examples
```
Integration Pattern: University API

Adapter: UniversityApiAdapter
  - Transforms external format to internal
  - Handles rate limiting (100 req/min)
  - Implements circuit breaker
  - Caches responses (1 hour)

Sync Strategy:
  - Full sync: Daily at 2 AM
  - Incremental: Every 4 hours
  - On-demand: User triggers refresh
```

---
SKILL_ID: DES-009
SKILL_PATH: skills/design/validation/SKILL.md
---
name: validation-design
description: Design validation strategy across application layers
skill_id: DES-009
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Form design, API design, data integrity
dependencies: []
---

# Validation Design

## Purpose
Design comprehensive validation strategy that ensures data integrity at all application layers.

## Process
1. Define validation layers
2. Create validation rules
3. Design error messages
4. Plan client/server sync
5. Document validation

## StudyAbroad-Specific Considerations
- Client: Zod schemas with React Hook Form
- API: class-validator DTOs
- Database: Prisma constraints
- Cross-field validation (dates, document requirements)

## Examples
```
Validation Layers:

1. Client (immediate feedback)
   - Required fields
   - Format validation
   - Length limits

2. API (security boundary)
   - All client validations
   - Business rules
   - Authorization

3. Database (data integrity)
   - Unique constraints
   - Foreign keys
   - Check constraints
```

---
SKILL_ID: DES-010
SKILL_PATH: skills/design/wireframing/SKILL.md
---
name: wireframing
description: Create UI wireframes at various fidelity levels
skill_id: DES-010
owner: design
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: UI design, stakeholder communication, developer handoff
dependencies: [DES-003]
---

# Wireframing

## Purpose
Create visual representations of user interfaces at appropriate fidelity levels for design communication and validation.

## Process
1. Choose fidelity level
2. Define page structure
3. Create wireframes
4. Add annotations
5. Review and iterate

## StudyAbroad-Specific Considerations
- Dashboard wireframe
- Application wizard steps
- University search results
- Document upload interface

## Examples
```
Wireframe: Application Dashboard

┌────────────────────────────────────────────────────────┐
│ [Logo]           Search...        [Profile] [Logout]   │
├────────────────────────────────────────────────────────┤
│                                                        │
│  Welcome back, {firstName}!                            │
│                                                        │
│  ┌──────────────────────────────────────────────────┐  │
│  │ Your Applications (3)              [+ New]       │  │
│  ├──────────────────────────────────────────────────┤  │
│  │ ┌────────────────────────────────────────────┐   │  │
│  │ │ 🎓 TU Munich - MSc CS        [Draft]       │   │  │
│  │ │ Progress: ████████░░ 80%     [Continue →]  │   │  │
│  │ │ Deadline: Mar 15 (10 days)                 │   │  │
│  │ └────────────────────────────────────────────┘   │  │
│  │                                                  │  │
│  │ ┌────────────────────────────────────────────┐   │  │
│  │ │ 🎓 ETH Zurich - MSc DS       [Submitted]   │   │  │
│  │ │ Submitted: Jan 5             [View →]      │   │  │
│  │ └────────────────────────────────────────────┘   │  │
│  └──────────────────────────────────────────────────┘  │
│                                                        │
└────────────────────────────────────────────────────────┘
```
# Complete SDLC Skills Content - Missing Developer and Security Skills
# Project: StudyAbroad-v1

---
SKILL_ID: DEV-011
SKILL_PATH: skills/development/code-review/SKILL.md
---
name: code-review
description: Review code for quality, security, and standards compliance
skill_id: DEV-011
owner: developer
collaborators: [security, architecture]
collaboration_rules: |
  - security-agent: Invokes for security-focused reviews (auth, data handling, input validation)
  - architecture-agent: Invokes for architectural compliance reviews (API design, patterns)
project: studyabroad-v1
version: 1.0.0
when_to_use: Pull request review, code quality assurance
dependencies: [DEV-001]
---

# Code Review

## Purpose
Review code changes for quality, security, performance, and standards compliance before merging.

## When to Use
- Pull request review
- Pre-merge validation
- Knowledge sharing
- Quality assurance

## Process

### Step 1: Understand Context
- Read PR description
- Review linked issues
- Understand requirements

### Step 2: Review Code
- Correctness
- Security concerns
- Performance implications
- Code style/standards
- Test coverage

### Step 3: Provide Feedback
- Clear, constructive comments
- Suggest improvements
- Ask questions
- Approve or request changes

## StudyAbroad-Specific Considerations
- Check for PII handling
- Verify authentication/authorization
- Validate error handling
- Confirm test coverage

## Examples
```markdown
## Code Review Checklist

### Functionality
- [ ] Meets requirements
- [ ] Edge cases handled
- [ ] Error handling appropriate

### Security
- [ ] Input validation present
- [ ] No SQL injection risks
- [ ] Auth checks in place
- [ ] No secrets in code

### Quality
- [ ] Clear naming
- [ ] DRY principle followed
- [ ] Functions are focused
- [ ] Comments where needed

### Testing
- [ ] Unit tests present
- [ ] Tests are meaningful
- [ ] Edge cases tested
```

---
SKILL_ID: DEV-012
SKILL_PATH: skills/development/code-documentation/SKILL.md
---
name: code-documentation
description: Write inline code documentation and JSDoc comments
skill_id: DEV-012
owner: developer
collaborators: [documentation]
collaboration_rules: |
  - documentation-agent: Invokes when generating API docs or user guides from code comments
project: studyabroad-v1
version: 1.0.0
when_to_use: Code commenting, API documentation
dependencies: [DEV-001]
---

# Code Documentation

## Purpose
Write clear documentation within code using JSDoc, inline comments, and README files.

## When to Use
- Public function documentation
- Complex logic explanation
- API documentation
- Module overviews

## Process

1. Document public interfaces
2. Add JSDoc to functions
3. Comment complex logic
4. Create module README
5. Keep docs in sync

## StudyAbroad-Specific Considerations
- Document all service methods
- Explain business logic
- Document DTOs
- API endpoint documentation

## Examples
```typescript
/**
 * Submits an application for review.
 * 
 * @param applicationId - The UUID of the application to submit
 * @param userId - The UUID of the user submitting (must be owner)
 * @throws {NotFoundException} If application doesn't exist or user doesn't own it
 * @throws {BusinessException} If application is incomplete or already submitted
 * @returns The updated application with 'submitted' status
 * 
 * @example
 * const submitted = await applicationService.submit('app-123', 'user-456');
 * console.log(submitted.status); // 'submitted'
 */
async submit(applicationId: string, userId: string): Promise<Application> {
  // Implementation...
}
```

---
SKILL_ID: DEV-013
SKILL_PATH: skills/development/migration-writing/SKILL.md
---
name: migration-writing
description: Create database migrations for schema changes
skill_id: DEV-013
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Schema changes, data transformations
dependencies: [DEV-004]
---

# Migration Writing

## Purpose
Write database migrations that safely modify schema while preserving data integrity.

## When to Use
- New table/column additions
- Schema modifications
- Index changes
- Data transformations

## Process

1. Plan migration
2. Write forward migration
3. Write rollback (if needed)
4. Test in development
5. Test with production-like data

## StudyAbroad-Specific Considerations
- Always have rollback plan
- Test with realistic data volumes
- Consider GDPR (soft deletes)
- Handle production data carefully

## Examples
```typescript
// prisma/migrations/20240115_add_virus_scan/migration.sql

-- Add virus scan fields to documents table
ALTER TABLE documents 
ADD COLUMN virus_scan_status VARCHAR(20) DEFAULT 'pending',
ADD COLUMN virus_scan_at TIMESTAMP,
ADD COLUMN virus_scan_result JSONB;

-- Create index for pending scans
CREATE INDEX idx_documents_scan_pending 
ON documents (virus_scan_status) 
WHERE virus_scan_status = 'pending';
```

---
SKILL_ID: DEV-014
SKILL_PATH: skills/development/performance-optimization/SKILL.md
---
name: performance-optimization
description: Optimize code and queries for better performance
skill_id: DEV-014
owner: developer
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Performance issues, scalability improvements
dependencies: [DEV-001]
---

# Performance Optimization

## Purpose
Identify and resolve performance bottlenecks in code, queries, and application architecture.

## When to Use
- Performance issues identified
- Scalability requirements
- Resource optimization
- Response time improvements

## Process

1. Profile and measure
2. Identify bottlenecks
3. Implement optimizations
4. Verify improvements
5. Document changes

## StudyAbroad-Specific Considerations
- University search query optimization
- Application list pagination
- Document upload streaming
- Caching strategy

## Examples
```typescript
// Before: N+1 query problem
const applications = await prisma.application.findMany();
for (const app of applications) {
  app.program = await prisma.program.findUnique({
    where: { id: app.programId }
  });
}

// After: Eager loading
const applications = await prisma.application.findMany({
  include: {
    program: {
      include: { university: true }
    }
  }
});
```

---
SKILL_ID: SEC-003
SKILL_PATH: skills/security/vulnerability-scanning/SKILL.md
---
name: vulnerability-scanning
description: Run automated security scans to identify vulnerabilities
skill_id: SEC-003
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Security testing, CI/CD integration
dependencies: []
---

# Vulnerability Scanning

## Purpose
Automatically scan code and infrastructure for known vulnerabilities and security weaknesses.

## When to Use
- Every build (CI/CD)
- Before releases
- Regular security audits
- After dependency updates

## Process

1. Configure scanning tools
2. Run SAST (static analysis)
3. Run DAST (dynamic analysis)
4. Review findings
5. Prioritize and remediate

## StudyAbroad-Specific Considerations
- npm audit for dependencies
- Snyk for continuous monitoring
- OWASP ZAP for DAST
- Trivy for container scanning

## Examples
```yaml
# CI/CD Security Scan Stage
security-scan:
  script:
    - npm audit --production
    - npx snyk test --severity-threshold=high
    - docker run --rm -v $(pwd):/app aquasec/trivy fs /app
```

---
SKILL_ID: SEC-004
SKILL_PATH: skills/security/dependency-auditing/SKILL.md
---
name: dependency-auditing
description: Audit third-party dependencies for vulnerabilities
skill_id: SEC-004
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Dependency management, security compliance
dependencies: []
---

# Dependency Auditing

## Purpose
Audit and manage third-party dependencies to identify and remediate known vulnerabilities.

## When to Use
- Regular audits (weekly)
- Before releases
- After adding dependencies
- Security alerts

## Process

1. Run audit tools
2. Review vulnerabilities
3. Assess impact
4. Update or patch
5. Document exceptions

## StudyAbroad-Specific Considerations
- Production dependencies priority
- Automated alerts setup
- Update schedule (monthly)
- License compliance

---
SKILL_ID: SEC-005
SKILL_PATH: skills/security/code-security-review/SKILL.md
---
name: code-security-review
description: Manual security review of code for vulnerabilities
skill_id: SEC-005
owner: security
collaborators: [developer]
collaboration_rules: |
  - developer-agent: Invokes for security guidance during implementation of auth/data handling code
project: studyabroad-v1
version: 1.0.0
when_to_use: Security-critical code, authentication code
dependencies: []
---

# Code Security Review

## Purpose
Manually review code for security vulnerabilities that automated tools may miss.

## When to Use
- Authentication/authorization code
- Cryptographic implementations
- Input handling code
- Security-critical features

## Process

1. Identify critical code paths
2. Review for common vulnerabilities
3. Check security patterns
4. Document findings
5. Verify fixes

## StudyAbroad-Specific Considerations
- OAuth implementation review
- JWT handling review
- File upload security
- PII handling review

---
SKILL_ID: SEC-006
SKILL_PATH: skills/security/authentication-testing/SKILL.md
---
name: authentication-testing
description: Test authentication mechanisms for security weaknesses
skill_id: SEC-006
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Auth system testing, security validation
dependencies: []
---

# Authentication Testing

## Purpose
Test authentication mechanisms to ensure they properly protect against unauthorized access.

## When to Use
- After auth implementation
- Security audits
- Before releases
- After auth changes

## Process

1. Test valid authentication
2. Test invalid credentials
3. Test session management
4. Test token security
5. Test edge cases

## StudyAbroad-Specific Considerations
- OAuth2 flow testing
- JWT token validation
- Session timeout testing
- Concurrent session handling

---
SKILL_ID: SEC-007
SKILL_PATH: skills/security/authorization-testing/SKILL.md
---
name: authorization-testing
description: Test authorization controls and access policies
skill_id: SEC-007
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Access control testing, permission verification
dependencies: [SEC-006]
---

# Authorization Testing

## Purpose
Verify that authorization controls properly restrict access to resources and actions.

## When to Use
- After authz implementation
- New resource/action added
- Role changes
- Security audits

## Process

1. Map authorization rules
2. Test allowed access
3. Test denied access
4. Test privilege escalation
5. Test cross-user access

## StudyAbroad-Specific Considerations
- User can only access own applications
- Horizontal privilege testing
- Admin role verification
- Resource ownership validation

---
SKILL_ID: SEC-008
SKILL_PATH: skills/security/input-validation-testing/SKILL.md
---
name: input-validation-testing
description: Test input validation for injection vulnerabilities
skill_id: SEC-008
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: API testing, form testing, security audits
dependencies: []
---

# Input Validation Testing

## Purpose
Test all input points for proper validation and resistance to injection attacks.

## When to Use
- API endpoint testing
- Form submission testing
- File upload testing
- Search functionality testing

## Process

1. Identify all input points
2. Test SQL injection
3. Test XSS
4. Test command injection
5. Test file upload attacks

## StudyAbroad-Specific Considerations
- University search input
- Application form fields
- Document upload filenames
- URL parameters

---
SKILL_ID: SEC-009
SKILL_PATH: skills/security/security-configuration/SKILL.md
---
name: security-configuration
description: Review and harden security configurations
skill_id: SEC-009
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Infrastructure setup, security hardening
dependencies: []
---

# Security Configuration

## Purpose
Review and configure security settings for application, infrastructure, and services.

## When to Use
- Initial setup
- Security audits
- Configuration changes
- Compliance checks

## Process

1. Review HTTP headers
2. Configure TLS
3. Set up CORS
4. Configure CSP
5. Review cookie settings

## StudyAbroad-Specific Considerations
- Strict CORS policy
- HSTS enabled
- Secure cookie flags
- CSP for XSS prevention

---
SKILL_ID: SEC-010
SKILL_PATH: skills/security/compliance-checking/SKILL.md
---
name: compliance-checking
description: Verify compliance with security standards and regulations
skill_id: SEC-010
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: GDPR compliance, security standards
dependencies: []
---

# Compliance Checking

## Purpose
Verify application meets security standards, regulations, and compliance requirements.

## When to Use
- GDPR verification
- Security audits
- Before launches
- Regular compliance checks

## Process

1. Identify requirements
2. Map to controls
3. Verify implementation
4. Document compliance
5. Address gaps

## StudyAbroad-Specific Considerations
- GDPR data rights (export, delete)
- Consent management
- Data retention policies
- Privacy by design

---
SKILL_ID: SEC-011
SKILL_PATH: skills/security/penetration-testing/SKILL.md
---
name: penetration-testing
description: Conduct security penetration testing
skill_id: SEC-011
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Security validation, pre-release testing
dependencies: [SEC-002]
---

# Penetration Testing

## Purpose
Conduct authorized security testing to identify exploitable vulnerabilities.

## When to Use
- Pre-release security validation
- Annual security assessment
- After major changes
- Compliance requirements

## Process

1. Define scope
2. Reconnaissance
3. Vulnerability scanning
4. Exploitation attempts
5. Report findings

## StudyAbroad-Specific Considerations
- Test authentication bypass
- Test data access controls
- Test file upload security
- Test API authorization

---
SKILL_ID: SEC-012
SKILL_PATH: skills/security/security-reporting/SKILL.md
---
name: security-reporting
description: Generate security status and vulnerability reports
skill_id: SEC-012
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Security status, stakeholder reporting
dependencies: []
---

# Security Reporting

## Purpose
Generate clear security reports communicating risk status, vulnerabilities, and remediation progress.

## When to Use
- Regular status updates
- After security tests
- For stakeholders
- Compliance documentation

## Process

1. Collect security data
2. Assess risk levels
3. Generate report
4. Include recommendations
5. Track remediation

## StudyAbroad-Specific Considerations
- Vulnerability summary
- GDPR compliance status
- Remediation tracking
- Security metrics

---
SKILL_ID: SEC-013
SKILL_PATH: skills/security/incident-analysis/SKILL.md
---
name: incident-analysis
description: Analyze security incidents for root cause and impact
skill_id: SEC-013
owner: security
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Security incidents, breach response
dependencies: []
---

# Incident Analysis

## Purpose
Analyze security incidents to determine root cause, impact, and necessary remediation.

## When to Use
- Security incidents
- Anomaly detection
- Post-breach analysis
- Near-miss reviews

## Process

1. Contain incident
2. Collect evidence
3. Analyze timeline
4. Determine root cause
5. Document lessons learned

## StudyAbroad-Specific Considerations
- Data breach notification (GDPR)
- Log preservation
- User notification
- Regulatory reporting

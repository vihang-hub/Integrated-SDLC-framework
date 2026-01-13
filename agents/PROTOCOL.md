# Agent Communication Protocol

## Message Format
All inter-agent communication uses this structure:

```json
{
  "from": "agent-id",
  "to": "agent-id",
  "type": "request|response|notification",
  "priority": "critical|high|medium|low",
  "payload": {},
  "context": {
    "task_id": "string",
    "phase": "string",
    "requirement_id": "string"
  }
}
```

## Escalation Rules
1. Blockers -> Orchestrator
2. Security issues -> Security Agent
3. Requirement clarifications -> Requirements Agent
4. Architecture decisions -> Architecture Agent


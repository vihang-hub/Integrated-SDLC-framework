# Orchestrator Commands

## Workflow Commands
```
/orchestrate start <feature>     # Start new feature workflow
/orchestrate status              # Show current workflow state
/orchestrate gate <phase>        # Run gate validation
/orchestrate delegate <agent>    # Delegate to specific agent
/orchestrate escalate            # Escalate to human
```

## Spec Kit Integration
```
/orchestrate specify             # -> /speckit.specify
/orchestrate plan                # -> /speckit.plan
/orchestrate tasks               # -> /speckit.tasks
/orchestrate implement           # -> /speckit.implement
```

## BMAD Integration
```
/orchestrate bmad analyst        # Activate BMAD analyst
/orchestrate bmad architect      # Activate BMAD architect
/orchestrate bmad dev            # Activate BMAD developer
```

## Ralph Integration
```
/ralph-loop "<task>" --max-iterations <n> --completion-promise "<promise>"
/cancel-ralph
```


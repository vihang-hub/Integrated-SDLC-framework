# studyabroad-v2

[TODO: Add project description]

## Quick Start

```bash
# Clone and setup
git clone <repo-url>
cd studyabroad-v2
cp .env.example .env
# Edit .env with your configuration

# Start development
npm install  # or pip install -r requirements.txt
npm run dev
```

## SDLC Framework

This project uses a 10-agent SDLC framework. See [CLAUDE.md](CLAUDE.md) for details.

### Available Commands (in Claude Code)

| Command | Description |
|---------|-------------|
| `/orchestrate` | Start task coordination |
| `/specify` | Capture requirements |
| `/plan` | Create implementation plan |
| `/implement` | Execute implementation |
| `/ralph-loop` | Autonomous execution |

## Project Structure

```
├── agents/          # 10 agent definitions
├── skills/          # 116 skill templates
├── .specify/        # Spec Kit artifacts
├── .bmad/           # BMAD configuration
├── .ralph/          # Ralph loop configuration
├── docs/            # Documentation
├── src/             # Source code
└── tests/           # Test suites
```

## Documentation

- [Architecture](docs/architecture/)
- [API Documentation](docs/api/)
- [User Guide](docs/user-guide/)

## License

[Your License]


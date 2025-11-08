# Claude Code Starter Pack

A ready-to-use starter pack for integrating Claude Code into your projects, complete with custom agents, slash commands, and best practices for AI-assisted development.

## Quick Reference

### Slash Commands
| Command | Description |
|---------|-------------|
| `/commit` | Review changes and create a well-formatted commit |
| `/amend` | Amend the last commit with current changes |
| `/status` | Check repository status |
| `/push` | Push changes to remote repository |

### Custom Agents
| Agent | Purpose |
|-------|---------|
| `agent-creator` | Designs and generates clear, effective AI agent definitions |
| `tech-stack-advisor` | Analyzes requirements and recommends optimal technologies |
| `svelte-specialist` | Builds modern web applications with Svelte and SvelteKit |

## What's Inside

This starter pack provides a curated collection of tools and configurations to enhance your Claude Code experience:

### Custom Agents

Located in [.claude/agents/](.claude/agents/), these specialized agents help with specific development tasks:

- **[agent-creator.md](.claude/agents/agent-creator.md)** - Designs and generates clear, effective AI agent definitions following established best practices
- **[tech-stack-advisor.md](.claude/agents/tech-stack-advisor.md)** - Analyzes project requirements and recommends optimal programming languages, frameworks, and technologies
- **[svelte-specialist.md](.claude/agents/svelte-specialist.md)** - Builds modern web applications with Svelte, SvelteKit, and TypeScript

### Slash Commands

Located in [.claude/commands/](.claude/commands/), these quick commands streamline your git workflow:

- `/commit` - Review changes and create a well-formatted commit
- `/amend` - Amend the last commit with current changes
- `/status` - Check repository status
- `/push` - Push changes to remote repository

### Meta-Agent Guidelines

The [meta-agent-guidelines.md](meta-agent-guidelines.md) file provides comprehensive documentation for creating your own effective AI agents, including:

- Core principles for clarity and conciseness
- Agent definition structure and templates
- Best practices and common patterns
- Quality metrics and validation checklists

## Getting Started

### 1. Clone or Copy This Starter Pack

```bash
# Clone this repository into your project
git clone <repository-url> .

# Or copy the .claude directory into an existing project
cp -r .claude /path/to/your/project/
```

### 2. Install Claude Code

If you haven't already, install Claude Code CLI:

```bash
# Installation instructions at https://docs.claude.com/claude-code
```

### 3. Customize for Your Project

- Add project-specific agents to [.claude/agents/](.claude/agents/)
- Create custom slash commands in [.claude/commands/](.claude/commands/)
- Modify existing agents to match your team's workflow

## Usage

### Using Agents

Agents are automatically available when you use Claude Code. The system will suggest appropriate agents based on your request, or you can explicitly invoke them.

### Using Slash Commands

In Claude Code, type `/` followed by the command name:

```
/status      # View git status
/commit      # Create a commit
/amend       # Amend last commit
/push        # Push to remote
```

### Creating Your Own Agents

Follow the guidelines in [meta-agent-guidelines.md](meta-agent-guidelines.md):

1. Use the agent-creator agent to help design new agents
2. Follow the standard template structure
3. Define clear purpose, capabilities, and activation triggers
4. Save to `.claude/agents/your-agent-name.md`

### Creating Custom Slash Commands

Create a new markdown file in `.claude/commands/`:

```markdown
<!-- .claude/commands/your-command.md -->
Your command instructions here. This will be executed when the user types /your-command
```

## Directory Structure

```
.
├── .claude/
│   ├── agents/              # Custom AI agents
│   │   ├── agent-creator.md
│   │   ├── tech-stack-advisor.md
│   │   └── svelte-specialist.md
│   └── commands/            # Slash commands
│       ├── commit.md
│       ├── amend.md
│       ├── status.md
│       └── push.md
├── .vscode/
│   └── settings.json        # VSCode configuration
├── meta-agent-guidelines.md # Agent creation guidelines
└── README.md               # This file
```

## Best Practices

### Working with Agents

- Use the agent-creator agent to design new agents
- Keep agents focused on a single responsibility
- Define clear activation triggers
- Include concrete examples and success criteria
- Review the meta-agent guidelines before creating agents

### Working with Commands

- Keep commands simple and focused
- Use descriptive names that indicate the action
- Include brief descriptions of what the command does
- Test commands before committing them to your project

### Project Integration

- Commit the `.claude/` directory to version control
- Share custom agents and commands with your team
- Document project-specific agents in your project README
- Update agents as your project evolves

## Examples

### Example: Creating a New Agent

```bash
# In Claude Code, ask the agent-creator for help
"I need an agent that helps with Python FastAPI development"
```

The agent-creator will guide you through creating a well-structured agent definition.

### Example: Using the Tech Stack Advisor

```bash
# Ask for technology recommendations
"I need to build a real-time chat application. What tech stack should I use?"
```

The tech-stack-advisor agent will analyze requirements and recommend appropriate technologies.

## Contributing

To contribute new agents or commands to this starter pack:

1. Ensure your agent follows the meta-agent guidelines
2. Test thoroughly in a real project
3. Document any prerequisites or dependencies
4. Submit with clear examples and use cases

## Resources

- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Meta-Agent Guidelines](meta-agent-guidelines.md)
- [Agent Creation Best Practices](meta-agent-guidelines.md#core-principles)

## License

This starter pack is provided as-is for use in your projects. Customize freely to meet your needs.

## Support

For issues with Claude Code itself, visit the [official documentation](https://docs.claude.com/claude-code) or file an issue at https://github.com/anthropics/claude-code/issues.

For questions about this starter pack, refer to the included documentation and guidelines.

# Specialized Agents

## Agents vs Skills vs Slash Commands

| Mechanism | Definition | Typical usage |
|-----------|------------|---------------|
| **Agent** | Autonomous sub-process with its own tools | Parallel tasks, context isolation |
| **Skill** | Structured prompt defining a workflow (`/analyze`, `/implement`…) | Development cycle steps |
| **Slash command** | Shortcut to a simple prompt | Quick actions (`/commit`, `/status`) |

---

## Agents available in this repository

Placed in `.claude/agents/`, they are automatically available in Claude Code.

| Agent | Role |
|-------|------|
| `agent-creator` | Designs effective agent definitions |
| `tech-stack-advisor` | Recommends technologies based on constraints |
| `svelte-specialist` | Svelte/SvelteKit/TypeScript applications |
| `browser-extension-expert` | Chrome/Firefox extensions, Manifest V3 |
| `rust-specialist` | Idiomatic, high-performance Rust code |
| `github-ci-specialist` | GitHub Actions workflows |
| `gitlab-cicd-specialist` | GitLab CI/CD pipelines |
| `kubernetes-migration-specialist` | Docker → Kubernetes migration |
| `tech-learning-guide` | Learning new languages and stacks |

---

## Creating an effective agent

### Basic rules

- **One clear responsibility** — if you cannot explain the agent in one sentence, it is too broad
- **Action verbs** — "Analyze", "Generate", "Optimize" (not "help with")
- **Explicit boundaries** — what it does AND what it does NOT do
- **Precise triggers** — when to use it vs other agents

### Minimal structure

```markdown
# Agent name

## Purpose
[One sentence: what this agent does]

## Capabilities
- [Specific capability 1]
- [Specific capability 2]

## When to use
- [Scenario 1]
- [Scenario 2]

## When NOT to use
- [Excluded cases]
```

### What to avoid

- ❌ "Helps with code" → too vague
- ❌ Two agents doing the same thing
- ❌ Promising capabilities the agent does not have
- ❌ An agent that "does everything"

---

## The ghost file problem (sub-agents)

**Common symptom:** a sub-agent confirms "I created file X" but the file does not exist. This happens even after repeated reminders.

**Cause:** agents can generate a textual response without having actually called the write tools. The confirmation is sincere but false.

**Solutions:**

1. **Force tools in the prompt:**
```
You MUST use the Write tool for each file.
Do not say you created a file if you did not call the Write tool.
```

2. **Verify systematically** — never trust textual confirmation, read the file afterwards.

3. **Restrict available tools** for the agent to prevent it from "imagining" alternatives.

4. **Break tasks down** — an agent that must create 10 files at once is more likely to miss some. Targeted agents are better.

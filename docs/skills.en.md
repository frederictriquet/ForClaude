# Skills

Skills are reusable prompts invocable via `/skill-name`, built-in or custom — see the [official docs](https://docs.anthropic.com/en/docs/claude-code/skills).

## Reference

| Skill | Description |
|-------|-------------|
| `/simplify` | **Built-in Claude Code.** Reviews changed code for reuse opportunities, quality and efficiency improvements, then automatically fixes any issues found. |
| `/batch` | **Built-in Claude Code.** Runs the same prompt across multiple files in parallel. Useful for repetitive large-scale changes (renaming, refactoring, migrations). |
| `/debug [description]` | **Built-in Claude Code.** Diagnoses Claude Code itself (not your code). Reads the internal debug log of the current session to explain unexpected behavior: tool refusal, loops, hooks or permissions not working. You can specify the issue: `/debug why is Claude not using the Read tool?` |
| `/loop [interval] <prompt>` | **Built-in Claude Code.** Runs a prompt repeatedly on an interval while the session stays open. Useful for monitoring a deployment, babysitting a PR, or periodically re-running another skill. Example: `/loop 5m check if the deploy finished`. |

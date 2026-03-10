# Feature Changelog

Tracking notable features added to Claude Code, with discovery date and documentation link.

---

| Date | Feature | Description | Doc |
|------|---------|-------------|-----|
| 2026-03-09 | `/simplify` | Built-in skill that reviews changed code for reuse opportunities, quality and efficiency improvements, then automatically fixes any issues found. | [Skills](skills.en.md#reference) |
| 2026-03-09 | `/batch` | Built-in skill that orchestrates large-scale changes in parallel. Decomposes work into 5-30 units, each agent works in an isolated git worktree and opens a PR. | [Skills](skills.en.md#reference) |
| 2026-03-10 | LSP | Semantic code navigation (definitions, references, types, call hierarchy) via Language Server Protocol. ~50ms instead of 30-60s with grep, auto-correction of errors after edits. | [Best practices](bonnes-pratiques.en.md#lsp-semantic-code-navigation) |

# Claude Code Best Practices

## CLAUDE.md

The `CLAUDE.md` file at the root of the project is read automatically by Claude at every session. It is the most powerful lever for guiding its behavior.

**What to put in it:**
- The tools and scripts to use (and those NOT to use)
- The project conventions (naming, structure, languages)
- The important constraints ("never modify the DB directly")
- References to other files (`@RTK.md`, `@ARCHITECTURE.md`)

**Concrete example**: if Claude needs to query a containerized PostgreSQL database whose credentials are not obvious, it will fail to connect several times. The solution: create a `db_query.sh "<SQL>"` script and write in `CLAUDE.md` that it is forbidden to use anything else to query the DB. Claude will use it naturally.

> Golden rule: the more you simplify the available tools, the more effective Claude is.

---

## Commit Often

**Why it's critical:** frequent commits protect in both directions.

- **If Claude makes a mistake**: it can decide to restore a file with `git checkout`. Without a recent commit, you lose all intermediate work.
- **If you want to undo**: a `git reset` or `git checkout` brings you back to a known state. Without a commit, you have no safety net.

Commit after each logical unit of work, even a small one. Uncommitted work is invisible to recovery mechanisms — yours as well as Claude's.

---

## Incremental Development

Two complementary principles for keeping Claude effective on complex projects.

### 1. Vertical slicing — one complete feature before the next

Implement a feature end-to-end across all layers (input, processing, persistence, display) before moving on to the next — rather than developing an entire technical layer first.

- Yes: Frontend + backend + DB for a single use case, then the next one
- No: The entire DB layer first, then the entire backend, then the entire frontend

### 2. Reduced scope — avoid cross-cutting features too early

Do not start with features that touch everything (parallelization, global cache, auth overhaul...). They are difficult to change once in place because they become embedded in the entire architecture.

**Example:** for a monitoring application with multiple scanners, a multi-stage pipeline and Grafana visualization:
- Yes: Get **a single scanner** working across the full pipeline -> parallelize -> add the other scanners
- No: Start with parallelization or implement all scanners at the same time

**Why this matters with Claude:** tasks that touch many files simultaneously increase the risk that Claude loses track, forgets changes, or leaves inconsistencies. A reduced scope = a controlled context.

> Start simple -> validate -> add complexity.

---

## Managing Long Conversations

The longer a conversation gets, the more likely Claude is to lose track: forgetting constraints established at the start of the session, contradictions with earlier decisions, repeating work already done.

**Warning signals:**
- Claude proposes something it had explicitly ruled out earlier
- Responses become less precise or less consistent with the project context
- Claude "reinvents" a convention that was already established

**What to do:**
- Open a new conversation for independent tasks
- Summarize the essential context at the start of a new session (a good `CLAUDE.md` helps a lot)
- For long sessions, remind Claude of key constraints before an important step: *"reminder: we don't use the DB directly, only via db_query.sh"*

---

## Sub-agents and Ghost Files

When using sub-agents (via the `Agent` tool), a common pitfall: **the agent confirms having created a file, but did not actually do it.**

Agents can produce a textual confirmation without having actually called the write tools. This happens even after explicit reminders, and even when repeating the instruction multiple times.

**When to use a sub-agent:** parallelizable and independent tasks (research, analyzing multiple files, generating isolated content). Not for a sequence of interdependent writes where order and verification are critical.

**How to protect against it:**

1. **Force tools in the prompt** — explicitly name `Write tool` or `Edit tool`, no other alternative accepted
2. **Verify systematically** with `Read` or `Glob` after the response — never trust a textual confirmation
3. **Break it down** — an agent creating 10 files at once is more likely to miss some; prefer agents focused on a single precise task

Effective wording in a sub-agent prompt:
```
You MUST create each file by calling the Write tool.
Do not confirm having created a file if you have not called Write tool.
Verify with Read tool that the file exists before moving on to the next.
```

---

## Requiring Concrete Evidence

State explicitly: "Show me the result of the command" rather than "Tell me if it works". When in doubt, verify yourself with a `Read` or by running the command directly. Never accept a textual confirmation as proof.

**Why:** Claude can claim to have done something — tests passed, bug fixed, performance measured — without having actually executed it. This is not deliberate deception, it is **confabulation**: the model generates text consistent with what seems expected, without an internal verification mechanism. Textual confirmations ("I fixed the bug") are therefore unreliable by nature.

---

## Detecting Unwanted Shortcuts

- Explicitly forbid in `CLAUDE.md` modifying existing tests
- Require that any empty `catch` or removal of a lint warning be justified in a comment
- Do not phrase the task as "fix lint errors" without specifying that disabling rules is forbidden

**Why:** Claude seeks to satisfy the request quickly. Faced with a failing test or a persistent warning, it may choose the shortest solution — disabling the test, adding a silent `catch`, ignoring the rule — rather than fixing the underlying problem. These shortcuts are hard to detect because they make surface-level checks pass.

---

## Multi-Role Sessions

- Dedicate one session to writing code
- Dedicate a separate session to verification: tests, performance, stability
- Optionally, a third session for the quality gate: code cleanliness, convention compliance

**Why:** rules given at the start of a session lose their influence as the context grows. Distributing responsibilities across short sessions limits this dilution effect.

This also allows for **single-objective sessions**: a session tasked with both writing code and guaranteeing its quality is in a situation of internal conflict — it may unconsciously sacrifice one for the other. By separating roles, these dilemmas are eliminated and each session can optimize without compromise.

**Nuances:** a verification session is itself subject to the same biases — it may validate what seems plausible rather than what is actually correct. What matters is that each session has a **narrow scope and objectively verifiable criteria**. Prefer short, single-task sessions: context dilution applies to all sessions.

---

## Hooks: Natural Checkpoint, Not Continuous Surveillance

Use git hooks (pre-commit) to enforce linting before each commit. This is a natural checkpoint: code is supposed to be in a stable state at that moment.

**Avoid** `PostToolUse` hooks (after each `Write`/`Edit`) to run tests or linting: code is often in an invalid intermediate state between two steps of a refactoring, which generates noise rather than signal and can disorient Claude in the middle of a modification.

---

## Git Worktrees

Git worktrees allow working on multiple branches simultaneously in separate directories — useful for isolating a task without polluting the main branch.

The `-w` flag of Claude Code creates the worktree and launches the session inside it in a single command, with automatic cleanup if no changes are made:

```bash
claude -w             # worktree with generated name
claude -w ma-feature  # named worktree
```

Manual creation (`git worktree add`) is only worth it if you need precise control over the base branch or location.

**Important limitation:** if the project shares global state resources — a single database, migrations (Drizzle, Alembic...), lock files — launching two Claude sessions in parallel in two worktrees can cause migration conflicts or inconsistent states. In that case, worktrees remain useful but sequentially, not in parallel.

---

## Specs Before Code

Rather than directly asking for the implementation of a requirement, go through an intermediate step: ask Claude to write a list of specs, validate them, then ask for the implementation based on those specs.

```
1. "Here is my requirement: [...]. Write a list of specs."
2. [you read, correct, and validate]
3. "Implement based on these specs."
```

**Why it's more effective:** when developing directly, Claude interprets the requirement and makes implicit choices that you only discover when seeing the result. Specs make these choices visible and correctable before the code is written. This avoids costly back-and-forth and misunderstandings buried in the implementation.

It is also useful for you: the exercise of reading specs forces you to realize what you had not specified.

---

## LSP: Semantic Code Navigation

By default, Claude Code navigates code with `grep` — text-based search, slow (~30-60s) and sometimes imprecise. LSP mode (Language Server Protocol) gives it the same semantic intelligence as an IDE: definitions, references, types, call hierarchy.

**Concrete benefits:**
- Queries in ~50ms instead of 30-60s
- Exact location (file + line) with 100% accuracy
- Auto-correction after edits: LSP detects errors at call sites and Claude fixes them in the same turn

**Setup:**

1. Add to `~/.claude/settings.json`:
```json
{ "env": { "ENABLE_LSP_TOOL": "1" } }
```
2. Install the language server (`npm i -g pyright`, etc.)
3. Install the plugin: `claude plugin install <name>`
4. Enable the plugin and restart Claude Code

**Available LSP servers:**

| Language | LSP Server | Binary install | Claude plugin |
|----------|-----------|----------------|---------------|
| Python | pyright | `npm i -g pyright` | `pyright-lsp` |
| TypeScript/JS | typescript-language-server | `npm i -g typescript-language-server typescript` | `typescript-lsp` |
| Go | gopls | `go install golang.org/x/tools/gopls@latest` | `gopls-lsp` |
| Rust | rust-analyzer | `rustup component add rust-analyzer` | `rust-analyzer-lsp` |
| Java | jdtls | `brew install jdtls` / `apt install eclipse-jdt-ls` | `jdtls-lsp` |
| C/C++ | clangd | `brew install llvm` / `apt install clangd` | `clangd-lsp` |
| C# | csharp-ls | `dotnet tool install -g csharp-ls` | `csharp-lsp` |
| PHP | intelephense | `npm i -g intelephense` | `php-lsp` |
| Kotlin | kotlin-language-server | GitHub releases | `kotlin-lsp` |
| Swift | sourcekit-lsp | Included with Xcode | `swift-lsp` |
| Svelte | svelte-language-server | auto-installed via npx | `svelte-lsp@agentic-utils` ¹ |
| Lua | lua-language-server | GitHub releases | `lua-lsp` |

All plugins install via `claude plugin install <plugin-name>`. Installation is **project-level** (`.claude/plugins/`), not global — you need to install the plugin in each project where you want to use it.

¹ Plugin from the third-party marketplace [agentic-utils/claude-plugins](https://github.com/agentic-utils/claude-plugins). Add the marketplace first:
```
/plugin marketplace add https://github.com/agentic-utils/claude-plugins
/plugin install svelte-lsp@agentic-utils
```

**Warning:** an installed but disabled plugin won't register its LSP server at startup.

**CLAUDE.md tip:** add an instruction so Claude prioritizes LSP:
```
Use LSP for code navigation.
Use grep only for text/pattern searches where LSP cannot help.
Check diagnostics after editing code.
```

---

## Describe the Use Case, Not Just the Symptom

When reporting a bug, describing **the use case and the expected result** is systematically more effective than "it doesn't work".

- No: "The login function doesn't work, fix it"
- Yes: "When I submit the form with `user@Example.COM`, I am redirected to the error page. The expected behavior is a successful login — emails should not be case-sensitive"

With the symptom alone, Claude has to guess the expected behavior and may "fix" things in the wrong direction. With the complete use case, it can reason about the gap between what happens and what should happen — which is exactly the nature of a bug.

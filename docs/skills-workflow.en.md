# Skills Workflow

A system of atomic skills covering the entire development cycle.
Each skill = one phase. Explicit transitions between each step.

## The workflow

```
/analyze → /explore-options → /tech-choice → /architecture
                                                    ↓
/implement → /test-write → /test-run → /quality-check → /code-review
                                                              ↓
                                          /document → /capitalize → /roadmap-update --done → /pre-merge
```

> `/pre-merge` is always the **last** step. Do not merge before documenting and capitalizing.

### Feedback loops

After `/code-review` with requested corrections:
```
corrections → /implement or /test-write → /test-run → /quality-check → /code-review (re-review)
```

---

## Skills reference

### Analysis
| Skill | Description |
|-------|-------------|
| `/analyze` | Understand the problem before coding |
| `/explore-options` | Explore the different solutions |
| `/tech-choice` | Document a technical decision (ADR) |
| `/architecture` | Design the structure before implementing |

### Implementation
| Skill | Useful flags |
|-------|-------------|
| `/implement` | `--tdd`, `--incremental` |
| `/test-write` | `--unit`, `--integration`, `--e2e` |
| `/test-run` | `--watch`, `--coverage` |
| `/quality-check` | `--fix`, `--strict` |
| `/debug` | `--verbose` |

### Validation & finalization
| Skill | Useful flags |
|-------|-------------|
| `/code-review` | `--security`, `--performance`, `--thorough` |
| `/document` | `--api`, `--readme`, `--inline` |
| `/capitalize` | `--pattern`, `--adr`, `--bug` |
| `/roadmap-update` | `--done`, `--in-progress`, `--blocked` |
| `/pre-merge` | `--pr`, `--squash` |

### Utilities
| Skill | Description |
|-------|-------------|
| `/next` | Recalls the context and suggests the next step |
| `/refactor` | Refactors without changing behavior |
| `/clean-code` | Cleans up maintainability after an intensive session |
| `/post-mortem` | Analyzes an incident or a session |

---

## The escape trap

**Symptom:** Claude suggests skipping steps or jumping directly to `/pre-merge` after `/implement`.

This is the most common problem with this workflow. Possible causes:
- The step order is not visible enough in the prompt
- Claude "optimizes" by skipping what seems redundant to it
- The conversation context has grown long and the rules are forgotten

**Solutions:**

1. **Use `/next`** — explicitly recalls where we are and what the next required step is
2. **The gates** — each skill checks prerequisites via `workflow-current.md` (SERENA)
3. **Explicitly recall the order** if needed: "We are after /test-run, the next step is /quality-check"

---

## SERENA integration

Each skill uses SERENA to:
- **Consult** existing memories at the start (patterns, ADR, known bugs)
- **Update** `workflow-current.md` to track progress
- **Capitalize** discoveries at the end

The `workflow-current.md` file is the source of truth for the state of the current workflow.

---

## Example: new feature

```bash
/analyze "add OAuth authentication"
/explore-options OAuth providers
/tech-choice Auth0
/roadmap-update "Auth OAuth" --in-progress
/architecture module auth
/implement auth-module --tdd
/test-write auth-module --unit --integration
/test-run auth --coverage
/quality-check
/code-review auth-module --security
/document auth-module --api
/capitalize OAuth integration --pattern
/roadmap-update "Auth OAuth" --done
/pre-merge --pr
```

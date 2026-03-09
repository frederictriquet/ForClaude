# Effective Prompting

## Golden Rules

**1. Context before instructions**
Explain *why* before *what*. Claude understands constraints better when it understands the goal.

**2. Explicit deliverables**
List exactly what needs to be produced. "Create a system for X" is less effective than "Create files A, B, and C with functions X, Y, Z".

**3. Negative constraints**
Stating what NOT to do is often more effective than stating what to do.
```
Do not modify configuration files.
Do not use the DB connection directly, go through db_query.sh.
```

**4. One task at a time**
Several small sequential requests > one large complex request. Claude stays on track better with focused tasks.

**5. Format specificity**
Specify the expected output format: files to create, naming, structure, language.

---

## Anti-patterns

| ❌ Avoid | ✅ Do instead |
|------------|-----------|
| "Help me with the code" | "Fix the bug on line 42 of auth.ts: email validation doesn't handle uppercase letters" |
| Separate requests for each sub-task | One complete prompt with all requirements structured together |
| "Do your best" | Explicit success criteria |
| Omitting constraints | List restrictions in `CLAUDE.md` or in the prompt |

---

## Example: prompt to create a complex system

```
Create a [X] system with the following components:

## Architecture
- [component A]: [responsibility]
- [component B]: [responsibility]

## Constraints
- Use [technology] for [reason]
- Do not modify [existing files]
- All functions must have strict TypeScript types

## Deliverables
1. src/[module]/index.ts — entry point
2. src/[module]/types.ts — interfaces
3. src/[module]/[feature].ts — implementation

## Success Criteria
- Existing tests continue to pass
- [expected behavior] works with [example input]
```

---

## Prompts for difficult cases

### Fixing a recurring error
```
You are currently [doing X] but the expected behavior is [Y].
Here is what you produced: [excerpt]
Here is what should be produced: [example]
Explain your reasoning before modifying anything.
```

### Forcing the use of a specific tool
```
For each file to create, you MUST call the Write tool.
Do not use Bash to write files.
Verify with the Read tool that each file exists before moving on to the next.
```

### Staying on track through a long workflow
```
We are following this workflow: /implement → /test-write → /test-run → /quality-check → /code-review
We just successfully completed /test-run.
The next step is ONLY /quality-check. Do not suggest any other step.
```

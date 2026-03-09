# MCP Servers

MCP servers (Model Context Protocol) extend Claude Code's capabilities by giving it access to external tools. This is one of the most powerful levers in the ecosystem.

---

## SERENA — Persistent project memory

SERENA gives Claude a structured memory that persists between sessions. It can read, write, and search typed memory files, and navigate code symbolically.

**What it changes:** Claude no longer forgets architecture decisions, project patterns, or already-resolved bugs.

**Installation:**
```bash
cd <your-project>
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project $(pwd)
```

Then in Claude:
```
/status          # Check that SERENA is active
start Serena Onboarding
```

And index the project:
```bash
uvx --from git+https://github.com/oraios/serena serena project index
```

**Memory types:**

| Prefix | Usage |
|--------|-------|
| `pattern-*` | Reusable solutions |
| `adr-*` | Architecture Decision Records |
| `bug-*` | Resolved bugs and their fixes |
| `std-*` | Standards and conventions |
| `arch-*` | Architecture documentation |
| `postmortem-*` | Incident analyses |

→ [GitHub oraios/serena](https://github.com/oraios/serena)

---

## RTK — Token reduction

RTK (Rust Token Killer) is a CLI proxy that filters command output before sending it to Claude. Result: 60–90% token savings on common operations.

**How it works:** the Claude Code hook automatically intercepts commands (`git status`, `ls`, `grep`…) and passes them to RTK, which returns a condensed version.

**Installation:**
```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
rtk init --global   # installs the Claude Code hook + creates RTK.md
```

**Key commands:**
```bash
rtk gain            # view savings achieved
rtk gain --history  # command history
rtk discover        # analyze Claude history for missed opportunities
```

→ [GitHub rtk-ai/rtk](https://github.com/rtk-ai/rtk)

---

## Context7 — Live documentation

Context7 injects up-to-date library documentation directly into Claude's context. No more hallucinations about APIs that changed since the cutoff.

**Installation:**
```
/plugin marketplace add pleaseai/context7
```

**Usage:** simply mention the library in your question, Context7 automatically injects the relevant documentation.

→ [Plugin Context7](https://context7.com)

---

## EU Regulations MCP — European regulations

50 European regulations queryable directly from Claude: GDPR, AI Act, DORA, NIS2, MiFID II, eIDAS… Full verbatim text (no AI paraphrasing), updated daily from EUR-Lex. Includes 709 mappings to ISO 27001:2022 and NIST CSF 2.0.

No API key required, available remotely without installation:

```bash
# Remote (no installation)
claude mcp add eu-regs --transport http https://eu-regulations-mcp.vercel.app/mcp

# Or local
claude mcp add eu-regs -- npx @ansvar/eu-regulations-mcp
```

→ [GitHub Ansvar-Systems/EU_compliance_MCP](https://github.com/Ansvar-Systems/EU_compliance_MCP)

---

## Other notable tools

| Tool | Description | Link |
|------|-------------|------|
| **snip** | Snippet manager for Claude | [GitHub](https://github.com/edouard-claude/snip) |
| **firefox-devtools-mcp** | Firefox control from Claude (see below) | [GitHub](https://github.com/freema/firefox-devtools-mcp) |

---

## Firefox DevTools MCP — Browser control

MCP server that connects Claude to Firefox via WebDriver BiDi. Claude can navigate, interact with pages, monitor network traffic, and read the console — without manual intervention.

**Typical use cases:**
- Test an interface by describing the scenario to Claude
- Inspect network requests from a web application
- Debug console errors directly from the Claude session

**Installation:**
```bash
claude mcp add firefox-devtools npx firefox-devtools-mcp
# or globally:
claude mcp add firefox-devtools npx firefox-devtools-mcp --scope user
```

There is a fork [`padenot/firefox-devtools-mcp`](https://github.com/padenot/firefox-devtools-mcp) maintained by a Mozilla developer, which adds Firefox preference management, access to privileged context, and WebExtension management — only useful if you are working on Firefox itself.

→ [GitHub freema/firefox-devtools-mcp](https://github.com/freema/firefox-devtools-mcp)

---

## Chrome DevTools MCP — Chrome control

The Chrome equivalent of Firefox DevTools MCP, maintained by the official Chrome DevTools team. 29 tools covering automation, navigation, performance (Lighthouse), network, and debugging.

**Installation:**
```bash
# Via CLI
claude mcp add chrome-devtools --scope user npx chrome-devtools-mcp@latest

# Via marketplace (MCP + skills)
/plugin marketplace add ChromeDevTools/chrome-devtools-mcp
```

→ [GitHub ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp)

---

## Configuring multiple MCP servers

MCP servers are declared in `.claude/settings.json` or via the `claude mcp add` command. They are active for any session in the relevant project.

To see active MCP servers: `/status` in Claude Code.

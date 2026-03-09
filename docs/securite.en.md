# Security

## AIDA — Claude-driven Pentesting

AIDA connects Claude to a real penetration testing environment via MCP. Since it is an MCP server that drives the auditing tools, everything happens directly in the Claude CLI — no API key, no external interface. Claude can run security tools directly, chain commands and document results — without manual intervention at each step.

**What it gives access to:**
- 400+ pentesting tools via [Exegol](https://github.com/ThePorgs/Exegol) (nmap, sqlmap, ffuf, nuclei…)
- Structured workflows from reconnaissance to exploitation
- Web dashboard for tracking findings with severity and evidence
- Context maintained across sessions

**Installation:**
```bash
git clone https://github.com/Vasco0x4/AIDA.git
cd AIDA
./start.sh
# Dashboard: http://localhost:5173

python3 aida.py --assessment "test-name"
```

> ⚠️ Alpha project. Local use only, on environments you are authorized to test.

→ [GitHub Vasco0x4/AIDA](https://github.com/Vasco0x4/AIDA)

---

## Kali Linux MCP — Raw Shell Access to Kali

The principle is the same as AIDA: an MCP server runs in a Kali environment (VM or Docker container) and exposes the tools to Claude Code on the host machine. No external API key required.

The difference from AIDA: it is **raw shell access**, with no management layer on top. No dashboard, no structured workflows, no automatic documentation of findings. More minimalist and flexible, but less polished for structured pentest use.

Advantage: it is an **official Kali package**, maintained by the Kali Linux team.

**Installation:**
```bash
sudo apt install mcp-kali-server
```

Then configure Claude Code to point to the local server.

> ⚠️ Claude has access to a full shell — use only on isolated environments and authorized targets.

→ [kali.org/tools/mcp-kali-server](https://www.kali.org/tools/mcp-kali-server/)

---

## Shannon — Autonomous Exploitation-Oriented Pentest

Shannon is an autonomous pentest framework that goes beyond detection: it actually exploits vulnerabilities to produce reproducible proof-of-concepts. It analyzes source code to guide its attack strategy, then performs browser attacks under real conditions.

**Current coverage:** injections, XSS, SSRF, authentication and authorization flaws.

**Installation:**
```bash
git clone https://github.com/KeygraphHQ/shannon
# Configure credentials in .env
docker compose up
```

> ⚠️ **API key required** — Shannon relies on the Anthropic Agent SDK and requires an Anthropic API key (or a Claude Code OAuth token). Parallel analyses consume many tokens: **costs can escalate quickly**, especially on complex targets.

> Use strictly limited to environments you are authorized to test.

→ [GitHub KeygraphHQ/shannon](https://github.com/KeygraphHQ/shannon)

---

## Burp Suite MCP — Interactive Web Testing

Official PortSwigger MCP, compatible with the Community Edition (free). Exposes the proxy, traffic history, scanner, Repeater and Collaborator directly to Claude.

**Installation:** via the BApp Store in Burp Suite → search for "MCP Server". The server listens on `127.0.0.1:9876`.

```bash
claude mcp add burp --transport http http://127.0.0.1:9876/mcp
```

→ [PortSwigger/mcp-server](https://github.com/PortSwigger/mcp-server)

---

## OWASP ZAP MCP — Automated Scanning

No official ZAP MCP, but serious community implementations exist. The most notable one exposes spider, active scan, OpenAPI import and report generation.

```bash
claude mcp add zap -- npx mcp-zap-server
```

→ [dtkmn/mcp-zap-server](https://github.com/dtkmn/mcp-zap-server)

---

## Snyk MCP — Vulnerability Analysis

Official Snyk MCP, available since CLI v1.1296.2. Dependency scans, vulnerabilities and code analysis directly from Claude.

> ⚠️ Requires a Snyk account (free for open source projects).

```bash
claude mcp add snyk -- snyk mcp
```

→ [snyk.io — Snyk MCP](https://snyk.io/articles/secure-ai-coding-with-snyk-now-supporting-model-context-protocol-mcp/)

---

## Risks Related to Untrusted MCPs

A malicious or compromised MCP server has access to everything Claude can do in your session: read files, execute commands, exfiltrate data. Critical vulnerabilities were discovered in 2025-2026 in Claude Code itself via this vector (CVE-2025-59536, CVE-2026-21852, now patched).

**Basic rules:**
- Only install MCPs whose source code you can verify
- Restrict permissions in `.claude/settings.json` to the strict minimum
- A security MCP (shell, network access) is particularly sensitive — review its code before enabling it

→ [Check Point Research — RCE via Claude Code project files](https://research.checkpoint.com/2026/rce-and-api-token-exfiltration-through-claude-code-project-files-cve-2025-59536/)

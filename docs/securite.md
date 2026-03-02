# Sécurité

## AIDA — Pentesting piloté par Claude

AIDA connecte Claude à un environnement réel de test de pénétration via MCP. Comme c'est un serveur MCP qui pilote les outils d'audit, tout se passe directement dans la CLI de Claude — pas de clé d'API, pas d'interface externe. Claude peut exécuter des outils de sécurité directement, enchaîner des commandes et documenter les résultats — sans intervention manuelle à chaque étape.

**Ce que ça donne accès à :**
- 400+ outils de pentesting via [Exegol](https://github.com/ThePorgs/Exegol) (nmap, sqlmap, ffuf, nuclei…)
- Workflows structurés de la reconnaissance jusqu'à l'exploitation
- Tableau de bord web de suivi des découvertes avec sévérité et preuves
- Contexte maintenu entre les sessions

**Installation :**
```bash
git clone https://github.com/Vasco0x4/AIDA.git
cd AIDA
./start.sh
# Tableau de bord : http://localhost:5173

python3 aida.py --assessment "nom-du-test"
```

> ⚠️ Projet en alpha. Usage local uniquement, sur des environnements que tu es autorisé à tester.

→ [GitHub Vasco0x4/AIDA](https://github.com/Vasco0x4/AIDA)

---

## Kali Linux MCP — Accès shell brut à Kali

Le principe est le même qu'AIDA : un serveur MCP tourne dans un environnement Kali (VM ou conteneur Docker) et expose les outils à Claude Code sur la machine hôte. Pas de clé API externe nécessaire.

La différence avec AIDA : c'est un accès **shell brut**, sans couche de gestion au-dessus. Pas de tableau de bord, pas de workflows structurés, pas de documentation automatique des découvertes. Plus minimaliste et flexible, mais moins abouti pour un usage pentest structuré.

Avantage : c'est un **package officiel Kali**, maintenu par l'équipe Kali Linux.

**Installation :**
```bash
sudo apt install mcp-kali-server
```

Puis configurer Claude Code pour pointer sur le serveur local.

> ⚠️ Claude a accès à un shell complet — à utiliser uniquement sur des environnements isolés et des cibles autorisées.

→ [kali.org/tools/mcp-kali-server](https://www.kali.org/tools/mcp-kali-server/)

---

## Shannon — Pentest autonome orienté exploitation

Shannon est un framework de pentest autonome qui va au-delà de la détection : il exploite réellement les vulnérabilités pour produire des preuves de concept reproductibles. Il analyse le code source pour guider sa stratégie d'attaque, puis effectue des attaques navigateur en conditions réelles.

**Couverture actuelle :** injections, XSS, SSRF, failles d'authentification et d'autorisation.

**Installation :**
```bash
git clone https://github.com/KeygraphHQ/shannon
# Configurer les credentials dans .env
docker compose up
```

> ⚠️ **Clé API obligatoire** — Shannon repose sur l'Anthropic Agent SDK et nécessite une clé API Anthropic (ou un token Claude Code OAuth). Les analyses parallèles consomment beaucoup de tokens : **ça peut vite coûter cher**, surtout sur des cibles complexes.

> Usage strictement limité aux environnements que tu es autorisé à tester.

→ [GitHub KeygraphHQ/shannon](https://github.com/KeygraphHQ/shannon)

---

## Burp Suite MCP — Test web interactif

MCP officiel PortSwigger, compatible avec la Community Edition (gratuite). Expose le proxy, l'historique de trafic, le scanner, le Repeater et Collaborator directement à Claude.

**Installation :** via le BApp Store dans Burp Suite → chercher "MCP Server". Le serveur écoute sur `127.0.0.1:9876`.

```bash
claude mcp add burp --transport http http://127.0.0.1:9876/mcp
```

→ [PortSwigger/mcp-server](https://github.com/PortSwigger/mcp-server)

---

## OWASP ZAP MCP — Scan automatisé

Pas de MCP officiel ZAP, mais des implémentations communautaires sérieuses. La plus notable expose spider, active scan, import OpenAPI et génération de rapports.

```bash
claude mcp add zap -- npx mcp-zap-server
```

→ [dtkmn/mcp-zap-server](https://github.com/dtkmn/mcp-zap-server)

---

## Snyk MCP — Analyse de vulnérabilités

MCP officiel Snyk, disponible depuis la CLI v1.1296.2. Scans de dépendances, vulnérabilités et analyse de code directement depuis Claude.

> ⚠️ Nécessite un compte Snyk (gratuit pour les projets open source).

```bash
claude mcp add snyk -- snyk mcp
```

→ [snyk.io — Snyk MCP](https://snyk.io/articles/secure-ai-coding-with-snyk-now-supporting-model-context-protocol-mcp/)

---

## Risques liés aux MCP non fiables

Un serveur MCP malveillant ou compromis a accès à tout ce que Claude peut faire dans ta session : lire des fichiers, exécuter des commandes, exfiltrer des données. Des vulnérabilités critiques ont été découvertes en 2025-2026 dans Claude Code lui-même via ce vecteur (CVE-2025-59536, CVE-2026-21852, depuis patchées).

**Règles de base :**
- N'installer que des MCP dont tu peux vérifier le code source
- Restreindre les permissions dans `.claude/settings.json` au strict nécessaire
- Un MCP de sécurité (shell, accès réseau) est particulièrement sensible — vérifier son code avant de l'activer

→ [Check Point Research — RCE via Claude Code project files](https://research.checkpoint.com/2026/rce-and-api-token-exfiltration-through-claude-code-project-files-cve-2025-59536/)

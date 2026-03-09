🇫🇷 Français · [🇬🇧 English](README.en.md)

# Guide Claude Code

Bonnes pratiques et outils pour développeurs utilisant Claude Code.
Documentation synthétique, orientée terrain.

## Sommaire

| Guide | Contenu |
|-------|---------|
| [Bonnes pratiques](docs/bonnes-pratiques.md) | CLAUDE.md, commits fréquents, développement incrémental |
| [Serveurs MCP ⭐](docs/mcp-servers.md) | SERENA, Context7, RTK — ce qui change vraiment la donne |
| [Agents spécialisés](docs/agents.md) | Créer des agents efficaces, éviter les pièges courants |
| [Workflow de skills](docs/skills-workflow.md) | Processus de développement structuré étape par étape |
| [Prompting](docs/prompting.md) | Écrire des prompts qui fonctionnent |
| [Frameworks](docs/frameworks.md) | Superpowers et autres frameworks de workflow |
| [Sécurité](docs/securite.md) | AIDA, Kali MCP, Burp, ZAP, Snyk, Shannon — outils de sécurité |

## Démarrage rapide

**3 choses à faire dès maintenant :**

1. **Créer `CLAUDE.md`** à la racine du projet → [guide](docs/bonnes-pratiques.md#claudemd)
2. **Installer RTK** pour économiser 60–90% de tokens → [guide](docs/mcp-servers.md#rtk)
3. **Ajouter SERENA** pour la mémoire de projet persistante → [guide](docs/mcp-servers.md#serena)

## Ce que contient ce dépôt

- [`docs/`](docs/) — cette documentation
- [`.claude/agents/`](.claude/agents/) — agents spécialisés prêts à l'emploi
- [`_claude/skills/`](_claude/skills/) — workflow de skills complet avec intégration SERENA

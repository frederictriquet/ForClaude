# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Présentation du dépôt

Ce dépôt est un recueil de bonnes pratiques et d'outils pour les développeurs utilisant Claude Code. Il contient uniquement de la documentation Markdown et des configurations — pas de code à compiler ni de tests à lancer.

**Documentation principale :** [`docs/`](docs/) — cinq guides thématiques lisibles indépendamment.

## Structure clé

```
docs/                        # Documentation principale (5 guides)
.claude/agents/              # Agents spécialisés (format YAML frontmatter + Markdown)
_claude/skills/              # Skills de workflow (format YAML frontmatter + Markdown)
  └── <nom>/SKILL.md         # Un dossier par skill
.serena/memories/            # Mémoires SERENA persistantes (pattern-, adr-, bug-, std-...)
_claude/settings.json        # Hooks de notification système
.claude/settings.local.json  # Permissions pré-approuvées (git, SERENA MCP)
```

## Ajouter une skill

Chaque skill suit ce format dans `_claude/skills/<nom>/SKILL.md` :

```markdown
---
name: <nom>
description: <une phrase>
argument-hint: [args] [--flag]
model: haiku | sonnet | opus
---

# Titre

$ARGUMENTS

## Sections structurées...
```

La skill doit proposer la prochaine étape du workflow dans un bloc de transition final. L'ordre canonique obligatoire est :

```
/implement → /test-write → /test-run → /quality-check → /code-review → /document → /capitalize → /roadmap-update --done → /pre-merge
```

Toute table de transition doit inclure une colonne `⛔ INTERDIT` contenant **au minimum** le skill immédiatement après le `Next` suggéré (règle du "one-step skip") et toujours `/pre-merge` sauf après `/roadmap-update --done`.

## Ajouter un agent

Chaque agent dans `.claude/agents/<nom>.md` suit ce format :

```markdown
---
name: <nom>
description: <déclencheurs d'activation explicites>
tools: all | [liste restrictive]
model: sonnet
---

# Nom

## One-Line Purpose
[Une phrase avec verbe d'action]

## Core Capabilities / When to Use / When NOT to Use
...
```

L'agent doit avoir une responsabilité unique. La description dans le frontmatter est ce que Claude utilise pour décider d'activer l'agent — elle doit être précise sur les triggers.

## SERENA MCP

SERENA est actif sur ce projet (permissions pré-approuvées dans `.claude/settings.local.json`). Les mémoires sont dans `.serena/memories/` avec des préfixes typés : `pattern-*`, `adr-*`, `bug-*`, `std-*`.

Pour consulter l'état du workflow en cours : lire `workflow-current.md` via SERENA.

## Conventions

- Tout le contenu est **en français**, y compris les nouvelles docs et les messages de commit
- Style : synthétique, orienté terrain, pas de blabla ni de listes exhaustives
- Ne pas dupliquer d'informations déjà présentes dans les fichiers `docs/`

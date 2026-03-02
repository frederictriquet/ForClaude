# Serveurs MCP

Les serveurs MCP (Model Context Protocol) étendent les capacités de Claude Code en lui donnant accès à des outils externes. C'est l'un des leviers les plus puissants de l'écosystème.

---

## SERENA — Mémoire de projet persistante

SERENA donne à Claude une mémoire structurée qui persiste entre les sessions. Il peut lire, écrire et rechercher dans des fichiers de mémoire typés, et naviguer dans le code symboliquement.

**Ce que ça change :** Claude n'oublie plus les décisions d'architecture, les patterns du projet, les bugs déjà résolus.

**Installation :**
```bash
cd <your-project>
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project $(pwd)
```

Puis dans Claude :
```
/status          # Vérifier que SERENA est actif
start Serena Onboarding
```

Et indexer le projet :
```bash
uvx --from git+https://github.com/oraios/serena serena project index
```

**Types de mémoires :**

| Préfixe | Usage |
|---------|-------|
| `pattern-*` | Solutions réutilisables |
| `adr-*` | Décisions architecturales (Architecture Decision Records) |
| `bug-*` | Bugs résolus et leurs solutions |
| `std-*` | Standards et conventions |
| `arch-*` | Documentation d'architecture |
| `postmortem-*` | Analyses d'incidents |

→ [GitHub oraios/serena](https://github.com/oraios/serena)

---

## RTK — Réduction de tokens

RTK (Rust Token Killer) est un proxy CLI qui filtre les sorties des commandes avant de les envoyer à Claude. Résultat : 60–90% de tokens économisés sur les opérations courantes.

**Fonctionnement :** le hook Claude Code intercepte automatiquement les commandes (`git status`, `ls`, `grep`…) et les passe à RTK qui retourne une version condensée.

**Installation :**
```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
rtk init --global   # installe le hook Claude Code + crée RTK.md
```

**Commandes clés :**
```bash
rtk gain            # voir les économies réalisées
rtk gain --history  # historique des commandes
rtk discover        # analyser l'historique Claude pour les opportunités manquées
```

→ [GitHub rtk-ai/rtk](https://github.com/rtk-ai/rtk)

---

## Context7 — Documentation live

Context7 injecte la documentation à jour des librairies directement dans le contexte de Claude. Fini les hallucinations sur les APIs qui ont changé depuis le cutoff.

**Installation :**
```
/plugin marketplace add pleaseai/context7
```

**Usage :** mentionner simplement la librairie dans ta question, Context7 injecte la doc pertinente automatiquement.

→ [Plugin Context7](https://context7.com)

---

## Autres outils notables

| Outil | Description | Lien |
|-------|-------------|------|
| **snip** | Gestionnaire de snippets pour Claude | [GitHub](https://github.com/edouard-claude/snip) |
| **firefox-devtools-mcp** | Accès aux DevTools Firefox depuis Claude | [GitHub](https://github.com/freema/firefox-devtools-mcp) |

---

## Configurer plusieurs MCP

Les serveurs MCP se déclarent dans `.claude/settings.json` ou via la commande `claude mcp add`. Ils sont actifs pour toute session dans le projet concerné.

Pour voir les MCP actifs : `/status` dans Claude Code.

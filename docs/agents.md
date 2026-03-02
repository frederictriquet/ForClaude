# Agents spécialisés

## Agents vs Skills vs Slash Commands

| Mécanisme | Définition | Usage typique |
|-----------|------------|---------------|
| **Agent** | Sous-processus autonome avec ses propres outils | Tâches parallèles, isolation du contexte |
| **Skill** | Prompt structuré définissant un workflow (`/analyze`, `/implement`…) | Étapes du cycle de développement |
| **Slash command** | Raccourci vers un prompt simple | Actions rapides (`/commit`, `/status`) |

---

## Agents disponibles dans ce dépôt

Placés dans `.claude/agents/`, ils sont automatiquement disponibles dans Claude Code.

| Agent | Rôle |
|-------|------|
| `agent-creator` | Conçoit des définitions d'agents efficaces |
| `tech-stack-advisor` | Recommande des technologies selon les contraintes |
| `svelte-specialist` | Applications Svelte/SvelteKit/TypeScript |
| `browser-extension-expert` | Extensions Chrome/Firefox, Manifest V3 |
| `rust-specialist` | Code Rust idiomatique et performant |
| `github-ci-specialist` | Workflows GitHub Actions |
| `gitlab-cicd-specialist` | Pipelines GitLab CI/CD |
| `kubernetes-migration-specialist` | Migration Docker → Kubernetes |
| `tech-learning-guide` | Apprendre de nouveaux langages et stacks |

---

## Créer un agent efficace

### Règles de base

- **Une responsabilité claire** — si tu ne peux pas expliquer l'agent en une phrase, c'est trop large
- **Verbes d'action** — "Analyse", "Génère", "Optimise" (pas "aide avec")
- **Frontières explicites** — ce qu'il fait ET ce qu'il ne fait PAS
- **Triggers précis** — quand l'utiliser vs les autres agents

### Structure minimale

```markdown
# Nom de l'agent

## Objectif
[Une phrase : ce que fait cet agent]

## Capacités
- [Capacité spécifique 1]
- [Capacité spécifique 2]

## Quand l'utiliser
- [Scénario 1]
- [Scénario 2]

## Quand NE PAS l'utiliser
- [Cas exclus]
```

### À éviter

- ❌ "Aide avec le code" → trop vague
- ❌ Deux agents qui font la même chose
- ❌ Promettre des capacités que l'agent n'a pas
- ❌ Un agent qui "fait tout"

---

## Le problème des fichiers fantômes (sub-agents)

**Symptôme fréquent :** un sous-agent confirme "J'ai créé le fichier X" mais le fichier n'existe pas. Cela arrive même après des rappels répétés.

**Cause :** les agents peuvent générer une réponse textuelle sans avoir réellement appelé les outils d'écriture. La confirmation est sincère mais fausse.

**Solutions :**

1. **Forcer les outils dans le prompt :**
```
Tu DOIS utiliser le Write tool pour chaque fichier.
Ne dis pas que tu as créé un fichier si tu n'as pas appelé Write tool.
```

2. **Vérifier systématiquement** — ne jamais faire confiance à la confirmation textuelle, lire le fichier après.

3. **Restreindre les outils disponibles** à l'agent pour éviter qu'il "imagine" des alternatives.

4. **Décomposer les tâches** — un agent qui doit créer 10 fichiers d'un coup est plus susceptible d'en rater. Mieux vaut des agents ciblés.

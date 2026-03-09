# Skills

Les skills sont des prompts réutilisables invocables via `/nom-de-la-skill`, built-in ou custom — voir la [doc officielle](https://docs.anthropic.com/en/docs/claude-code/skills).

## Référence

| Skill | Description |
|-------|-------------|
| `/simplify` | **Built-in Claude Code.** Review le code modifié pour détecter les opportunités de réutilisation, améliorer la qualité et l'efficacité, puis corrige automatiquement les problèmes trouvés. |
| `/batch` | **Built-in Claude Code.** Exécute un même prompt sur plusieurs fichiers en parallèle. Utile pour des modifications répétitives à grande échelle (renommage, refactoring, migrations). |
| `/debug [description]` | **Built-in Claude Code.** Diagnostic de Claude Code lui-même (pas de ton code). Lit le log de debug interne de la session pour expliquer un comportement inattendu : outil refusé, boucle, hook ou permission qui ne fonctionne pas. On peut préciser le problème : `/debug why is Claude not using the Read tool?` |
| `/loop [intervalle] <prompt>` | **Built-in Claude Code.** Exécute un prompt de façon récurrente tant que la session est ouverte. Utile pour surveiller un déploiement, babysitter une PR, ou relancer périodiquement une autre skill. Ex : `/loop 5m check if the deploy finished`. |

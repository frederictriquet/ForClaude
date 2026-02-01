# Guide des Skills de Développement

## Vue d'Ensemble

Ce projet dispose d'un ensemble de **14 skills atomiques** couvrant tout le cycle de développement. Chaque skill suit le Single Responsibility Principle et s'intègre avec SERENA pour capitaliser les apprentissages.

## Phases et Skills

### 1. Phase d'Analyse (avant de coder)

| Ordre | Skill | Quand l'utiliser |
|-------|-------|------------------|
| 1 | `/analyze` | Nouveau problème à comprendre |
| 2 | `/explore-options` | Plusieurs solutions possibles |
| 3 | `/tech-choice` | Décision technique à documenter |
| 4 | `/architecture` | Conception nécessaire avant implémentation |

### 2. Phase d'Implémentation

| Ordre | Skill | Quand l'utiliser |
|-------|-------|------------------|
| 5 | `/implement` | Écrire le code |
| 6 | `/test-write` | Écrire les tests |
| 7 | `/test-run` | Exécuter et valider les tests |
| 8 | `/debug` | Corriger un bug |

### 3. Phase de Validation

| Ordre | Skill | Quand l'utiliser |
|-------|-------|------------------|
| 9 | `/code-review` | Relire le code |
| 10 | `/document` | Documenter le code/API |
| 11 | `/pre-merge` | Préparer le merge/PR |

### 4. Phase de Capitalisation

| Ordre | Skill | Quand l'utiliser |
|-------|-------|------------------|
| 12 | `/roadmap-update` | Mettre à jour le statut d'une tâche |
| 13 | `/capitalize` | Sauvegarder un apprentissage |
| 14 | `/post-mortem` | Analyser un incident/session |

### Skills Utilitaires

- `/next` - **Rappeler le contexte et proposer la suite** (NOUVEAU)
- `/clean-code` - Nettoyer le code
- `/refactor` - Refactoriser
- `/explain-code` - Expliquer du code
- `/fix-issue` - Corriger une issue GitHub

## Continuité du Workflow

### Utilisation de `/next`

| Commande | Usage |
|----------|-------|
| `/next` | Voir le contexte et la prochaine étape |
| `/next --status` | Voir le status détaillé du workflow |
| `/next --reset` | Réinitialiser pour une nouvelle tâche |

### Tracking automatique

Chaque skill met à jour `workflow-current.md` dans SERENA avec :
- L'historique des skills exécutées
- Le contexte clé (décisions, fichiers, blocages)
- La prochaine étape suggérée

## Transitions Recommandées

```
/analyze → /explore-options → /tech-choice 
                                    ↓
                        /roadmap-update --in-progress
                                    ↓
                            /architecture → /implement
                                                  ↓
         /test-write ← /test-run ← /debug ← /code-review
                                                  ↓
                                            /document
                                                  ↓
                                           /capitalize
                                                  ↓
                                    /roadmap-update --done
                                                  ↓
                                           /pre-merge ← MERGE EN DERNIER !
                                                  ↓
                                         /post-mortem (si incident)
```

### Ordre de finalisation (après code-review)

⚠️ **Le merge arrive EN DERNIER** :
1. `/document` - Documenter
2. `/capitalize` - Sauvegarder les apprentissages  
3. `/roadmap-update --done` - Marquer comme terminé
4. `/pre-merge` - Merger

## Intégration SERENA

### Début de chaque skill
```
mcp__serena__list_memories
mcp__serena__read_memory
```
→ Consulter les connaissances existantes

### Fin de chaque skill
```
mcp__serena__write_memory
```
→ Capitaliser les nouvelles découvertes

### Types de mémoires

| Préfixe | Contenu |
|---------|---------|
| `pattern-` | Solutions réutilisables |
| `adr-` | Décisions architecturales |
| `bug-` | Résolutions de bugs |
| `std-` | Standards et conventions |
| `arch-` | Documentations d'architecture |
| `postmortem-` | Analyses d'incidents |

## Flags Courants

| Flag | Skills | Usage |
|------|--------|-------|
| `--tdd` | implement | Développement test-first |
| `--unit/integration/e2e` | test-write | Type de tests |
| `--security` | code-review | Focus sécurité |
| `--performance` | code-review | Focus performance |
| `--pr` | pre-merge | Créer une PR |
| `--blameless` | post-mortem | Sans blame |

## Gestion de la Roadmap

| Moment | Commande |
|--------|----------|
| Début de tâche | `/roadmap-update [tâche] --in-progress` |
| Blocage rencontré | `/roadmap-update [tâche] --blocked "[raison]"` |
| Fin de tâche | `/roadmap-update [tâche] --done` |

## Gestion des Branches

### Vérification obligatoire au début du workflow

| Si sur... | Action |
|-----------|--------|
| `main` ou `master` | Créer une branche feature |
| `develop` | Selon conventions |
| `feature/xxx` | ✅ OK |

### Conventions de nommage

- `feature/[description]` - Nouvelles fonctionnalités
- `fix/[description]` - Corrections de bugs
- `refactor/[description]` - Refactoring

## Bonnes Pratiques

1. **Vérifier la branche** avant de coder
2. **Toujours consulter SERENA** avant de commencer
2. **Suivre les transitions** suggérées par chaque skill
3. **Mettre à jour la roadmap** au début et à la fin de chaque tâche
4. **Capitaliser systématiquement** les découvertes
5. **Utiliser les flags** appropriés pour adapter le comportement

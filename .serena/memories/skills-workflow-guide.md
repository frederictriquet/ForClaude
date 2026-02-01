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
| 12 | `/capitalize` | Sauvegarder un apprentissage |
| 13 | `/post-mortem` | Analyser un incident/session |

### Skills Utilitaires

- `/clean-code` - Nettoyer le code
- `/refactor` - Refactoriser
- `/explain-code` - Expliquer du code
- `/fix-issue` - Corriger une issue GitHub

## Transitions Recommandées

```
/analyze → /explore-options → /tech-choice → /architecture → /implement
                                                                  ↓
/pre-merge ← /code-review ← /debug ← /test-run ← /test-write ← ┘
     ↓
/document → /capitalize → /post-mortem (si incident)
```

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

## Bonnes Pratiques

1. **Toujours consulter SERENA** avant de commencer
2. **Suivre les transitions** suggérées par chaque skill
3. **Capitaliser systématiquement** les découvertes
4. **Utiliser les flags** appropriés pour adapter le comportement

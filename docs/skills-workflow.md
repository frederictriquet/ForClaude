# Workflow de Skills

Un système de skills atomiques couvrant tout le cycle de développement.
Chaque skill = une phase. Transitions explicites entre chaque étape.

## Le workflow

```
/analyze → /explore-options → /tech-choice → /architecture
                                                    ↓
/implement → /test-write → /test-run → /quality-check → /code-review
                                                              ↓
                                          /document → /capitalize → /roadmap-update --done → /pre-merge
```

> `/pre-merge` est toujours la **dernière** étape. On ne merge pas avant d'avoir documenté et capitalisé.

### Boucles de rétroaction

Après `/code-review` avec corrections demandées :
```
corrections → /implement ou /test-write → /test-run → /quality-check → /code-review (re-review)
```

---

## Référence des skills

### Analyse
| Skill | Description |
|-------|-------------|
| `/analyze` | Comprendre le problème avant de coder |
| `/explore-options` | Explorer les différentes solutions |
| `/tech-choice` | Documenter une décision technique (ADR) |
| `/architecture` | Concevoir la structure avant d'implémenter |

### Implémentation
| Skill | Flags utiles |
|-------|-------------|
| `/implement` | `--tdd`, `--incremental` |
| `/test-write` | `--unit`, `--integration`, `--e2e` |
| `/test-run` | `--watch`, `--coverage` |
| `/quality-check` | `--fix`, `--strict` |
| `/debug` | `--verbose` |

### Validation & finalisation
| Skill | Flags utiles |
|-------|-------------|
| `/code-review` | `--security`, `--performance`, `--thorough` |
| `/document` | `--api`, `--readme`, `--inline` |
| `/capitalize` | `--pattern`, `--adr`, `--bug` |
| `/roadmap-update` | `--done`, `--in-progress`, `--blocked` |
| `/pre-merge` | `--pr`, `--squash` |

### Utilitaires
| Skill | Description |
|-------|-------------|
| `/next` | Rappelle le contexte et propose la prochaine étape |
| `/refactor` | Refactorise sans changer le comportement |
| `/clean-code` | Nettoie la maintenabilité après une session intensive |
| `/post-mortem` | Analyse un incident ou une session |

---

## Le piège de l'échappement

**Symptôme :** Claude propose de sauter des étapes ou de passer directement à `/pre-merge` après `/implement`.

C'est le problème le plus fréquent avec ce workflow. Causes possibles :
- L'ordre des étapes n'est pas assez visible dans le prompt
- Claude "optimise" en sautant ce qui lui semble redondant
- Le contexte de la conversation s'est allongé et les règles sont oubliées

**Solutions :**

1. **Utiliser `/next`** — rappelle explicitement où on en est et quelle est la prochaine étape obligatoire
2. **Les gates** — chaque skill vérifie les prérequis via `workflow-current.md` (SERENA)
3. **Rappeler explicitement l'ordre** si nécessaire : "Nous sommes après /test-run, l'étape suivante est /quality-check"

---

## Intégration SERENA

Chaque skill utilise SERENA pour :
- **Consulter** les mémoires existantes au début (patterns, ADR, bugs connus)
- **Mettre à jour** `workflow-current.md` pour tracker la progression
- **Capitaliser** les découvertes à la fin

Le fichier `workflow-current.md` est la source de vérité de l'état du workflow en cours.

---

## Exemple : nouvelle feature

```bash
/analyze "ajouter l'authentification OAuth"
/explore-options OAuth providers
/tech-choice Auth0
/roadmap-update "Auth OAuth" --in-progress
/architecture module auth
/implement auth-module --tdd
/test-write auth-module --unit --integration
/test-run auth --coverage
/quality-check
/code-review auth-module --security
/document auth-module --api
/capitalize OAuth integration --pattern
/roadmap-update "Auth OAuth" --done
/pre-merge --pr
```

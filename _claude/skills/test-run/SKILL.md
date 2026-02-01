---
name: test-run
description: Exécute les tests et analyse les résultats pour identifier les problèmes
argument-hint: [pattern-de-test] [--watch] [--coverage] [--verbose]
model: haiku
---

# Exécution des Tests

Exécute et analyse les tests pour :

$ARGUMENTS

## Objectif

Exécuter les tests de manière **efficace**, analyser les échecs, et fournir un diagnostic clair.

---

## 0. Consultation SERENA

### Avant l'exécution

```
mcp__serena__search_for_pattern - Trouver la config de test
mcp__serena__list_memories - Commandes de test du projet
```

### Identifier la commande de test

| Framework | Commande typique |
|-----------|------------------|
| Jest | `npm test` ou `jest` |
| Vitest | `npm test` ou `vitest` |
| Mocha | `npm test` ou `mocha` |
| pytest | `pytest` |
| cargo | `cargo test` |
| go | `go test ./...` |

---

## 1. Exécution Ciblée

### Options de filtrage

```bash
# Tests spécifiques
npm test -- --testPathPattern="feature"
npm test -- -t "should handle error"

# Fichier spécifique
npm test -- path/to/test.ts

# Avec watch mode
npm test -- --watch

# Avec couverture
npm test -- --coverage
```

### Mode verbose (`--verbose`)

```bash
npm test -- --verbose
```

---

## 2. Analyse des Résultats

### Statuts possibles

| Statut | Signification | Action |
|--------|---------------|--------|
| ✅ PASS | Test réussi | Continuer |
| ❌ FAIL | Assertion échouée | Investiguer |
| ⏭️ SKIP | Test ignoré | Vérifier pourquoi |
| ⏱️ TIMEOUT | Dépassement de temps | Optimiser ou augmenter timeout |
| 💥 ERROR | Erreur d'exécution | Corriger le test ou le code |

### Format de rapport

```markdown
## Résultats des Tests

**Exécutés** : X tests
**Réussis** : Y (Z%)
**Échoués** : N

### Tests échoués

#### 1. `[nom du test]`
- **Fichier** : path/to/test.ts:42
- **Erreur** : [message d'erreur]
- **Expected** : [valeur attendue]
- **Received** : [valeur reçue]
- **Diagnostic** : [analyse probable]

#### 2. ...
```

---

## 3. Diagnostic des Échecs

### Catégories d'échecs

| Type | Symptôme | Cause probable |
|------|----------|----------------|
| **Assertion** | Expected vs Received | Logique incorrecte ou test incorrect |
| **Timeout** | Test hangs | Async non résolu, boucle infinie |
| **Reference** | undefined/null | Dépendance manquante, mock incomplet |
| **Type** | Type mismatch | Interface changée |
| **Connection** | ECONNREFUSED | Service externe non disponible |

### Analyse approfondie

Pour chaque échec :

1. **Lire le message d'erreur** complet
2. **Identifier la ligne** dans le test
3. **Examiner le code testé** via SERENA :
   ```
   mcp__serena__find_symbol - Trouver la fonction testée
   mcp__serena__get_symbols_overview - Contexte du fichier
   ```
4. **Proposer une hypothèse** de cause
5. **Suggérer la correction**

---

## 4. Tests Flaky (Instables)

### Détection

```bash
# Exécuter plusieurs fois
for i in {1..5}; do npm test -- path/to/test.ts; done
```

### Causes courantes

| Cause | Solution |
|-------|----------|
| Race condition | Ajouter await/waitFor |
| Dépendance à l'ordre | Isoler les tests |
| Date/heure | Mock le temps |
| Random | Seed déterministe |
| État partagé | Reset dans beforeEach |

---

## 5. Couverture (`--coverage`)

### Analyser la couverture

```bash
npm test -- --coverage
```

### Rapport de couverture

```markdown
## Couverture de Code

| Fichier | Statements | Branches | Functions | Lines |
|---------|------------|----------|-----------|-------|
| file1.ts | 95% | 90% | 100% | 95% |
| file2.ts | 60% | 45% | 70% | 62% |

### Zones non couvertes

- `file2.ts:42-50` : Bloc catch jamais atteint
- `file2.ts:78` : Branche else non testée
```

### Recommandations

| Couverture | Action |
|------------|--------|
| > 85% | ✅ Excellent |
| 70-85% | 🟡 Acceptable, améliorer si critique |
| < 70% | 🔴 Insuffisant, ajouter des tests |

---

## 6. Performance des Tests

### Métriques

```markdown
## Performance

**Durée totale** : X.XX secondes
**Tests les plus lents** :
1. `test name 1` - X.XXs
2. `test name 2` - X.XXs
3. `test name 3` - X.XXs
```

### Optimisations

| Problème | Solution |
|----------|----------|
| Tests lents | Paralléliser, mocker I/O |
| Setup lourd | Réutiliser entre tests |
| Mocks lents | Simplifier les mocks |
| Trop de tests | Prioriser les critiques |

---

## 7. Mode Watch (`--watch`)

### Utilisation

```bash
npm test -- --watch
```

### Commandes interactives (Jest)

| Touche | Action |
|--------|--------|
| `a` | Exécuter tous les tests |
| `f` | Exécuter uniquement les échecs |
| `p` | Filtrer par pattern de fichier |
| `t` | Filtrer par nom de test |
| `q` | Quitter |

---

## 8. Intégration Continue

### Vérification CI-compatible

```bash
# Exit code non-zero si échecs
npm test -- --ci --coverage --reporters=default --reporters=jest-junit
```

### Artefacts à générer

- [ ] Rapport de couverture (HTML/LCOV)
- [ ] Rapport JUnit (pour CI)
- [ ] Screenshots (pour E2E)

---

## 9. Rapport Final

### Template de rapport

```markdown
# Rapport d'Exécution des Tests

## Résumé
- **Date** : [timestamp]
- **Durée** : X secondes
- **Résultat** : ✅ PASS / ❌ FAIL

## Statistiques
| Métrique | Valeur |
|----------|--------|
| Total | X |
| Passés | Y |
| Échoués | Z |
| Ignorés | W |
| Couverture | N% |

## Détails des Échecs
[Si applicable]

## Recommandations
[Actions suggérées]

## Prochaine Étape
[debug | implement | code-review | pre-merge]
```

---

## 10. Capitalisation SERENA

### Si patterns récurrents identifiés

```
mcp__serena__write_memory
```

**À capitaliser :**
- Erreurs de test fréquentes et solutions
- Configuration de test optimale
- Patterns de tests flaky résolus

---

## Transition vers la prochaine phase

| Résultat | Prochaine skill |
|----------|-----------------|
| ❌ Tests échouent | `/debug` |
| 🟡 Couverture insuffisante | `/test-write` |
| ✅ Tous les tests passent | `/code-review` ou `/pre-merge` |

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /test-run [✅|❌|🟡]
  → Noter la couverture dans "Contexte Clé"
  → Lister les échecs éventuels dans "Blocages"
```

2. **Afficher le résumé de transition** :
```markdown
---
## [✅|❌|🟡] Tests Exécutés

**Résultat** : X/Y passés (Z%)
**Couverture** : XX%

[Si échecs:]
**Tests échoués** :
- `test name` - [raison courte]

→ **Prochaine étape** :
  - Si ✅ : `/code-review` ou `/pre-merge --pr`
  - Si ❌ : `/debug [test échoué]`
  - Si 🟡 couverture basse : `/test-write [module]`

💡 `/next` pour voir le workflow complet
---
```

3. **Toujours proposer l'action suivante** en fonction du résultat des tests

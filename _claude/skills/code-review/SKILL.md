---
name: code-review
description: Effectue une revue de code approfondie avec feedback constructif
argument-hint: [fichier-ou-PR] [--security] [--performance] [--thorough]
model: opus
---

# Code Review

Effectue une revue de code pour :

$ARGUMENTS

## Objectif

Identifier les problèmes **avant** qu'ils n'arrivent en production, tout en fournissant un feedback constructif et éducatif.

---

## 0. Consultation SERENA

### Contexte du projet

```
mcp__serena__list_memories - Standards et conventions du projet
mcp__serena__read_memory - ADR et décisions architecturales
mcp__serena__search_for_pattern - Patterns établis à respecter
```

### Questions préliminaires

1. Quelles sont les conventions de code du projet ?
2. Y a-t-il des patterns architecturaux à respecter ?
3. Quels types de problèmes ont été identifiés précédemment ?

---

## 1. Vue d'Ensemble

### Première lecture

```
mcp__serena__get_symbols_overview - Structure des changements
mcp__serena__find_symbol - Comprendre les nouvelles entités
```

### Questions de contexte

| Question | Réponse |
|----------|---------|
| Quel est l'objectif du changement ? | ... |
| Quelle est la taille du changement ? | ... fichiers, ... lignes |
| Y a-t-il des tests ? | Oui / Non / Partiellement |
| La documentation est-elle à jour ? | Oui / Non / N/A |

---

## 2. Checklist Principale

### Correctness (Exactitude)

- [ ] Le code fait ce qu'il est censé faire
- [ ] Les edge cases sont gérés
- [ ] La logique est correcte
- [ ] Pas de bugs évidents

### Security (Sécurité) [`--security`]

- [ ] Pas de secrets hard-codés
- [ ] Validation des entrées utilisateur
- [ ] Protection contre les injections
- [ ] Authentification/autorisation respectée

### Performance [`--performance`]

- [ ] Pas de N+1 queries
- [ ] Pas de boucles inutiles sur grandes collections
- [ ] Caching approprié
- [ ] Complexité algorithmique acceptable

### Maintainability (Maintenabilité)

- [ ] Code lisible et compréhensible
- [ ] Noms de variables/fonctions clairs
- [ ] Fonctions courtes et focalisées
- [ ] Pas de duplication

### Testing

- [ ] Tests présents et pertinents
- [ ] Couverture suffisante des nouveaux chemins
- [ ] Tests lisibles et maintenables

---

## 3. Analyse Détaillée

### Pour chaque fichier modifié

```markdown
### Fichier : `path/to/file.ts`

#### Changements
[Résumé des modifications]

#### Points positifs ✅
- [Ce qui est bien fait]
- [Bonnes pratiques respectées]

#### Points à améliorer 🔧
- [Suggestion d'amélioration]
- [Problème potentiel]

#### Problèmes critiques 🚨
- [Ce qui doit absolument être corrigé]
```

---

## 4. Catégories de Feedback

### Niveaux de sévérité

| Niveau | Icône | Signification | Action requise |
|--------|-------|---------------|----------------|
| **Blocker** | 🚨 | Empêche le merge | Obligatoire |
| **Major** | ⚠️ | Problème significatif | Fortement recommandé |
| **Minor** | 💡 | Amélioration possible | Optionnel |
| **Nitpick** | 📝 | Style/préférence | À discrétion |
| **Question** | ❓ | Besoin de clarification | Réponse attendue |
| **Praise** | 👍 | Point positif | - |

### Format de commentaire

```markdown
**[🚨 BLOCKER]** `file.ts:42`
Le password est loggé en clair.

**Problème** : Fuite potentielle de données sensibles dans les logs.

**Suggestion** :
```typescript
// Avant
logger.info('Login attempt', { password });

// Après
logger.info('Login attempt', { email: user.email });
```
```

---

## 5. Analyse de Sécurité (`--security`)

### Points de vérification

| Catégorie | Vérification |
|-----------|--------------|
| **Injection** | SQL, NoSQL, Command, LDAP |
| **XSS** | Échappement des outputs HTML |
| **CSRF** | Tokens de protection |
| **Auth** | Vérification des permissions |
| **Crypto** | Algorithmes sûrs, pas de custom crypto |
| **Secrets** | Pas de credentials en dur |
| **Data** | Données sensibles protégées |

### Rapport de sécurité

```markdown
## Analyse de Sécurité

### Risques identifiés
| Risque | Sévérité | Localisation |
|--------|----------|--------------|
| ... | Haute/Moyenne/Basse | file.ts:XX |

### Recommandations
1. ...
2. ...
```

---

## 6. Analyse de Performance (`--performance`)

### Points de vérification

| Pattern | Problème | Solution |
|---------|----------|----------|
| N+1 queries | Multiple requêtes en boucle | Eager loading, batch |
| Large arrays | `.filter().map().find()` | Combinaison ou early exit |
| Unbounded | Liste sans limite | Pagination, streaming |
| Memory | Accumulation en mémoire | Streaming, chunks |
| Sync I/O | Blocage du thread | Async I/O |

### Rapport de performance

```markdown
## Analyse de Performance

### Hotspots potentiels
| Localisation | Problème | Impact estimé |
|--------------|----------|---------------|
| file.ts:XX | N+1 query | O(n) → O(1) possible |

### Recommandations
1. ...
```

---

## 7. Review Approfondie (`--thorough`)

### Analyse architecturale

```
mcp__serena__find_referencing_symbols - Impact des changements
mcp__serena__find_symbol - Cohérence avec l'existant
```

### Points additionnels

- [ ] Cohérence avec l'architecture existante
- [ ] Respect des patterns du projet
- [ ] Impact sur les autres modules
- [ ] Évolutivité de la solution
- [ ] Dette technique introduite

---

## 8. Feedback Constructif

### Règles de communication

| ❌ À éviter | ✅ Préférer |
|------------|-------------|
| "C'est mauvais" | "Ceci pourrait poser problème car..." |
| "Tu aurais dû..." | "Une alternative serait..." |
| "Pourquoi tu as fait ça ?" | "Peux-tu expliquer le choix de... ?" |
| "C'est faux" | "Je crois qu'il y a une erreur ici" |

### Structure d'un bon feedback

1. **Contexte** : Où est le problème
2. **Observation** : Ce que vous voyez
3. **Impact** : Pourquoi c'est un problème
4. **Suggestion** : Comment améliorer
5. **Exemple** : Code concret si possible

---

## 9. Rapport de Review

### Template de rapport

```markdown
# Code Review : [Titre/PR]

## Résumé
- **Fichiers reviewés** : X
- **Lignes ajoutées/modifiées** : +X / -Y
- **Verdict** : ✅ Approuvé / 🔄 Changements requis / ❌ Rejeté

## Vue d'ensemble
[Description générale des changements et de leur qualité]

## Points positifs 👍
- [Ce qui est bien fait]
- [Bonnes pratiques notées]

## Changements requis 🚨
1. [Blocker 1] - `file.ts:XX`
2. [Blocker 2] - `file.ts:YY`

## Suggestions d'amélioration 💡
1. [Suggestion 1]
2. [Suggestion 2]

## Questions ❓
1. [Question 1]

## Checklist de validation
- [ ] Tous les blockers sont résolus
- [ ] Les tests passent
- [ ] La documentation est à jour
```

---

## 10. Suivi des Commentaires

### Tracking des issues

| # | Fichier | Ligne | Sévérité | Statut |
|---|---------|-------|----------|--------|
| 1 | file.ts | 42 | 🚨 | Ouvert |
| 2 | file.ts | 78 | ⚠️ | Résolu |
| 3 | util.ts | 15 | 💡 | Won't fix |

---

## 11. Capitalisation SERENA

### Patterns identifiés à documenter

```
mcp__serena__write_memory
```

**À capitaliser :**
- Problèmes récurrents observés
- Bonnes pratiques à promouvoir
- Anti-patterns à éviter
- Standards de code à formaliser

### Format de mémoire

```markdown
# Review Patterns : [Domaine]

## Problèmes fréquents
- [Pattern 1] : [Solution recommandée]
- [Pattern 2] : [Solution recommandée]

## Bonnes pratiques observées
- [Pratique à reproduire]

## Standards à ajouter
- [Nouveau standard suggéré]
```

---

## 12. Décision Finale

### Critères de décision

| Verdict | Conditions |
|---------|------------|
| ✅ **Approuvé** | Pas de blockers, mineurs acceptables |
| 🔄 **Changements requis** | Blockers ou majeurs présents |
| ❌ **Rejeté** | Problèmes fondamentaux, refonte nécessaire |

### Après la review

- [ ] Communiquer le verdict clairement
- [ ] Être disponible pour les questions
- [ ] Re-reviewer après corrections

---

## Transition vers la prochaine phase

| Verdict | Prochaine skill |
|---------|-----------------|
| ✅ Approuvé | `/pre-merge` |
| 🔄 Changements requis | Auteur corrige → Re-review |
| Problèmes de tests | `/test-write` ou `/test-run` |
| Bugs trouvés | `/debug` |
| Architecture à revoir | `/architecture` |

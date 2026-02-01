---
name: debug
description: Diagnostique et corrige un bug de manière méthodique
argument-hint: [description-du-bug] [--verbose]
model: opus
---

# Debugging

Diagnostique et corrige le problème suivant :

$ARGUMENTS

## Objectif

Identifier la **cause racine** du bug et le corriger de manière durable, pas juste les symptômes.

---

## ⛔ LIMITES STRICTES DE CETTE SKILL

### ✅ CE QUE CETTE SKILL FAIT
- Reproduire le bug
- Analyser les logs et stack traces
- Isoler la cause racine
- Corriger le bug spécifique
- Ajouter un test de régression

### ❌ CE QUE CETTE SKILL NE FAIT PAS
- **PAS de refactoring** : Corriger le bug, pas réécrire le module
- **PAS de nouvelles features** : Corriger, pas améliorer
- **PAS de changement d'architecture** : Fix minimal
- **PAS d'optimisation** : Corriger le comportement, pas la performance
- **PAS de documentation générale** : Juste documenter le bug si complexe

### 🛑 SI TU ES TENTÉ DE REFACTORER
STOP ! Corrige le bug minimalement. Propose `/refactor` après si nécessaire.

### 🛑 SI LE BUG RÉVÈLE UN PROBLÈME D'ARCHITECTURE
STOP ! Note le problème, corrige le symptôme, et propose `/architecture` pour une vraie solution.

---

---

## 0. Consultation SERENA

### Recherche de contexte

```
mcp__serena__search_for_pattern - Chercher des bugs similaires résolus
mcp__serena__list_memories - Solutions passées documentées
mcp__serena__read_memory - Lire les post-mortems pertinents
```

### Questions préliminaires

1. Ce bug a-t-il déjà été rencontré ?
2. Y a-t-il des patterns de bugs documentés pour ce module ?
3. Quelles solutions ont fonctionné précédemment ?

---

## 1. Collecte d'Informations

### Le bug en détail

```markdown
## Description du Bug

**Comportement observé** :
[Ce qui se passe]

**Comportement attendu** :
[Ce qui devrait se passer]

**Étapes de reproduction** :
1. ...
2. ...
3. ...

**Fréquence** : [Toujours | Parfois | Rarement]

**Environnement** :
- OS : ...
- Version : ...
- Configuration : ...
```

### Logs et erreurs

```markdown
## Informations Techniques

**Message d'erreur** :
```
[copier l'erreur exacte]
```

**Stack trace** :
```
[si disponible]
```

**Logs pertinents** :
```
[extraits de logs]
```
```

---

## 2. Reproduction

### Créer un cas de test minimal

```typescript
// Reproduction minimale
it('reproduces the bug', () => {
  // Setup minimal
  const input = { /* minimal data causing bug */ };

  // Action qui déclenche le bug
  const result = buggyFunction(input);

  // Ce qui échoue
  expect(result).toBe(expected); // FAIL
});
```

### Si non reproductible

- [ ] Vérifier les données d'entrée
- [ ] Vérifier l'état initial
- [ ] Vérifier les conditions de concurrence
- [ ] Vérifier les dépendances externes

---

## 3. Analyse Méthodique

### Méthode scientifique

```
1. OBSERVER  : Collecter les faits (logs, comportement)
2. HYPOTHÈSE : Formuler une théorie sur la cause
3. PRÉDIRE   : Que devrait-il se passer si l'hypothèse est vraie ?
4. TESTER    : Vérifier la prédiction
5. CONCLURE  : Confirmer ou rejeter l'hypothèse
6. RÉPÉTER   : Si rejeté, nouvelle hypothèse
```

### Exploration du code

```
mcp__serena__find_symbol - Trouver les fonctions suspectes
mcp__serena__find_referencing_symbols - Comprendre qui appelle quoi
mcp__serena__get_symbols_overview - Vue d'ensemble du module
```

---

## 4. Techniques de Debug

### Isolation (Divide and Conquer)

```
┌─────────────────────────────┐
│      Code complet           │
└─────────────────────────────┘
              ↓
┌──────────┐  │  ┌───────────┐
│ Moitié A │  │  │ Moitié B  │  ← Bug dans quelle moitié ?
└──────────┘     └───────────┘
              ↓
    ┌──────┐  │  ┌───────┐
    │ A.1  │  │  │ A.2   │      ← Continuer à réduire
    └──────┘     └───────┘
```

### Traçage

```typescript
// Ajouter des logs temporaires
console.log('[DEBUG] Entering function', { param1, param2 });
console.log('[DEBUG] State before:', JSON.stringify(state));
console.log('[DEBUG] State after:', JSON.stringify(state));
```

### Assertions intermédiaires

```typescript
// Vérifier les invariants
function process(data) {
  assert(data !== null, 'data should not be null');
  assert(data.items.length > 0, 'items should not be empty');
  // ...
}
```

---

## 5. Causes Courantes

### Checklist de causes fréquentes

| Catégorie | Vérifications |
|-----------|---------------|
| **Null/Undefined** | Accès à propriété inexistante, optional chaining |
| **Type mismatch** | String vs Number, formats de date |
| **State mutation** | Mutation d'objet partagé, référence vs valeur |
| **Async issues** | Race condition, promesse non attendue |
| **Edge cases** | Collections vides, valeurs limites |
| **Dependencies** | Version incompatible, config manquante |
| **Environment** | Variables d'env, chemins de fichiers |
| **Cache** | Données périmées, invalidation manquante |

### Questions diagnostiques

- [ ] Le bug est-il apparu après un changement récent ?
- [ ] Le bug se produit-il dans tous les environnements ?
- [ ] Le bug est-il lié à des données spécifiques ?
- [ ] Le bug est-il lié au timing/concurrence ?

---

## 6. Utilisation des Outils

### Debugger

```typescript
// Point d'arrêt programmatique
debugger;

// Ou utiliser l'IDE :
// - Breakpoints
// - Step over/into/out
// - Watch expressions
// - Call stack inspection
```

### Profiling (si performance)

```typescript
// Mesurer le temps
console.time('operation');
// ... code à mesurer
console.timeEnd('operation');

// Ou utiliser les DevTools Performance
```

---

## 7. Identification de la Cause Racine

### Template de diagnostic

```markdown
## Diagnostic

### Symptôme
[Ce qui est observé]

### Cause immédiate
[Ce qui provoque directement le symptôme]

### Cause racine
[La vraie raison sous-jacente]

### Chaîne causale
1. [Cause racine] →
2. [Effet intermédiaire] →
3. [Symptôme observé]
```

### Technique des 5 Pourquoi

```
Bug : L'application crash au login

1. Pourquoi ? → Le token est null
2. Pourquoi ? → La réponse API est vide
3. Pourquoi ? → Le header d'auth est manquant
4. Pourquoi ? → La config n'est pas chargée
5. Pourquoi ? → L'init async n'est pas attendue ← CAUSE RACINE
```

---

## 8. Correction

### Principes de correction

1. **Corriger la cause racine**, pas le symptôme
2. **Minimiser le changement** (éviter les régressions)
3. **Ajouter un test** qui aurait attrapé le bug
4. **Vérifier les impacts** sur le reste du code

### Checklist de correction

- [ ] Le test de reproduction passe maintenant
- [ ] Les tests existants passent toujours
- [ ] Pas de nouveaux warnings
- [ ] Le fix est documenté si complexe
- [ ] Le code de debug temporaire est supprimé

---

## 9. Vérification

### Avant de conclure

```bash
# Exécuter tous les tests
npm test

# Vérifier les types
npm run typecheck

# Vérifier le lint
npm run lint

# Tester manuellement la reproduction
# [étapes de reproduction] → ✅ Bug résolu
```

### Régression check

- [ ] Fonctionnalité principale OK
- [ ] Cas limites OK
- [ ] Autres parties du système OK

---

## 10. Documentation

### Note de résolution

```markdown
## Résolution du Bug

### Bug
[Description brève]

### Cause
[Cause racine identifiée]

### Solution
[Ce qui a été changé]

### Test ajouté
[Référence au test]

### Impact
[Fichiers modifiés, risques de régression]
```

---

## 11. Capitalisation SERENA

### Sauvegarder la résolution

```
mcp__serena__write_memory
```

**Nom** : `bug-[YYYY-MM-DD]-[description-courte].md`

**Contenu** :

```markdown
# Bug : [Titre descriptif]

## Date : YYYY-MM-DD

## Symptôme
[Ce qui était observé]

## Cause racine
[La vraie cause]

## Solution
[Le fix appliqué]

## Leçons apprises
- [Ce qu'on peut faire pour éviter ce bug à l'avenir]
- [Patterns à surveiller]

## Tests ajoutés
- [Nom du test]
```

### Patterns à documenter

- Bugs récurrents dans un module
- Causes de bugs non évidentes
- Solutions contre-intuitives

---

## 12. Prévention Future

### Actions préventives

| Type de bug | Prévention |
|-------------|------------|
| Null access | Optional chaining, strict null checks |
| Type errors | TypeScript strict mode |
| Async issues | Lint rules pour async/await |
| Edge cases | Tests de propriété (property-based) |

### Améliorations suggérées

- [ ] Ajouter une règle de lint ?
- [ ] Améliorer la validation d'entrée ?
- [ ] Ajouter du logging ?
- [ ] Documenter un piège ?

---

## Transition vers la prochaine phase

| Situation | Prochaine skill |
|----------|-----------------|
| Bug corrigé, besoin de tests | `/test-write` |
| Bug corrigé, tests passent | `/test-run` |
| Correction complexe | `/code-review` |
| Plusieurs bugs liés | `/post-mortem` |
| Bug dans l'architecture | `/architecture` |

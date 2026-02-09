---
name: refactor
description: Refactorise du code en améliorant sa qualité sans changer son comportement
argument-hint: [fichier-ou-fonction] [--extract] [--rename] [--simplify]
model: sonnet
---

# Refactoring

Refactorise le code suivant :

$ARGUMENTS

## Objectif

Améliorer la **qualité interne** du code sans modifier son comportement externe observable.

---

## ⛔ LIMITES STRICTES DE CETTE SKILL

### ✅ CE QUE CETTE SKILL FAIT
- Extraire des fonctions trop longues
- Renommer des variables/fonctions peu claires
- Simplifier des conditions complexes
- Éliminer la duplication (DRY)
- Supprimer le code mort
- Réorganiser la structure

### ❌ CE QUE CETTE SKILL NE FAIT PAS
- **PAS de nouvelles features** : Refactorer, pas ajouter
- **PAS de fix de bugs** : Si bug trouvé → `/debug`
- **PAS de changement de comportement** : Le comportement externe reste identique
- **PAS de changement d'architecture** : Pour ça → `/architecture`
- **PAS d'optimisation de performance** : Sauf si triviale

### 🛑 SI TU ES TENTÉ DE CHANGER LE COMPORTEMENT
STOP ! Le refactoring ne change pas ce que fait le code, seulement comment il le fait.

---

## 0. Vérification des Prérequis (RECOMMANDÉ)

### Vérifier que des tests existent

```bash
# Chercher les tests pour le fichier/module à refactorer
```

### ⚠️ SI PAS DE TESTS

```markdown
⚠️ **ATTENTION : Pas de tests pour ce code**

Refactorer sans tests est risqué. Options :
1. Écrire des tests d'abord → `/test-write [fichier]` puis revenir
2. Continuer avec prudence (non recommandé)
3. Refactoring minimal uniquement (renommage, formatage)

→ Que souhaitez-vous faire ?
```

---

## 0b. Consultation SERENA

### Analyse préalable

```
mcp__serena__get_symbols_overview - Structure actuelle
mcp__serena__find_symbol - Comprendre le code à refactorer
mcp__serena__find_referencing_symbols - Identifier les dépendances
mcp__serena__list_memories - Standards de code du projet
```

### Questions à résoudre

1. Quels patterns de code sont utilisés dans le projet ?
2. Y a-t-il des conventions de nommage à respecter ?
3. Ce code est-il utilisé ailleurs ?

---

## 1. Principes de Refactoring

### Règles d'or

| Principe | Application |
|----------|-------------|
| **Petits pas** | Un changement à la fois, tester entre chaque |
| **Tests verts** | Les tests doivent passer avant ET après |
| **Même comportement** | L'output ne change pas |
| **Amélioration mesurable** | Le code doit être objectivement meilleur |

### Métriques de qualité

| Métrique | Avant | Après | Objectif |
|----------|-------|-------|----------|
| Lignes par fonction | ? | ? | < 20 |
| Complexité cyclomatique | ? | ? | < 10 |
| Profondeur d'imbrication | ? | ? | < 3 |
| Duplication | ? | ? | 0 |

---

## 2. Techniques de Refactoring

### Extract Function (`--extract`)

```typescript
// Avant
function processOrder(order) {
  // 50 lignes de code...
  const tax = order.subtotal * 0.2;
  const shipping = order.weight * 0.5 + 5;
  const total = order.subtotal + tax + shipping;
  // 30 lignes de plus...
}

// Après
function processOrder(order) {
  // ...
  const total = calculateTotal(order);
  // ...
}

function calculateTotal(order) {
  const tax = calculateTax(order.subtotal);
  const shipping = calculateShipping(order.weight);
  return order.subtotal + tax + shipping;
}
```

### Rename (`--rename`)

```typescript
// Avant
const d = new Date();
const x = users.filter(u => u.a > 18);

// Après
const currentDate = new Date();
const adultUsers = users.filter(user => user.age > 18);
```

### Simplify Conditionals (`--simplify`)

```typescript
// Avant
if (user !== null && user !== undefined) {
  if (user.isActive === true) {
    if (user.role === 'admin' || user.role === 'superadmin') {
      // ...
    }
  }
}

// Après
const isActiveAdmin = user?.isActive && ['admin', 'superadmin'].includes(user.role);
if (isActiveAdmin) {
  // ...
}
```

### Remove Duplication

```typescript
// Avant
function getAdminUsers() {
  return users.filter(u => u.active).filter(u => u.role === 'admin');
}
function getModeratorUsers() {
  return users.filter(u => u.active).filter(u => u.role === 'moderator');
}

// Après
function getUsersByRole(role) {
  return users.filter(u => u.active && u.role === role);
}
```

---

## 3. Process de Refactoring

### Pour chaque changement

```
1. IDENTIFIER  → Quel problème de qualité ?
      ↓
2. PLANIFIER   → Quelle technique appliquer ?
      ↓
3. VÉRIFIER    → Les tests passent avant ?
      ↓
4. APPLIQUER   → Faire le changement minimal
      ↓
5. TESTER      → Les tests passent après ?
      ↓
6. COMMITTER   → Petit commit descriptif
      ↓
7. RÉPÉTER     → Prochain problème
```

### Utiliser les outils SERENA

```
mcp__serena__rename_symbol - Renommer proprement dans tout le projet
mcp__serena__replace_symbol_body - Modifier le corps d'une fonction
mcp__serena__find_referencing_symbols - Vérifier les impacts
```

---

## 4. Validation

### Checklist de validation

- [ ] Tous les tests passent
- [ ] Pas de changement de comportement
- [ ] Le code est plus lisible
- [ ] Pas de nouvelle duplication introduite
- [ ] Les noms sont clairs et explicites
- [ ] La complexité a diminué

### Commandes de vérification

```bash
# Tests
npm test

# Lint
npm run lint

# Types
npm run typecheck
```

---

## 5. Capitalisation SERENA

### Si patterns utiles identifiés

```
mcp__serena__write_memory
```

**À capitaliser :**
- Techniques de refactoring efficaces pour ce projet
- Anti-patterns identifiés à éviter
- Standards de code à formaliser

---

## Transition vers la prochaine phase

| Situation | Prochaine skill |
|-----------|-----------------|
| Refactoring terminé, dans un workflow | `/test-run` pour valider |
| Refactoring isolé | Terminé |
| Bug découvert pendant refactoring | `/debug` |
| Besoin de tests avant refactoring | `/test-write` |

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** (si un workflow est en cours) :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /refactor ✅
  → Lister les fichiers refactorisés
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Refactoring Terminé

**Fichiers refactorisés** :
- `path/file.ts` - [type de refactoring]

**Améliorations** :
- [Amélioration 1]
- [Amélioration 2]

**Tests** : ✅ Passent toujours

→ **Prochaine étape** : `/test-run` pour valider (si dans un workflow)

💡 `/next` pour voir le workflow complet
---
```

---
name: implement
description: Implémente une fonctionnalité en suivant les bonnes pratiques et le plan établi
argument-hint: [fonctionnalité-à-implémenter] [--tdd] [--incremental]
model: sonnet
---

# Implémentation

Implémente la fonctionnalité suivante :

$ARGUMENTS

## Objectif

Écrire du code **propre, testé et maintenable** en suivant le plan établi lors des phases précédentes.

---

## 0. Préparation SERENA

### Consultation préalable

```
mcp__serena__list_memories - Trouver l'architecture/plan existant
mcp__serena__read_memory - Lire les décisions techniques (ADR)
mcp__serena__get_symbols_overview - Comprendre les fichiers à modifier
mcp__serena__find_symbol - Localiser les points d'intégration
```

### Checklist de démarrage

- [ ] Architecture/plan disponible ? (sinon → `/architecture`)
- [ ] Décisions techniques documentées ? (sinon → `/tech-choice`)
- [ ] Conventions du projet connues ?
- [ ] Tests existants identifiés ?
- [ ] Point d'intégration clair ?

---

## 1. Mode TDD (si `--tdd`)

### Cycle Red-Green-Refactor

```
1. RED    : Écrire un test qui échoue
2. GREEN  : Écrire le minimum de code pour passer
3. REFACTOR : Améliorer sans casser les tests
4. REPEAT
```

### Commencer par les tests

```
/test-write [fonctionnalité]
```

Puis revenir ici pour l'implémentation.

---

## 2. Implémentation Incrémentale

### Principe

Faire des **petits commits fonctionnels** plutôt qu'un gros commit final.

### Étapes recommandées

```
Commit 1 : Structure et types
├── Créer les fichiers
├── Définir les interfaces
└── Types de base

Commit 2 : Squelette
├── Signatures de fonctions
├── TODOs pour la logique
└── Tests en pending

Commit 3-N : Implémentation
├── Une fonction/méthode à la fois
├── Tests correspondants
└── Pas de code mort

Commit Final : Polish
├── Documentation
├── Clean up
└── Validation finale
```

---

## 3. Standards de Code

### Principes à suivre

| Principe | Application |
|----------|-------------|
| **SOLID** | Single responsibility, Open/closed, etc. |
| **DRY** | Pas de duplication |
| **KISS** | Garder simple |
| **YAGNI** | Pas de code "au cas où" |

### Checklist par fonction

- [ ] Nom descriptif (verbe + objet)
- [ ] Une seule responsabilité
- [ ] < 20 lignes idéalement
- [ ] Paramètres limités (< 4)
- [ ] Gestion d'erreurs appropriée
- [ ] Testable (pas d'effets de bord cachés)

---

## 4. Process d'Implémentation

### Pour chaque composant

```markdown
### Composant : [Nom]

1. **Créer le fichier** avec la structure de base
2. **Définir les types** (entrées, sorties, erreurs)
3. **Implémenter la logique** en suivant le plan
4. **Écrire les tests** (ou vérifier les existants)
5. **Valider** que ça fonctionne
6. **Commit** avec message descriptif
```

### Utiliser les outils SERENA

```
mcp__serena__replace_symbol_body - Modifier une fonction existante
mcp__serena__insert_after_symbol - Ajouter après un symbole
mcp__serena__insert_before_symbol - Ajouter avant un symbole
mcp__serena__rename_symbol - Renommer proprement
```

---

## 5. Gestion des Erreurs

### Pattern standard

```typescript
// Validation en entrée
function doSomething(input: Input): Result {
  // 1. Valider les entrées (fail fast)
  if (!isValid(input)) {
    throw new ValidationError('Invalid input', { details });
  }

  // 2. Logique métier
  try {
    const result = processLogic(input);
    return { success: true, data: result };
  } catch (error) {
    // 3. Erreurs attendues → gérer
    if (error instanceof ExpectedError) {
      return { success: false, error: mapError(error) };
    }
    // 4. Erreurs inattendues → propager
    throw error;
  }
}
```

### Types d'erreurs

| Type | Quand | Action |
|------|-------|--------|
| Validation | Input invalide | Return early |
| Business | Règle métier violée | Return error |
| Technical | Bug, infrastructure | Throw + log |

---

## 6. Logging et Observabilité

### Quand logger

| Niveau | Usage |
|--------|-------|
| `error` | Erreurs nécessitant attention |
| `warn` | Situations anormales gérées |
| `info` | Événements importants (entrée/sortie) |
| `debug` | Détails pour debugging |

### Format

```typescript
logger.info('Processing request', {
  action: 'createUser',
  userId: user.id,
  duration: elapsed,
});
```

---

## 7. Tests en Parallèle

### Après chaque implémentation significative

```bash
# Exécuter les tests concernés
npm test -- --watch [pattern]
```

### Couverture minimale

- [ ] Happy path
- [ ] Edge cases identifiés
- [ ] Erreurs attendues
- [ ] Intégration basique

---

## 8. Intégration

### Points de connexion

```
mcp__serena__find_referencing_symbols - Où s'intégrer
mcp__serena__get_symbols_overview - Structure existante
```

### Checklist d'intégration

- [ ] Imports ajoutés correctement
- [ ] Exports publics définis
- [ ] Dépendances injectées
- [ ] Configuration mise à jour
- [ ] Tests d'intégration passent

---

## 9. Validation Continue

### Après chaque étape

```bash
# Linting
npm run lint

# Type checking
npm run typecheck

# Tests
npm test

# Build (si applicable)
npm run build
```

### Avant de terminer

- [ ] Tous les tests passent
- [ ] Pas d'erreurs de lint
- [ ] Pas d'erreurs de type
- [ ] Le build fonctionne
- [ ] La fonctionnalité marche manuellement

---

## 10. Documentation du Code

### Quand documenter

| Situation | Action |
|-----------|--------|
| API publique | JSDoc complet |
| Logique complexe | Commentaire "pourquoi" |
| Workaround | Commentaire avec contexte |
| Code évident | Pas de commentaire |

### Format JSDoc

```typescript
/**
 * Brève description de la fonction.
 *
 * @param param1 - Description du paramètre
 * @param param2 - Description du paramètre
 * @returns Description du retour
 * @throws {ErrorType} Quand [condition]
 *
 * @example
 * ```typescript
 * const result = myFunction(input);
 * ```
 */
```

---

## 11. Capitalisation SERENA

### Pendant l'implémentation

Si des découvertes importantes sont faites :

```
mcp__serena__write_memory - Sauvegarder les découvertes
mcp__serena__edit_memory - Mettre à jour l'architecture si elle a évolué
```

### À capitaliser

- Patterns utiles découverts
- Pièges rencontrés et solutions
- Décisions d'implémentation importantes
- Code réutilisable identifié

---

## 12. Commit Final

### Message de commit

```
type(scope): description courte

- Détail 1
- Détail 2

Closes #issue (si applicable)
```

### Types de commit

| Type | Usage |
|------|-------|
| `feat` | Nouvelle fonctionnalité |
| `fix` | Correction de bug |
| `refactor` | Refactoring sans changement de comportement |
| `test` | Ajout/modification de tests |
| `docs` | Documentation |
| `chore` | Maintenance |

---

## Transition vers la prochaine phase

| Situation | Prochaine skill |
|-----------|-----------------|
| Tests manquants | `/test-write` |
| Tests à exécuter | `/test-run` |
| Bug découvert | `/debug` |
| Code à nettoyer | `/clean-code` |
| Review nécessaire | `/code-review` |
| Documentation manquante | `/document` |

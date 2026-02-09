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

## ⛔ LIMITES STRICTES DE CETTE SKILL

### ✅ CE QUE CETTE SKILL FAIT
- Écrire le code de la fonctionnalité
- Créer les fichiers nécessaires
- Suivre le plan d'architecture établi
- Faire des commits incrémentaux
- Écrire des tests unitaires basiques en parallèle

### ❌ CE QUE CETTE SKILL NE FAIT PAS
- **PAS de re-analyse** : L'analyse est faite, on implémente
- **PAS de changement d'architecture** : Suivre le plan (sinon retour à `/architecture`)
- **PAS de refactoring massif** : Implémenter d'abord, refactorer après
- **PAS de documentation complète** : C'est pour `/document`
- **PAS de debug approfondi** : Si bug complexe → `/debug`

### 🛑 SI TU DÉCOUVRES UN PROBLÈME D'ARCHITECTURE
STOP ! Note le problème et propose de revenir à `/architecture` pour ajuster.

### 🛑 SI TU RENCONTRES UN BUG COMPLEXE
STOP ! Note le bug et propose `/debug` plutôt que de partir en investigation.

---

---

## 0. Vérification de Branche (OBLIGATOIRE)

### ⚠️ AVANT D'ÉCRIRE DU CODE, vérifier la branche

```bash
git branch --show-current
```

### 🛑 STOP si sur main ou master

```markdown
⛔ **ATTENTION : Vous êtes sur la branche principale (`main` ou `master`)**

Il est dangereux d'implémenter directement sur la branche principale.

**Options** :
1. Créer une branche `feature/[nom]` maintenant
2. Retourner à `/analyze` pour démarrer proprement
3. Confirmer explicitement vouloir rester sur main (non recommandé)
```

### Si pas de branche feature

Ne pas commencer à coder avant d'avoir :
- [ ] Vérifié la branche actuelle
- [ ] Créé une branche feature si nécessaire
- [ ] Confirmation de l'utilisateur

---

## 0b. Vérification des Prérequis

### Consulter l'état du workflow

```
mcp__serena__read_memory
  memory_file_name: "workflow-current.md"
```

### Prérequis recommandés

| # | Prérequis | Status | Si manquant |
|---|-----------|--------|-------------|
| 1 | `/analyze` | ✅ ou N/A si simple | Optionnel pour tâches simples |
| 2 | `/architecture` | ✅ recommandé | ⚠️ Proposer `/architecture` d'abord |

### ⚠️ SI ARCHITECTURE MANQUANTE

Pour les tâches non triviales, vérifier qu'un plan existe :

```markdown
⚠️ **ARCHITECTURE NON DOCUMENTÉE**

Aucun plan d'architecture n'a été trouvé pour cette tâche.

**Options** :
1. Exécuter `/architecture` pour concevoir le plan (recommandé)
2. Continuer si la tâche est simple et ne nécessite pas de conception
3. Confirmer explicitement vouloir implémenter sans plan

→ Que souhaitez-vous faire ?
```

---

## 1. Préparation SERENA

### Consultation préalable

```
mcp__serena__list_memories - Trouver l'architecture/plan existant
mcp__serena__read_memory - Lire les décisions techniques (ADR)
mcp__serena__get_symbols_overview - Comprendre les fichiers à modifier
mcp__serena__find_symbol - Localiser les points d'intégration
```

### Checklist de démarrage (BLOQUANT si non rempli)

- [ ] Architecture/plan disponible ? (sinon → `/architecture`)
- [ ] Décisions techniques documentées ? (sinon → `/tech-choice`)
- [ ] Conventions du projet connues ?
- [ ] Tests existants identifiés ?
- [ ] Point d'intégration clair ?

### 🛑 SI CHECKLIST NON REMPLIE

Ne pas commencer à coder. Proposer la skill manquante.

---

## 2. Mode TDD (si `--tdd`)

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

## 3. Implémentation Incrémentale

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

## 4. Standards de Code

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

## 5. Process d'Implémentation

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

## 6. Gestion des Erreurs

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

## 7. Logging et Observabilité

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

## 8. Tests en Parallèle

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

## 9. Intégration

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

## 10. Validation Continue

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

## 11. Documentation du Code

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

## 12. Capitalisation SERENA

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

## 13. Commit Final

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

### ⛔ ORDRE STRICT après /implement

```
/implement → /test-write → /test-run → /quality-check → /code-review → /document → /capitalize → /roadmap-update --done → /pre-merge
```

**JAMAIS proposer `/code-review`, `/quality-check` ou `/pre-merge` directement après `/implement`.**

### Choix de la prochaine skill

| Situation | Prochaine skill | ⛔ INTERDIT |
|-----------|-----------------|-------------|
| **Nouveaux fichiers/fonctions créés** | `/test-write` (OBLIGATOIRE) | `/test-run`, `/quality-check`, `/code-review`, `/pre-merge` |
| **Tests existants couvrent déjà les changements** | `/test-write` pour ajouter des cas | `/quality-check`, `/code-review`, `/pre-merge` |
| **Correction mineure dans code existant testé** | `/test-run` pour vérifier non-régression | `/quality-check`, `/code-review`, `/pre-merge` |
| **Bug découvert pendant l'implémentation** | `/debug` | `/code-review`, `/pre-merge` |

### ⚠️ Quand peut-on aller directement à `/test-run` ?

**SEULEMENT SI** :
1. Les tests existants couvrent DÉJÀ les changements effectués
2. Aucune nouvelle fonction/méthode n'a été créée
3. Le changement est une correction mineure

**DANS LE DOUTE** : Toujours proposer `/test-write` d'abord.

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /implement ✅ (ou 🔄 si partiel)
  → Mettre à jour "Fichiers Concernés" avec les fichiers créés/modifiés
  → Ajouter les commits effectués
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Implémentation Terminée (ou 🔄 En Cours)

**Fichiers créés/modifiés** :
- `path/file1.ts` - [description]
- `path/file2.ts` - [description]

**Status** : [X% complété] ou [Terminé]

**Tests** : [Existent / À écrire / À exécuter]

→ **Prochaine étape** : `/test-write [fichiers]`
  (ou `/test-run` UNIQUEMENT si les tests existants couvrent déjà les changements)

⚠️ Il reste **8 étapes** avant le merge : test-write → test-run → quality-check → code-review → document → capitalize → roadmap-update → pre-merge

💡 `/next` pour voir le workflow complet
---
```

3. **Ne jamais terminer sans proposer** la prochaine action concrète

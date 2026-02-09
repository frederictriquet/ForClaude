---
name: test-write
description: Écrit des tests unitaires et d'intégration pour une fonctionnalité
argument-hint: [fichier-ou-fonction] [--unit] [--integration] [--e2e]
model: sonnet
---

# Écriture de Tests

Écris les tests pour :

$ARGUMENTS

## Objectif

Créer une **suite de tests complète** qui garantit le bon fonctionnement et prévient les régressions.

---

## ⛔ LIMITES STRICTES DE CETTE SKILL

### ✅ CE QUE CETTE SKILL FAIT
- Écrire des tests (unit, integration, e2e)
- Créer des fixtures et mocks
- Définir les cas de test
- Configurer le framework de test si nécessaire

### ❌ CE QUE CETTE SKILL NE FAIT PAS
- **PAS de correction de code** : Si un test échoue → `/debug`
- **PAS d'implémentation de features** : On teste l'existant
- **PAS d'exécution complète** : C'est pour `/test-run`
- **PAS de refactoring** : Écrire les tests, pas changer le code

### 🛑 SI UN TEST RÉVÈLE UN BUG
STOP ! Note le bug et propose `/debug`. N'essaie pas de corriger dans cette skill.

---

## 0. Vérification des Prérequis (OBLIGATOIRE)

### Consulter l'état du workflow

```
mcp__serena__read_memory
  memory_file_name: "workflow-current.md"
```

### Prérequis pour cette skill

| # | Prérequis | Status requis | Si manquant |
|---|-----------|---------------|-------------|
| 1 | `/implement` | ✅ code écrit | STOP → `/implement` |
| 2 | Code à tester | Fichiers existent | STOP → `/implement` |

### 🛑 SI PRÉREQUIS NON REMPLIS

**NE PAS CONTINUER.** Afficher :

```markdown
⛔ **PRÉREQUIS MANQUANT**

`/test-write` requiert que du code à tester existe.

→ **Action requise** : Exécuter `/implement` d'abord

⚠️ Ordre obligatoire : implement → test-write → test-run → ...
```

### Vérification du code à tester

Avant d'écrire des tests, vérifier :
1. Les fichiers à tester existent
2. Les fonctions/classes à tester sont implémentées
3. Le code compile/s'exécute sans erreur

---

## 0b. Consultation SERENA

### Analyse préalable

```
mcp__serena__get_symbols_overview - Structure du code à tester
mcp__serena__find_symbol - Signature des fonctions
mcp__serena__search_for_pattern - Tests existants similaires
mcp__serena__list_memories - Conventions de test du projet
```

### Questions à résoudre

1. **Quel framework de test** est utilisé ? (Jest, Vitest, Mocha, pytest...)
2. **Quelles conventions** de nommage pour les tests ?
3. **Où placer** les fichiers de test ?
4. **Patterns de mock** utilisés dans le projet ?

---

## 1. Stratégie de Test

### Pyramide des tests

```
        /\
       /  \      E2E (peu, lents, coûteux)
      /----\
     /      \    Integration (modéré)
    /--------\
   /          \  Unit (beaucoup, rapides, peu coûteux)
  /------------\
```

### Répartition recommandée

| Type | Proportion | Focus |
|------|------------|-------|
| Unit | 70% | Logique isolée, fonctions pures |
| Integration | 20% | Interaction entre modules |
| E2E | 10% | Parcours utilisateur critiques |

---

## 2. Tests Unitaires (`--unit`)

### Structure d'un test unitaire

```typescript
describe('[Module/Fonction]', () => {
  // Setup commun
  beforeEach(() => {
    // Initialisation
  });

  describe('[Méthode/Cas]', () => {
    it('should [comportement attendu] when [condition]', () => {
      // Arrange
      const input = createTestInput();

      // Act
      const result = functionUnderTest(input);

      // Assert
      expect(result).toEqual(expectedOutput);
    });
  });
});
```

### Cas à couvrir

| Catégorie | Exemples |
|-----------|----------|
| **Happy path** | Cas nominal, entrée valide |
| **Edge cases** | Limites, valeurs extrêmes |
| **Error cases** | Entrées invalides, erreurs |
| **Null/undefined** | Valeurs manquantes |
| **Empty** | Collections vides, strings vides |

### Matrice de couverture

```markdown
## Fonction : [nom]

| Cas | Input | Expected | Test |
|-----|-------|----------|------|
| Nominal | {...} | {...} | ✅ |
| Edge: vide | [] | [] | ✅ |
| Edge: max | [1..1000] | [...] | ✅ |
| Error: null | null | throws | ✅ |
| Error: invalid | {...bad} | throws | ✅ |
```

---

## 3. Tests d'Intégration (`--integration`)

### Focus

- Interaction entre modules
- Accès aux ressources (DB, API, fichiers)
- Workflows complets

### Structure

```typescript
describe('[Feature] Integration', () => {
  // Setup de l'environnement
  beforeAll(async () => {
    await setupTestDatabase();
  });

  afterAll(async () => {
    await cleanupTestDatabase();
  });

  it('should complete [workflow] successfully', async () => {
    // Setup
    const service = createService(realDependencies);

    // Execute workflow
    const result = await service.completeWorkflow(input);

    // Verify end state
    expect(result.status).toBe('completed');

    // Verify side effects
    const dbState = await queryDatabase();
    expect(dbState).toMatchObject(expectedState);
  });
});
```

### Points d'attention

- [ ] Isolation entre tests (cleanup)
- [ ] Données de test réalistes
- [ ] Timeouts appropriés
- [ ] Gestion des erreurs async

---

## 4. Tests E2E (`--e2e`)

### Quand écrire des tests E2E

- [ ] Parcours utilisateur critiques
- [ ] Flows de paiement/transaction
- [ ] Intégrations externes importantes

### Structure

```typescript
describe('E2E: [User Journey]', () => {
  it('should allow user to [complete action]', async () => {
    // Navigate
    await page.goto('/start');

    // Interact
    await page.fill('[name=email]', 'test@example.com');
    await page.click('button[type=submit]');

    // Wait for result
    await page.waitForSelector('.success-message');

    // Verify
    expect(await page.textContent('.success-message'))
      .toContain('Success');
  });
});
```

---

## 5. Mocking et Stubbing

### Stratégie de mock

| Quoi mocker | Pourquoi | Comment |
|-------------|----------|---------|
| APIs externes | Lenteur, instabilité | Mock responses |
| Base de données | Isolation, vitesse | In-memory ou mock |
| Date/Time | Déterminisme | Fake timers |
| Random | Reproductibilité | Seed fixe |

### Patterns de mock

```typescript
// Mock de module
jest.mock('./database', () => ({
  query: jest.fn().mockResolvedValue([]),
}));

// Mock de fonction
const mockFn = jest.fn()
  .mockReturnValueOnce('first')
  .mockReturnValueOnce('second');

// Mock partiel
jest.spyOn(service, 'method').mockImplementation(() => 'mocked');

// Reset entre tests
beforeEach(() => {
  jest.clearAllMocks();
});
```

---

## 6. Fixtures et Factories

### Test Data Builders

```typescript
// factories/user.factory.ts
export function createTestUser(overrides?: Partial<User>): User {
  return {
    id: faker.string.uuid(),
    email: faker.internet.email(),
    name: faker.person.fullName(),
    createdAt: new Date(),
    ...overrides,
  };
}

// Usage
const user = createTestUser({ name: 'Test User' });
```

### Fixtures réutilisables

```typescript
// fixtures/index.ts
export const fixtures = {
  validUser: createTestUser(),
  adminUser: createTestUser({ role: 'admin' }),
  invalidEmail: { email: 'not-an-email' },
};
```

---

## 7. Assertions Claires

### Bonnes pratiques

```typescript
// ❌ Mauvais : assertion vague
expect(result).toBeTruthy();

// ✅ Bon : assertion spécifique
expect(result.status).toBe('success');
expect(result.data).toHaveLength(3);
expect(result.data[0]).toMatchObject({
  id: expect.any(String),
  name: 'Expected Name',
});
```

### Matchers utiles

| Matcher | Usage |
|---------|-------|
| `toBe` | Égalité stricte |
| `toEqual` | Égalité profonde |
| `toMatchObject` | Sous-ensemble d'objet |
| `toContain` | Contient élément |
| `toThrow` | Lance exception |
| `toHaveBeenCalledWith` | Vérifier appel mock |

---

## 8. Tests Asynchrones

### Patterns async

```typescript
// Async/await (recommandé)
it('should fetch data', async () => {
  const result = await fetchData();
  expect(result).toBeDefined();
});

// Rejections
it('should reject on error', async () => {
  await expect(failingFn()).rejects.toThrow('Error message');
});

// Timeouts
it('should complete within timeout', async () => {
  const result = await Promise.race([
    longOperation(),
    timeout(5000),
  ]);
  expect(result).toBeDefined();
}, 10000); // Jest timeout
```

---

## 9. Organisation des Tests

### Structure de fichiers

```
src/
├── feature/
│   ├── feature.ts
│   └── __tests__/
│       ├── feature.test.ts        # Unit tests
│       ├── feature.integration.ts # Integration tests
│       └── fixtures.ts            # Test fixtures
tests/
├── e2e/
│   └── feature.e2e.ts
└── setup.ts
```

### Nommage des tests

```typescript
// Pattern : should [expected behavior] when [condition]
it('should return empty array when no items match filter')
it('should throw ValidationError when email is invalid')
it('should call save() exactly once when form is submitted')
```

---

## 10. Couverture de Code

### Objectifs de couverture

| Métrique | Minimum | Idéal |
|----------|---------|-------|
| Statements | 70% | 85% |
| Branches | 70% | 85% |
| Functions | 80% | 90% |
| Lines | 70% | 85% |

### Vérifier la couverture

```bash
npm test -- --coverage
```

### Points non couverts à justifier

- Code de fallback/recovery rarement exécuté
- Branches d'erreurs système
- Code généré automatiquement

---

## 11. Capitalisation SERENA

### Sauvegarder les patterns de test

```
mcp__serena__write_memory
```

**À capitaliser :**
- Patterns de mock réutilisables
- Fixtures utiles pour le domaine
- Stratégies de test pour cas complexes
- Erreurs de test fréquentes et solutions

### Format de mémoire

```markdown
# Tests : [Feature/Domain]

## Patterns de mock
[Code réutilisable]

## Fixtures standard
[Données de test]

## Pièges à éviter
- [Piège 1] : [Solution]
- [Piège 2] : [Solution]
```

---

## 12. Checklist de Validation

### Avant de terminer

- [ ] Tous les cas critiques sont couverts
- [ ] Les tests sont indépendants et isolés
- [ ] Les noms de tests sont descriptifs
- [ ] Pas de tests flaky (instables)
- [ ] Les mocks sont appropriés
- [ ] La couverture est suffisante
- [ ] Les tests s'exécutent rapidement

---

## Transition vers la prochaine phase

| Situation | Prochaine skill | ⛔ INTERDIT |
|-----------|-----------------|-------------|
| Tests écrits, à exécuter | `/test-run` | `/code-review`, `/pre-merge` |
| Bug découvert en écrivant tests | `/debug` | `/pre-merge` |
| Code manquant (TDD) | `/implement` → revenir ici | `/pre-merge` |

### ⚠️ Après /test-write, TOUJOURS aller à /test-run

Il reste **7 étapes** avant le merge : test-run → quality-check → code-review → document → capitalize → roadmap-update → pre-merge

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /test-write ✅
  → Lister les fichiers de tests créés/modifiés
  → Noter la couverture estimée
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Tests Écrits

**Fichiers de tests créés/modifiés** :
- `path/to/test1.test.ts` - [description]
- `path/to/test2.test.ts` - [description]

**Couverture estimée** : [X cas de test pour Y fonctions]

→ **Prochaine étape** : `/test-run` pour exécuter et valider les tests

⚠️ Il reste 7 étapes avant le merge

💡 `/next` pour voir le workflow complet
---
```

3. **Ne jamais proposer** `/code-review` ou `/pre-merge` directement

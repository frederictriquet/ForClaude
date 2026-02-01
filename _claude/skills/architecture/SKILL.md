---
name: architecture
description: Conçoit l'architecture d'une fonctionnalité ou d'un module avant l'implémentation
argument-hint: [fonctionnalité-à-concevoir]
model: opus
---

# Conception d'Architecture

Conçois l'architecture pour :

$ARGUMENTS

## Objectif

Créer un **blueprint détaillé** avant d'écrire le code. Une bonne architecture facilite l'implémentation, les tests et la maintenance.

---

## ⛔ LIMITES STRICTES DE CETTE SKILL

### ✅ CE QUE CETTE SKILL FAIT
- Définir la structure des fichiers/modules
- Dessiner les diagrammes (composants, séquence, flux)
- Définir les interfaces et types
- Lister les dépendances
- Planifier l'ordre d'implémentation
- Écrire des **signatures** de fonctions (sans corps)

### ❌ CE QUE CETTE SKILL NE FAIT PAS
- **PAS d'implémentation** : Juste les interfaces, pas le code
- **PAS de création de fichiers** : On planifie, on ne crée pas encore
- **PAS de tests** : On conçoit l'architecture des tests, on ne les écrit pas
- **PAS de debug** : On n'est pas encore en train de coder

### 🛑 SI TU ES TENTÉ D'IMPLÉMENTER
STOP ! Finalise le plan d'architecture et passe à `/implement`.

---

---

## 0. Consultation SERENA

### Analyse de l'existant

```
mcp__serena__get_symbols_overview - Structure des fichiers existants
mcp__serena__find_symbol - Patterns architecturaux utilisés
mcp__serena__find_referencing_symbols - Dépendances existantes
mcp__serena__list_memories - ADR et décisions passées
mcp__serena__read_memory - Lire les conventions architecturales
```

### Questions SERENA

1. **Quels patterns architecturaux** sont déjà utilisés dans le projet ?
2. **Quelles conventions** de structuration existent ?
3. **Y a-t-il des contraintes** documentées à respecter ?
4. **Quelles dépendances** existent déjà qu'on peut réutiliser ?

---

## 1. Vue d'Ensemble

### Diagramme de haut niveau

```
┌─────────────────────────────────────────────────┐
│                   [Système]                      │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐  │
│  │ Module A │───▶│ Module B │───▶│ Module C │  │
│  └──────────┘    └──────────┘    └──────────┘  │
│                                                 │
└─────────────────────────────────────────────────┘
```

### Description des composants

| Composant | Responsabilité | Entrées | Sorties |
|-----------|----------------|---------|---------|
| Module A | ... | ... | ... |
| Module B | ... | ... | ... |
| Module C | ... | ... | ... |

---

## 2. Structure des Fichiers

### Arborescence proposée

```
src/
├── [feature]/
│   ├── index.ts              # Point d'entrée public
│   ├── types.ts              # Types et interfaces
│   ├── [feature].ts          # Logique principale
│   ├── [feature].utils.ts    # Fonctions utilitaires
│   ├── [feature].constants.ts # Constantes
│   └── __tests__/
│       ├── [feature].test.ts
│       └── [feature].utils.test.ts
```

### Conventions de nommage

| Type | Convention | Exemple |
|------|------------|---------|
| Fichiers | kebab-case | `user-service.ts` |
| Classes | PascalCase | `UserService` |
| Fonctions | camelCase | `getUserById` |
| Constantes | SCREAMING_SNAKE | `MAX_RETRY_COUNT` |
| Types/Interfaces | PascalCase | `UserDTO` |

---

## 3. Interfaces et Contrats

### Types principaux

```typescript
// types.ts

/**
 * [Description du type]
 */
interface [TypeName] {
  /** [Description du champ] */
  field1: Type1;
  field2: Type2;
}

/**
 * [Description de l'interface publique]
 */
interface I[ServiceName] {
  method1(param: Type): ReturnType;
  method2(param: Type): Promise<ReturnType>;
}
```

### Contrats d'API

```typescript
// Entrées
interface [Feature]Input {
  // ...
}

// Sorties
interface [Feature]Output {
  // ...
}

// Erreurs
type [Feature]Error =
  | { code: 'NOT_FOUND'; message: string }
  | { code: 'VALIDATION_ERROR'; details: string[] }
  | { code: 'INTERNAL_ERROR'; message: string };
```

---

## 4. Flux de Données

### Diagramme de séquence

```
┌─────┐          ┌─────────┐          ┌──────────┐          ┌────┐
│Client│          │Controller│          │ Service  │          │ DB │
└──┬──┘          └────┬────┘          └────┬─────┘          └──┬─┘
   │                  │                    │                   │
   │  1. Request      │                    │                   │
   │─────────────────▶│                    │                   │
   │                  │  2. Validate       │                   │
   │                  │───────────────────▶│                   │
   │                  │                    │  3. Query         │
   │                  │                    │──────────────────▶│
   │                  │                    │                   │
   │                  │                    │  4. Result        │
   │                  │                    │◀──────────────────│
   │                  │  5. Transform      │                   │
   │                  │◀───────────────────│                   │
   │  6. Response     │                    │                   │
   │◀─────────────────│                    │                   │
```

### États et transitions

```
[Initial] ──▶ [Processing] ──▶ [Completed]
                   │
                   ▼
              [Failed] ──▶ [Retry] ──▶ [Processing]
```

---

## 5. Gestion des Erreurs

### Stratégie d'erreurs

| Couche | Stratégie | Exemple |
|--------|-----------|---------|
| Validation | Fail fast, messages clairs | `ValidationError` |
| Service | Erreurs métier typées | `BusinessError` |
| Infrastructure | Wrap et retry | `InfrastructureError` |
| API | HTTP codes appropriés | 400, 404, 500 |

### Pattern de gestion

```typescript
// Result pattern (optionnel)
type Result<T, E> =
  | { success: true; data: T }
  | { success: false; error: E };

// Ou exceptions typées
class [Feature]Error extends Error {
  constructor(
    public code: ErrorCode,
    message: string,
    public details?: unknown
  ) {
    super(message);
  }
}
```

---

## 6. Dépendances

### Dépendances internes

| Module | Dépend de | Type |
|--------|-----------|------|
| A | B | Direct |
| B | C | Interface |
| C | - | Aucune |

### Dépendances externes

| Package | Version | Usage |
|---------|---------|-------|
| pkg1 | ^x.y.z | Pour X |
| pkg2 | ^x.y.z | Pour Y |

### Injection de dépendances

```typescript
class [Service] {
  constructor(
    private readonly dep1: IDep1,
    private readonly dep2: IDep2,
  ) {}
}
```

---

## 7. Considérations Non-Fonctionnelles

### Performance

- [ ] Caching strategy : [...]
- [ ] Lazy loading : [...]
- [ ] Pagination : [...]

### Sécurité

- [ ] Validation des entrées
- [ ] Sanitization des sorties
- [ ] Authentification/Autorisation

### Observabilité

- [ ] Logging (quoi, niveau)
- [ ] Métriques (lesquelles)
- [ ] Tracing (si distribué)

### Scalabilité

- [ ] Stateless/Stateful
- [ ] Horizontal scaling possible ?
- [ ] Bottlenecks identifiés

---

## 8. Plan d'Implémentation

### Ordre de développement

```
Phase 1 : Fondations
├── 1.1 Types et interfaces
├── 1.2 Structure des fichiers
└── 1.3 Tests de base

Phase 2 : Core
├── 2.1 Logique métier principale
├── 2.2 Gestion des erreurs
└── 2.3 Tests unitaires

Phase 3 : Intégration
├── 3.1 Connexion aux dépendances
├── 3.2 Tests d'intégration
└── 3.3 Documentation

Phase 4 : Polish
├── 4.1 Edge cases
├── 4.2 Performance tuning
└── 4.3 Code review
```

### Fichiers à créer/modifier

| Fichier | Action | Description |
|---------|--------|-------------|
| `path/file1.ts` | Créer | Types principaux |
| `path/file2.ts` | Créer | Service principal |
| `path/file3.ts` | Modifier | Ajouter intégration |

---

## 9. Capitalisation SERENA

### Sauvegarder l'architecture

```
mcp__serena__write_memory
```

**Nom** : `arch-[YYYY-MM-DD]-[feature-name].md`

**Contenu** :

```markdown
# Architecture : [Feature Name]

## Date : YYYY-MM-DD

## Vue d'ensemble
[Diagramme et description]

## Composants
[Liste des composants et responsabilités]

## Interfaces
[Contrats principaux]

## Décisions architecturales
[Choix faits et justifications]

## Patterns utilisés
[Patterns et pourquoi]

## Leçons apprises
[À documenter après implémentation]
```

### Mettre à jour la doc projet

Si des conventions architecturales nouvelles émergent :
- Proposer de les ajouter aux standards du projet
- Documenter les patterns réutilisables

---

## 10. Checklist de Validation

### Avant de passer à l'implémentation

- [ ] Les interfaces sont clairement définies
- [ ] Les responsabilités sont bien séparées
- [ ] Les dépendances sont minimales et bien orientées
- [ ] La testabilité est assurée (DI, interfaces)
- [ ] Les erreurs sont gérées de manière cohérente
- [ ] La structure suit les conventions du projet
- [ ] Les considérations non-fonctionnelles sont adressées
- [ ] Le plan d'implémentation est réaliste

---

## Transition vers la prochaine phase

| Situation | Prochaine skill |
|-----------|-----------------|
| Architecture validée | `/implement` |
| Tests à écrire d'abord (TDD) | `/test-write` |
| Décisions techniques à prendre | `/tech-choice` |
| Besoin de plus d'exploration | `/explore-options` |

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /architecture ✅
  → Mettre à jour "Fichiers Concernés" avec la liste des fichiers à créer/modifier
  → Ajouter les composants clés dans "Contexte Clé"
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Architecture Conçue

**Composants** : [Liste des modules/composants]
**Fichiers à créer** : [Nombre]
**Pattern principal** : [Pattern utilisé]

→ **Prochaine étape** : `/implement [feature]` ou `/test-write` (si TDD)

**Plan d'implémentation suggéré** :
1. [Première chose à implémenter]
2. [Deuxième chose]
3. ...

💡 `/next` pour voir le workflow complet
---
```

3. **Fournir un plan d'implémentation** concret pour faciliter la suite

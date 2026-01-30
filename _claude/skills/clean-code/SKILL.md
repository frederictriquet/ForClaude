---
name: clean-code
description: Nettoie et améliore la maintenabilité du code après une session de développement intensive
argument-hint: [fichier-ou-dossier] [--audit-all]
---

# Nettoyage et Maintenance du Code

Analyse et nettoie le code suivant pour améliorer sa maintenabilité à long terme :

$ARGUMENTS

## Objectif Principal

Rendre le code **auto-évolutif** : il doit s'adapter aux changements sans intervention manuelle.

---

## 0. Intégration SERENA

### Avant de commencer

1. **Consulter les recommandations SERENA** du projet via l'outil MCP `serena`
2. **Appliquer les conventions** définies dans SERENA pour ce projet
3. **Vérifier les patterns** recommandés par SERENA

### Pendant le nettoyage

Si tu identifies des **patterns récurrents** qui pourraient bénéficier à tout le projet :

- Nouvelles conventions de nommage utiles
- Patterns d'architecture à standardiser
- Règles de validation à généraliser
- Anti-patterns à documenter pour éviter leur retour

→ **Propose de nouvelles recommandations à ajouter dans SERENA** en utilisant l'outil approprié.

### Format de proposition SERENA

```
Nouvelle recommandation proposée :
- Catégorie : [architecture|naming|validation|anti-pattern|...]
- Règle : [description claire]
- Justification : [pourquoi c'est important]
- Exemple : [code avant/après]
```

---

## 1. Éliminer la Duplication (DRY)

### Rechercher
- Blocs de code identiques ou quasi-identiques
- Logique répétée avec des variations mineures
- Patterns copy-paste évidents

### Actions
- Extraire en fonctions/méthodes réutilisables
- Créer des abstractions si 3+ occurrences
- Utiliser des génériques/templates si applicable

---

## 2. Éliminer le Hard-Coding

### Flag `--audit-all`

Si `--audit-all` est présent dans les arguments, **ignorer tous les marqueurs `@hardcoded-ok`** et re-questionner l'utilisateur sur chaque valeur suspecte.

### Processus interactif pour les valeurs hard-codées

Pour chaque valeur hard-codée suspecte trouvée :

1. **Vérifier** si elle porte le marqueur `@hardcoded-ok` (sauf si `--audit-all`)
2. **Si marquée OK** → passer à la suivante
3. **Si non marquée** → demander à l'utilisateur :

```
Valeur hard-codée détectée :
  Fichier : src/config.ts:42
  Valeur  : "https://api.example.com/v2"
  Context : const API_URL = "https://api.example.com/v2"

Cette valeur doit-elle être externalisée ?
  1. Oui, externaliser (config/env)
  2. Non, c'est OK de la garder hard-codée
  3. Passer pour l'instant
  4. Autre (réponse libre)
```

L'utilisateur peut aussi donner une instruction personnalisée (ex: "extraire dans une constante nommée mais garder dans ce fichier").

4. **Si l'utilisateur répond "OK"** → ajouter le marqueur dans le code :

```typescript
// Avant
const API_URL = "https://api.example.com/v2";

// Après (marqué OK)
const API_URL = "https://api.example.com/v2"; // @hardcoded-ok: URL de prod stable
```

### Format du marqueur

```
// @hardcoded-ok: [raison courte]
```

Le marqueur doit être sur la **même ligne** que la valeur ou sur la ligne précédente.

Exemples valides :
```typescript
const TIMEOUT = 30000; // @hardcoded-ok: valeur standard du projet

// @hardcoded-ok: constante métier définie par le client
const MAX_ITEMS_PER_PAGE = 50;
```

### Valeurs à externaliser (par défaut)

| Type | Où les mettre |
|------|---------------|
| URLs, endpoints | Variables d'environnement ou config |
| Clés API, secrets | `.env` (jamais dans le code) |
| Timeouts, limites | Constantes nommées ou config |
| Messages utilisateur | Fichiers i18n ou constantes |
| Chemins de fichiers | Config ou calcul dynamique |
| Numéros de version | Package.json ou constante centrale |
| Feature flags | Config ou service dédié |

### Valeurs à dériver dynamiquement

- **Dates** : calculer plutôt que hard-coder (`new Date()`, pas `"2024-01-15"`)
- **Longueurs de tableaux** : utiliser `.length`, pas un nombre fixe
- **Noms de fichiers** : dériver du contexte si possible
- **Index** : utiliser des constantes nommées, pas des magic numbers

### Constantes acceptables (ne pas questionner)

- Constantes mathématiques (π, e)
- Valeurs sémantiques évidentes (0, 1, -1, true, false)
- Chaînes vides `""`
- Valeurs déjà marquées `@hardcoded-ok` (sauf `--audit-all`)

---

## 3. Magic Numbers & Strings

### Interdits
```typescript
// ❌ Mauvais
if (status === 2) { ... }
setTimeout(fn, 86400000);
if (role === "admin") { ... }
```

### Requis
```typescript
// ✅ Bon
const STATUS_APPROVED = 2;
const ONE_DAY_MS = 24 * 60 * 60 * 1000;
enum Role { ADMIN = "admin" }

if (status === STATUS_APPROVED) { ... }
setTimeout(fn, ONE_DAY_MS);
if (role === Role.ADMIN) { ... }
```

---

## 4. Configuration Centralisée

### Créer/Mettre à jour un fichier de config si nécessaire

```typescript
// config/app.config.ts
export const config = {
  api: {
    baseUrl: process.env.API_URL ?? "http://localhost:3000",
    timeout: 30_000,
    retries: 3,
  },
  pagination: {
    defaultPageSize: 20,
    maxPageSize: 100,
  },
  cache: {
    ttl: 5 * 60 * 1000, // 5 minutes
  },
} as const;
```

---

## 5. Améliorer la Résilience

### Vérifier
- Gestion des erreurs cohérente
- Valeurs par défaut sensées
- Null checks appropriés
- Timeouts sur les appels externes

### Patterns recommandés
- Fail fast avec messages clairs
- Circuit breaker pour les services externes
- Retry avec backoff exponentiel
- Graceful degradation

---

## 6. Nettoyage Général

### Supprimer
- Code commenté (utiliser git pour l'historique)
- Imports inutilisés
- Variables non utilisées
- Fonctions mortes
- TODO/FIXME résolus
- Console.log de debug

### Améliorer
- Noms de variables peu clairs → noms descriptifs
- Fonctions trop longues (>30 lignes) → découper
- Nesting profond (>3 niveaux) → early returns
- Conditions complexes → extraire en fonctions nommées

---

## 7. Cohérence du Style

- Uniformiser les patterns (async/await vs promises)
- Cohérence des imports (ordre, groupement)
- Cohérence des exports (named vs default)
- Conventions de nommage uniformes

---

## 8. Documentation Minimale

Ajouter UNIQUEMENT si nécessaire :
- JSDoc pour les fonctions publiques complexes
- Commentaires pour la logique non évidente ("pourquoi", pas "quoi")
- Types explicites pour les signatures complexes

---

## Format de Sortie

Pour chaque problème trouvé, indique :

1. **Fichier:ligne** — localisation
2. **Problème** — ce qui ne va pas
3. **Impact** — pourquoi c'est problématique
4. **Solution** — correction proposée
5. **Code** — avant/après

Puis applique les corrections.

---

## Priorité des Corrections

1. 🔴 **Critique** : Secrets hard-codés, failles de sécurité
2. 🟠 **Important** : Duplication massive, magic numbers critiques
3. 🟡 **Moyen** : Config hard-codée, noms peu clairs
4. 🟢 **Mineur** : Style, documentation manquante

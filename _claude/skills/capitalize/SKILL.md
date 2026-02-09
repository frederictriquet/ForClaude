---
name: capitalize
description: Capitalise les apprentissages et bonnes pratiques dans SERENA pour usage futur
argument-hint: [sujet-à-capitaliser] [--pattern] [--adr] [--bug] [--standard]
model: sonnet
---

# Capitalisation des Connaissances

Capitalise les apprentissages concernant :

$ARGUMENTS

## Objectif

Transformer les **expériences ponctuelles en connaissances durables** qui bénéficieront aux futures sessions de développement.

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
| 1 | `/test-run` | ✅ tests passent | STOP → `/test-run` |
| 2 | `/code-review` | ✅ approuvé | STOP → `/code-review` |
| 3 | `/document` | ✅ documentation à jour | STOP → `/document` |

**Il reste 2 étapes** après /capitalize : roadmap-update --done → pre-merge

### 🛑 SI PRÉREQUIS NON REMPLIS

**NE PAS CONTINUER.** Afficher :

```markdown
⛔ **PRÉREQUIS MANQUANT**

`/capitalize` requiert que `/document` soit ✅.

→ **Action requise** : Exécuter `/document` d'abord

⚠️ **Rappel du flux** : code-review → document → capitalize → roadmap-update → pre-merge
```

---

## 0b. Analyse SERENA Existante

### Vérifier ce qui existe déjà

```
mcp__serena__list_memories - Lister toutes les mémoires
mcp__serena__read_memory - Lire les mémoires pertinentes
```

### Questions préliminaires

1. Cette connaissance existe-t-elle déjà ?
2. Doit-on mettre à jour une mémoire existante ?
3. Quelle catégorie est la plus appropriée ?

---

## 1. Types de Capitalisation

### Catégories principales

| Type | Flag | Usage |
|------|------|-------|
| **Pattern** | `--pattern` | Solutions réutilisables |
| **ADR** | `--adr` | Décisions architecturales |
| **Bug** | `--bug` | Résolutions de bugs |
| **Standard** | `--standard` | Conventions et règles |

### Autres types

- Leçons apprises (post-mortem)
- Configurations optimales
- Dépendances et versions recommandées
- Workflows efficaces

---

## 2. Capitalisation de Pattern (`--pattern`)

### Quand capitaliser un pattern ?

- [ ] Problème récurrent résolu de manière élégante
- [ ] Solution non évidente mais efficace
- [ ] Code réutilisable identifié
- [ ] Abstraction utile découverte

### Format de mémoire

```markdown
# Pattern : [Nom du Pattern]

## Problème
[Quel problème ce pattern résout]

## Contexte
[Quand utiliser ce pattern]

## Solution
[Description de la solution]

## Code
```[language]
// Exemple d'implémentation
```

## Avantages
- [Avantage 1]
- [Avantage 2]

## Inconvénients
- [Inconvénient 1]

## Exemples d'utilisation
- `path/to/file.ts:42` - [Description]
- `path/to/other.ts:78` - [Description]

## Voir aussi
- [Patterns liés]
- [Documentation externe]
```

### Commande SERENA

```
mcp__serena__write_memory
  memory_file_name: "pattern-[nom-kebab].md"
  content: [contenu ci-dessus]
```

---

## 3. Capitalisation ADR (`--adr`)

### Quand créer un ADR ?

- [ ] Choix technique significatif fait
- [ ] Multiple options étaient possibles
- [ ] La décision affecte l'architecture
- [ ] Besoin de justifier le choix futur

### Format ADR

```markdown
# ADR-[NNN] : [Titre de la Décision]

## Statut
Accepté | Proposé | Déprécié | Remplacé par ADR-XXX

## Date
YYYY-MM-DD

## Contexte
[Situation qui a mené à cette décision]

## Décision
[Ce qui a été décidé]

## Options Considérées

### Option A : [Nom]
- **Avantages** : ...
- **Inconvénients** : ...

### Option B : [Nom]
- **Avantages** : ...
- **Inconvénients** : ...

## Justification
[Pourquoi cette option a été choisie]

## Conséquences

### Positives
- ...

### Négatives
- ...

## Références
- [Liens utiles]
```

### Indexation

Mettre à jour l'index des ADR :

```markdown
# Index des ADR

| ID | Date | Titre | Statut |
|----|------|-------|--------|
| 001 | YYYY-MM-DD | [Titre] | Accepté |
```

---

## 4. Capitalisation Bug (`--bug`)

### Quand capitaliser un bug ?

- [ ] Bug difficile à diagnostiquer
- [ ] Solution non évidente
- [ ] Risque de récurrence
- [ ] Piège pour les développeurs

### Format Bug

```markdown
# Bug : [Description courte]

## Date
YYYY-MM-DD

## Symptômes
[Ce qui était observé]

## Cause Racine
[La vraie cause du problème]

## Chemin de Diagnostic
1. [Étape 1] - [Résultat]
2. [Étape 2] - [Résultat]
3. [Conclusion]

## Solution
[Comment le bug a été corrigé]

## Code
```[language]
// Avant (buggy)
...

// Après (fixed)
...
```

## Prévention
[Comment éviter ce bug à l'avenir]

## Tags
- [type: null-pointer | race-condition | etc.]
- [module: auth | api | etc.]
```

---

## 5. Capitalisation Standard (`--standard`)

### Quand définir un standard ?

- [ ] Pratique bénéfique à généraliser
- [ ] Inconsistance observée dans le code
- [ ] Nouveau framework/outil adopté
- [ ] Convention d'équipe à formaliser

### Format Standard

```markdown
# Standard : [Nom du Standard]

## Catégorie
[Naming | Architecture | Testing | Security | etc.]

## Règle
[Description claire et concise de la règle]

## Justification
[Pourquoi cette règle est importante]

## Exemples

### ✅ Correct
```[language]
// Exemple de code correct
```

### ❌ Incorrect
```[language]
// Exemple de code incorrect
```

## Exceptions
[Cas où la règle peut être contournée]

## Vérification
[Comment vérifier le respect de cette règle]
- Lint rule : [nom de la règle]
- Review checklist item

## Date d'adoption
YYYY-MM-DD

## Références
- [Documentation liée]
```

---

## 6. Processus de Capitalisation

### Workflow

```
1. IDENTIFIER  → Quoi capitaliser ?
      ↓
2. CATÉGORISER → Pattern | ADR | Bug | Standard ?
      ↓
3. RÉDIGER     → Suivre le format approprié
      ↓
4. VALIDER     → Vérifier clarté et complétude
      ↓
5. SAUVEGARDER → mcp__serena__write_memory
      ↓
6. INDEXER     → Mettre à jour les index
```

### Checklist de qualité

- [ ] Le contenu est actionnable (pas juste informatif)
- [ ] Les exemples de code sont testés
- [ ] Le contexte est suffisant pour comprendre
- [ ] Les tags/catégories sont appropriés
- [ ] Pas de duplication avec l'existant

---

## 7. Organisation des Mémoires

### Convention de nommage

| Type | Format | Exemple |
|------|--------|---------|
| Pattern | `pattern-[nom].md` | `pattern-error-handling.md` |
| ADR | `adr-[NNN]-[titre].md` | `adr-001-auth-strategy.md` |
| Bug | `bug-[YYYY-MM-DD]-[desc].md` | `bug-2024-01-15-null-token.md` |
| Standard | `std-[categorie]-[nom].md` | `std-naming-components.md` |

### Structure recommandée

```
memories/
├── patterns/
│   ├── pattern-error-handling.md
│   └── pattern-api-client.md
├── adr/
│   ├── index.md
│   ├── adr-001-auth.md
│   └── adr-002-database.md
├── bugs/
│   └── bug-2024-01-15-null-token.md
├── standards/
│   ├── std-naming.md
│   └── std-testing.md
└── index.md
```

---

## 8. Mise à Jour des Mémoires

### Quand mettre à jour ?

- Nouvelle information disponible
- Erreur dans le contenu existant
- Context a changé
- Pattern/standard a évolué

### Commande SERENA

```
mcp__serena__edit_memory
  memory_file_name: "[nom].md"
  needle: "[texte à remplacer]"
  repl: "[nouveau texte]"
  mode: "literal" | "regex"
```

### Versioning

```markdown
## Historique des modifications

| Date | Modification |
|------|--------------|
| YYYY-MM-DD | Création initiale |
| YYYY-MM-DD | Ajout de l'exemple X |
| YYYY-MM-DD | Correction de Y |
```

---

## 9. Utilisation des Mémoires

### Comment les mémoires sont utilisées

1. **Au début de chaque phase** → Consultation automatique
2. **Lors de la résolution de problèmes** → Recherche de solutions
3. **Lors des reviews** → Vérification des standards
4. **Pour l'onboarding** → Documentation du projet

### Recherche efficace

```
mcp__serena__list_memories - Vue d'ensemble
mcp__serena__search_for_pattern - Recherche ciblée
mcp__serena__read_memory - Lecture complète
```

---

## 10. Index Global

### Maintenir un index

```markdown
# Index des Connaissances du Projet

## Patterns
| Nom | Description | Fichier |
|-----|-------------|---------|
| Error Handling | Gestion centralisée des erreurs | pattern-error-handling.md |

## ADR
| ID | Titre | Statut | Fichier |
|----|-------|--------|---------|
| 001 | Stratégie d'authentification | Accepté | adr-001-auth.md |

## Standards
| Catégorie | Nom | Fichier |
|-----------|-----|---------|
| Naming | Conventions de nommage | std-naming.md |

## Bugs Documentés
| Date | Description | Fichier |
|------|-------------|---------|
| 2024-01-15 | Null token issue | bug-2024-01-15-null-token.md |

## Dernière mise à jour
YYYY-MM-DD
```

---

## 11. Validation et Review

### Avant de sauvegarder

- [ ] Le contenu est clair et actionnable
- [ ] Le format est respecté
- [ ] Pas de duplication
- [ ] Les exemples fonctionnent
- [ ] Les références sont valides

### Feedback loop

Après quelques utilisations, vérifier :
- [ ] La mémoire est-elle utile ?
- [ ] Manque-t-il des informations ?
- [ ] Le contenu est-il toujours valide ?

---

## 12. Bonnes Pratiques

### Pour une capitalisation efficace

1. **Capitaliser tôt** - Ne pas attendre "la fin du projet"
2. **Être concis** - Aller à l'essentiel
3. **Être précis** - Exemples concrets > descriptions vagues
4. **Être honnête** - Documenter aussi les échecs
5. **Maintenir** - Mettre à jour régulièrement

### Éviter

- ❌ Documentation obsolète jamais mise à jour
- ❌ Duplication avec documentation existante
- ❌ Contenu trop générique/vague
- ❌ Mémoires jamais relues

---

## Transition

| Situation | Prochaine action |
|-----------|------------------|
| Fin de feature | `/roadmap-update --done` (puis pre-merge) |
| Incident résolu | `/post-mortem` |
| Nouvelle session | Consulter les mémoires |

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /capitalize ✅
  → Lister les mémoires créées/modifiées
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Capitalisation Terminée

**Mémoires sauvegardées** :
- [type] : [nom-du-fichier.md]

→ **Prochaine étape** : `/roadmap-update "[tâche]" --done`

⚠️ **Rappel** : Marquer la tâche comme DONE avant de merger !

💡 `/next` pour voir le workflow complet
---
```

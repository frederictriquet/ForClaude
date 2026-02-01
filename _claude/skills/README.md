# Skills de Développement

Un ensemble de skills atomiques couvrant tout le cycle de développement, avec intégration SERENA pour capitaliser les apprentissages.

## Philosophie

Chaque skill suit le **Single Responsibility Principle** :
- Une skill = une phase du développement
- Transitions claires entre skills
- Capitalisation systématique via SERENA

## Workflow Typique

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         CYCLE DE DÉVELOPPEMENT                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌──────────┐     ┌─────────────────┐     ┌──────────────┐             │
│  │ /analyze │ ──▶ │ /explore-options│ ──▶ │ /tech-choice │             │
│  └──────────┘     └─────────────────┘     └──────────────┘             │
│       │                                          │                      │
│       │         ┌────────────────────────────────┘                      │
│       ▼         ▼                                                       │
│  ┌──────────────────┐                                                   │
│  │   /architecture  │                                                   │
│  └──────────────────┘                                                   │
│            │                                                            │
│            ▼                                                            │
│  ┌──────────────────┐     ┌──────────────┐     ┌─────────────┐         │
│  │   /implement     │ ◀──▶│ /test-write  │ ──▶ │  /test-run  │         │
│  └──────────────────┘     └──────────────┘     └─────────────┘         │
│            │                                          │                 │
│            │                    ┌─────────────────────┘                 │
│            ▼                    ▼                                       │
│  ┌──────────────────┐     ┌──────────┐                                 │
│  │   /code-review   │ ◀── │  /debug  │                                 │
│  └──────────────────┘     └──────────┘                                 │
│            │                                                            │
│            ▼                                                            │
│  ┌──────────────────┐     ┌──────────────┐     ┌─────────────┐         │
│  │   /pre-merge     │ ──▶ │  /document   │ ──▶ │ /capitalize │         │
│  └──────────────────┘     └──────────────┘     └─────────────┘         │
│            │                                                            │
│            ▼                                                            │
│  ┌──────────────────┐                                                   │
│  │  /post-mortem    │  (si incident ou fin de sprint)                   │
│  └──────────────────┘                                                   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

## Skills Disponibles

### Phase d'Analyse

| Skill | Description | Flags |
|-------|-------------|-------|
| `/analyze` | Analyse en profondeur un problème | - |
| `/explore-options` | Explore les différentes solutions | - |
| `/tech-choice` | Documente une décision technique (ADR) | - |
| `/architecture` | Conçoit l'architecture d'une feature | - |

### Phase d'Implémentation

| Skill | Description | Flags |
|-------|-------------|-------|
| `/implement` | Implémente une fonctionnalité | `--tdd`, `--incremental` |
| `/test-write` | Écrit les tests | `--unit`, `--integration`, `--e2e` |
| `/test-run` | Exécute et analyse les tests | `--watch`, `--coverage`, `--verbose` |
| `/debug` | Diagnostique et corrige un bug | `--verbose` |

### Phase de Validation

| Skill | Description | Flags |
|-------|-------------|-------|
| `/code-review` | Effectue une revue de code | `--security`, `--performance`, `--thorough` |
| `/document` | Documente le code | `--api`, `--readme`, `--inline` |
| `/pre-merge` | Prépare le merge | `--pr`, `--squash` |

### Phase de Capitalisation

| Skill | Description | Flags |
|-------|-------------|-------|
| `/capitalize` | Capitalise les apprentissages | `--pattern`, `--adr`, `--bug`, `--standard` |
| `/post-mortem` | Analyse un incident/session | `--incident`, `--session`, `--blameless` |

### Skills Existantes

| Skill | Description |
|-------|-------------|
| `/clean-code` | Nettoie et améliore la maintenabilité |
| `/refactor` | Refactorise sans changer le comportement |
| `/explain-code` | Explique du code avec des analogies |
| `/fix-issue` | Corrige une issue GitHub |

## Intégration SERENA

### Chaque skill utilise SERENA pour :

1. **Consulter** les connaissances existantes au début
2. **Appliquer** les patterns et standards du projet
3. **Capitaliser** les nouvelles découvertes à la fin

### Outils SERENA utilisés

| Outil | Usage |
|-------|-------|
| `list_memories` | Lister les mémoires disponibles |
| `read_memory` | Lire une mémoire spécifique |
| `write_memory` | Créer/sauvegarder une mémoire |
| `edit_memory` | Modifier une mémoire existante |
| `search_for_pattern` | Chercher dans le code |
| `find_symbol` | Trouver des symboles |
| `get_symbols_overview` | Vue d'ensemble d'un fichier |
| `find_referencing_symbols` | Comprendre les dépendances |

### Types de mémoires

| Type | Préfixe | Exemple |
|------|---------|---------|
| Pattern | `pattern-` | `pattern-error-handling.md` |
| ADR | `adr-` | `adr-001-auth-strategy.md` |
| Bug | `bug-` | `bug-2024-01-15-null-token.md` |
| Standard | `std-` | `std-naming-conventions.md` |
| Architecture | `arch-` | `arch-2024-01-15-user-module.md` |
| Post-mortem | `postmortem-` | `postmortem-2024-01-15-incident.md` |

## Exemples d'Utilisation

### Nouvelle fonctionnalité

```
/analyze ajouter l'authentification OAuth
  → Comprend le besoin, identifie les contraintes

/explore-options OAuth pour l'authentification
  → Compare OAuth providers, stratégies

/tech-choice utilisation de Auth0
  → Documente la décision dans un ADR

/architecture module d'authentification OAuth
  → Conçoit la structure, les interfaces

/implement auth-module --tdd
  → Implémente avec tests en premier

/test-run auth --coverage
  → Vérifie que tout passe

/code-review auth-module --security
  → Review avec focus sécurité

/pre-merge auth-feature --pr
  → Prépare la PR

/capitalize OAuth integration --pattern
  → Documente le pattern pour réutilisation
```

### Correction de bug

```
/debug le login échoue avec des emails en majuscules
  → Diagnostique, trouve la cause racine

/test-write email-normalization --unit
  → Ajoute des tests de régression

/test-run email --verbose
  → Vérifie les corrections

/capitalize email case sensitivity bug --bug
  → Documente pour éviter la récurrence
```

### Après un incident

```
/post-mortem incident de production du 15/01 --incident --blameless
  → Analyse complète, actions, leçons
```

## Bonnes Pratiques

### Utiliser les transitions

Chaque skill suggère la prochaine étape. Suivre ces transitions assure un workflow cohérent.

### Capitaliser systématiquement

À la fin de chaque skill, penser à capitaliser :
- Patterns utiles découverts
- Décisions techniques prises
- Bugs résolus et leurs solutions
- Standards à formaliser

### Consulter avant d'agir

Au début de chaque skill, consulter SERENA :
- Existe-t-il déjà une solution ?
- Quels patterns utiliser ?
- Y a-t-il des pièges documentés ?

## Structure des Fichiers

```
_claude/skills/
├── README.md                 # Ce fichier
├── analyze/
│   └── SKILL.md
├── explore-options/
│   └── SKILL.md
├── tech-choice/
│   └── SKILL.md
├── architecture/
│   └── SKILL.md
├── implement/
│   └── SKILL.md
├── test-write/
│   └── SKILL.md
├── test-run/
│   └── SKILL.md
├── debug/
│   └── SKILL.md
├── code-review/
│   ├── SKILL.md
│   └── references/
│       └── checklist.md
├── document/
│   └── SKILL.md
├── capitalize/
│   └── SKILL.md
├── pre-merge/
│   └── SKILL.md
├── post-mortem/
│   └── SKILL.md
├── clean-code/              # Existant
│   └── SKILL.md
├── refactor/                # Existant
│   └── SKILL.md
├── explain-code/            # Existant
│   └── SKILL.md
└── fix-issue/               # Existant
    └── SKILL.md
```

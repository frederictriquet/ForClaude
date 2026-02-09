# Skills de Développement

Un ensemble de skills atomiques couvrant tout le cycle de développement, avec intégration SERENA pour capitaliser les apprentissages.

## Philosophie

Chaque skill suit le **Single Responsibility Principle** :
- Une skill = une phase du développement
- Transitions claires entre skills
- Capitalisation systématique via SERENA

## Workflow Typique

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                          CYCLE DE DÉVELOPPEMENT                              │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────┐     ┌─────────────────┐     ┌──────────────┐                   │
│  │ /analyze │ ──▶ │ /explore-options│ ──▶ │ /tech-choice │                   │
│  └──────────┘     └─────────────────┘     └──────────────┘                   │
│       │                                          │                           │
│       │  ┌───────────────────┐   ┌───────────────┘                           │
│       └▶ │ /roadmap-update   │ ◀─┘                                           │
│          │  --in-progress    │                                               │
│          └─────────┬─────────┘                                               │
│                    ▼                                                         │
│          ┌──────────────────┐                                                │
│          │   /architecture  │                                                │
│          └──────────────────┘                                                │
│                    │                                                         │
│  ┌─────────────────┼─────────────────────────────────────────────────────┐   │
│  │                 ▼              BOUCLE DE RÉTROACTION                  │   │
│  │       ┌──────────────────┐                                            │   │
│  │   ┌──▶│   /implement     │                                            │   │
│  │   │   └────────┬─────────┘                                            │   │
│  │   │            ▼                                                      │   │
│  │   │   ┌──────────────────┐                                            │   │
│  │   │   │   /test-write    │                                            │   │
│  │   │   └────────┬─────────┘                                            │   │
│  │   │            ▼                                                      │   │
│  │   │   ┌──────────────────┐     ┌──────────┐                           │   │
│  │   │   │   /test-run      │ ──▶ │  /debug  │ ──┐                       │   │
│  │   │   └────────┬─────────┘ (❌) └──────────┘   │                       │   │
│  │   │            │ (✅)                          │                       │   │
│  │   │            ▼                               │                       │   │
│  │   │   ┌──────────────────┐                     │                       │   │
│  │   │   │  /quality-check  │ ◀───────────────────┘                       │   │
│  │   │   └────────┬─────────┘                                            │   │
│  │   │            │ (✅)                                                  │   │
│  │   │            ▼                                                      │   │
│  │   │   ┌──────────────────┐                                            │   │
│  │   │   │   /code-review   │                                            │   │
│  │   │   └────────┬─────────┘                                            │   │
│  │   │            │                                                      │   │
│  │   │     ┌──────┴──────┐                                               │   │
│  │   │     │             │                                               │   │
│  │   │    (✅)          (🔄 corrections requises)                         │   │
│  │   │     │             │                                               │   │
│  │   │     │             └───────────────────────────────────────────┐   │   │
│  │   │     │                                                         │   │   │
│  │   └─────┼─────────────────────────────────────────────────────────┘   │   │
│  │         │  ⬆ Retour à /implement ou /test-write selon les corrections │   │
│  └─────────┼─────────────────────────────────────────────────────────────┘   │
│            ▼                                                                 │
│          ┌──────────────────┐                                                │
│          │    /document     │                                                │
│          └──────────────────┘                                                │
│                    │                                                         │
│                    ▼                                                         │
│          ┌──────────────────┐                                                │
│          │   /capitalize    │                                                │
│          └──────────────────┘                                                │
│                    │                                                         │
│                    ▼                                                         │
│          ┌───────────────────┐                                               │
│          │ /roadmap-update   │                                               │
│          │     --done        │                                               │
│          └─────────┬─────────┘                                               │
│                    │                                                         │
│                    ▼                                                         │
│          ┌──────────────────┐                                                │
│          │   /pre-merge     │  ← Le merge arrive EN DERNIER                  │
│          └──────────────────┘                                                │
│                    │                                                         │
│                    ▼                                                         │
│          ┌──────────────────┐                                                │
│          │  /post-mortem    │  (si incident ou fin de sprint)                │
│          └──────────────────┘                                                │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

## Boucles de Rétroaction

Le workflow n'est **pas linéaire**. Après une code-review, on peut revenir en arrière :

| Situation après /code-review | Retour à | Raison |
|------------------------------|----------|--------|
| 🔄 Corrections mineures de code | `/implement` | Modifier le code |
| 🔄 Tests manquants ou insuffisants | `/test-write` | Ajouter des tests |
| 🔄 Tests échouent après correction | `/test-run` → `/debug` | Valider les corrections |
| 🔄 Architecture à revoir | `/architecture` | Repenser la conception |

**Après chaque boucle de correction** : repasser par `/test-run` puis `/code-review` avant de continuer.

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
| `/quality-check` | Lint, formatage et checks de qualité | `--fix`, `--strict` |
| `/debug` | Diagnostique et corrige un bug | `--verbose` |

### Phase de Validation

| Skill | Description | Flags |
|-------|-------------|-------|
| `/code-review` | Effectue une revue de code | `--security`, `--performance`, `--thorough` |
| `/document` | Documente le code | `--api`, `--readme`, `--inline` |
| `/pre-merge` | Prépare le merge | `--pr`, `--squash` |

### Phase de Capitalisation et Suivi

| Skill | Description | Flags |
|-------|-------------|-------|
| `/roadmap-update` | Met à jour le statut dans la roadmap | `--done`, `--in-progress`, `--blocked` |
| `/capitalize` | Capitalise les apprentissages | `--pattern`, `--adr`, `--bug`, `--standard` |
| `/post-mortem` | Analyse un incident/session | `--incident`, `--session`, `--blameless` |

### Skills Utilitaires

| Skill | Description | Flags |
|-------|-------------|-------|
| `/next` | **Rappelle le contexte et propose la prochaine étape** | `--status`, `--reset` |
| `/clean-code` | Nettoie et améliore la maintenabilité | `--audit-all` |
| `/refactor` | Refactorise sans changer le comportement | - |
| `/explain-code` | Explique du code avec des analogies | - |
| `/fix-issue` | Corrige une issue GitHub | - |

## Continuité du Workflow

### Problème résolu

Sur des processus longs, il est facile de perdre le fil. Les skills intègrent maintenant :

1. **Tracking automatique** : Chaque skill met à jour `workflow-current.md` dans SERENA
2. **Transitions explicites** : Chaque skill propose clairement la prochaine étape
3. **Skill `/next`** : Rappelle le contexte et suggère la suite à tout moment

### Utilisation de `/next`

```bash
# Voir où on en est
/next --status

# Reprendre le workflow (affiche contexte + suggestion)
/next

# Réinitialiser pour une nouvelle tâche
/next --reset
```

### Exemple de rappel automatique

Après chaque skill, vous verrez :

```
---
## ✅ [Skill] Terminée

**Résumé** : [Ce qui a été fait]

→ **Prochaine étape** : `/[skill]` [arguments]

💡 `/next` pour voir le workflow complet
---
```

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

### Nouvelle fonctionnalité (workflow complet)

```
/analyze ajouter l'authentification OAuth
  → Vérifie la branche (propose feature/oauth-login)
  → Comprend le besoin, identifie les contraintes
  → Crée la branche si accepté

/explore-options OAuth pour l'authentification
  → Compare OAuth providers, stratégies

/tech-choice utilisation de Auth0
  → Documente la décision dans un ADR

/roadmap-update "Authentification OAuth" --in-progress
  → Marque la tâche comme en cours

/architecture module d'authentification OAuth
  → Conçoit la structure, les interfaces

/implement auth-module --tdd
  → Vérifie qu'on est sur la bonne branche
  → Implémente avec tests en premier

/test-run auth --coverage
  → Vérifie que tout passe

/code-review auth-module --security
  → Review avec focus sécurité

/document auth-module --api
  → Documente l'API et le module

/capitalize OAuth integration --pattern
  → Sauvegarde le pattern pour réutilisation

/roadmap-update "Authentification OAuth" --done
  → Marque la tâche comme terminée ✅

/pre-merge auth-feature --pr
  → Crée la PR et merge (DERNIÈRE ÉTAPE)
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

/roadmap-update "Fix email case sensitivity" --done
  → Met à jour la roadmap
```

### Gestion de blocage

```
/roadmap-update "Déploiement prod" --blocked "En attente validation sécurité"
  → Documente le blocage avec la raison
```

### Après un incident

```
/post-mortem incident de production du 15/01 --incident --blameless
  → Analyse complète, actions, leçons
```

## ⛔ RÈGLES STRICTES — INTERDICTIONS ABSOLUES

### Ces règles sont IMPÉRATIVES. Aucune exception, aucun raccourci.

#### 1. ORDRE DU WORKFLOW : NON NÉGOCIABLE

L'ordre de finalisation après implémentation est **fixe et obligatoire** :

```
/implement → /test-write → /test-run → /quality-check → /code-review → /document → /capitalize → /roadmap-update --done → /pre-merge
```

**`/pre-merge` est TOUJOURS la DERNIÈRE étape.** Aucune étape ne peut être sautée.

#### 2. INTERDICTIONS EXPLICITES PAR SKILL

| Après cette skill | ⛔ INTERDIT de proposer | ✅ Proposer à la place |
|-------------------|------------------------|----------------------|
| `/implement` | `/pre-merge`, `/code-review`, commit | `/test-write` |
| `/test-write` | `/pre-merge`, `/code-review` | `/test-run` |
| `/test-run` ✅ | `/pre-merge`, `/code-review` (il reste 6 étapes !) | `/quality-check` |
| `/quality-check` ✅ | `/pre-merge` (il reste 5 étapes !) | `/code-review` |
| `/quality-check` ❌ | `/code-review`, `/pre-merge` | Corriger → `/test-run` → `/quality-check` |
| `/code-review` ✅ | `/pre-merge` (il reste 3 étapes !) | `/document` |
| `/code-review` 🔄 | `/pre-merge`, `/document` | Boucle de correction |
| `/document` | `/pre-merge` (il reste 2 étapes !) | `/capitalize` |
| `/capitalize` | `/pre-merge` (il reste 1 étape !) | `/roadmap-update --done` |

#### 3. BOUCLES DE RÉTROACTION OBLIGATOIRES

Après une `/code-review` 🔄 (changements requis), **TOUJOURS** :

```
corrections → /test-write (si tests à ajouter) → /test-run → /code-review (re-review)
```

**On ne passe à `/document` qu'après un ✅ de la code-review.**

#### 4. RÈGLES D'OR

> **Si tu hésites entre proposer la prochaine skill du workflow ou proposer un commit/merge : TOUJOURS proposer la prochaine skill.**

> **Après des corrections demandées en code-review : TOUJOURS repasser par /test-run puis /code-review.**

#### 5. VÉRIFICATION DES PRÉREQUIS (GATES)

Chaque skill DOIT vérifier `workflow-current.md` au début et refuser de s'exécuter si les prérequis ne sont pas remplis :

| Skill | Prérequis obligatoires | Gate implémenté ? |
|-------|----------------------|-------------------|
| `/test-run` | `/implement` ✅, `/test-write` ✅ ou tests existants | ✅ OUI |
| `/quality-check` | `/test-run` ✅ | ✅ OUI |
| `/code-review` | `/quality-check` ✅ | ✅ OUI |
| `/document` | `/code-review` ✅ (approuvé, pas 🔄) | ✅ OUI |
| `/capitalize` | `/document` ✅ | ✅ OUI |
| `/roadmap-update --done` | `/capitalize` ✅ | ✅ OUI |
| `/pre-merge` | TOUTES les étapes précédentes ✅ | ✅ OUI |

#### 6. FORMAT STANDARD DE GATE

Chaque skill avec prérequis inclut cette vérification :

```markdown
## 0. Vérification des Prérequis (OBLIGATOIRE)

### Consulter l'état du workflow
mcp__serena__read_memory("workflow-current.md")

### Prérequis pour cette skill
| # | Prérequis | Status requis |
|---|-----------|---------------|
| 1 | /[skill-précédente] | ✅ |

### 🛑 SI PRÉREQUIS NON REMPLIS
STOP ! Afficher le message d'erreur et proposer l'étape manquante.
```

---

## Bonnes Pratiques

### Respecter les limites de chaque skill

⚠️ **Chaque skill a un scope strict**. Ne pas digresser :

| Pendant... | Ne pas faire... | À la place... |
|------------|-----------------|---------------|
| `/analyze` | Coder | Noter et passer à `/implement` |
| `/explore-options` | Implémenter complètement | Mini-PoC max, puis `/tech-choice` |
| `/architecture` | Créer les fichiers | Planifier, puis `/implement` |
| `/implement` | Refactorer tout | Implémenter, puis `/refactor` |
| `/debug` | Refactorer | Fix minimal, puis `/refactor` |
| `/code-review` | Corriger le code | Feedback, l'auteur corrige |
| `/document` | Modifier le code | Documenter, suggérer `/refactor` |

### Vérifier la branche au début

⚠️ **Toujours vérifier qu'on est sur la bonne branche avant d'implémenter** :

| Si sur... | Action |
|-----------|--------|
| `main` ou `master` | Créer une branche `feature/xxx` |
| `develop` | Selon les conventions du projet |
| `feature/xxx`, `fix/xxx` | ✅ OK si correspond à la tâche |

**Conventions de nommage** :
- `feature/[description]` - Nouvelles fonctionnalités
- `fix/[description]` - Corrections de bugs
- `refactor/[description]` - Refactoring
- `hotfix/[description]` - Correctifs urgents

### Utiliser les transitions

Chaque skill suggère la prochaine étape. Suivre ces transitions assure un workflow cohérent.

### Mettre à jour la roadmap

- **Au début** : `/roadmap-update [tâche] --in-progress`
- **En cas de blocage** : `/roadmap-update [tâche] --blocked "[raison]"`
- **Avant le merge** : `/roadmap-update [tâche] --done`

### Ordre de finalisation (après code-review)

⚠️ **Le merge arrive EN DERNIER** pour s'assurer que tout est documenté et capitalisé :

```
/code-review ✅
    ↓
/document      ← Documenter le code
    ↓
/capitalize    ← Sauvegarder les apprentissages
    ↓
/roadmap-update --done  ← Marquer comme terminé
    ↓
/pre-merge     ← Merger (DERNIÈRE ÉTAPE)
```

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
├── quality-check/
│   └── SKILL.md
├── code-review/
│   ├── SKILL.md
│   └── references/
│       └── checklist.md
├── document/
│   └── SKILL.md
├── roadmap-update/           # Gestion de roadmap
│   └── SKILL.md
├── next/                     # Continuité du workflow
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

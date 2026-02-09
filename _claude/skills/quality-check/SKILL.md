---
name: quality-check
description: Exécute le linting, formatage et checks de qualité du code
argument-hint: [--fix] [--strict] [pattern]
model: haiku
---

# Quality Check

Exécute les vérifications de qualité pour :

$ARGUMENTS

## Objectif

S'assurer que le code respecte les **standards de qualité** (linting, formatage, types) **avant** la code-review.

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
| 2 | `/test-run` | ✅ tests passent | STOP → `/test-run` |

### 🛑 SI PRÉREQUIS NON REMPLIS

**NE PAS CONTINUER.** Afficher :

```markdown
⛔ **PRÉREQUIS MANQUANT**

`/quality-check` requiert que `/test-run` soit ✅.

→ **Action requise** : Exécuter `/test-run` d'abord

⚠️ Ordre obligatoire : implement → test-write → test-run → quality-check
```

---

## ⛔ POSITION DANS LE WORKFLOW

### Cette skill est OBLIGATOIRE entre /test-run et /code-review

```
/implement → /test-write → /test-run → /quality-check → /code-review → ...
```

### ⛔ INTERDIT

- Exécuter `/code-review` sans avoir passé `/quality-check`
- Proposer `/pre-merge` depuis cette skill (il reste 5 étapes !)

---

## 1. Détection de l'Environnement

### Identifier les outils du projet

```bash
# Vérifier package.json pour les scripts
cat package.json | grep -E "(lint|format|check|prettier|eslint|tsc)"

# Ou pour Python
ls -la pyproject.toml setup.cfg .flake8 .pylintrc 2>/dev/null

# Ou pour Rust
ls -la rustfmt.toml .rustfmt.toml Cargo.toml 2>/dev/null
```

### Outils courants par langage

| Langage | Linter | Formatter | Type Check |
|---------|--------|-----------|------------|
| **TypeScript/JS** | ESLint | Prettier | tsc |
| **Python** | flake8, pylint, ruff | black, isort | mypy, pyright |
| **Rust** | clippy | rustfmt | (compilateur) |
| **Go** | golint, staticcheck | gofmt | (compilateur) |
| **Java** | checkstyle, spotbugs | google-java-format | (compilateur) |

---

## 2. Exécution des Checks

### TypeScript/JavaScript

```bash
# Lint
npm run lint
# ou
npx eslint . --ext .ts,.tsx,.js,.jsx

# Format check (sans modifier)
npm run format:check
# ou
npx prettier --check .

# Type check
npm run typecheck
# ou
npx tsc --noEmit
```

### Python

```bash
# Lint
ruff check .
# ou
flake8 .
# ou
pylint **/*.py

# Format check
black --check .
isort --check-only .

# Type check
mypy .
# ou
pyright
```

### Rust

```bash
# Lint
cargo clippy -- -D warnings

# Format check
cargo fmt --check

# (Type check inclus dans la compilation)
cargo check
```

---

## 3. Mode Fix (`--fix`)

### Corriger automatiquement les erreurs corrigibles

```bash
# TypeScript/JS
npm run lint -- --fix
npx prettier --write .

# Python
ruff check --fix .
black .
isort .

# Rust
cargo clippy --fix
cargo fmt
```

### ⚠️ Après un fix automatique

1. Vérifier les changements (`git diff`)
2. Re-exécuter les tests (`/test-run`)
3. Committer les corrections de formatage séparément

---

## 4. Mode Strict (`--strict`)

### Checks supplémentaires

```bash
# TypeScript - vérifications strictes
npx tsc --noEmit --strict

# ESLint - toutes les règles
npx eslint . --max-warnings 0

# Python - vérifications strictes
mypy --strict .
ruff check --select ALL .
```

### Métriques additionnelles

- Complexité cyclomatique
- Couverture de documentation
- Dépendances circulaires
- Code mort

---

## 5. Rapport de Qualité

### Template de rapport

```markdown
## Rapport de Qualité

**Date** : [timestamp]
**Scope** : [fichiers ou pattern]

### Résumé

| Check | Status | Erreurs | Warnings |
|-------|--------|---------|----------|
| Lint | ✅/❌ | X | Y |
| Format | ✅/❌ | X | - |
| Types | ✅/❌ | X | Y |

### Détails des Erreurs

#### Lint (X erreurs)

| Fichier | Ligne | Règle | Message |
|---------|-------|-------|---------|
| `file.ts` | 42 | no-unused-vars | 'x' is defined but never used |

#### Types (X erreurs)

| Fichier | Ligne | Message |
|---------|-------|---------|
| `file.ts` | 78 | Type 'string' is not assignable to type 'number' |

### Actions Requises

- [ ] Corriger les erreurs de lint
- [ ] Corriger les erreurs de type
- [ ] Reformatter le code
```

---

## 6. Catégorisation des Erreurs

### Niveaux de sévérité

| Niveau | Action | Exemples |
|--------|--------|----------|
| 🚨 **Erreur** | Bloquant, doit être corrigé | Erreur de type, variable non définie |
| ⚠️ **Warning** | À corriger avant review | Variable non utilisée, import inutilisé |
| 💡 **Info** | Suggestion d'amélioration | Complexité élevée, nommage |

### Règles de blocage

| Situation | Peut continuer vers /code-review ? |
|-----------|-----------------------------------|
| 0 erreurs, 0 warnings | ✅ Oui |
| 0 erreurs, N warnings | ⚠️ Oui avec justification |
| N erreurs | ❌ Non, corriger d'abord |

---

## 7. Intégration avec la Boucle de Rétroaction

### Si des erreurs sont trouvées

```
/quality-check ❌
       │
       ▼
  Corrections nécessaires
       │
       ├── Erreurs de code → /implement (corriger)
       │                          ↓
       │                     /test-run (re-valider)
       │                          ↓
       └──────────────────▶ /quality-check (re-vérifier)
                                  │
                                 (✅)
                                  ↓
                            /code-review
```

### Après corrections

1. Re-exécuter `/test-run` pour valider que les corrections n'ont rien cassé
2. Re-exécuter `/quality-check` pour confirmer que tout est propre
3. Seulement alors passer à `/code-review`

---

## 8. Configuration Projet

### Vérifier/créer les configs

Si les configs n'existent pas, proposer de les créer :

```bash
# ESLint
npx eslint --init

# Prettier
echo '{"semi": true, "singleQuote": true}' > .prettierrc

# TypeScript
npx tsc --init
```

### Configs recommandées à capitaliser

Si une bonne config est créée, la sauvegarder dans SERENA :

```
mcp__serena__write_memory
  memory_file_name: "std-linting-config.md"
```

---

## 9. Hooks Pre-commit

### Vérifier si configuré

```bash
cat .husky/pre-commit 2>/dev/null || cat .git/hooks/pre-commit 2>/dev/null
```

### Suggérer si absent

```markdown
💡 **Suggestion** : Configurer un hook pre-commit pour exécuter automatiquement les checks.

```bash
# Avec Husky (Node.js)
npx husky add .husky/pre-commit "npm run lint && npm run typecheck"

# Avec pre-commit (Python)
# .pre-commit-config.yaml
```
```

---

## 10. Capitalisation SERENA

### À capitaliser

```
mcp__serena__write_memory
```

- Configs de lint optimales pour le projet
- Règles désactivées et pourquoi
- Patterns de code à éviter identifiés

---

## Transition vers la prochaine phase

| Résultat | Prochaine skill | ⛔ INTERDIT |
|----------|-----------------|-------------|
| ✅ Tous les checks passent | `/code-review` | `/pre-merge` (il reste 5 étapes !) |
| ❌ Erreurs de lint/types | Corriger → `/test-run` → `/quality-check` | `/code-review`, `/pre-merge` |
| ⚠️ Warnings uniquement | `/code-review` (avec note) | `/pre-merge` (il reste 5 étapes !) |

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /quality-check [✅|❌|⚠️]
  → Noter les erreurs/warnings dans "Contexte Clé"
```

2. **Afficher le résumé de transition** :
```markdown
---
## [✅|❌|⚠️] Quality Check Terminé

**Lint** : X erreurs, Y warnings
**Types** : X erreurs
**Format** : ✅/❌

[Si erreurs:]
→ **Prochaine étape** : Corriger les erreurs puis `/test-run` → `/quality-check`

[Si OK:]
→ **Prochaine étape** : `/code-review`

💡 `/next` pour voir le workflow complet
---
```

3. **Ne jamais proposer /code-review si des erreurs existent**

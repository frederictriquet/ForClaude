---
name: next
description: Rappelle le contexte du workflow en cours et propose la prochaine étape
argument-hint: [--status] [--reset]
model: haiku
---

# Prochaine Étape du Workflow

$ARGUMENTS

## Objectif

Maintenir la **continuité du workflow** en rappelant le contexte et en proposant la prochaine skill à exécuter.

---

## ⛔ RÈGLES STRICTES DU WORKFLOW (INTERDICTIONS)

### Ces règles sont IMPÉRATIVES et ne peuvent JAMAIS être contournées :

1. **JAMAIS de commit/merge/PR avant d'avoir complété TOUTES les étapes de validation**
   - L'ordre est : `/implement` → `/test-write` → `/test-run` → `/code-review` → `/document` → `/capitalize` → `/roadmap-update --done` → `/pre-merge`
   - `/pre-merge` est la DERNIÈRE étape, JAMAIS avant

2. **JAMAIS proposer une action qui saute des étapes**
   - Si la dernière skill complétée est `/implement`, la prochaine est `/test-write` ou `/test-run`, JAMAIS `/pre-merge` ni "on commit ?"
   - Si la dernière skill est `/code-review`, la prochaine est `/document`, JAMAIS `/pre-merge`

3. **JAMAIS proposer un commit comme action finale d'une skill**
   - Les commits incrémentaux pendant `/implement` sont OK
   - Proposer "on commit et merge ?" comme conclusion d'une skill est INTERDIT
   - Le commit/merge final est exclusivement géré par `/pre-merge`

4. **JAMAIS ignorer le workflow-current.md dans SERENA**
   - Toujours lire `workflow-current.md` avant de suggérer la prochaine étape
   - Si le workflow indique des étapes non complétées, ne pas les sauter

5. **TOUJOURS proposer EXACTEMENT la prochaine étape selon la matrice de transitions**
   - Pas d'interprétation, pas de raccourcis, pas de "on peut simplifier"
   - Même si le projet semble simple, le workflow complet s'applique

### En cas de doute : consulter la matrice de transitions ci-dessous et proposer UNIQUEMENT l'étape suivante.

---

## 0. Récupération du Contexte

### Lire l'état du workflow

```
mcp__serena__read_memory
  memory_file_name: "workflow-current.md"
```

### Si pas de workflow en cours

Proposer de démarrer avec `/analyze` pour une nouvelle tâche.

---

## 1. Vérification de Branche

### Toujours vérifier la branche au début

```bash
git branch --show-current
git status --short
```

### Inclure dans le status

```markdown
## 🌿 Branche : `feature/xxx`
```

### ⚠️ Alerter si sur main ou master

```markdown
⚠️ **Attention** : Vous êtes sur la branche principale (`main` ou `master`).
Créez une branche feature avant de continuer l'implémentation.
```

---

## 2. Affichage du Status (`--status`)

### Format de rappel

```markdown
## 🌿 Branche : `[branche-actuelle]`

## 📍 Workflow en Cours

**Tâche** : [Description de la tâche]
**Démarrée** : [Date/heure]
**Phase actuelle** : [Nom de la phase]
**Dernière skill** : [Skill exécutée]

### Progression

✅ /analyze - Terminé
✅ /explore-options - Terminé
✅ /tech-choice - Terminé
🔄 /architecture - EN COURS
⬜ /implement
⬜ /test-write
⬜ /test-run
⬜ /code-review
⬜ /pre-merge
⬜ /roadmap-update --done
⬜ /capitalize

### Contexte clé
- [Point important 1]
- [Point important 2]
- [Décision prise]

### Prochaine étape recommandée
→ `/[skill]` [arguments suggérés]
```

---

## 2. Logique de Suggestion

### Matrice de transitions (flux principal)

| Dernière skill complétée | Prochaine skill suggérée | ⛔ INTERDIT |
|--------------------------|--------------------------|-------------|
| `/analyze` | `/explore-options` ou `/architecture` (si simple) | Coder, commit |
| `/explore-options` | `/tech-choice` | Implémenter |
| `/tech-choice` | `/roadmap-update --in-progress` puis `/architecture` | Implémenter |
| `/architecture` | `/implement` | - |
| `/implement` | `/test-write` (par défaut) | `/pre-merge`, `/code-review`, `/quality-check` |
| `/implement` (si tests existants couvrent) | `/test-run` (exception) | `/pre-merge`, `/code-review` |
| `/test-write` | `/test-run` | `/pre-merge`, `/code-review` |
| `/test-run` (✅ couverture > 85%) | `/quality-check` | `/pre-merge`, `/code-review` (il reste 6 étapes) |
| `/test-run` (⚠️ couverture 70-85%) | `/quality-check` avec avertissement | `/pre-merge`, `/code-review` |
| `/test-run` (🟡 couverture < 70%) | `/test-write` (BLOQUANT) | `/quality-check`, `/code-review`, `/pre-merge` |
| `/test-run` (❌ tests échouent) | `/debug` | `/quality-check`, `/code-review`, `/pre-merge` |
| `/debug` | `/test-run` | `/pre-merge` |
| `/quality-check` (✅) | `/code-review` | `/pre-merge` (5 étapes restantes) |
| `/quality-check` (❌) | Corriger → `/test-run` → `/quality-check` | `/code-review`, `/pre-merge` |
| `/code-review` (✅) | `/document` | `/pre-merge` (il reste 4 étapes) |
| `/code-review` (🔄) | Voir "Boucles de rétroaction" ci-dessous | `/pre-merge`, `/document` |
| `/document` | `/capitalize` | `/pre-merge` (2 étapes restantes) |
| `/capitalize` | `/roadmap-update --done` | `/pre-merge` (1 étape restante) |
| `/roadmap-update --done` | `/pre-merge` ← SEUL moment autorisé | - |
| `/pre-merge` | Workflow terminé ou `/post-mortem` | - |

### Boucles de rétroaction (après /code-review 🔄 ou /quality-check ❌)

Quand une code-review demande des corrections ou que le quality-check échoue, le workflow **revient en arrière** :

| Type de correction demandée | Retour à | Puis |
|-----------------------------|----------|------|
| Corrections de code | `/implement` | → `/test-write` → `/test-run` → `/quality-check` → `/code-review` |
| Tests manquants/insuffisants | `/test-write` | → `/test-run` → `/quality-check` → `/code-review` |
| Tests échouent | `/debug` | → `/test-run` → `/quality-check` → `/code-review` |
| Erreurs de lint/types | Corriger | → `/test-run` → `/quality-check` → `/code-review` |
| Problème d'architecture | `/architecture` | → `/implement` → ... → `/code-review` |

**⚠️ IMPORTANT** : Après CHAQUE boucle de correction, il faut :
1. Repasser par `/test-run` pour valider que les corrections n'ont rien cassé
2. Repasser par `/quality-check` pour vérifier lint et types
3. Repasser par `/code-review` pour re-review
4. SEULEMENT après ✅ de la re-review, continuer vers `/document`

---

## 3. Rappel du Contexte

### Informations à rappeler

1. **Objectif initial** : Ce qu'on cherche à accomplir
2. **Décisions prises** : ADR, choix techniques
3. **Blocages éventuels** : Ce qui attend
4. **Fichiers modifiés** : Liste des fichiers touchés
5. **Tests status** : Passent ou non

### Extraire depuis SERENA

```
mcp__serena__read_memory - workflow-current.md
mcp__serena__search_for_pattern - Changements récents
```

---

## 4. Mise à Jour du Workflow

### Après chaque skill

Le workflow doit être mis à jour automatiquement. Format de `workflow-current.md` :

```markdown
# Workflow Actif

## Tâche
[Description]

## Démarré
YYYY-MM-DD HH:MM

## Historique
| Timestamp | Skill | Status | Notes |
|-----------|-------|--------|-------|
| HH:MM | /analyze | ✅ | Besoin clarifié |
| HH:MM | /explore-options | ✅ | 3 options identifiées |
| HH:MM | /tech-choice | ✅ | Option B choisie |
| HH:MM | /architecture | 🔄 | En cours |

## Phase Actuelle
/architecture

## Contexte Clé
- [Point 1]
- [Point 2]

## Prochaine Étape
/implement

## Fichiers Concernés
- path/to/file1.ts
- path/to/file2.ts
```

---

## 5. Reset du Workflow (`--reset`)

### Quand utiliser

- Tâche abandonnée
- Changement de priorité
- Nouveau workflow à démarrer

### Action

```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Archiver dans workflow-archive-YYYY-MM-DD.md
  → Créer nouveau workflow vide
```

---

## 6. Commandes Rapides

### Voir le status
```
/next --status
```

### Continuer le workflow
```
/next
→ Affiche le contexte et lance la skill suivante
```

### Réinitialiser
```
/next --reset
```

---

## 7. Intégration avec les Autres Skills

### Chaque skill doit

À la **fin** de son exécution :

1. Mettre à jour `workflow-current.md` via SERENA
2. Afficher clairement la prochaine étape
3. Proposer d'exécuter `/next` si l'utilisateur perd le fil

### Template de fin de skill

```markdown
---

## ✅ [Skill] Terminée

**Résumé** : [Ce qui a été fait]

**Prochaine étape** : `/[next-skill]` [args]

💡 *Utilisez `/next` à tout moment pour voir le status du workflow*

---
```

---

## 8. Gestion des Interruptions

### Si le workflow est interrompu

Lors du retour :

1. `/next --status` pour voir où on en était
2. Rappel du contexte complet
3. Proposition de reprendre ou reset

### Détection d'interruption

Si la dernière mise à jour du workflow date de :
- < 1h : Continuer normalement
- 1-24h : Rappeler le contexte avant de continuer
- > 24h : Proposer un rappel détaillé ou reset

---

## 9. Exemple d'Utilisation

### Scénario : Reprise après interruption

```
User: /next

Claude:
## 📍 Workflow en Cours

**Tâche** : Implémenter l'authentification OAuth
**Démarrée** : 2024-01-15 09:30
**Phase actuelle** : Implémentation

### Progression
✅ /analyze - Besoin clarifié, contraintes identifiées
✅ /explore-options - Auth0, Cognito, custom comparés
✅ /tech-choice - Auth0 choisi (ADR-003)
✅ /roadmap-update --in-progress
✅ /architecture - Module auth conçu
🔄 /implement - 60% complété
⬜ /test-write
⬜ /test-run
⬜ /code-review
⬜ /pre-merge
⬜ /roadmap-update --done

### Contexte clé
- Utilisation de Auth0 avec PKCE flow
- Fichiers : src/auth/*, src/middleware/auth.ts
- Dernier commit : "feat(auth): add token refresh logic"

### Prochaine action
→ Continuer `/implement` sur le module de logout

Voulez-vous continuer l'implémentation ?
```

---

## 10. Instructions pour les Autres Skills

### IMPORTANT : Mise à jour automatique

**Chaque skill DOIT** à la fin de son exécution :

1. **Sauvegarder l'état** dans `workflow-current.md`
2. **Afficher clairement** la transition suggérée
3. **Rappeler** que `/next` est disponible

### Code à ajouter en fin de chaque skill

```markdown
---

## 🔄 Mise à Jour Workflow

**Skill complétée** : /[nom-skill]
**Status** : ✅ Succès / ⚠️ Partiel / ❌ Échec
**Notes** : [Résumé en 1 ligne]

→ **Prochaine étape** : `/[next-skill]` [arguments]

---

💡 **Rappel** : Utilisez `/next` pour voir le status complet du workflow
```

---

## 11. Création/Mise à Jour du Workflow

### Au début d'un nouveau workflow

```
mcp__serena__write_memory
  memory_file_name: "workflow-current.md"
  content: [template initial]
```

### Après chaque skill

```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter la ligne dans l'historique
  → Mettre à jour la phase actuelle
  → Mettre à jour la prochaine étape
```

---

## 12. Workflow Template Initial

```markdown
# Workflow Actif

## Tâche
[À remplir par /analyze]

## Objectif
[Description claire de ce qu'on veut accomplir]

## Démarré
[YYYY-MM-DD HH:MM]

## Historique
| Timestamp | Skill | Status | Notes |
|-----------|-------|--------|-------|

## Phase Actuelle
/analyze

## Contexte Clé
- [À enrichir au fil du workflow]

## Décisions Prises
- [ADR et choix techniques]

## Fichiers Concernés
- [À enrichir]

## Prochaine Étape
[À déterminer]

## Blocages
- [Si applicable]
```

---

## Transitions

| Situation | Action |
|-----------|--------|
| Workflow actif trouvé | Afficher status et suggérer suite |
| Pas de workflow | Proposer `/analyze` pour démarrer |
| Reset demandé | Archiver et créer nouveau |
| Workflow terminé | Proposer `/post-mortem --session` |
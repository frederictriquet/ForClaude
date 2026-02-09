---
name: pre-merge
description: Prépare et valide une branche avant le merge avec checklist complète
argument-hint: [branche] [--pr] [--squash]
model: sonnet
---

# Pré-Merge

Prépare le merge de la branche :

$ARGUMENTS

## Objectif

S'assurer que **tout est prêt** pour un merge propre et sans régression.

---

## ⛔ GATE OBLIGATOIRE — PRÉREQUIS BLOQUANTS

### ⚠️ CETTE SKILL EST LA DERNIÈRE DU WORKFLOW

`/pre-merge` ne doit JAMAIS être proposée ni exécutée avant que TOUTES les étapes précédentes soient terminées.
Compter le nombre d'étapes restantes avant `/pre-merge` et les rappeler à l'utilisateur si nécessaire.

### AVANT TOUTE ACTION, vérifier que TOUTES ces skills ont été complétées :

```
mcp__serena__read_memory
  memory_file_name: "workflow-current.md"
```

### Checklist de prérequis (TOUTES doivent être ✅) :

| # | Prérequis | Status requis | Si manquant |
|---|-----------|---------------|-------------|
| 1 | `/implement` | ✅ code écrit | STOP → exécuter `/implement` |
| 2 | `/test-write` | ✅ tests écrits | STOP → exécuter `/test-write` |
| 3 | `/test-run` | ✅ tous les tests passent | STOP → exécuter `/test-run` |
| 4 | `/code-review` | ✅ **approuvé** (pas 🔄) | STOP → exécuter `/code-review` |
| 5 | `/document` | ✅ documentation à jour | STOP → exécuter `/document` |
| 6 | `/capitalize` | ✅ apprentissages sauvegardés | STOP → exécuter `/capitalize` |
| 7 | `/roadmap-update --done` | ✅ tâche marquée done | STOP → exécuter `/roadmap-update --done` |

### 🛑 SI UN PRÉREQUIS MANQUE :

**NE PAS CONTINUER.** Afficher :

```markdown
⛔ **GATE PRE-MERGE BLOQUÉ**

`/pre-merge` est la DERNIÈRE étape du workflow. Il reste X étapes avant :

Les prérequis suivants ne sont pas remplis :
- [ ] [prérequis manquant 1] ← prochaine étape à exécuter
- [ ] [prérequis manquant 2]
- [ ] ...

→ **Action requise** : exécuter `/[skill manquante]` avant de revenir à `/pre-merge`
```

**Ne jamais contourner ce gate, même si l'utilisateur le demande sans avoir complété les étapes.**
**Ne jamais proposer cette skill avant la fin du workflow complet.**

---

## 0. Consultation SERENA

### Vérification préalable

```
mcp__serena__list_memories - Standards de merge du projet
mcp__serena__read_memory - Checklist de merge si existante
mcp__serena__search_for_pattern - Convention de commits
```

---

## 1. État de la Branche

### Vérification Git

```bash
# Branche actuelle
git branch --show-current

# État par rapport à main/master
git log --oneline main..HEAD

# Fichiers modifiés
git diff --stat main

# Commits à merger
git log --oneline origin/main..HEAD
```

### Rapport d'état

```markdown
## État de la Branche

**Branche** : feature/xxx
**Base** : main
**Commits** : X
**Fichiers modifiés** : Y
**Lignes** : +XXX / -YYY
```

---

## 2. Synchronisation

### Mettre à jour depuis main

```bash
# Récupérer les dernières modifications
git fetch origin main

# Vérifier les conflits potentiels
git merge-base HEAD origin/main

# Rebase ou merge
git rebase origin/main
# ou
git merge origin/main
```

### Résolution de conflits

Si des conflits existent :
1. Identifier les fichiers en conflit
2. Résoudre chaque conflit
3. Tester après résolution
4. Committer la résolution

---

## 3. Checklist de Qualité

### Code

- [ ] Tous les fichiers nécessaires sont inclus
- [ ] Pas de fichiers temporaires/debug
- [ ] Pas de code commenté
- [ ] Pas de console.log/print de debug
- [ ] Pas de TODO non résolu pour ce scope

### Tests

- [ ] Tous les tests passent localement
- [ ] Nouveaux tests pour nouvelles fonctionnalités
- [ ] Couverture de code acceptable
- [ ] Pas de tests flaky

### Documentation

- [ ] README mis à jour si nécessaire
- [ ] CHANGELOG mis à jour
- [ ] Documentation API à jour
- [ ] Commentaires de code appropriés

### Configuration

- [ ] Variables d'environnement documentées
- [ ] Migrations de base de données prêtes
- [ ] Configuration de déploiement à jour

---

## 4. Validation des Tests

### Exécution complète

```bash
# Tests unitaires
npm test

# Tests d'intégration
npm run test:integration

# Tests E2E (si applicable)
npm run test:e2e

# Lint
npm run lint

# Type check
npm run typecheck

# Build
npm run build
```

### Rapport de tests

```markdown
## Résultats des Tests

| Suite | Passés | Échoués | Ignorés |
|-------|--------|---------|---------|
| Unit | X | 0 | Y |
| Integration | X | 0 | Y |
| E2E | X | 0 | Y |

**Couverture** : XX%
```

---

## 5. Historique des Commits

### Vérification

```bash
# Voir l'historique
git log --oneline main..HEAD

# Vérifier les messages
git log --format="%s" main..HEAD
```

### Standards de commits

| Type | Usage |
|------|-------|
| `feat` | Nouvelle fonctionnalité |
| `fix` | Correction de bug |
| `docs` | Documentation |
| `refactor` | Refactoring |
| `test` | Tests |
| `chore` | Maintenance |

### Nettoyage (`--squash`)

Si l'historique doit être nettoyé :

```bash
# Interactive rebase pour squash
git rebase -i main

# Combiner les commits liés
# pick + squash/fixup
```

---

## 6. Création de PR (`--pr`)

### Préparation

```bash
# Push de la branche
git push -u origin feature/xxx
```

### Template de PR

```markdown
## Description

[Description claire et concise des changements]

## Type de changement

- [ ] Bug fix
- [ ] Nouvelle fonctionnalité
- [ ] Breaking change
- [ ] Documentation

## Changements

### Ajouté
- [Élément ajouté]

### Modifié
- [Élément modifié]

### Supprimé
- [Élément supprimé]

## Tests

- [ ] Tests unitaires ajoutés/modifiés
- [ ] Tests d'intégration ajoutés/modifiés
- [ ] Tous les tests passent

## Checklist

- [ ] Mon code suit les conventions du projet
- [ ] J'ai fait une auto-review de mon code
- [ ] J'ai commenté le code complexe
- [ ] J'ai mis à jour la documentation
- [ ] Mes changements ne génèrent pas de warnings
- [ ] J'ai ajouté des tests couvrant mes changements
- [ ] Les tests nouveaux et existants passent

## Screenshots (si applicable)

[Screenshots de changements UI]

## Notes pour les reviewers

[Informations utiles pour la review]
```

### Commande gh

```bash
gh pr create \
  --title "feat: description courte" \
  --body "[contenu de la PR]" \
  --base main \
  --head feature/xxx
```

---

## 7. Vérifications CI/CD

### Attendre les checks

```bash
# Voir le statut des checks
gh pr checks

# Attendre la complétion
gh pr checks --watch
```

### Checks attendus

- [ ] Build réussi
- [ ] Tests passés
- [ ] Lint/format OK
- [ ] Security scan OK
- [ ] Coverage OK

---

## 8. Review Finale

### Auto-review

Avant de demander une review :

```bash
# Voir le diff complet
git diff main...HEAD

# Vérifier chaque fichier
gh pr diff
```

### Points à vérifier

- [ ] Pas de changements accidentels
- [ ] Pas de fichiers sensibles exposés
- [ ] Cohérence du changement
- [ ] Messages de commit clairs

---

## 9. Demande de Review

### Sélection des reviewers

```bash
gh pr edit --add-reviewer @username
```

### Message de review

```markdown
@reviewer PR prête pour review.

**Contexte** : [Bref contexte]

**Points d'attention** :
- [Point 1 à regarder particulièrement]
- [Point 2]

**Questions** :
- [Question pour le reviewer]
```

---

## 10. Après Approbation

### Merge strategy

| Stratégie | Quand utiliser |
|-----------|----------------|
| **Merge commit** | Historique complet important |
| **Squash and merge** | Historique de dev peu important |
| **Rebase and merge** | Historique linéaire souhaité |

### Commandes

```bash
# Merge via gh
gh pr merge --merge
# ou
gh pr merge --squash
# ou
gh pr merge --rebase
```

### Post-merge

```bash
# Supprimer la branche locale
git branch -d feature/xxx

# Supprimer la branche remote
git push origin --delete feature/xxx

# Mettre à jour main local
git checkout main
git pull
```

---

## 11. Capitalisation SERENA

### Après le merge

```
mcp__serena__write_memory
```

**À capitaliser si pertinent :**
- Patterns introduits dans ce changement
- Problèmes rencontrés et solutions
- ADR si décision architecturale prise

### Mise à jour changelog

Si pas fait automatiquement :

```markdown
## [Version] - YYYY-MM-DD

### Added
- [Ce qui a été ajouté dans cette PR]

### Changed
- [Ce qui a été modifié]

### Fixed
- [Ce qui a été corrigé]
```

---

## 12. Checklist Finale

### Avant de merger

- [ ] Branche à jour avec main
- [ ] Tous les tests passent
- [ ] CI/CD checks verts
- [ ] PR approuvée
- [ ] Pas de conflits
- [ ] Documentation à jour
- [ ] Changelog à jour

### Après le merge

- [ ] Branches nettoyées
- [ ] Déploiement vérifié (si applicable)
- [ ] Monitoring en place
- [ ] Communication faite si nécessaire

---

## Transition

| Situation | Prochaine action |
|-----------|------------------|
| Merge réussi | Célébrer, passer au prochain ticket |
| Problème en prod | `/debug` puis `/post-mortem` |
| Retour d'expérience | `/capitalize` |
| Incident | `/post-mortem` |

---

## 🔄 IMPORTANT : Finalisation du Workflow

### Prérequis avant d'utiliser cette skill

⚠️ **Le merge est la DERNIÈRE étape !** Vérifier que ces skills ont été exécutées :

- [ ] `/code-review` - Code relu et approuvé
- [ ] `/document` - Documentation à jour
- [ ] `/capitalize` - Apprentissages sauvegardés
- [ ] `/roadmap-update --done` - Tâche marquée comme terminée

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Marquer /pre-merge ✅
  → Marquer le workflow comme TERMINÉ
  → Ajouter le numéro de PR dans "Contexte Clé"
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Merge Effectué - Workflow Terminé !

**PR** : #[numéro] - [titre]
**Status** : Mergée ✅

🎉 **Félicitations !** Le cycle de développement est complet.

→ **Prochaine étape optionnelle** : `/post-mortem --session` si fin de sprint ou feature majeure

💡 `/next --reset` pour démarrer une nouvelle tâche
---
```

---
name: roadmap-update
description: Met à jour le statut d'une tâche dans la roadmap (TODO → IN_PROGRESS → DONE)
argument-hint: [tâche] [--done] [--in-progress] [--blocked]
model: haiku
---

# Mise à Jour de Roadmap

Met à jour le statut de la tâche :

$ARGUMENTS

## Objectif

Maintenir la **traçabilité** des tâches et garder la roadmap à jour pour refléter l'état réel du projet.

---

## 0. Localisation de la Roadmap

### Fichiers typiques de roadmap

```
mcp__serena__search_for_pattern - Chercher les fichiers de roadmap
mcp__serena__find_file - Localiser ROADMAP.md, TODO.md, etc.
```

### Emplacements courants

| Fichier | Format typique |
|---------|----------------|
| `ROADMAP.md` | Markdown avec checkboxes |
| `TODO.md` | Liste de tâches |
| `docs/roadmap.md` | Documentation projet |
| `.github/PROJECT.md` | GitHub Projects style |
| `CHANGELOG.md` | Pour les releases |

### Formats reconnus

```markdown
# Format Checkbox
- [ ] TODO : Tâche à faire
- [x] DONE : Tâche terminée

# Format Status
| Tâche | Status |
|-------|--------|
| Feature X | TODO |
| Feature Y | IN_PROGRESS |
| Feature Z | DONE |

# Format Liste
## TODO
- Tâche 1

## IN PROGRESS
- Tâche 2

## DONE
- Tâche 3
```

---

## 1. Identification de la Tâche

### Recherche dans la roadmap

```
mcp__serena__search_for_pattern
  substring_pattern: "[description de la tâche]"
  paths_include_glob: "**/ROADMAP.md,**/TODO.md,**/roadmap.md"
```

### Informations à collecter

| Info | Description |
|------|-------------|
| **Fichier** | Où se trouve la tâche |
| **Ligne** | Numéro de ligne |
| **Format** | Checkbox, tableau, liste |
| **Status actuel** | TODO, IN_PROGRESS, DONE, BLOCKED |

---

## 2. Changement de Status

### Statuts disponibles

| Status | Icône | Description |
|--------|-------|-------------|
| `TODO` | ⬜ / `[ ]` | À faire |
| `IN_PROGRESS` | 🔄 / `[~]` | En cours |
| `DONE` | ✅ / `[x]` | Terminé |
| `BLOCKED` | 🚫 / `[!]` | Bloqué |
| `CANCELLED` | ❌ / `[-]` | Annulé |

### Flag `--done`

Marque la tâche comme terminée :

```markdown
# Avant
- [ ] Implémenter l'authentification OAuth

# Après
- [x] Implémenter l'authentification OAuth
```

### Flag `--in-progress`

Marque la tâche comme en cours :

```markdown
# Avant
- [ ] Implémenter l'authentification OAuth

# Après
- [~] Implémenter l'authentification OAuth (EN COURS)
```

### Flag `--blocked`

Marque la tâche comme bloquée :

```markdown
# Avant
- [ ] Implémenter l'authentification OAuth

# Après
- [!] Implémenter l'authentification OAuth (BLOQUÉ: [raison])
```

---

## 3. Mise à Jour du Fichier

### Format Checkbox Markdown

```markdown
# Transformation
- [ ] Tâche  →  - [x] Tâche
```

### Format Tableau

```markdown
# Transformation
| Tâche | TODO |  →  | Tâche | DONE |
```

### Format Sections

```markdown
# Déplacer de la section TODO vers DONE
## TODO
- ~~Tâche~~  (supprimer)

## DONE
- Tâche     (ajouter)
```

---

## 4. Ajout de Métadonnées

### Informations optionnelles à ajouter

```markdown
- [x] Implémenter l'authentification OAuth
  - Complété : 2024-01-15
  - PR : #123
  - Durée : 3 jours
```

### Format enrichi

```markdown
| Tâche | Status | Date | PR | Notes |
|-------|--------|------|-----|-------|
| Auth OAuth | ✅ DONE | 2024-01-15 | #123 | Avec Auth0 |
```

---

## 5. Vérification

### Après la mise à jour

- [ ] Le fichier est correctement formaté
- [ ] Le status est visible
- [ ] Les métadonnées sont ajoutées si pertinent
- [ ] Pas de corruption du format

### Validation du format

```bash
# Vérifier que le markdown est valide
npx markdownlint ROADMAP.md
```

---

## 6. Notification et Communication

### Actions post-update

Si la tâche est significative :

1. **Commit dédié** (optionnel) :
   ```
   docs: mark [tâche] as DONE in roadmap
   ```

2. **Communication** (si nécessaire) :
   ```markdown
   ## Mise à jour Roadmap

   ✅ **[Tâche]** est maintenant terminée.

   - PR associée : #123
   - Documentation : [lien]
   ```

---

## 7. Synchronisation avec Issues

### GitHub Issues

Si la tâche correspond à une issue :

```bash
# Fermer l'issue associée
gh issue close [numéro] --comment "Terminé dans PR #XXX"
```

### Vérification de cohérence

```bash
# Lister les issues ouvertes vs roadmap
gh issue list --state open
```

---

## 8. Rapport de Mise à Jour

### Format de sortie

```markdown
## Roadmap Update

**Fichier** : ROADMAP.md
**Tâche** : [Description]
**Ancien status** : TODO
**Nouveau status** : DONE

### Modifications
- Ligne 42 : `- [ ]` → `- [x]`
- Ajout date de complétion

### Actions associées
- [ ] Issue #XX fermée
- [ ] PR #YY référencée
```

---

## 9. Historique des Changements

### Tracker les progressions

```markdown
# Dans un fichier séparé ou section dédiée

## Historique Roadmap

| Date | Tâche | Changement |
|------|-------|------------|
| 2024-01-15 | Auth OAuth | TODO → DONE |
| 2024-01-14 | API Users | TODO → IN_PROGRESS |
```

---

## 10. Capitalisation SERENA

### Si milestone importante

```
mcp__serena__write_memory
```

**À capitaliser :**
- Jalons importants atteints
- Décisions liées à la roadmap
- Changements de priorité

### Format de mémoire

```markdown
# Milestone : [Nom]

## Date : YYYY-MM-DD

## Tâches complétées
- [Tâche 1]
- [Tâche 2]

## Impact
[Ce que ça débloque]

## Prochaines étapes
[Ce qui vient après]
```

---

## 11. Intégration dans le Workflow

### Quand utiliser cette skill ?

| Situation | Action |
|-----------|--------|
| Début de travail sur une tâche | `--in-progress` |
| Après `/capitalize` (avant merge) | `--done` |
| Problème bloquant rencontré | `--blocked` |
| Après `/post-mortem` | Mise à jour si nécessaire |

### Workflow recommandé

```
/analyze → /roadmap-update [tâche] --in-progress
   ...
/capitalize → /roadmap-update [tâche] --done → /pre-merge
```

⚠️ **Important** : Le merge (`/pre-merge`) arrive APRÈS la mise à jour de la roadmap

---

## 12. Commandes Rapides

### Marquer comme DONE

```
/roadmap-update "Implémenter auth OAuth" --done
```

### Marquer comme IN_PROGRESS

```
/roadmap-update "Implémenter API users" --in-progress
```

### Marquer comme BLOCKED

```
/roadmap-update "Déploiement prod" --blocked "En attente validation sécurité"
```

---

## Transition

| Situation | Prochaine action |
|-----------|------------------|
| Tâche marquée DONE | `/pre-merge` pour finaliser |
| Tâche BLOCKED | Résoudre le blocage, puis revenir |
| Nouvelle tâche à prendre | `/analyze` |
| Fin de sprint | `/post-mortem --session` |

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill (avec --done), TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /roadmap-update --done ✅
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Roadmap Mise à Jour

**Tâche** : [Description]
**Nouveau status** : DONE ✅

→ **Prochaine étape** : `/pre-merge --pr` pour créer la PR et merger

🎯 C'est la dernière étape avant le merge !

💡 `/next` pour voir le workflow complet
---
```

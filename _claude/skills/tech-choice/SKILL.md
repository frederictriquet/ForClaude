---
name: tech-choice
description: Prend et documente une décision technique de manière structurée (ADR)
argument-hint: [sujet-de-la-décision]
model: sonnet
---

# Choix Technique (ADR)

Documente et valide la décision technique concernant :

$ARGUMENTS

## Objectif

Prendre une décision **éclairée et traçable**. Créer un Architecture Decision Record (ADR) qui servira de référence future.

---

## ⛔ LIMITES STRICTES DE CETTE SKILL

### ✅ CE QUE CETTE SKILL FAIT
- Comparer les options (reprises de `/explore-options`)
- Définir les critères de décision
- Documenter le choix et sa justification
- Créer un ADR dans SERENA
- Identifier les conséquences

### ❌ CE QUE CETTE SKILL NE FAIT PAS
- **PAS d'implémentation** : On décide, on ne code pas
- **PAS d'exploration supplémentaire** : L'exploration est faite (sinon → `/explore-options`)
- **PAS d'architecture détaillée** : C'est pour `/architecture`
- **PAS de PoC complet** : Mini-validation OK, pas d'implémentation

### 🛑 SI TU ES TENTÉ DE COMMENCER À CODER
STOP ! Finalise l'ADR et passe à `/architecture` ou `/implement`.

---

---

## 0. Consultation SERENA

### Recherche préalable obligatoire

```
mcp__serena__list_memories - Lister les mémoires existantes
mcp__serena__read_memory - Lire les ADR précédents
mcp__serena__search_for_pattern - Chercher des décisions similaires
```

### Questions critiques

1. **Y a-t-il déjà une décision sur ce sujet ?** → Si oui, la challenger ou la réutiliser
2. **Quels choix similaires ont été faits ?** → Cohérence architecturale
3. **Y a-t-il des contraintes documentées ?** → Les respecter

---

## 1. Contexte de la Décision

### Template de contexte

```markdown
## Contexte

**Date** : [YYYY-MM-DD]
**Statut** : [Proposé | Accepté | Déprécié | Remplacé par ADR-XXX]
**Décideurs** : [Qui participe à la décision]

### Problème
[Quel problème nécessite cette décision ?]

### Drivers
[Quelles forces poussent vers cette décision ?]
- Driver 1
- Driver 2

### Contraintes
[Quelles limitations devons-nous respecter ?]
- Contrainte 1
- Contrainte 2
```

---

## 2. Options Considérées

### Résumé des options

(Reprendre de `/explore-options` si disponible)

| Option | Description | Effort | Risque |
|--------|-------------|--------|--------|
| A | ... | Moyen | Faible |
| B | ... | Faible | Moyen |
| C | ... | Élevé | Faible |

---

## 3. Critères de Décision

### Définir les critères et leurs poids

| Critère | Description | Poids |
|---------|-------------|-------|
| **Performance** | Temps de réponse, throughput | [1-5] |
| **Maintenabilité** | Facilité de modification future | [1-5] |
| **Simplicité** | Courbe d'apprentissage, complexité | [1-5] |
| **Coût** | Effort de développement | [1-5] |
| **Risque** | Incertitudes techniques | [1-5] |
| **Cohérence** | Alignement avec l'existant | [1-5] |

### Scoring des options

| Critère | Poids | Option A | Option B | Option C |
|---------|-------|----------|----------|----------|
| Performance | X | | | |
| Maintenabilité | X | | | |
| Simplicité | X | | | |
| Coût | X | | | |
| Risque | X | | | |
| Cohérence | X | | | |
| **TOTAL** | - | **X** | **X** | **X** |

---

## 4. La Décision

### Format de décision

```markdown
## Décision

Nous choisissons **[Option X]** parce que :

1. [Raison principale]
2. [Raison secondaire]
3. [Raison tertiaire]

### Trade-offs acceptés

En choisissant cette option, nous acceptons :
- [Inconvénient 1] - Mitigation : [...]
- [Inconvénient 2] - Mitigation : [...]

### Options rejetées

- **Option Y** rejetée car : [raison]
- **Option Z** rejetée car : [raison]
```

---

## 5. Conséquences

### Impacts positifs

- [Impact 1]
- [Impact 2]

### Impacts négatifs (à monitorer)

- [Impact 1] → Action : [...]
- [Impact 2] → Action : [...]

### Actions requises

- [ ] Action 1
- [ ] Action 2
- [ ] Action 3

---

## 6. Validation

### Checklist de validation

- [ ] Les stakeholders ont été consultés
- [ ] Les contraintes sont respectées
- [ ] La décision est cohérente avec l'architecture existante
- [ ] Les risques sont acceptables et mitigés
- [ ] Les alternatives ont été correctement évaluées
- [ ] La décision est réversible ou ses conséquences sont acceptables

### Approbation

```markdown
**Décision approuvée** : [Oui/Non/En attente]
**Par** : [Nom]
**Date** : [YYYY-MM-DD]
**Commentaires** : [...]
```

---

## 7. Capitalisation SERENA

### Sauvegarde obligatoire de l'ADR

```
mcp__serena__write_memory
```

**Nom du fichier** : `adr-[YYYY-MM-DD]-[sujet-kebab-case].md`

**Contenu complet de l'ADR** :

```markdown
# ADR : [Titre de la décision]

## Métadonnées
- **Date** : YYYY-MM-DD
- **Statut** : Accepté
- **Décideurs** : [...]

## Contexte
[Pourquoi cette décision est nécessaire]

## Décision
[Ce qui a été décidé]

## Options considérées
1. [Option retenue] - **Choisie**
2. [Option 2] - Rejetée : [raison]
3. [Option 3] - Rejetée : [raison]

## Conséquences
### Positives
- ...

### Négatives
- ...

## Références
- [Liens vers documentation, discussions, etc.]
```

### Index des ADR

Mettre à jour ou créer un index :

```markdown
# Index des ADR

| ID | Date | Titre | Statut |
|----|------|-------|--------|
| 001 | 2024-01-15 | Choix du framework de test | Accepté |
| 002 | ... | ... | ... |
```

---

## 8. Communication

### Template d'annonce

```markdown
## Nouvelle Décision Technique

**Sujet** : [Titre]

**Résumé** : Nous avons décidé de [décision] pour [raison principale].

**Impact** : [Ce que ça change pour l'équipe]

**Détails** : Voir ADR-XXX dans [emplacement]

**Questions** : [Contact]
```

---

## Transition vers la prochaine phase

| Situation | Prochaine skill |
|-----------|-----------------|
| Décision validée, architecture simple | `/implement` |
| Décision validée, architecture complexe | `/architecture` |
| Décision nécessite plus d'exploration | `/explore-options` |
| Décision nécessite PoC | Implémenter PoC d'abord |

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /tech-choice ✅
  → Ajouter la décision dans "Décisions Prises"
  → Suggérer /roadmap-update --in-progress si pas encore fait
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Décision Technique Documentée

**Décision** : [Résumé en 1 ligne]
**ADR** : [Référence si créé]

→ **Prochaines étapes** :
  1. `/roadmap-update "[tâche]" --in-progress` (si pas fait)
  2. `/architecture [feature]` (si complexe) ou `/implement` (si simple)

💡 `/next` pour voir le workflow complet
---
```

3. **Rappeler** de mettre à jour la roadmap avant de continuer

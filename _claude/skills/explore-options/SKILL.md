---
name: explore-options
description: Explore les différentes possibilités techniques pour résoudre un problème
argument-hint: [problème-à-résoudre]
model: sonnet
---

# Exploration des Options

Explore les différentes possibilités pour résoudre :

$ARGUMENTS

## Objectif

Identifier **TOUTES** les approches viables avant de choisir. Évite de se verrouiller sur la première idée.

---

## ⛔ LIMITES STRICTES DE CETTE SKILL

### ✅ CE QUE CETTE SKILL FAIT
- Lister les différentes options possibles
- Rechercher des bibliothèques/solutions existantes
- Comparer les avantages/inconvénients
- Créer une matrice de décision
- Faire un mini PoC **si vraiment nécessaire** (max 10 lignes)

### ❌ CE QUE CETTE SKILL NE FAIT PAS
- **PAS d'implémentation complète** : Juste explorer
- **PAS de décision finale** : C'est le rôle de `/tech-choice`
- **PAS de modifications de fichiers** : Lecture et recherche seulement
- **PAS de tests** : On explore, on n'implémente pas
- **PAS de refactoring** : On ne touche pas au code existant

### 🛑 SI TU ES TENTÉ DE CHOISIR ET IMPLÉMENTER
STOP ! Documente les options trouvées et passe à `/tech-choice`.

---

---

## 0. Consultation SERENA

### Recherche préalable

1. **Lire les mémoires** pour trouver des solutions similaires déjà explorées
2. **Chercher les patterns** du projet qui pourraient s'appliquer
3. **Identifier les choix passés** et leurs justifications

```
mcp__serena__list_memories
mcp__serena__read_memory
mcp__serena__search_for_pattern
```

### Questions SERENA

- Quelles solutions similaires existent dans le projet ?
- Y a-t-il des bibliothèques/patterns déjà utilisés pour ce type de problème ?
- Quels choix passés ont bien/mal fonctionné ?

---

## 1. Génération d'Options (Divergence)

### Règles de brainstorming

- **Quantité > Qualité** (dans un premier temps)
- **Pas de jugement** pendant la génération
- **Inclure les options "folles"** (parfois les meilleures)
- **Varier les angles** (performance, simplicité, maintenabilité)

### Catégories d'options à explorer

#### A. Solutions existantes

- [ ] Bibliothèques/packages disponibles
- [ ] Code existant dans le projet à réutiliser
- [ ] Patterns standards du langage/framework

#### B. Solutions custom

- [ ] Implémentation from scratch
- [ ] Adaptation d'une solution existante
- [ ] Combinaison de plusieurs approches

#### C. Solutions alternatives

- [ ] Contourner le problème plutôt que le résoudre
- [ ] Simplifier les requirements
- [ ] Reporter à plus tard (dette technique consciente)

---

## 2. Documentation des Options

Pour chaque option identifiée, documenter :

```markdown
### Option N : [Nom descriptif]

**Description** : [2-3 phrases]

**Avantages** :
- ...
- ...

**Inconvénients** :
- ...
- ...

**Effort estimé** : [Faible | Moyen | Élevé]

**Risque** : [Faible | Moyen | Élevé]

**Prérequis** : [Ce qui doit exister avant]

**Exemple de code** (si pertinent) :
```code
...
```
```

---

## 3. Recherche Approfondie

### Pour chaque option viable

1. **Rechercher la documentation** officielle
2. **Chercher des exemples** d'utilisation
3. **Identifier les pièges** connus
4. **Vérifier la compatibilité** avec le projet

### Outils à utiliser

```
WebSearch - Documentation et exemples
mcp__serena__search_for_pattern - Usages dans le projet
mcp__serena__find_symbol - Intégrations existantes
```

---

## 4. Matrice de Comparaison

### Critères d'évaluation

| Critère | Poids | Option 1 | Option 2 | Option 3 |
|---------|-------|----------|----------|----------|
| **Complexité** | [1-5] | /5 | /5 | /5 |
| **Performance** | [1-5] | /5 | /5 | /5 |
| **Maintenabilité** | [1-5] | /5 | /5 | /5 |
| **Testabilité** | [1-5] | /5 | /5 | /5 |
| **Compatibilité** | [1-5] | /5 | /5 | /5 |
| **Courbe d'apprentissage** | [1-5] | /5 | /5 | /5 |
| **Score pondéré** | - | **X** | **X** | **X** |

### Scoring

- 5 = Excellent
- 4 = Bon
- 3 = Acceptable
- 2 = Problématique
- 1 = Bloquant

---

## 5. Proof of Concept (si nécessaire)

### Quand faire un PoC ?

- [ ] L'option la plus prometteuse a des incertitudes techniques
- [ ] Deux options sont très proches et difficiles à départager
- [ ] Une nouvelle technologie/bibliothèque est envisagée

### Format du PoC

```markdown
## PoC : [Nom de l'option]

**Question à valider** : [Ce qu'on veut prouver]

**Temps alloué** : [Maximum X heures]

**Critère de succès** : [Comment savoir si ça marche]

**Code minimal** : [Juste ce qu'il faut pour valider]
```

---

## 6. Livrables de l'Exploration

### Document de sortie

```markdown
## Exploration des Options

### Contexte
[Rappel du problème en 1-2 phrases]

### Options Identifiées

1. **[Option 1]** - [Description courte]
2. **[Option 2]** - [Description courte]
3. **[Option 3]** - [Description courte]

### Matrice de Comparaison
[Tableau des scores]

### Recommandation Préliminaire
[Option recommandée avec justification]

### Incertitudes Restantes
[Ce qui nécessite validation]

### Prochaine Étape
[tech-choice | PoC | architecture]
```

---

## 7. Capitalisation SERENA

### Sauvegarder les découvertes

```
mcp__serena__write_memory
```

**À capitaliser :**
- Options rejetées et pourquoi (éviter de les ré-explorer)
- Bibliothèques évaluées avec leurs forces/faiblesses
- Patterns découverts utiles pour le projet
- Ressources/documentation de référence trouvées

### Format de mémoire

```markdown
# Exploration : [Sujet]

## Date : [YYYY-MM-DD]

## Problème
[Description]

## Options évaluées
1. [Option] - [Verdict: Retenue/Rejetée] - [Raison]
2. ...

## Choix final
[Option choisie et pourquoi]

## Leçons apprises
- ...
```

---

## Transition vers la prochaine phase

| Situation | Prochaine skill |
|-----------|-----------------|
| Une option claire se dégage | `/tech-choice` pour valider |
| Besoin de PoC | Implémenter le PoC puis revenir |
| Architecture complexe nécessaire | `/architecture` |
| Option simple et claire | `/implement` |

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /explore-options ✅
  → Mettre à jour "Contexte Clé" avec les options évaluées
  → Définir "Prochaine Étape"
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Exploration Terminée

**Options évaluées** : [nombre]
**Recommandation** : [Option retenue]
**Justification** : [1 phrase]

→ **Prochaine étape** : `/tech-choice [sujet]` pour documenter la décision

💡 `/next` pour voir le workflow complet
---
```

3. **Proposer explicitement** la prochaine commande à exécuter

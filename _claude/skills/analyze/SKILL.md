---
name: analyze
description: Analyse en profondeur un problème ou une demande avant toute implémentation
argument-hint: [description-du-problème]
model: sonnet
---

# Analyse de Problème

Analyse en profondeur la demande suivante :

$ARGUMENTS

## Objectif

Comprendre **complètement** le problème avant de proposer une solution. Cette phase est critique : une bonne analyse évite les retours en arrière coûteux.

---

## ⛔ LIMITES STRICTES DE CETTE SKILL

### ✅ CE QUE CETTE SKILL FAIT
- Comprendre et reformuler le besoin
- Identifier les contraintes et le contexte
- Lister les fichiers/modules concernés
- Définir le périmètre (IN/OUT)
- Poser des questions de clarification

### ❌ CE QUE CETTE SKILL NE FAIT PAS
- **PAS de code** : Ne pas écrire de code, même "pour illustrer"
- **PAS de debug** : Ne pas corriger de bugs découverts
- **PAS d'implémentation** : Ne pas commencer à implémenter
- **PAS de choix technique définitif** : Juste identifier les options
- **PAS de modifications de fichiers** : Lecture seule

### 🛑 SI TU ES TENTÉ DE CODER
STOP ! Note le besoin et passe à `/explore-options` ou `/implement` après.

---

---

## 0. Vérification de Branche

### Avant toute analyse, vérifier la branche courante

```bash
git branch --show-current
git status
```

### Règles de branche

| Branche actuelle | Action |
|------------------|--------|
| `main` ou `master` | ⚠️ **Proposer de créer une nouvelle branche** |
| `develop` | ⚠️ Selon les conventions du projet |
| `feature/*`, `fix/*` | ✅ OK si correspond à la tâche |
| Autre | Vérifier si appropriée |

### Détection de la branche principale

```bash
# La branche principale peut être main OU master
git branch --show-current
# Si résultat = "main" ou "master" → proposer nouvelle branche
```

### Si sur main ou master, proposer :

```markdown
⚠️ **Vous êtes sur la branche principale (`main` ou `master`)**

Pour cette feature, je recommande de créer une nouvelle branche :

**Nom suggéré** : `feature/[nom-court-de-la-feature]`

Voulez-vous :
1. Créer la branche `feature/[suggestion]` et y basculer
2. Créer une branche avec un autre nom
3. Rester sur `main` (non recommandé)
```

### Création de branche

```bash
# Si l'utilisateur accepte
git checkout -b feature/[nom-de-la-feature]
```

### Conventions de nommage

| Type | Format | Exemple |
|------|--------|---------|
| Feature | `feature/[description]` | `feature/oauth-login` |
| Bugfix | `fix/[description]` | `fix/null-token-error` |
| Refactor | `refactor/[description]` | `refactor/auth-module` |
| Hotfix | `hotfix/[description]` | `hotfix/security-patch` |

---

## 1. Consultation SERENA

### Avant toute analyse

1. **Lire les mémoires pertinentes** via `mcp__serena__list_memories` puis `mcp__serena__read_memory`
2. **Chercher des problèmes similaires** déjà résolus dans le projet
3. **Identifier les patterns** établis qui pourraient s'appliquer
4. **Vérifier les anti-patterns** documentés à éviter

### Questions à poser à SERENA

- Existe-t-il une solution similaire dans le projet ?
- Y a-t-il des contraintes architecturales à respecter ?
- Quels sont les patterns recommandés pour ce type de problème ?

---

## 1. Clarification du Besoin

### Questions essentielles

| Question | Pourquoi |
|----------|----------|
| **Qui** est l'utilisateur final ? | Adapte la solution |
| **Quoi** exactement doit être fait ? | Évite le scope creep |
| **Pourquoi** ce besoin existe ? | Comprend la motivation |
| **Quand** c'est nécessaire ? | Priorise correctement |
| **Où** dans le système ? | Identifie les impacts |

### Reformulation

Reformule le besoin en une phrase claire :
> "L'utilisateur [qui] a besoin de [quoi] afin de [pourquoi]"

---

## 2. Analyse du Contexte Existant

### Code à examiner

Utilise les outils SERENA pour explorer :

```
mcp__serena__find_symbol - Trouver les symboles pertinents
mcp__serena__get_symbols_overview - Vue d'ensemble des fichiers
mcp__serena__find_referencing_symbols - Comprendre les dépendances
mcp__serena__search_for_pattern - Chercher des patterns similaires
```

### Points à identifier

- [ ] Fichiers/modules concernés
- [ ] Fonctions/classes impactées
- [ ] Dépendances externes
- [ ] Tests existants
- [ ] Documentation existante

---

## 3. Identification des Contraintes

### Contraintes techniques

- Langage/Framework utilisé
- Versions et compatibilité
- Performance requise
- Limites de ressources

### Contraintes métier

- Règles business à respecter
- Cas limites à gérer
- Rétrocompatibilité nécessaire

### Contraintes projet

- Timeline
- Budget technique (complexité acceptable)
- Standards de code

---

## 4. Définition du Périmètre

### Inclus (IN scope)

Liste explicite de ce qui DOIT être fait :
1. ...
2. ...
3. ...

### Exclu (OUT of scope)

Liste explicite de ce qui NE SERA PAS fait :
1. ...
2. ...
3. ...

### Critères d'acceptation

Comment saurons-nous que c'est terminé ?
- [ ] Critère 1
- [ ] Critère 2
- [ ] Critère 3

---

## 5. Risques et Incertitudes

### Risques identifiés

| Risque | Probabilité | Impact | Mitigation |
|--------|-------------|--------|------------|
| ... | Haute/Moyenne/Basse | ... | ... |

### Questions ouvertes

Liste des points qui nécessitent clarification :
1. ...
2. ...

---

## 6. Livrables de l'Analyse

### Document de sortie

Produis un résumé structuré contenant :

```markdown
## Résumé de l'Analyse

### Problème
[Description en 2-3 phrases]

### Contexte
[Fichiers/modules concernés]

### Contraintes
[Liste des contraintes majeures]

### Périmètre
- IN: [liste]
- OUT: [liste]

### Critères d'acceptation
[Liste numérotée]

### Risques
[Top 3 risques]

### Questions ouvertes
[Si applicable]

### Prochaine étape recommandée
[explore-options | tech-choice | architecture | implement]
```

---

## 7. Capitalisation SERENA

### À la fin de l'analyse

Si des insights réutilisables ont émergé :

```
mcp__serena__write_memory - Sauvegarder les découvertes importantes
```

**Candidats à la capitalisation :**
- Patterns de problèmes récurrents identifiés
- Contraintes cachées découvertes
- Dépendances non documentées
- Pièges à éviter pour ce type de problème

---

## Transition vers la prochaine phase

Selon la complexité :

| Situation | Prochaine skill |
|-----------|-----------------|
| Plusieurs solutions possibles | `/explore-options` |
| Une seule solution évidente mais technique | `/tech-choice` |
| Architecture à concevoir | `/architecture` |
| Solution simple et claire | `/implement` |

---

## 🔄 IMPORTANT : Mise à Jour du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Créer/Mettre à jour le workflow** dans SERENA :

```
mcp__serena__write_memory
  memory_file_name: "workflow-current.md"
  content: |
    # Workflow Actif

    ## Tâche
    [Description de la tâche analysée]

    ## Objectif
    [Objectif clair identifié]

    ## Démarré
    [Date/heure actuelle]

    ## Historique
    | Timestamp | Skill | Status | Notes |
    |-----------|-------|--------|-------|
    | [maintenant] | /analyze | ✅ | [résumé en 5 mots] |

    ## Phase Actuelle
    /analyze ✅

    ## Contexte Clé
    - [Point clé 1 de l'analyse]
    - [Point clé 2]
    - [Contraintes identifiées]

    ## Prochaine Étape
    /[skill suggérée]
```

2. **Afficher clairement la transition** :

```markdown
---
## ✅ Analyse Terminée

**Résumé** : [1 phrase résumant l'analyse]

**Contexte clé retenu** :
- [Point 1]
- [Point 2]

→ **Prochaine étape recommandée** : `/[skill]` [arguments]

💡 Tapez `/next` à tout moment pour voir le status du workflow
---
```

3. **Proposer explicitement** de lancer la prochaine skill

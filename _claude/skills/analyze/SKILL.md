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

## 0. Consultation SERENA

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

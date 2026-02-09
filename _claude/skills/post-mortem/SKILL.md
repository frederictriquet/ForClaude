---
name: post-mortem
description: Analyse un incident ou une session de développement pour en tirer des leçons
argument-hint: [sujet] [--incident] [--session] [--blameless]
model: opus
---

# Post-Mortem

Analyse de :

$ARGUMENTS

## Objectif

Transformer une **expérience (positive ou négative) en apprentissage durable** pour l'équipe et le projet.

---

## 0. Principes Fondamentaux

### Culture Blameless (`--blameless`)

> "On analyse les systèmes, pas les personnes"

- ❌ "Qui a fait cette erreur ?"
- ✅ "Qu'est-ce qui a permis que cette erreur se produise ?"

### Objectif du post-mortem

1. **Comprendre** ce qui s'est passé
2. **Identifier** les facteurs contributifs
3. **Définir** des actions d'amélioration
4. **Capitaliser** les apprentissages

---

## 1. Contexte de l'Événement

### Identification

```markdown
## Identification

**Type** : Incident | Session de dev | Release | Autre
**Date** : YYYY-MM-DD
**Durée** : X heures/jours
**Participants** : [Liste]
**Impact** : [Description de l'impact]
**Sévérité** : Critique | Haute | Moyenne | Basse
```

### Timeline

```markdown
## Timeline

| Heure | Événement | Action | Résultat |
|-------|-----------|--------|----------|
| HH:MM | [Événement déclencheur] | - | - |
| HH:MM | [Détection] | [Action prise] | [Résultat] |
| HH:MM | [Escalade] | [Action prise] | [Résultat] |
| HH:MM | [Résolution] | [Action prise] | [Résultat] |
```

---

## 2. Analyse de l'Incident (`--incident`)

### Description de l'incident

```markdown
## Incident

### Symptômes observés
[Ce qui a été constaté]

### Impact utilisateur
- [Impact 1]
- [Impact 2]

### Métriques affectées
- [Métrique 1] : X → Y
- [Métrique 2] : X → Y
```

### Cause racine

```markdown
## Analyse de Cause Racine

### Cause immédiate
[Ce qui a directement provoqué l'incident]

### Causes contributives
1. [Facteur 1] : [Description]
2. [Facteur 2] : [Description]
3. [Facteur 3] : [Description]

### Cause racine
[La vraie raison sous-jacente]
```

### Méthode des 5 Pourquoi

```markdown
## 5 Pourquoi

1. **Pourquoi** l'incident s'est produit ?
   → [Réponse 1]

2. **Pourquoi** [Réponse 1] ?
   → [Réponse 2]

3. **Pourquoi** [Réponse 2] ?
   → [Réponse 3]

4. **Pourquoi** [Réponse 3] ?
   → [Réponse 4]

5. **Pourquoi** [Réponse 4] ?
   → **CAUSE RACINE**
```

---

## 3. Analyse de Session (`--session`)

### Résumé de la session

```markdown
## Session de Développement

### Objectif initial
[Ce qui devait être accompli]

### Résultat
[Ce qui a été accompli]

### Écart
[Différence entre objectif et résultat]
```

### Ce qui a bien fonctionné

```markdown
## Points Positifs ✅

### Pratiques efficaces
- [Pratique 1] : [Pourquoi efficace]
- [Pratique 2] : [Pourquoi efficace]

### Décisions qui ont payé
- [Décision 1] : [Impact positif]
- [Décision 2] : [Impact positif]

### Outils utiles
- [Outil 1] : [Comment il a aidé]
```

### Ce qui peut être amélioré

```markdown
## Points d'Amélioration 🔧

### Obstacles rencontrés
- [Obstacle 1] : [Impact]
- [Obstacle 2] : [Impact]

### Temps perdu sur
- [Activité 1] : [Durée estimée, cause]
- [Activité 2] : [Durée estimée, cause]

### Décisions à réévaluer
- [Décision 1] : [Pourquoi reconsidérer]
```

---

## 4. Facteurs Contributifs

### Catégories de facteurs

| Catégorie | Questions | Facteurs identifiés |
|-----------|-----------|---------------------|
| **Processus** | Le processus était-il clair ? | ... |
| **Communication** | L'information a-t-elle bien circulé ? | ... |
| **Outils** | Les outils ont-ils aidé ou gêné ? | ... |
| **Documentation** | La doc était-elle suffisante ? | ... |
| **Formation** | Les compétences étaient-elles là ? | ... |
| **Architecture** | Le système a-t-il facilité ou compliqué ? | ... |

### Analyse systémique

```
┌─────────────────────────────────────────────────────────┐
│                    ENVIRONNEMENT                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │                 ORGANISATION                      │   │
│  │  ┌─────────────────────────────────────────┐    │   │
│  │  │              ÉQUIPE                      │    │   │
│  │  │  ┌─────────────────────────────────┐   │    │   │
│  │  │  │           INDIVIDU              │   │    │   │
│  │  │  │  ┌─────────────────────────┐   │   │    │   │
│  │  │  │  │        TÂCHE            │   │   │    │   │
│  │  │  │  └─────────────────────────┘   │   │    │   │
│  │  │  └─────────────────────────────────┘   │    │   │
│  │  └─────────────────────────────────────────┘    │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘

À quel niveau se situent les facteurs ?
```

---

## 5. Ce Qui a Bien Fonctionné

### Identification des succès

```markdown
## Succès à Reproduire

### Détection
[Comment l'incident/problème a été détecté]
- Temps de détection : X minutes
- Outil/processus qui a aidé : ...

### Réponse
[Comment la réponse a été efficace]
- Temps de réponse : X minutes
- Coordination : ...

### Résolution
[Comment la résolution a été trouvée]
- Ressources utiles : ...
- Expertise mobilisée : ...

### Communication
[Ce qui a bien fonctionné dans la comm]
- Canaux utilisés : ...
- Information partagée : ...
```

---

## 6. Actions d'Amélioration

### Définition des actions

```markdown
## Plan d'Action

### Actions Immédiates (cette semaine)

| Action | Responsable | Deadline | Statut |
|--------|-------------|----------|--------|
| [Action 1] | @qui | YYYY-MM-DD | ⬜ |
| [Action 2] | @qui | YYYY-MM-DD | ⬜ |

### Actions Court Terme (ce mois)

| Action | Responsable | Deadline | Statut |
|--------|-------------|----------|--------|
| [Action 3] | @qui | YYYY-MM-DD | ⬜ |

### Actions Long Terme (ce trimestre)

| Action | Responsable | Deadline | Statut |
|--------|-------------|----------|--------|
| [Action 4] | @qui | YYYY-MM-DD | ⬜ |
```

### Types d'actions

| Type | Exemple |
|------|---------|
| **Prévention** | Ajouter une validation |
| **Détection** | Améliorer le monitoring |
| **Réponse** | Créer un runbook |
| **Documentation** | Documenter le processus |
| **Formation** | Session de formation |
| **Automatisation** | Script de déploiement |

---

## 7. Mesures de Prévention

### Barrières à mettre en place

```markdown
## Barrières Préventives

### Technique
- [ ] Tests automatisés pour [scénario]
- [ ] Validation d'entrée pour [cas]
- [ ] Circuit breaker pour [service]

### Processus
- [ ] Checklist de [activité]
- [ ] Review obligatoire pour [type de changement]
- [ ] Validation en staging avant prod

### Monitoring
- [ ] Alerte pour [condition]
- [ ] Dashboard pour [métrique]
- [ ] Log pour [événement]
```

---

## 8. Leçons Apprises

### Synthèse des apprentissages

```markdown
## Leçons Apprises

### Ce que nous avons appris

1. **[Leçon 1]**
   - Contexte : [Quand c'est pertinent]
   - Application : [Comment l'appliquer]

2. **[Leçon 2]**
   - Contexte : [Quand c'est pertinent]
   - Application : [Comment l'appliquer]

### Ce que nous referions

- [Bonne pratique à conserver]
- [Décision qui a bien marché]

### Ce que nous ferions différemment

- [Changement 1] au lieu de [pratique actuelle]
- [Changement 2] au lieu de [pratique actuelle]
```

---

## 9. Capitalisation SERENA

### Sauvegarder le post-mortem

```
mcp__serena__write_memory
```

**Nom** : `postmortem-[YYYY-MM-DD]-[sujet].md`

### Contenu à sauvegarder

```markdown
# Post-Mortem : [Titre]

## Date : YYYY-MM-DD

## Résumé
[2-3 phrases résumant l'événement]

## Impact
[Impact mesuré]

## Cause Racine
[La vraie cause]

## Actions Prises
1. [Action 1] - Statut: ✅/⬜
2. [Action 2] - Statut: ✅/⬜

## Leçons Apprises
- [Leçon 1]
- [Leçon 2]

## Prévention Future
- [Mesure 1]
- [Mesure 2]

## Références
- [Liens vers tickets, PRs, docs]
```

### Index des post-mortems

```markdown
# Index des Post-Mortems

| Date | Titre | Sévérité | Cause | Actions |
|------|-------|----------|-------|---------|
| YYYY-MM-DD | [Titre] | Haute | [Cause] | 3/4 ✅ |
```

---

## 10. Communication

### Template de communication

```markdown
## Post-Mortem : [Titre]

### TL;DR
[1-2 phrases résumant l'essentiel]

### Ce qui s'est passé
[Description factuelle]

### Impact
[Ce qui a été affecté]

### Cause
[Cause racine en termes simples]

### Ce que nous faisons
[Actions prises et prévues]

### Questions ?
[Contact pour questions]
```

### Canaux de diffusion

- [ ] Équipe directement concernée
- [ ] Équipes dépendantes
- [ ] Management si nécessaire
- [ ] Documentation interne

---

## 11. Suivi des Actions

### Tracking

```bash
# Créer des tickets pour chaque action
# Exemple avec GitHub
gh issue create --title "Post-mortem action: [action]" --body "[détails]"
```

### Revue périodique

- [ ] Revue des actions après 1 semaine
- [ ] Revue des actions après 1 mois
- [ ] Validation de l'efficacité des mesures

---

## 12. Checklist de Clôture

### Avant de conclure

- [ ] Timeline complète et validée
- [ ] Cause racine identifiée
- [ ] Actions définies avec responsables
- [ ] Leçons apprises documentées
- [ ] Communication faite
- [ ] Post-mortem sauvegardé dans SERENA
- [ ] Tickets créés pour les actions
- [ ] Suivi planifié

### Métriques de succès

- Récurrence : l'incident ne se reproduit pas
- Actions : toutes les actions sont complétées
- Apprentissage : les leçons sont appliquées

---

## Transition

| Situation | Prochaine action |
|-----------|------------------|
| Actions techniques à faire | `/analyze` → `/implement` |
| Tests à ajouter | `/test-write` |
| Documentation à créer | `/document` |
| Nouvelle fonctionnalité à analyser | `/analyze` |
| Fin de session, rien à faire | `/next --reset` |

---

## 🔄 IMPORTANT : Continuité du Workflow

### À la fin de cette skill, TOUJOURS :

1. **Mettre à jour le workflow** (si un workflow était en cours) :
```
mcp__serena__edit_memory
  memory_file_name: "workflow-current.md"
  → Ajouter dans Historique : /post-mortem ✅
  → Noter les actions identifiées
```

2. **Afficher le résumé de transition** :
```markdown
---
## ✅ Post-Mortem Terminé

**Sujet** : [Titre du post-mortem]
**Type** : [Incident / Session / Release]

**Leçons clés** :
- [Leçon 1]
- [Leçon 2]

**Actions définies** : X actions

**Mémoire sauvegardée** : `postmortem-YYYY-MM-DD-[sujet].md`

→ **Prochaines étapes** :
  - Si actions techniques : `/analyze [action]` pour les planifier
  - Si fin de session : `/next --reset` pour une nouvelle tâche

💡 `/next` pour voir le workflow complet
---
```

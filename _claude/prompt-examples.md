# Exemples de Prompts Efficaces

## Création d'un Système de Skills de Développement Complet

### Le Prompt Optimal

```
Crée un ensemble complet de skills Claude Code pour couvrir tout le cycle de développement logiciel.

## Exigences

### Architecture des Skills
- Chaque skill doit être **atomique** (Single Responsibility Principle)
- Les skills doivent s'enchaîner naturellement avec des **transitions explicites**
- Chaque skill doit proposer clairement la **prochaine étape** à la fin
- Inclure un système de **tracking du workflow** pour ne pas perdre le fil sur les processus longs

### Phases à Couvrir
1. **Analyse** : Comprendre le problème avant de coder
2. **Exploration** : Explorer les différentes solutions possibles
3. **Choix technique** : Documenter les décisions (ADR)
4. **Architecture** : Concevoir avant d'implémenter
5. **Implémentation** : Coder proprement
6. **Tests** : Écrire et exécuter les tests
7. **Debug** : Diagnostiquer et corriger les bugs
8. **Code Review** : Relire et valider
9. **Documentation** : Documenter le code et les APIs
10. **Capitalisation** : Sauvegarder les apprentissages
11. **Roadmap** : Mettre à jour le statut des tâches (TODO → DONE)
12. **Pre-merge** : Préparer le merge/PR (⚠️ EN DERNIER, après capitalisation)
13. **Post-mortem** : Analyser les incidents/sessions

### Intégration SERENA (MCP)
Chaque skill doit utiliser SERENA pour :
- **Consulter** les mémoires existantes au début (patterns, ADR, bugs résolus)
- **Utiliser** les outils symboliques pour naviguer dans le code
- **Capitaliser** les découvertes à la fin dans des mémoires typées :
  - `pattern-*` : Solutions réutilisables
  - `adr-*` : Décisions architecturales
  - `bug-*` : Résolutions de bugs
  - `std-*` : Standards et conventions
  - `arch-*` : Documentation d'architecture
  - `postmortem-*` : Analyses d'incidents

### Continuité du Workflow
- Créer une skill `/next` qui rappelle le contexte et propose la suite
- Chaque skill doit mettre à jour `workflow-current.md` dans SERENA
- Chaque skill doit afficher un bloc de transition clair à la fin :
  ```
  ## ✅ [Skill] Terminée
  **Résumé** : ...
  → **Prochaine étape** : /[skill] [args]
  💡 /next pour voir le workflow complet
  ```

### Format des Skills
- Fichier : `_claude/skills/[nom]/SKILL.md`
- Frontmatter YAML : name, description, argument-hint, model
- Sections structurées avec intégration SERENA
- Flags pour personnaliser le comportement (ex: --tdd, --security, --verbose)
- Table de transition vers les prochaines skills

### Livrables
1. Toutes les skills dans `_claude/skills/`
2. Un README.md avec :
   - Diagramme du workflow complet
   - Table de toutes les skills avec leurs flags
   - Exemples d'utilisation
   - Documentation de l'intégration SERENA
3. Une mémoire SERENA `skills-workflow-guide.md` pour référence future
```

---

## Pourquoi ce Prompt Fonctionne

### 1. **Contexte Clair**
Le prompt établit immédiatement l'objectif : un système complet de skills pour le cycle de développement.

### 2. **Exigences Structurées**
Les exigences sont organisées en catégories claires :
- Architecture (comment les skills doivent être conçues)
- Phases (quoi couvrir)
- Intégration (comment utiliser SERENA)
- Continuité (comment maintenir le fil)
- Format (standards techniques)

### 3. **Spécificité**
Le prompt est spécifique sur :
- Les noms des fichiers de mémoire SERENA
- Le format du bloc de transition
- Les flags attendus
- La structure des fichiers

### 4. **Livrables Explicites**
Le prompt liste exactement ce qui doit être produit, évitant toute ambiguïté.

### 5. **Problème Résolu Identifié**
Le prompt mentionne explicitement le problème de "perdre le fil sur les processus longs" et demande une solution (skill `/next` + tracking).

---

## Variantes

### Version Minimaliste
```
Crée des skills Claude Code atomiques pour tout le cycle de dev (analyse → deploy).
Chaque skill doit utiliser SERENA pour capitaliser et proposer explicitement la prochaine étape.
Ajoute une skill /next pour rappeler le contexte sur les processus longs.
```

### Version avec Contraintes Supplémentaires
```
[Prompt principal ci-dessus]

## Contraintes Additionnelles
- Les skills doivent fonctionner en français
- Privilégier le modèle haiku pour les skills simples, opus pour les complexes
- Inclure des checklists interactives dans chaque skill
- Supporter le mode TDD dans /implement
- Inclure des exemples de code dans chaque skill
```

---

## Anti-Patterns à Éviter

### ❌ Trop Vague
```
Crée des skills pour m'aider à coder.
```

### ❌ Trop de Requêtes Séparées
```
Crée une skill d'analyse.
[attendre]
Maintenant crée une skill d'implémentation.
[attendre]
...
```

### ❌ Pas de Vision d'Ensemble
```
Crée une skill /analyze qui analyse le code.
```
→ Manque le contexte du workflow global et des transitions.

### ❌ Oublier l'Intégration
```
Crée des skills de développement.
```
→ Ne mentionne pas SERENA, les transitions, ni le tracking.

---
name: fix-issue
description: Corrige une issue GitHub par son numéro
argument-hint: [numéro-issue]
disable-model-invocation: true
---

# Correction d'Issue GitHub

Corrige l'issue GitHub #$ARGUMENTS

## Étapes

1. **Lire l'issue** : Récupère le contexte avec `gh issue view $ARGUMENTS`
2. **Analyser** : Identifie les fichiers concernés
3. **Implémenter** : Écris la correction
4. **Tester** : Vérifie que ça fonctionne
5. **Commit** : Message format conventionnel, référence `Fixes #$ARGUMENTS`

## Standards

- Respecte le style du projet
- Ajoute des tests si nécessaire
- Documente les changements importants

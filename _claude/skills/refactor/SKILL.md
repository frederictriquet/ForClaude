---
name: refactor
description: Refactorise du code en améliorant sa qualité sans changer son comportement
argument-hint: [fichier-ou-fonction]
---

# Refactoring

Refactorise le code suivant : $ARGUMENTS

## Objectifs

1. **Lisibilité** : Noms clairs, structure logique
2. **Maintenabilité** : Fonctions courtes, responsabilité unique
3. **Performance** : Optimisations évidentes uniquement
4. **Tests** : Ne pas casser les tests existants

## Checklist

- [ ] Extraire les fonctions trop longues (> 20 lignes)
- [ ] Renommer les variables peu claires
- [ ] Supprimer le code mort
- [ ] Simplifier les conditions complexes
- [ ] Éliminer la duplication

## Important

- Garder le même comportement externe
- Faire des petits changements incrémentaux
- Expliquer chaque modification

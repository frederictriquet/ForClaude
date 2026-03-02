# Prompting efficace

## Règles d'or

**1. Contexte avant instructions**
Expliquer *pourquoi* avant *quoi*. Claude comprend mieux les contraintes quand il comprend l'objectif.

**2. Livrables explicites**
Lister exactement ce qui doit être produit. "Crée un système de X" est moins efficace que "Crée les fichiers A, B et C avec les fonctions X, Y, Z".

**3. Contraintes négatives**
Dire ce qu'il ne faut PAS faire est souvent plus efficace que dire ce qu'il faut faire.
```
Ne modifie pas les fichiers de configuration.
N'utilise pas directement la connexion DB, passe par db_query.sh.
```

**4. Une tâche à la fois**
Plusieurs petites demandes séquentielles > une grande demande complexe. Claude maintient mieux le cap sur des tâches ciblées.

**5. Spécificité des formats**
Préciser le format de sortie attendu : fichiers à créer, nommage, structure, langue.

---

## Anti-patterns

| ❌ À éviter | ✅ À faire |
|------------|-----------|
| "Aide-moi avec le code" | "Corrige le bug ligne 42 de auth.ts : la validation email ne gère pas les majuscules" |
| Demandes séparées pour chaque sous-tâche | Un prompt complet avec toutes les exigences structurées |
| "Fais de ton mieux" | Critères de succès explicites |
| Omettre les contraintes | Lister les restrictions dans `CLAUDE.md` ou dans le prompt |

---

## Exemple : prompt pour créer un système complexe

```
Crée un système de [X] avec les composants suivants :

## Architecture
- [composant A] : [responsabilité]
- [composant B] : [responsabilité]

## Contraintes
- Utiliser [technologie] pour [raison]
- Ne pas modifier [fichiers existants]
- Toutes les fonctions doivent avoir des types TypeScript stricts

## Livrables
1. src/[module]/index.ts — point d'entrée
2. src/[module]/types.ts — interfaces
3. src/[module]/[feature].ts — implémentation

## Critères de succès
- Les tests existants continuent de passer
- [comportement attendu] fonctionne avec [input exemple]
```

---

## Prompts pour les cas difficiles

### Corriger une erreur récurrente
```
Tu es en train de [faire X] mais le comportement attendu est [Y].
Voici ce que tu as produit : [extrait]
Voici ce qui devrait être produit : [exemple]
Explique ton raisonnement avant de modifier quoi que ce soit.
```

### Forcer l'utilisation d'un outil spécifique
```
Pour chaque fichier à créer, tu DOIS appeler Write tool.
N'utilise pas Bash pour écrire des fichiers.
Vérifie avec Read tool que chaque fichier existe avant de passer au suivant.
```

### Garder le cap sur un workflow long
```
Nous suivons ce workflow : /implement → /test-write → /test-run → /quality-check → /code-review
Nous venons de terminer /test-run avec succès.
L'étape suivante est UNIQUEMENT /quality-check. Ne pas proposer d'autre étape.
```

# Bonnes pratiques Claude Code

## CLAUDE.md

Le fichier `CLAUDE.md` à la racine du projet est lu automatiquement par Claude à chaque session. C'est le levier le plus puissant pour guider son comportement.

**Ce qu'on y met :**
- Les outils et scripts à utiliser (et ceux à ne PAS utiliser)
- Les conventions du projet (nommage, structure, langages)
- Les contraintes importantes ("ne jamais modifier la DB directement")
- Les références vers d'autres fichiers (`@RTK.md`, `@ARCHITECTURE.md`)

**Exemple concret** : si Claude doit interroger une base PostgreSQL conteneurisée dont les credentials ne sont pas évidents, il va rater plusieurs fois sa connexion. La solution : créer un script `db_query.sh "<SQL>"` et écrire dans `CLAUDE.md` qu'il est interdit d'utiliser autre chose pour requêter la DB. Claude l'utilisera naturellement.

> Règle d'or : plus on simplifie les outils disponibles, plus Claude est efficace.

---

## Committer souvent

**Pourquoi c'est critique :** quand Claude réalise qu'il a fait une erreur, il peut décider de restaurer un fichier avec `git checkout`. Si tu n'as pas committé, tu perds tout le travail intermédiaire.

- Committer après chaque unité logique de travail, même petite
- Les commits fréquents créent des points de sauvegarde exploitables
- Le travail non commité est invisible aux mécanismes de récupération de Claude

---

## Développement vertical avant horizontal

**Le principe :** construire une feature complète de bout en bout (de l'entrée jusqu'à la visualisation) avant d'en ajouter d'autres.

**Exemple :** pour une application de monitoring avec plusieurs scanners, un pipeline multi-étages et une visualisation Grafana :
- ✅ Faire fonctionner **un seul scanner** sur tout le pipeline, puis paralléliser, puis ajouter les autres scanners
- ❌ Commencer par la parallélisation ou par tous les scanners en même temps

**Pourquoi ça marche :** les décisions d'architecture prises trop tôt touchent beaucoup de fichiers et deviennent difficiles à modifier. Claude perd le fil, oublie des changements, laisse des incohérences.

> Commencer simple → valider → complexifier.

---

## Sub-agents et fichiers fantômes

Lorsqu'on utilise des sous-agents (via le tool `Agent`), un piège fréquent : **l'agent confirme avoir créé un fichier, mais ne l'a pas fait.**

Les agents peuvent "simuler" une réponse sans avoir réellement appelé les outils d'écriture. Cela arrive même après des rappels répétés.

**Comment s'en prémunir :**

1. **Spécifier explicitement dans le prompt** que l'agent *doit* utiliser `Write tool` ou `Edit tool` — pas d'autre alternative
2. **Vérifier systématiquement** avec un `Read` ou `Glob` après la réponse de l'agent
3. **Ne jamais faire confiance à une confirmation textuelle** ("J'ai créé le fichier X")
4. **Restreindre les outils** de l'agent à ce qui est nécessaire pour limiter la confusion

Exemple de formulation efficace dans le prompt d'un sous-agent :
```
Tu DOIS créer chaque fichier en appelant le Write tool.
Ne confirme pas avoir créé un fichier si tu n'as pas appelé Write tool.
Après chaque Write tool, continue avec le fichier suivant.
```

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

**Pourquoi c'est critique :** les commits fréquents protègent dans les deux sens.

- **Si Claude se plante** : il peut décider de restaurer un fichier avec `git checkout`. Sans commit récent, tu perds tout le travail intermédiaire.
- **Si tu veux annuler** : un `git reset` ou `git checkout` te ramène à un état connu. Sans commit, tu n'as aucun filet.

Committer après chaque unité logique de travail, même petite. Le travail non commité est invisible aux mécanismes de récupération — les tiens comme ceux de Claude.

---

## Développement incrémental

Deux principes complémentaires pour garder Claude efficace sur des projets complexes.

### 1. Vertical slicing — une feature complète avant la suivante

Implémenter une fonctionnalité de bout en bout à travers toutes les couches (entrée, traitement, persistance, affichage) avant de passer à la suivante — plutôt que de développer toute une couche technique en premier.

- ✅ Frontend + backend + DB d'un seul cas d'usage, puis le suivant
- ❌ Toute la couche DB d'abord, puis tout le backend, puis tout le frontend

### 2. Périmètre réduit — éviter les features cross-cutting trop tôt

Ne pas commencer par les fonctionnalités qui touchent à tout (parallélisation, cache global, refonte de l'auth…). Elles sont difficiles à modifier une fois en place car elles s'ancrent dans toute l'architecture.

**Exemple :** pour une application de monitoring avec plusieurs scanners, un pipeline multi-étages et une visualisation Grafana :
- ✅ Faire fonctionner **un seul scanner** sur tout le pipeline → paralléliser → ajouter les autres scanners
- ❌ Commencer par la parallélisation ou implémenter tous les scanners en même temps

**Pourquoi c'est important avec Claude :** les tâches qui touchent beaucoup de fichiers simultanément augmentent le risque que Claude perde le fil, oublie des changements ou laisse des incohérences. Un périmètre réduit = un contexte maîtrisé.

> Commencer simple → valider → complexifier.

---

## Gérer les conversations longues

Plus une conversation s'allonge, plus Claude risque de perdre le fil : oubli de contraintes établies en début de session, contradictions avec des décisions antérieures, répétition de travail déjà fait.

**Signaux d'alerte :**
- Claude propose quelque chose qu'il avait explicitement exclu plus tôt
- Les réponses deviennent moins précises ou moins cohérentes avec le contexte du projet
- Claude "réinvente" une convention déjà établie

**Que faire :**
- Ouvrir une nouvelle conversation pour les tâches indépendantes
- Résumer le contexte essentiel en début de nouvelle session (un bon `CLAUDE.md` aide beaucoup)
- Pour les longues sessions, rappeler les contraintes clés avant une étape importante : *"rappel : on n'utilise pas directement la DB, uniquement via db_query.sh"*

---

## Sub-agents et fichiers fantômes

Lorsqu'on utilise des sous-agents (via le tool `Agent`), un piège fréquent : **l'agent confirme avoir créé un fichier, mais ne l'a pas fait.**

Les agents peuvent produire une confirmation textuelle sans avoir réellement appelé les outils d'écriture. Cela arrive même après des rappels explicites, et même en répétant l'instruction plusieurs fois.

**Quand utiliser un sous-agent :** tâches parallélisables et indépendantes (recherche, analyse de plusieurs fichiers, génération de contenu isolé). Pas pour une séquence d'écritures interdépendantes où l'ordre et la vérification sont critiques.

**Comment s'en prémunir :**

1. **Forcer les outils dans le prompt** — nommer explicitement `Write tool` ou `Edit tool`, pas d'autre alternative acceptée
2. **Vérifier systématiquement** avec `Read` ou `Glob` après la réponse — ne jamais faire confiance à une confirmation textuelle
3. **Décomposer** — un agent qui crée 10 fichiers d'un coup est plus susceptible d'en rater ; préférer des agents ciblés sur une tâche précise

Formulation efficace dans le prompt d'un sous-agent :
```
Tu DOIS créer chaque fichier en appelant le Write tool.
Ne confirme pas avoir créé un fichier si tu n'as pas appelé Write tool.
Vérifie avec Read tool que le fichier existe avant de passer au suivant.
```

---

## Exiger des preuves concrètes

Formuler explicitement : "Montre-moi le résultat de la commande" plutôt que "Dis-moi si ça marche". En cas de doute, vérifier soi-même avec un `Read` ou en lançant la commande directement. Ne jamais accepter une confirmation textuelle comme preuve.

**Pourquoi :** Claude peut affirmer avoir fait quelque chose — tests passés, bug corrigé, performance mesurée — sans l'avoir réellement exécuté. Ce n'est pas de la tromperie délibérée, c'est de la **confabulation** : le modèle génère du texte cohérent avec ce qui semble attendu, sans mécanisme de vérification interne. Les confirmations textuelles ("J'ai corrigé le bug") sont donc non fiables par nature.

---

## Détecter les raccourcis non désirés

- Interdire explicitement dans `CLAUDE.md` la modification des tests existants
- Exiger que tout `catch` vide ou suppression de warning de lint soit justifié dans un commentaire
- Ne pas formuler la tâche "corriger les erreurs de lint" sans préciser qu'il est interdit de désactiver les règles

**Pourquoi :** Claude cherche à satisfaire la demande rapidement. Devant un test qui échoue ou un warning persistant, il peut choisir la solution la plus courte — désactiver le test, ajouter un `catch` silencieux, ignorer la règle — plutôt que de corriger le problème sous-jacent. Ces raccourcis sont difficiles à détecter car ils font passer les vérifications en surface.

---

## Sessions multi-rôles

- Dédier une session à l'écriture du code
- Dédier une session distincte à la vérification : tests, performance, stabilité
- Optionnellement, une troisième session au quality gate : propreté du code, respect des conventions

**Pourquoi :** les règles données en début de session perdent de leur influence au fur et à mesure que le contexte grossit. Distribuer les responsabilités entre sessions courtes limite cet effet de dilution.

Cela permet également d'avoir des sessions **mono-objectif** : une session chargée à la fois d'écrire du code et de garantir sa qualité est en situation de conflit interne — elle peut inconsciemment sacrifier l'un pour l'autre. En séparant les rôles, on élimine ces dilemmes et chaque session peut optimiser sans compromis.

**Nuances :** une session de vérification est elle-même soumise aux mêmes biais — elle peut valider ce qui semble plausible plutôt que ce qui est réellement correct. Ce qui compte, c'est que chaque session ait un **scope étroit et des critères objectifs vérifiables**. Préférer des sessions courtes et mono-tâches : la dilution du contexte s'applique à toutes les sessions.

---

## Hooks : checkpoint naturel, pas surveillance continue

Utiliser les hooks git (pre-commit) pour forcer le linting avant chaque commit. C'est un checkpoint naturel : le code est censé être dans un état stable à ce moment.

**Éviter** les hooks `PostToolUse` (après chaque `Write`/`Edit`) pour lancer des tests ou du linting : le code est souvent dans un état intermédiaire invalide entre deux étapes d'un refactoring, ce qui génère du bruit plutôt que du signal et peut désorienter Claude en plein milieu d'une modification.

---

## Git worktrees

Les git worktrees permettent de travailler sur plusieurs branches simultanément dans des répertoires séparés — utile pour isoler une tâche sans polluer la branche principale.

Le flag `-w` de Claude Code crée le worktree et lance la session dedans en une commande, avec nettoyage automatique si aucun changement :

```bash
claude -w             # worktree avec nom généré
claude -w ma-feature  # worktree nommé
```

La création manuelle (`git worktree add`) ne vaut le coup que si tu as besoin de contrôler précisément la branche de base ou l'emplacement.

**Limite importante :** si le projet partage des ressources d'état global — base de données unique, migrations (Drizzle, Alembic…), fichiers de lock — lancer deux sessions Claude en parallèle dans deux worktrees peut provoquer des conflits de migration ou des états incohérents. Dans ce cas, les worktrees restent utiles mais en séquentiel, pas en parallèle.

---

## Specs avant code

Plutôt que de demander directement l'implémentation d'un besoin, passer par une étape intermédiaire : demander à Claude de rédiger une liste de specs, les valider, puis demander l'implémentation basée sur ces specs.

```
1. "Voici mon besoin : [...]. Écris une liste de specs."
2. [tu lis, tu corriges, tu valides]
3. "Implémente en te basant sur ces specs."
```

**Pourquoi c'est plus efficace :** en développant directement, Claude interprète le besoin et fait des choix implicites que tu ne découvres qu'en voyant le résultat. Les specs rendent ces choix visibles et corrigeables avant que le code soit écrit. Ça évite les allers-retours coûteux et les malentendus enfouis dans l'implémentation.

C'est aussi utile pour toi : l'exercice de lire des specs force à réaliser ce qu'on n'avait pas précisé.

---

## Décrire le cas d'usage, pas juste le symptôme

Pour signaler un bug, décrire **le cas d'usage et le résultat attendu** est systématiquement plus efficace que "ça ne marche pas".

- ❌ "La fonction de login ne marche pas, corrige-la"
- ✅ "Quand je soumets le formulaire avec `user@Example.COM`, je suis redirigé vers la page d'erreur. Le comportement attendu est une connexion réussie — les emails ne devraient pas être sensibles à la casse"

Avec le symptôme seul, Claude doit deviner le comportement attendu et peut "corriger" dans la mauvaise direction. Avec le cas d'usage complet, il peut raisonner sur l'écart entre ce qui se passe et ce qui devrait se passer — ce qui est exactement la nature d'un bug.

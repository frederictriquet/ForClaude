# commit often
parfois Claude peut se tromper dans le développement qu'il produit. Lorsqu'on lui fait remarquer et qu'on lui demande de corriger, il se rend compte de sa grosse erreur et choisit de restaurer le(s) fichier(s) avec un `git checkout`. Vous vous retrouvez donc avec la version du dépôt et perdez les modifications intermédiaires.

# start with the ... tasks
Par exemple, j'ai une application de monitoring de sécurité de code qui utilise de nombreux outils différents, les résultats sont traités et envoyés dans un pipeline à plusieurs étages avant d'arriver dans la visualisation Grafana. L'application permet d'effectuer ces ensembles de scans sur plusieurs dépôts en parallèle.

Il est plus efficace de commencer par la mise en place d'un seul outil de scan sur tout le pipeline, puis d'en faire la parallélisation et enfin d'ajouter les autres scanners un à la fois.

Si on s'intéresse à la parallélisation en dernier, on se retrouve avec des choix techniques difficiles à modifier car ils touchent à beaucoup de fichiers, à beaucoup de fonctionnalités et Claude s'y perd, oublie de faire certains changements.


mettre ça en forme pour le doc de Martin

---

# Best Practices for Using Claude Code - Structured Version

## 1. Commit Management: Protect Your Work with Frequent Commits

**✅ DO: Commit often**

Sometimes Claude can make mistakes in the development it produces. When you point this out and ask it to correct the error, it realizes its big mistake and chooses to restore the file(s) with a `git checkout`. You then end up with the repository version and lose all intermediate modifications.

Commit after each logical unit of work is completed, even if it's small. This creates safe checkpoints you can return to.

**❌ DON'T: Leave large amounts of uncommitted changes**

If you work on multiple changes without committing, you risk losing all your work if Claude decides to do a `git checkout` to fix an error. Uncommitted work is invisible to Claude's recovery mechanisms.

---

## 2. Iterative Development: Build Vertically Before Horizontally

**✅ DO: Start with core tasks and progress step by step**

Begin with simple, foundational features and build them completely end-to-end. Once a single feature works through the entire pipeline, then add complexity like parallelization or additional similar features.

This approach keeps the scope manageable and allows Claude to understand the full context of each change. It also creates a working foundation that can be tested and validated before adding more complexity.

Build vertically (end-to-end for one feature) before building horizontally (adding similar features in parallel).

**❌ DON'T: Don't start with complex or cross-cutting features**

Avoid beginning with features that touch many files or require changes across multiple parts of the codebase. When these architectural decisions are made too early, they become difficult to modify later because they're embedded throughout the system.

Claude can lose track of all the locations that need updating, leading to incomplete changes and inconsistencies. Start simple, prove the concept, then refactor for complexity.

# Checklist de Code Review

## Correctness
- [ ] Le code fait ce qu'il est censé faire
- [ ] Les edge cases sont gérés
- [ ] La logique est correcte
- [ ] Pas de bugs évidents

## Security
- [ ] Pas de secrets hard-codés
- [ ] Validation des entrées utilisateur
- [ ] Protection contre les injections (SQL, XSS, etc.)
- [ ] Authentification/autorisation respectée
- [ ] Données sensibles protégées

## Performance
- [ ] Pas de N+1 queries
- [ ] Pas de boucles inutiles
- [ ] Caching approprié
- [ ] Pas de memory leaks
- [ ] Complexité algorithmique raisonnable

## Maintainability
- [ ] Code lisible et compréhensible
- [ ] Noms de variables/fonctions clairs
- [ ] Fonctions courtes et focalisées
- [ ] Pas de duplication
- [ ] Découplage approprié

## Testing
- [ ] Tests présents et pertinents
- [ ] Couverture suffisante
- [ ] Tests lisibles
- [ ] Pas de tests flaky

## Error Handling
- [ ] Erreurs gérées proprement
- [ ] Messages d'erreur utiles
- [ ] Pas de fail silencieux
- [ ] Recovery approprié

## Documentation
- [ ] Code auto-documenté
- [ ] Commentaires pour la logique complexe
- [ ] API documentée si publique
- [ ] README mis à jour si nécessaire

## Style & Conventions
- [ ] Respecte les conventions du projet
- [ ] Formatage cohérent
- [ ] Imports organisés
- [ ] Pas de code mort

## Architecture
- [ ] Respecte l'architecture existante
- [ ] Séparation des concerns
- [ ] Interfaces appropriées
- [ ] Dépendances minimales

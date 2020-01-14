# Reciplease

Reciplease est une application iOS de recherche de recetes de cuisine.

## Architectures

Reciplease a été écrit sous Xcode en Swift 5 selon le pattern de conception MVC et supporte les iPhones en mode portrait à partir de iOS11

### API

Reciplease utilise l'API Edamam Recipe Search.

Créez un compte gratuit et récupérez votre clé:
https://developer.edamam.com/edamam-recipe-api

### POD

Bibliothèque Alamofire pour les appels réseau

### Features

- TableView, TableViewController
- Custom cell xib
- CoreData (recettes favorites)
- Cache des images
- Couverture du modèle (Unit Tests) 100% Core Data et Appels réseaux Alamofire (avec protocol)

### installation

Téléchargez et lancez le workspace reciplease.

Créez un ficher .plist "ApiKeys" dans le dossier Reciplease et créez la clé "edamamApiK"ey, placez comme valeur votre clé Edamam Recipe search API récupérée lors de votre inscription gratuite:
https://developer.edamam.com/edamam-recipe-api




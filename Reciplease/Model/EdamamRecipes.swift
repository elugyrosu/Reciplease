//
//  RecipeFromJSON.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 19/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct EdamamRecipes: Decodable {
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Double
    let healthLabels: [String]
    let ingredientLines: [String]
    let totalTime: Int
}
//enum HealthLabel: String, Decodable {
//    case alcoholFree = "Alcohol-Free"
//    case peanutFree = "Peanut-Free"
//    case sugarConscious = "Sugar-Conscious"
//    case treeNutFree = "Tree-Nut-Free"
//}



//enum HealthLabel: String, Decodable {
//    case alcoholCocktail = "Alcohol-Cocktail"
//    case alcoholFree = "Alcohol-Free"
//    case celeryFree = "Celery-Free"
//    case crustaceanFree = "Crustacean-Free"
//    case dairyFree = "Dairy-Free"
//    case eggFree = "Egg-Free"
//    case fishFree = "Fish-Free"
//    case glutenFree = "Gluten-free"
//    case keto = "Keto-Friendly"
//    case kidneyFriendly = "Kidney-Friendly"
//    case kosher = "Kosher"
//    case lowPotassium = "Low-Potassium"
//    case lupineFree = "Lupine-Free"
//    case mustardFree = "Mustard-Free"
//    case noOilAdded = "No-Oil-Added"
//    case lowSugar = "Low-Sugar"
//    case paleo = "Paleo"
//    case peanutFree = "Peanut-Free"
//    case pescatarian = "Pescatarian"
//    case porkFree = "Pork-Free"
//    case redMeatFree = "Red-Meat-Free"
//    case sesameFree = "Sesame-Free"
//    case shellfishFree = "Shellfish-Free"
//    case soyFree = "Soy-Free"
//    case sugarConscious = "Sugar-Conscious"
//    case treeNutFree = "Tree-Nut-Free"
//    case vegan = "Vegan"
//    case vegetarian = "Vegetarian"
//    case wheatFree = "Wheat-Free"
//}

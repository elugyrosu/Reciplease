//
//  RecipeFromJSON.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 19/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

// MARK: - EdamamRecipes
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

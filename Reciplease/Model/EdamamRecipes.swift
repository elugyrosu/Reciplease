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
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Decodable {
    let label: String
    let image: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int

}

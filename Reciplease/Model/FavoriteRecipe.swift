//
//  Recipe.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 18/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation
import CoreData

class FavoriteRecipe: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        
        guard let recipeList = try? viewContext.fetch(request) else { return [] }
        return recipeList
    }
    
//    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
//        FavoriteRecipe.fetchAll(viewContext: viewContext).forEach({ viewContext.delete($0) })
//        try? viewContext.save()
//    }
    
    static func deleteRecipe(recipeId: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        for recipe in FavoriteRecipe.fetchAll(){
            if recipe.id == recipeId{
                viewContext.delete(recipe)
            }
        }
        try? viewContext.save()
    }
    
    static func addRecipe(recipe: Recipe, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let favoriteRecipe = FavoriteRecipe(context: viewContext)
        favoriteRecipe.id = recipe.shareAs
        favoriteRecipe.image = recipe.image.data
        favoriteRecipe.label = recipe.label
        if recipe.totalTime != 0 {
            favoriteRecipe.totalTime = String(recipe.totalTime) + " min ⧖"
        }else{
            favoriteRecipe.totalTime = "- ⧖"
        }
        favoriteRecipe.totalTime = String(recipe.totalTime)
        favoriteRecipe.yield = String(Int(recipe.yield)) + " x ☺︎"
        favoriteRecipe.url = recipe.url
        favoriteRecipe.ingredients = recipe.ingredientLines as [NSString]?
        var healthLabelString = String()
        for label in recipe.healthLabels{
            healthLabelString += label + " ✔︎  "
        }
        favoriteRecipe.healthLabel = healthLabelString
        favoriteRecipe.image = recipe.image.data
        try? viewContext.save()
    }
    
    static func checkIfAlreadyExist(recipeId: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> Bool{
        
        for recipe in FavoriteRecipe.fetchAll(){
            if recipe.id == recipeId{
                return true
            }
        }
        return false
    }
    
}

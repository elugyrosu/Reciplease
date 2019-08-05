//
//  FavoriteRecipeTests.swift
//  RecipleaseTests
//
//  Created by Jordan MOREAU on 05/08/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class FavoriteRecipeTests: XCTestCase {
    //MARK: - Properties
    
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteRecipe")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()
    
    //MARK: - Helper Methods
    
    private func addRecipe(into managedObjectContext: NSManagedObjectContext) {
        let favoriteRecipe = FavoriteRecipe(context: managedObjectContext)
        favoriteRecipe.id = "Lemon pie"
    }
    
    //MARK: - Unit Tests
    
    func testInsertManyFavoriteRecipesItemsInPersistentContainer() {
        for _ in 0 ..< 100000 {
            addRecipe(into: mockContainer.newBackgroundContext())

        }
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    
    
    func testDeleteFavoriteRecipeItemInPersistentContainer() {
        let recipe = Recipe(label: "", image: "", url: "", shareAs: "Lemon Pie", yield: 0, healthLabels: [], ingredientLines: [], totalTime: 0)
    
        FavoriteRecipe.addRecipe(recipe: recipe)
        

        try? mockContainer.viewContext.save()
        FavoriteRecipe.deleteRecipe(recipeId: "Lemon Pie", viewContext: mockContainer.viewContext)
        XCTAssertEqual(FavoriteRecipe.fetchAll(viewContext: mockContainer.viewContext), [])
    }
}

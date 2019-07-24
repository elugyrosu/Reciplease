//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let edamamService = EdamamService()
    var recipesList = [Hit]()
    
    @IBOutlet var ingredientTextField: UITextField!
    
    @IBAction func clearIngredientsButton(_ sender: UIButton) {
    }
    
    @IBAction func addIngredientButton(_ sender: UIButton) {
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        recipesCall()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func recipesCall(){
        edamamService.getRecipeList(ingredients: "chicken") { success, edamamRecipes in
            if success {
                guard let edamamRecipes = edamamRecipes else { return }
//                self.recipesCount = edamamRecipes.hits.count
                self.recipesList = edamamRecipes.hits
                self.performSegue(withIdentifier: "segueToTableView", sender: self)

            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView" {
            let resultVC = segue.destination as! ResultTableViewController
            resultVC.recipesList = self.recipesList
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

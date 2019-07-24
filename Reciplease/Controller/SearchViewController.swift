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
    var recipeListCount = 0
    var ingredientList = [String]()
    
    @IBOutlet var ingredientListLabel: UILabel!
    @IBOutlet var ingredientTextField: UITextField!
    
    @IBAction func clearIngredientsButton(_ sender: UIButton) {
        self.ingredientList = [String]()
        refreshIngredientList()
    }
    
    @IBAction func addIngredientButton(_ sender: UIButton) {
        guard let ingredientToAdd = ingredientTextField.text else {return}
        if ingredientToAdd != "" {
            ingredientList.append(ingredientToAdd)
            refreshIngredientList()
            self.ingredientTextField.text = ""
        }
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        var ingredientsString = String()
        var i = 0
        for ingredient in ingredientList{
            if i > 0 {
                ingredientsString += ","
            }
            ingredientsString += ingredient
            i += 1
        }
        print(ingredientsString)
        recipesCall(ingredients: ingredientsString)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        refreshIngredientList()
    }
    private func recipesCall(ingredients: String){
        edamamService.getRecipeList(ingredients: ingredients) { success, edamamRecipes in
            if success {
                guard let edamamRecipes = edamamRecipes else { return }
                self.recipesList = edamamRecipes.hits
                self.recipeListCount = edamamRecipes.count
                if self.recipeListCount >= 1{
                    self.performSegue(withIdentifier: "segueToTableView", sender: self)
                }else{
                    self.presentAlert(message: "We have no recipe for your search, check your ingredients")
                }
            }else{
                self.presentAlert(message: "Network error")
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView" {
            let resultVC = segue.destination as! ResultTableViewController
            resultVC.recipesList = self.recipesList
        }
    }
    
   private func refreshIngredientList(){
        var textToShow = ""
        for ingredient in ingredientList{
            textToShow += "- " + ingredient + "\n"
        }
        self.ingredientListLabel.text = textToShow
    }
}

extension SearchViewController: UITextFieldDelegate{
    @IBAction func dismissedKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

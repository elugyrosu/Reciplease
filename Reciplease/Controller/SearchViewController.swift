//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private let edamamService = EdamamService()
    private var recipesList = [Hit]()
    private var recipeListCount = 0
    private var ingredientList = [String]()
    
    // MARK: - Outlets
    
    @IBOutlet private var ingredientSearchTableView: UITableView!
    @IBOutlet private var ingredientTextField: UITextField!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var searchButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
    }
    
    // MARK: - Action Button Outlets
    
    @IBAction func clearIngredientsButton(_ sender: UIButton) {
        self.ingredientList = [String]()
        ingredientSearchTableView.reloadData()
    }
    
    @IBAction func addIngredientButton(_ sender: UIButton) {
        guard let ingredientToAdd = ingredientTextField.text else {return}
        if ingredientToAdd != "" {
            ingredientList.append(ingredientToAdd)
            self.ingredientTextField.text = ""
            ingredientSearchTableView.reloadData()
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
        recipesCall(ingredients: ingredientsString)
    }
    
    // MARK: - Class Methods
    
    private func toggleActivityIndicator(shown: Bool){
        activityIndicatorView.isHidden = !shown
        searchButton.isHidden = shown
    }
    
    private func recipesCall(ingredients: String){
        toggleActivityIndicator(shown: true)
        edamamService.getRecipeList(ingredients: ingredients) { success, edamamRecipes in
            self.toggleActivityIndicator(shown: false)
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
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView" {
            guard let resultVC = segue.destination as? ResultTableViewController else{return}
            resultVC.recipesList = self.recipesList
        }
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate{
    @IBAction func dismissedKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientSearchCell", for: indexPath)
        cell.textLabel?.text = "- " + ingredientList[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            ingredientList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

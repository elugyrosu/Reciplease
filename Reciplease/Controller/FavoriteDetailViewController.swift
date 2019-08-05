//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

final class FavoriteDetailViewController: UIViewController {
    
    // MARK: Properties
    
    private var favoriteList = FavoriteRecipe.fetchAll()
    var favoriteRecipe: FavoriteRecipe?
    
    // MARK: Outlets
    
    @IBOutlet private var recipeImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var gradientView: UIView!
    @IBOutlet private var servingsLabelView: UILabel!
    @IBOutlet private var timeLabelView: UILabel!
    @IBOutlet private var favoriteBarButtonItem: UIBarButtonItem!
    
    // MARK: - Action Button Outlets
    
    @IBAction private func handleFavoriteBarButtonItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Caution", message: "Do you really want to remove this recipe from your favorite list ?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            guard let recipe  = self.favoriteRecipe else{return}
            guard let id = recipe.id else{return}
            FavoriteRecipe.deleteRecipe(recipeId: id)
            self.navigationController?.popViewController(animated: true)
        })
        let cancel = UIAlertAction(title: "No", style: .cancel)
        alertController.addAction(ok)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func handleGeDirectionButton(_ sender: UIButton) {
        guard let urlString = favoriteRecipe?.url else {return}
        guard let url = URL(string: urlString)else{return}
        UIApplication.shared.open(url)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Class Methods
    
    private func updateViews(){
        guard let recipe = favoriteRecipe else{return}
        titleLabel.text = recipe.label
        timeLabelView.text = recipe.totalTime
        servingsLabelView.text = recipe.yield
        guard let imageData = recipe.image else {return}
        recipeImageView.image = UIImage(data: imageData)
        recipeImageView.contentMode = .scaleAspectFill
    }
}

// MARK: - UITableViewDataSource

extension FavoriteDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = self.favoriteRecipe else {return 0}
        guard let ingredients = recipe.ingredients else{return 0}
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteIngredientCell", for: indexPath)
        guard let recipe = self.favoriteRecipe else {return UITableViewCell()}
        guard let ingredients = recipe.ingredients else {return UITableViewCell()}
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = "- " + (ingredient as String)
        return cell
    }
}

//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var recipe: Recipe?
    
    // MARK: - Outlets
    
    @IBOutlet private var recipeImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var gradientView: UIView!
    @IBOutlet private var servingLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var favoriteBarButtonItem: UIBarButtonItem!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        createGradientLayer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfFavorite()
    }
    
    // MARK: - Action Button Outlets
    
    @IBAction func handleFavoriteBarButtonItem(_ sender: UIBarButtonItem) {
        guard let id = recipe?.shareAs else {return}
        
        if FavoriteRecipe.checkIfAlreadyExist(recipeId: id) == true{
            FavoriteRecipe.deleteRecipe(recipeId: id)
        }else{
            guard let favoriteRecipe = recipe else{return}
            FavoriteRecipe.addRecipe(recipe: favoriteRecipe)
        }
        checkIfFavorite()
    }
    
    @IBAction func getDirectionsButton(_ sender: UIButton) {
        guard let urlString = recipe?.url else {return}
        guard let url = URL(string: urlString)else{return}
        UIApplication.shared.open(url)
    }
    
    // MARK: - Class Methods
    
    private func updateViews(){
        guard let recipe = recipe else{return}
        titleLabel.text = recipe.label
        if recipe.totalTime != 0 {
            timeLabel.text = String(recipe.totalTime) + " min ⧖"
        }else{
            timeLabel.text = "- ⧖"
        }
        servingLabel.text = String(Int(recipe.yield)) + " x ☺︎"
        guard let imageData = recipe.image.data else {return}
        recipeImageView.image = UIImage(data: imageData)
        recipeImageView.contentMode = .scaleAspectFill
    }
    
    private func checkIfFavorite(){
        guard let recipe = recipe else {return}
        let id = recipe.shareAs
        if FavoriteRecipe.checkIfAlreadyExist(recipeId: id) == true{
            favoriteBarButtonItem.image = #imageLiteral(resourceName: "Full star")
        }else{
            favoriteBarButtonItem.image = #imageLiteral(resourceName: "Empty Star")
        }
    }
    
    private func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView.bounds
        let greyColor = #colorLiteral(red: 0.2047212124, green: 0.1880749464, blue: 0.1830793917, alpha: 1)
        gradientLayer.colors = [UIColor.clear.cgColor, greyColor.cgColor]
        self.gradientView.layer.addSublayer(gradientLayer)
        self.titleLabel.superview?.bringSubviewToFront(titleLabel)
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = self.recipe else {return 0}
        return recipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        guard let ingredient = recipe?.ingredientLines[indexPath.row] else{
            return UITableViewCell()
        }
        cell.textLabel?.text = "- " + ingredient
        return cell
    }    
}

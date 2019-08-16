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
    @IBOutlet private var servingsLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
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
        createGradientLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfFavorite()
    }
    
    // MARK: - Class Methods
    
    private func checkIfFavorite(){
        guard let recipe = favoriteRecipe else {return}
        guard recipe.id != nil else {
            navigationController?.popViewController(animated: true)
            return
        }
    }
    
    private func updateViews(){
        guard let recipe = favoriteRecipe else{return}
        guard let time = recipe.totalTime else {return}
        guard let yield = recipe.yield else {return}
        if time != "0" {
            timeLabel.text = time + " min ⧖"
        }else{
            timeLabel.text = "- ⧖"
        }
        servingsLabel.text = yield + " x ☺︎"
        titleLabel.text = recipe.label
        guard let imageData = recipe.image else {return}
        recipeImageView.image = UIImage(data: imageData)
        recipeImageView.contentMode = .scaleAspectFill
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

//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var gradientView: UIView!
    
    @IBOutlet var servingsLabelView: UILabel!
    @IBOutlet var timeLabelView: UILabel!
    
    @IBOutlet var favoriteBarButtonItem: UIBarButtonItem!
    
    @IBAction func handleFavoriteBarButtonItem(_ sender: UIBarButtonItem) {
    }
    
    var favoriteList = FavoriteRecipe.fetchAll()
    
    var favoriteRecipe: FavoriteRecipe?

    @IBAction func handleGedirectionButton(_ sender: UIButton) {
        guard let source = favoriteRecipe?.url else {return}
        guard let url = URL(string: source)else{return}
        UIApplication.shared.open(url)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
extension FavoriteDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = self.favoriteRecipe else {return 0}
        return recipe.ingredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteIngredientCell", for: indexPath)
        guard let recipe = self.favoriteRecipe else {return UITableViewCell()}
        let ingredient = recipe.ingredients[indexPath.row]
        cell.textLabel?.text = "- " + (ingredient as String)
        
        return cell
    }
    
    
}

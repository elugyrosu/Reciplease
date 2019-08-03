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
        let alertController = UIAlertController(title: "Caution", message: "Do you really want to remove this recipe from your favorite list ?", preferredStyle: .alert)

        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.deleteRecipe()
            self.navigationController?.popViewController(animated: true)

        })
        
        let cancel = UIAlertAction(title: "No", style: .cancel)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)

        self.present(alertController, animated: true, completion: nil)
    
    }
    
    func deleteRecipe(){
        for favorite in favoriteList{
            if favorite.id == favoriteRecipe?.id {
                AppDelegate.viewContext.delete(favorite)
                
            }
        }
    }
    
    var favoriteList = FavoriteRecipe.fetchAll()
    
    var favoriteRecipe: FavoriteRecipe?

    @IBAction func handleGeDirectionButton(_ sender: UIButton) {
        guard let source = favoriteRecipe?.url else {return}
        guard let url = URL(string: source)else{return}
        UIApplication.shared.open(url)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
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
        guard let ingredients = recipe.ingredients else{return 0}
        return ingredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteIngredientCell", for: indexPath)
        guard let recipe = self.favoriteRecipe else {return UITableViewCell()}
        guard let ingredients = recipe.ingredients else{return UITableViewCell()}

        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = "- " + (ingredient as String)
        
        return cell
    }
    
    
}

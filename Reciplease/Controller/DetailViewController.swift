//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet var recipeImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var gradientView: UIView!
    @IBOutlet var servingsLabelView: UILabel!
    @IBOutlet var timeLabelView: UILabel!
    
    

    
    var recipe: Recipe?

    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.gradientView.bounds
        let greyColor = #colorLiteral(red: 0.2047212124, green: 0.1880749464, blue: 0.1830793917, alpha: 1)
        gradientLayer.colors = [UIColor.clear.cgColor, greyColor.cgColor]
        
        
        self.gradientView.layer.addSublayer(gradientLayer)
        
        self.titleLabel.superview?.bringSubviewToFront(titleLabel)
  
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        createGradientLayer()
        // Do any additional setup after loading the view.
    }
    
   private func updateViews(){
        guard let recipe = recipe else{return}
        titleLabel.text = recipe.label
        if recipe.totalTime != 0 {
            timeLabelView.text = String(recipe.totalTime) + " min ⧖"
        }else{
            timeLabelView.text = "- ⧖"
        }
        servingsLabelView.text = String(Int(recipe.yield)) + " x ☺︎"
        guard let imageData = recipe.image.data else {return}
        recipeImageView.image = UIImage(data: imageData)
        recipeImageView.contentMode = .scaleAspectFill
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
    

}

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

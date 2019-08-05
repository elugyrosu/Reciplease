//
//  RecipesCell.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 24/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    // MARK: - Properties
    
    var gradientLayer: CAGradientLayer!
    var recipe: Recipe? {
        didSet {
            guard let recipe = recipe else{return}
            titleLabelView.text = recipe.label
            if recipe.totalTime != 0 {
                timeLabelView.text = String(recipe.totalTime) + " min ⧖"
            }else{
                timeLabelView.text = "- ⧖"
            }
            servingsLabelView.text = String(Int(recipe.yield)) + " x ☺︎"
            var healthLabelString = String()
            for label in recipe.healthLabels{
                healthLabelString += label + " ✔︎  "
            }
            healthLabelView.text = healthLabelString
        }
    }
    var favoriteRecipe: FavoriteRecipe?{
        didSet {
            guard let recipe = favoriteRecipe else{return}
            titleLabelView.text = recipe.label
            timeLabelView.text = recipe.totalTime
            servingsLabelView.text = recipe.yield
            healthLabelView.text = recipe.healthLabel
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet var titleLabelView: UILabel!
    @IBOutlet var servingsLabelView: UILabel!
    @IBOutlet var timeLabelView: UILabel!
    @IBOutlet var healthLabelView: UILabel!
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var labelsStackView: UIStackView!
    @IBOutlet var gradientView: UIView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createGradientLayer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Class Methods

    private func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView.bounds
        let greyReciplease = #colorLiteral(red: 0.2047212124, green: 0.1880749464, blue: 0.1830793917, alpha: 1)
        gradientLayer.colors = [UIColor.clear.cgColor, greyReciplease.cgColor]
        self.gradientView.layer.addSublayer(gradientLayer)
        self.titleLabelView.superview?.bringSubviewToFront(titleLabelView)
        self.labelsStackView.superview?.bringSubviewToFront(labelsStackView)
        self.healthLabelView.superview?.bringSubviewToFront(healthLabelView)
    }
}

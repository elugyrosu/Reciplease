//
//  RecipesCell.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 24/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

final class CustomCell: UITableViewCell {

    // MARK: - Properties
    
    var gradientLayer: CAGradientLayer!
    var recipe: Recipe? {
        didSet {
            guard let recipe = recipe else{return}
            titleLabel.text = recipe.label
            if recipe.totalTime != 0 {
                timeLabel.text = String(recipe.totalTime) + " min ⧖"
            }else{
                timeLabel.text = "- ⧖"
            }
            servingLabel.text = String(Int(recipe.yield)) + " x ☺︎"
            var healthLabelString = String()
            for label in recipe.healthLabels{
                healthLabelString += label + " ✔︎  "
            }
            healthLabel.text = healthLabelString
        }
    }
    var favoriteRecipe: FavoriteRecipe?{
        didSet {
            guard let recipe = favoriteRecipe else{return}
            guard let totalTime = recipe.totalTime else {return}
            guard let yield = recipe.yield else {return}
            if recipe.totalTime != "0" {
                timeLabel.text = totalTime + " min ⧖"
            }else{
                timeLabel.text = "- ⧖"
            }
            titleLabel.text = recipe.label
            servingLabel.text = yield + " x ☺︎"
            healthLabel.text = recipe.healthLabel
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var servingLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var healthLabel: UILabel!
    @IBOutlet private var labelsStackView: UIStackView!
    @IBOutlet private var gradientView: UIView!
    @IBOutlet var cellImageView: UIImageView!

    
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
        self.titleLabel.superview?.bringSubviewToFront(titleLabel)
        self.labelsStackView.superview?.bringSubviewToFront(labelsStackView)
        self.healthLabel.superview?.bringSubviewToFront(healthLabel)
    }
}

//
//  RecipesCell.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 24/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var titleLabelView: UILabel!
    @IBOutlet var servingsLabelView: UILabel!
    @IBOutlet var timeLabelView: UILabel!
    @IBOutlet var healthLabelView: UILabel!
    @IBOutlet var cellImageView: UIImageView!
    
    @IBOutlet var labelsStackView: UIStackView!
    @IBOutlet var gradientView: UIView!
    
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
            guard let imageData = recipe.image.data else {return}
            cellImageView.image = UIImage(data: imageData)
            cellImageView.contentMode = .scaleAspectFill
            
            var healthLabelString = String()
            
            for label in recipe.healthLabels{
                healthLabelString += label + " ✔︎  "
            }
            healthLabelView.text = healthLabelString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createGradientLayer()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func createGradientLayer() {
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

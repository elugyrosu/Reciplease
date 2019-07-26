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
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createGradientLayer()

        // Initialization code
//        servingsLabelView.text =
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.gradientView.bounds
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        
        self.gradientView.layer.addSublayer(gradientLayer)
        
        self.titleLabelView.superview?.bringSubviewToFront(titleLabelView)
        self.labelsStackView.superview?.bringSubviewToFront(labelsStackView)
        self.healthLabelView.superview?.bringSubviewToFront(healthLabelView)

  

//        self.timeLabelView.textColor = .white
//        self.servingsLabelView.textColor = .white

        
    }
    
}

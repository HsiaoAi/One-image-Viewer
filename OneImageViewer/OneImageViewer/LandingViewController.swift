//
//  LandingViewController.swift
//  OneImageViewer
//
//  Created by Hsiao Ai LEE on 23/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    // Properties
    @IBOutlet weak var pickUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPickImageButton()
    }
    
}

extension LandingViewController {
    func setUpPickImageButton() {
        // Two colors background
        pickUpButton.backgroundColor = UIColor.CustomTheme.black43
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.pickUpButton.bounds
        gradientLayer.colors = [
            UIColor.CustomTheme.white5.cgColor,
            UIColor.CustomTheme.white5.cgColor,
            UIColor.CustomTheme.black43.cgColor,
            UIColor.CustomTheme.black43.cgColor
        ]
        gradientLayer.locations = [0, 0.5, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        pickUpButton.layer.addSublayer(gradientLayer)
        
        // Shadow
        pickUpButton.layer.shadowColor = UIColor.CustomTheme.black25.cgColor
        pickUpButton.layer.shadowOpacity = 1.0
        pickUpButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        pickUpButton.layer.shadowRadius = 4
    }
}

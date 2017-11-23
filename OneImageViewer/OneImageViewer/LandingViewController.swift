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
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.pickUpButton.bounds
        gradient.colors = [
            UIColor.CustomTheme.white5.cgColor,
            UIColor.CustomTheme.black43.cgColor
        ]
        
    }
}

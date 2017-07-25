//
//  TutorialViewController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 08/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialViewController1: UIViewController {
    
    @IBOutlet weak var center: UIImageView!
    
    var hasAlreadyAppeared = false
        
    override func viewDidLoad() {
        center.isUserInteractionEnabled = true
    }
    
    @IBAction func touch(_ sender: UITapGestureRecognizer) {
        center.shake()
    }
}

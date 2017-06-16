//
//  FagerstromPage2.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 11/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class FagerstromPage2: PageModelViewController{
    
    //MARK: - Outlets
    @IBOutlet weak var yesButtonOutlet: UIButton!
    @IBOutlet weak var noButtonOutlet: UIButton!
    
    //MARK: - Atributes
    var points: Int?
    
    //Manage selected button
    func deselect() {
        yesButtonOutlet.isSelected = false
        noButtonOutlet.isSelected = false
    }

    //MARK: - ViewController Life cicle
    override func shouldContinueToNextViewController() -> Bool {
        return points != nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Actions
    @IBAction func yesTap(_ sender: Any) {
        deselect()
        yesButtonOutlet.isSelected = true
        points = 1
    }
    
    @IBAction func noTap(_ sender: Any) {
        deselect()
        noButtonOutlet.isSelected = true
        points = 0
    }
}

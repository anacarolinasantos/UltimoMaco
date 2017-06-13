//
//  FagerstromPage4.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 11/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class FagerstromPage4: PageModelViewController{
    
    //MARK: - Outlets
    
    //MARK: - Atributes
    var points: Int?
    
    override func shouldContinueToNextViewController() -> Bool {
        return points != nil
    }
    
    //MARK: - Actions
    @IBAction func yesTap(_ sender: Any) {
        points = 0
    }
    
    @IBAction func noTap(_ sender: Any) {
        points = 1
    }
}

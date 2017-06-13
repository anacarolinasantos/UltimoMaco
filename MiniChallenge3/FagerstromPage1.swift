//
//  FagerstromPage1.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 11/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class FagerstromPage1: PageModelViewController{
    
    //MARK: - Outlets
    
    //MARK: - Atributes
    var points: Int?
    
    override func shouldContinueToNextViewController() -> Bool {
        return points != nil
    }
    
    //MARK: - Actions
    @IBAction func moreThan60Tap(_ sender: Any) {
        points = 0
    }
    
    @IBAction func between30And60Tap(_ sender: Any) {
        points = 1
    }
    
    @IBAction func between5And30Tap(_ sender: Any) {
        points = 2
    }

    @IBAction func lessThan5Tap(_ sender: Any) {
        points = 3
    }
    
}

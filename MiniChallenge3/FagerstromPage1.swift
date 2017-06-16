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
    @IBOutlet weak var moreThan60ButtonOutlet: UIButton!
    @IBOutlet weak var between30And60ButtonOutlet: UIButton!
    @IBOutlet weak var between5And30ButtonOutlet: UIButton!
    @IBOutlet weak var lessThan5ButtonOutlet: UIButton!
    
    //MARK: - Atributes
    var points: Int?
    
    //MARK: - ViewController Life cicle
    override func shouldContinueToNextViewController() -> Bool {
        return points != nil
    }
    
    //Manage selected button
    func deselect(){
        moreThan60ButtonOutlet.isSelected = false
        between30And60ButtonOutlet.isSelected = false
        between5And30ButtonOutlet.isSelected = false
        lessThan5ButtonOutlet.isSelected = false
    }
    
    //MARK: - Actions
    @IBAction func moreThan60Tap(_ sender: UIButton) {
        deselect()
        sender.isSelected = true
        points = 0
    }
    
    @IBAction func between30And60Tap(_ sender: UIButton) {
        deselect()
        sender.isSelected = true
        points = 1
    }
    
    @IBAction func between5And30Tap(_ sender: UIButton) {
        deselect()
        sender.isSelected = true
        points = 2
    }

    @IBAction func lessThan5Tap(_ sender: UIButton) {
        deselect()
        sender.isSelected = true
        points = 3
    }
    
}

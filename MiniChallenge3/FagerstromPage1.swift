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
    @IBOutlet weak var zero: UIButton!
    
    @IBOutlet weak var one: UIButton!
    
    @IBOutlet weak var two: UIButton!
    
    @IBOutlet weak var three: UIButton!
    
    var originalColor = UIColor.green
    
    func cleanAll() {
        zero.tintColor = originalColor
        one.tintColor = originalColor
        two.tintColor = originalColor
        three.tintColor = originalColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        originalColor = zero.tintColor
    }
    
    //MARK: - Atributes
    var points: Int?
    
    override func shouldContinueToNextViewController() -> Bool {
        return points != nil
    }
    
    //MARK: - Actions
    @IBAction func moreThan60Tap(_ sender: Any) {
        points = 0
        cleanAll()
        zero.tintColor = UIColor.yellow
    }
    
    @IBAction func between30And60Tap(_ sender: Any) {
        points = 1
        cleanAll()
        one.tintColor = UIColor.yellow
    }
    
    @IBAction func between5And30Tap(_ sender: Any) {
        points = 2
        cleanAll()
        two.tintColor = UIColor.yellow
    }

    @IBAction func lessThan5Tap(_ sender: Any) {
        points = 3
        cleanAll()
        three.tintColor = UIColor.yellow
    }
    
}

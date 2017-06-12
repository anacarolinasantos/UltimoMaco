//
//  Page4ViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class Page4ViewController: PageModelViewController {
    
    var selectedWeeks: Int?
    
    //MARK: - ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func shouldContinueToNextViewController() -> Bool {
        return selectedWeeks != nil
    }
    
    //MARK: - Actions
    
    @IBAction func oneTap(_ sender: UIButton) {
        selectedWeeks = 1
        print("One Week")
    }
    
    @IBAction func twoTap(_ sender: UIButton) {
        selectedWeeks = 2
        print("Two Week")
    }
    
    @IBAction func threeTap(_ sender: UIButton) {
        selectedWeeks = 3
        print("Three Week")
    }
    
    @IBAction func fourTap(_ sender: UIButton) {
        selectedWeeks = 4
        print("Four Week")
    }
    
}

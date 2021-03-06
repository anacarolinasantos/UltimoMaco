//
//  Page4ViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class Page4ViewController: PageModelViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var oneWeekButtonOutlet: UIButton!
    @IBOutlet weak var twoWeeksButtonOutlet: UIButton!
    @IBOutlet weak var threeWeeksButtonOutlet: UIButton!
    @IBOutlet weak var fourWeeksButtonOutlet: UIButton!
    
    //MARK: - Atributes
    var selectedWeeks: Int?
    
    //MARK: - ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        // -- SETUP

    }
    
    override func shouldContinueToNextViewController() -> Bool {
        return selectedWeeks != nil
    }
    
    //Manage selected button
    func deselect(){
        oneWeekButtonOutlet.isSelected = false
        twoWeeksButtonOutlet.isSelected = false
        threeWeeksButtonOutlet.isSelected = false
        fourWeeksButtonOutlet.isSelected = false
    }
    
    //MARK: - Actions
    
    @IBAction func oneTap(_ sender: UIButton) {
        deselect()
        sender.isSelected = true
        selectedWeeks = 1
        print("One Week")
    }
    
    @IBAction func twoTap(_ sender: UIButton) {
        deselect()
        sender.isSelected = true
        selectedWeeks = 2
        print("Two Week")
    }
    
    @IBAction func threeTap(_ sender: UIButton) {
        deselect()
        sender.isSelected = true
        selectedWeeks = 3
        print("Three Week")
    }
    
    @IBAction func fourTap(_ sender: UIButton) {
        deselect()
        sender.isSelected = true
        selectedWeeks = 4
        print("Four Week")
    }
    
}

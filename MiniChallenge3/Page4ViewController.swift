//
//  Page4ViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class Page4ViewController: PageModelViewController {
    
    //MARK: - ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    
    @IBAction func oneTap(_ sender: UIButton) {
        print("One Week")
    }
    
    @IBAction func twoTap(_ sender: UIButton) {
        print("Two Week")
    }
    
    @IBAction func threeTap(_ sender: UIButton) {
        print("Three Week")
    }
    
    @IBAction func fourTap(_ sender: UIButton) {
        print("Four Week")
    }
    
}

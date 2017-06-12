//
//  Page5ViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class Page5ViewController: PageModelViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: - Atributes
    
    //MARK: - ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        datePicker.datePickerMode = .time
    }
    
    @IBAction func startUsingApp(_ sender: Any) {
        //TODO: capture date, and finish storyboard
        
        let setViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UserDefaults.standard.set(true, forKey: "isFirstTimeInApp")
        UserDefaults.standard.synchronize()
        self.present(setViewController!, animated: true, completion: nil)
    }
    
}

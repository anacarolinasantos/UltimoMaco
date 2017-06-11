//
//  Page1ViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class Page1ViewController: PageModelViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Atributes
    var name: String?
    
    //MARK: - ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        self.hideKeyboardWhenTappedAround()
        nameTextField.delegate = self
    }
    
    //MARK: - UITextFieldDelegate
    
    // Dismiss keyboard, and capture text when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //TODO: Add text validation, and animation .shake to entry fail
        name = nameTextField.text
        textField.resignFirstResponder()
        return true
    }
    
}

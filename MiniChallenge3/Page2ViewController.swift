//
//  Page2ViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class Page2ViewController: PageModelViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var amountPickerView: UIPickerView!
    
    //MARK: - Atributes
    var cigaretteNumber: Int = 1
    var amount: [Int] = []  //It is the PickerView DataSource
    
    //MARK: - ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        amountPickerView.delegate = self
        amountPickerView.dataSource = self
        // I've decideed to give the user up to 200 cigarettes a day.
        for i in 1...200{
            amount.append(i)
        }
    }
    
    //MARK: - UIPickerViewDataSource
    
    // Sets the PickerView number of Columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the PickerView number of elements per column
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.amount.count
    }
    
    //MARK: - UIPickerViewDelegate
    
    // Sets each element of the row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.amount[row])
    }
    
    // Gets the row element when selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cigaretteNumber = self.amount[row]
    }
    
}

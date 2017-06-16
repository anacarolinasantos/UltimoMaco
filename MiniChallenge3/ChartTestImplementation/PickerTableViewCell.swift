//
//  PickerTableViewCell.swift
//  MiniChallenge3
//
//  Created by Osniel Lopes Teixeira on 15/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var picker: UIPickerView!
    var rowTitles: [String]! = []

    override func awakeFromNib() {
        super.awakeFromNib()
        picker.delegate = self
        rowTitles.append(contentsOf: ["Sem valor"])
        let sequence = Array(0...100)
        rowTitles.append(contentsOf: sequence.map{ String($0) })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 101
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rowTitles[row]
    }
    
//    override func didChangeValue(forKey key: String) {
//        LineChartData().updateSomePoint(<#T##date: Date##Date#>, <#T##cigarettNumber: Int##Int#>)
//    }


}

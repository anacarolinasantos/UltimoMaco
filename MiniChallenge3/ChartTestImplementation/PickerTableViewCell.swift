//
//  PickerTableViewCell.swift
//  MiniChallenge3
//
//  Created by Osniel Lopes Teixeira on 15/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol CustomCellUpdater: class {
    func updateTableView()
}

class PickerTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var picker: UIPickerView!
    var rowTitles: [String]! = []
    var forDate: Date!
    weak var delegate: CustomCellUpdater?
    
    func awakeFromNib(_ delegate: CustomCellUpdater,_ date: Date) {
        super.awakeFromNib()
        forDate = date
        picker.delegate = self
        rowTitles.append(contentsOf: ["Sem valor"])
        let sequence = Array(0...100)
        rowTitles.append(contentsOf: sequence.map{ String($0) })
        self.delegate = delegate
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        LineChartData().updateSomePoint(forDate, row-1)
        delegate?.updateTableView()
    }


}

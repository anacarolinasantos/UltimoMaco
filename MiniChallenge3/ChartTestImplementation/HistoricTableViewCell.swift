//
//  HistoricTableViewCell.swift
//  MiniChallenge3
//
//  Created by Osniel Lopes Teixeira on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class HistoricTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var numberOfCigarettes: UILabel!
    @IBOutlet weak var picker: UIPickerView!

    var point: ChartPoint!
    var rowTitles: [String]! = []
    
    func awakeFromNib(_ point:ChartPoint) {
        super.awakeFromNib()
        
        date.text = point.getFormattedDate()
        self.point = point
        if point.cigarettes != -1 {
        numberOfCigarettes.text = String(point.cigarettes)
        }
        else {
            numberOfCigarettes.text = "Não registrado"
        }
        picker.delegate = self
        
        rowTitles.append(contentsOf: ["Sem valor"])
        let sequence = Array(0...100)
        rowTitles.append(contentsOf: sequence.map{ String($0) })
        
        picker.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        picker.isHidden = false
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
}

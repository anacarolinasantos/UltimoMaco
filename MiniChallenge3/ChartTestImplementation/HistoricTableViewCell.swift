//
//  HistoricTableViewCell.swift
//  MiniChallenge3
//
//  Created by Osniel Lopes Teixeira on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class HistoricTableViewCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var numberOfCigarettes: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var point: ChartPoint!
    
    func awakeFromNib(_ point:ChartPoint) {
        super.awakeFromNib()
        self.point = point
        date.text = point.getFormattedDate()
        numberOfCigarettes.text = String(point.cigarettes)
        stepper.value = Double(point.cigarettes)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func stepperTouched(_ sender: Any) {
        point.cigarettes = Int(stepper!.value)
        LineChartData().updateSomePoint(date.text!, point.cigarettes)
        self.awakeFromNib(self.point)
        
    }

}

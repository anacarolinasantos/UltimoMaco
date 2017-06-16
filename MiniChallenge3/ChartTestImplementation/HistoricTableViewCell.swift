//
//  HistoricTableViewCell.swift
//  MiniChallenge3
//
//  Created by Osniel Lopes Teixeira on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class HistoricTableViewCell: UITableViewCell{
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var numberOfCigarettes: UILabel!
    
    var point: ChartPoint!
        
    func awakeFromNib(_ point:ChartPoint) {
        super.awakeFromNib()
        
        date.text = point.getExpandedFormattedDate()
        self.point = point
        if point.cigarettes != -1 {
        numberOfCigarettes.text = String(point.cigarettes)+" cigarros"
        }
        else {
            numberOfCigarettes.text = "Não registrado"
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

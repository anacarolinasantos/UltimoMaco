//
//  TodayViewController.swift
//  Widget
//
//  Created by Guilherme Paciulli on 08/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreData

class TodayViewController: UIViewController, NCWidgetProviding {
    
    //MARK: Outlets
    @IBOutlet weak var cigarettesNumberLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    //MARK: Atributes
    var todayCigarettesNumber:Int = 0
    let appGroupName:String = "group.br.minichallenge.3"
    let lineChartData = LineChartData()
    
    
    //MARK: ViewController Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        todayCigarettesNumber = getTodayCigarettesNumberFromCoreData()
        stepperOutlet.value = Double(todayCigarettesNumber)
        cigarettesNumberLabel.text = String(todayCigarettesNumber)
        
    }

    //MARK: CoreData todayCigarettesNumber get and set
    
    func setTodayCigarettesNumberToCoreData(_ todayCigarettesNumber: Int){
        lineChartData.updateSomePoint(Date(), todayCigarettesNumber)
    }
    
    func getTodayCigarettesNumberFromCoreData() -> Int{
        return lineChartData.getCigarettesOfSomeDay(Date())
    }
    
    //MARK: Actions
    @IBAction func stepperTap(_ sender: UIStepper) {
        todayCigarettesNumber = Int(sender.value)
        setTodayCigarettesNumberToCoreData(todayCigarettesNumber)
        cigarettesNumberLabel.text = String(todayCigarettesNumber)
    }
    
}

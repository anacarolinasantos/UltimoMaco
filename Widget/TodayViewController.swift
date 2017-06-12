//
//  TodayViewController.swift
//  Widget
//
//  Created by Guilherme Paciulli on 08/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    //MARK: Outlets
    @IBOutlet weak var cigarettesNumberLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    //MARK: Atributes
    var todayCigarettesNumber:Int = 0
    let appGroupName:String = "group.br.minichallenge.3"
    
    
    //MARK: ViewController Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        todayCigarettesNumber = getTodayCigarettesNumberFromNSUserDefaults()
        stepperOutlet.value = Double(todayCigarettesNumber)
        cigarettesNumberLabel.text = String(todayCigarettesNumber)
    }
    
    //MARK: Widget
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }

    //MARK: NSUserDefaults todayCigarettesNumber get and set
    
    func setTodayCigarettesNumberToNSUserDefaults(_ todayCigarettesNumber: Int){
        
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            userDefaults.set(todayCigarettesNumber as AnyObject, forKey: "todayCigarettesNumber")
            userDefaults.synchronize()
        }
    }
    
    func getTodayCigarettesNumberFromNSUserDefaults() -> Int{
        
        if let userDefaults = UserDefaults(suiteName: appGroupName){
            return userDefaults.integer(forKey: "todayCigarettesNumber")
        }
        
        return -1
    }
    
    //MARK: Actions
    @IBAction func stepperTap(_ sender: UIStepper) {
        
        todayCigarettesNumber = Int(sender.value)
        setTodayCigarettesNumberToNSUserDefaults(todayCigarettesNumber)
        cigarettesNumberLabel.text = String(todayCigarettesNumber)
    }
    
}

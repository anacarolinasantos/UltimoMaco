//
//  ViewController.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli, Osniel Teixeira. All rights reserved.
//

import UIKit

class PersonalProgressViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var chart: LineChart!
    @IBOutlet weak var cigarettesNumberLabel: UILabel!

    @IBOutlet weak var stepperOutlet: UIStepper!
    
    //MARK: Atributes
    var todayCigarettesNumber:Int = 0
    let appGroupName:String = "group.br.minichallenge.3"
    var synchronize = Timer()
    
    //MARK: ViewController Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        // Chart datasource
        let test = LineChartData(points: [ChartPoint(Date(), 21),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 1, to: Date())!, 20),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 2, to: Date())!, 17),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 3, to: Date())!, 19),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 4, to: Date())!, 6),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 5, to: Date())!),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 6, to: Date())!),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 7, to: Date())!),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 8, to: Date())!),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 9, to: Date())!),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 10, to: Date())!, 11),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 11, to: Date())!, 4),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 12, to: Date())!, 3),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 13, to: Date())!, 2),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 14, to: Date())!, 1),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 15, to: Date())!, 7),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 16, to: Date())!, 1),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 17, to: Date())!),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 18, to: Date())!),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 19, to: Date())!, 5),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 20, to: Date())!, 3),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 21, to: Date())!, 0)])
        chart.pointData = test
        
        //Update main atributes
        updateCigarettesNumber()
        
        //Timer that calls updateCigarettesNumberLabel each 0.01 second to keep it updated with NSUserDefaults
        synchronize = .scheduledTimer(timeInterval: 0.01, target: self,
                                      selector: #selector(self.updateCigarettesNumber),
                                      userInfo: nil,
                                      repeats: true)
        
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
    
    //Updates cigarettesNumberLabel, and stepperOutlet.value
    func updateCigarettesNumber(){
        todayCigarettesNumber = getTodayCigarettesNumberFromNSUserDefaults()
        stepperOutlet.value = Double(todayCigarettesNumber)
        cigarettesNumberLabel.text = String(todayCigarettesNumber)
    }
    
    //MARK: Actions

    @IBAction func stepperTap(_ sender: UIStepper) {
        
        todayCigarettesNumber = Int(sender.value)
        setTodayCigarettesNumberToNSUserDefaults(todayCigarettesNumber)
        cigarettesNumberLabel.text = String(todayCigarettesNumber)
    }
}


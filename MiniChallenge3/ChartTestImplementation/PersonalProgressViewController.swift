//
//  ViewController.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli, Osniel Teixeira. All rights reserved.
//

import UIKit
import CoreData

public class PersonalProgressViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var chart: LineChart!
    @IBOutlet weak var cigarettesNumberLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var today: UILabel!
    
    
    //MARK: Atributes
    var todayCigarettesNumber:Int = 0
    let appGroupName:String = "group.br.minichallenge.3"
    var synchronize = Timer()
    
    //MARK: ViewController Life Cicle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        
        //Update main atributes
        updateCigarettesNumber()
        
        //Timer that calls updateCigarettesNumberLabel each 0.01 second to keep it updated with NSUserDefaults
        synchronize = .scheduledTimer(timeInterval: 0.01, target: self,
                                      selector: #selector(self.updateCigarettesNumber),
                                      userInfo: nil,
                                      repeats: true)
        
        for view in self.view.subviews{
            if let thisView = view as? LineChart{
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
                recognizer.delegate = self
                thisView.addGestureRecognizer(recognizer)
            }
        }
        
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
        chart.pointData.points[LineChartData().points.count-1].cigarettes = Int(sender.value)
        updateChart()
    }
    
    public func updateChart(){
        chart.subviews.forEach { $0.removeFromSuperview() }
        chart.setNeedsDisplay()
    }
    
    func handleTap(recognizer: UITapGestureRecognizer){
        performSegue(withIdentifier: "showHistoric", sender: recognizer)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        updateChart()
        let cigarretsOfToday = -(Int(Double(chart.pointData.points[0].cigarettes)/Double(chart.pointData.totalDays) * Double(LineChartData().points.count-1))) + chart.pointData.points[0].cigarettes
        today.text = "Meta apenas \(cigarretsOfToday) cigarros"
    }
}


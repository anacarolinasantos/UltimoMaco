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
        stepperOutlet.value = Double(LineChartData().getCigarettesOfSomeDay(Date()))
        //Timer that calls updateCigarettesNumberLabel each 0.01 second to keep it updated with NSUserDefaults
//        synchronize = .scheduledTimer(timeInterval: 0.01, target: self,
//                                      selector: #selector(self.updateCigarettesNumber),
//                                      userInfo: nil,
//                                      repeats: true)
        
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
        stepperOutlet.value = Double(todayCigarettesNumber)
        setTodayCigarettesNumberToNSUserDefaults(todayCigarettesNumber)
        cigarettesNumberLabel.text = String(todayCigarettesNumber)
        chart.pointData.updateSomePoint(Date(), todayCigarettesNumber)
        updateChart()
    }
    
    public func updateChart(){
        chart.subviews.forEach { $0.removeFromSuperview() }
        chart.setNeedsDisplay()
    }
    
    func handleTap(recognizer: UITapGestureRecognizer){
        performSegue(withIdentifier: "showHistoric", sender: nil)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateChart()
        
        var allEntries: [CigaretteEntry] = []
        
        do {
            allEntries = try DatabaseController.persistentContainer.viewContext.fetch(CigaretteEntry.fetchRequest()) as! [CigaretteEntry]
        } catch _ as NSError { print("Error") }
        
        allEntries = allEntries.sorted(by: { ($0.date as Date!) < ($1.date as Date!) } )
        
        let cigarretsOfToday = LineChartData().getTargetOfConsumption(Date())
        today.text = "Meta apenas \(cigarretsOfToday) cigarros"
        
        let cigarettesNumber = LineChartData().getCigarettesOfSomeDay(Date())
        if cigarettesNumber != -1 {
        cigarettesNumberLabel.text = String(cigarettesNumber)
        } else{
            cigarettesNumberLabel.text = "Sem dados"
        }
        
    }
    
    
}


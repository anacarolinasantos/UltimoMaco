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
    var todayIndex: Int = 0
    
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
        
        today.text = LineChartData().points.last?.getFormattedDate()
        todayIndex = LineChartData().points.count-1
        
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
        chart.pointData.points[todayIndex].cigarettes = Int(sender.value)
        updateChart()
    }
    
    func alteraUltimoCampo(_ cigarettNumber: Int){
        //Pega todas as entradas
        var entries: [CigaretteEntry] = []
        do {
            entries = try DatabaseController.persistentContainer.viewContext.fetch(NSFetchRequest(entityName: "CiggareteEntry"))
        } catch _ as NSError {
            print("Error")
        }
        
        DatabaseController.saveContext()
        
    }
    
    public func updateChart(){
        chart.subviews.forEach { $0.removeFromSuperview() }
        chart.setNeedsDisplay()
    }
    
    @IBAction func yesterday(_ sender: Any) {
        todayIndex -= 1
        today.text = LineChartData().points[todayIndex].getFormattedDate()
    }
    @IBAction func tomorrow(_ sender: Any) {
        todayIndex += 1
        today.text = LineChartData().points[todayIndex].getFormattedDate()
    }
    
    func handleTap(recognizer: UITapGestureRecognizer){
        performSegue(withIdentifier: "showHistoric", sender: recognizer)
    }
    
    //    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "showHistoric" {
    //            
    //        }
    //    }
    
}


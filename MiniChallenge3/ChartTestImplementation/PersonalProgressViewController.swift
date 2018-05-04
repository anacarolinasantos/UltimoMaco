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
        viewWillAppear(false)
        stepperOutlet.value = Double(LineChartData().getCigarettesOfSomeDay(Date()))

        for view in self.view.subviews{
            if let thisView = view as? LineChart{
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
                recognizer.delegate = self
                thisView.addGestureRecognizer(recognizer)
            }
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appWillEnterForeground),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground,
                                               object: nil)
        
        // Watch
        WSManager.shared.recievedMessage = { message in
            if let smokedToday = message["NumberOfCigarettes"] as? Int {
                self.todayCigarettesNumber = smokedToday
                self.stepperOutlet.value = Double(self.todayCigarettesNumber)
                DispatchQueue.main.async {
                    self.cigarettesNumberLabel.text = String(self.todayCigarettesNumber)
                    LineChartData().updateSomePoint(Date(), self.todayCigarettesNumber)
                    self.updateChart()
                }
            }
        }
        
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
        today.text = "\(cigarretsOfToday)"
        
        let cigarettesNumber = LineChartData().getCigarettesOfSomeDay(Date())
        if cigarettesNumber != -1 {
            cigarettesNumberLabel.text = String(cigarettesNumber)
        } else {
            cigarettesNumberLabel.text = "Sem dados"
        }
        
        if (allEntries.last!.date! as Date) < Date() {
            self.cigarettesNumberLabel.text = "-"
            self.today.text = "-"
            self.stepperOutlet.isEnabled = false
        }
        
    }
    
    //MARK: Actions
    
    @IBAction func stepperTap(_ sender: UIStepper) {
        
        todayCigarettesNumber = Int(sender.value)
        stepperOutlet.value = Double(todayCigarettesNumber)
        cigarettesNumberLabel.text = String(todayCigarettesNumber)
        LineChartData().updateSomePoint(Date(), todayCigarettesNumber)
        WSManager.shared.sendNumberOfCigarettes(todayCigarettesNumber)
        updateChart()
    }
    
    public func updateChart(){
        chart.subviews.forEach { $0.removeFromSuperview() }
        chart.setNeedsDisplay()
    }
    
    func handleTap(recognizer: UITapGestureRecognizer){
        performSegue(withIdentifier: "showHistoric", sender: nil)
    }
    
    func appWillEnterForeground(){
        viewWillAppear(false)
    }
    
    
}


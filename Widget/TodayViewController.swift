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

class TodayViewController: UIViewController, NCWidgetProviding, CAAnimationDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var cigarettesNumberLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var circle: UIView!
    
    //MARK: Atributes
    var todayCigarettesNumber:Int = 0
    let appGroupName:String = "group.br.minichallenge.3"
    let lineChartData = LineChartData()
    var shapeLayer: CAShapeLayer?
    
    
    //MARK: ViewController Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        todayCigarettesNumber = getTodayCigarettesNumberFromCoreData()
        stepperOutlet.value = Double(todayCigarettesNumber)
        cigarettesNumberLabel.text = todayCigarettesNumber == -1 ? "Sem dados" : String(todayCigarettesNumber)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateCircle(oldValue: 0, newValue: todayCigarettesNumber)
    }
    
    //MARK: CoreData todayCigarettesNumber get and set
    
    func setTodayCigarettesNumberToCoreData(_ todayCigarettesNumber: Int){
        lineChartData.updateSomePoint(Date(), todayCigarettesNumber)
    }
    
    func getTodayCigarettesNumberFromCoreData() -> Int{
        return lineChartData.getCigarettesOfSomeDay(Date())
    }
    
    func updateCircle(oldValue: Int, newValue: Int) {
        
        let maxCigs = lineChartData.getTargetOfConsumption(Date())
        if newValue <= maxCigs {
            shapeLayer?.removeFromSuperlayer()
            
            let path = UIBezierPath(arcCenter: cigarettesNumberLabel.center, radius: circle.frame.width / 3,
                                     startAngle: 0, endAngle: .pi * 2,
                                     clockwise: true)
            shapeLayer = CAShapeLayer()
            shapeLayer?.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
            shapeLayer?.strokeColor = #colorLiteral(red: 0.03185217083, green: 0.6144382954, blue: 0.736053884, alpha: 1).cgColor
            shapeLayer?.lineWidth = 7
            shapeLayer?.path = path.cgPath

            let animation = CABasicAnimation(keyPath: "strokeEnd")
            let delta = oldValue - newValue > 0 ? oldValue - newValue : newValue - oldValue
            animation.duration = CFTimeInterval(delta / maxCigs)
            let unit: CGFloat = 1 / CGFloat(maxCigs)
            animation.fromValue = unit * CGFloat(oldValue)
            animation.toValue = unit * CGFloat(newValue)
            shapeLayer?.strokeEnd = unit * CGFloat(newValue)
            self.view.layer.insertSublayer(shapeLayer!, above: cigarettesNumberLabel.layer)
            shapeLayer?.add(animation, forKey: "MyAnimation")
            
        } else {
            cigarettesNumberLabel.shake()
        }
    }
    
    //MARK: Actions
    @IBAction func stepperTap(_ sender: UIStepper) {
        updateCircle(oldValue: todayCigarettesNumber, newValue: Int(sender.value))
        todayCigarettesNumber = Int(sender.value)
        setTodayCigarettesNumberToCoreData(todayCigarettesNumber)
        cigarettesNumberLabel.text = String(todayCigarettesNumber)
    }
    
}

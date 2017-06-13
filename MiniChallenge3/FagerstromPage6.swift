//
//  FagerstromPage6.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 11/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class FagerstromPage6: PageModelViewController{
    
    //MARK: - Outlets
    @IBOutlet weak var points: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    //MARK: - ViewController Life Cicle
    override func viewWillAppear(_ animated: Bool) {
        var test: FagerstromTest?
        
        do {
            var tests = try DatabaseController.persistentContainer.viewContext.fetch(FagerstromTest.fetchRequest())
            if tests.count == 0 {
                test = NSEntityDescription.insertNewObject(forEntityName: "FagerstromTest", into: DatabaseController.persistentContainer.viewContext) as? FagerstromTest
            } else {
                test = tests[0] as? FagerstromTest
            }
            
        } catch _ as NSError {
            print("Error")
        }
        
        
        if let vcs = (self.pageViewController as? FagerstromFormPageViewController)?.allViewControllers {
            
            var dependencyLevel = ""
            var color = UIColor.black
            
            let p1 = (vcs[0] as! FagerstromPage1).points
            test?.cigarreteRestriction = Int16(p1!)
            let p2 = (vcs[1] as! FagerstromPage2).points
            test?.cigQtyFirstHours = Int16(p2!)
            let p3 = (vcs[2] as! FagerstromPage3).points
            test?.firstCigarrete = Int16(p3!)
            let p4 = (vcs[3] as! FagerstromPage4).points
            test?.morningCigarrete = Int16(p4!)
            let p5 = (vcs[4] as! FagerstromPage5).points
            test?.sickSmoking = Int16(p5!)
            
            var p6 = 0
            do {
                // Verify if cigaretteEntry exists, and gets cigarettes number
                if let cigaretteEntry = (try DatabaseController.persistentContainer.viewContext.fetch(CigaretteEntry.fetchRequest()) as? [CigaretteEntry]) {
                    
                    if cigaretteEntry.count != 0 {
                        if cigaretteEntry[0].cigaretteNumber > 30 {
                            p6 = 3
                        } else if cigaretteEntry[0].cigaretteNumber > 20{
                            p6 = 2
                        } else if cigaretteEntry[0].cigaretteNumber > 10{
                            p6 = 1
                        }
                    }
                }

            } catch _ as NSError { print("Error") }
            
            let sum = p1! + p2! + p3! + p4! + p5! + p6
            
            if sum < 2 {
                dependencyLevel = "Muito baixo"
                color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            } else if sum < 4 {
                dependencyLevel = "Moderado"
                color = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            } else if sum < 7 {
                dependencyLevel = "Acima da média"
                color = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            } else if sum < 8 {
                dependencyLevel = "Muito alto"
                color = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            } else {
                dependencyLevel = "Grave"
                color = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
            
            points.text = String(describing: sum)
            resultLabel.text = dependencyLevel
            resultLabel.textColor = color
            
            DatabaseController.saveContext()
        }
    }
    
    override func shouldGoBackToPreviousViewController() -> Bool {
        return false
    }
    
    //MARK: - Actions
    @IBAction func end(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

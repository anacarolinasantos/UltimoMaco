//
//  MainTabBarController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 15/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class MainTabBarController: UITabBarController {
    
    var obtainedAchievements: [Achievement] = []
    
    var showEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtainedAchievements = AchievementsController.checkAllAchievements()
        
        if !UserDefaults.standard.bool(forKey: "endViewDidAppeared") {
            var entries: [CigaretteEntry] = []
            do {
                entries = try DatabaseController.persistentContainer.viewContext.fetch(NSFetchRequest(entityName: "CigaretteEntry"))
                entries.sort(by: { ($0.date! as Date) < ($1.date! as Date) })
                if (entries.last!.date! as Date) < Date() {
                    showEnd = true
                } else {
                    showEnd = false
                }
            } catch _ as NSError {
                print("Error")
            }
        } else {
            showEnd = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if obtainedAchievements.count > 0 {
            showAchievementsPopUp()
        }
        if showEnd && obtainedAchievements.count == 0 {
            if let endPopUp = self.storyboard?.instantiateViewController(withIdentifier: "lastPopUp") {
                showEnd = false
                endPopUp.modalTransitionStyle = .crossDissolve
                present(endPopUp, animated: true, completion: nil)
            }
        }
        
    }
    
    private func showAchievementsPopUp() {
        if let popUp = self.storyboard?.instantiateViewController(withIdentifier: "popUp") as? AchievementPopUpViewController {
            popUp.achievement = obtainedAchievements[obtainedAchievements.count - 1]
            popUp.isLastPopUpView = obtainedAchievements.count == 1
            popUp.modalTransitionStyle = .crossDissolve
            present(popUp, animated: true, completion: nil)
            _ = obtainedAchievements.popLast()
        }
    }

}

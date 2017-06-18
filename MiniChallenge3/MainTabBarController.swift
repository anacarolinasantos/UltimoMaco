//
//  MainTabBarController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 15/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var obtainedAchievements: [Achievement] = []
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtainedAchievements = AchievementsController.checkAllAchievements()
        index = obtainedAchievements.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        index -= 1
        showAchievementsPopUp(all: obtainedAchievements, index: index)
    }
    
    private func showAchievementsPopUp(all: [Achievement], index: Int) {
        if index >= 0 {
            if let popUp = self.storyboard?.instantiateViewController(withIdentifier: "popUp") as? AchievementPopUpViewController {
                popUp.achievement = all[index]
                popUp.isLastPopUpView = index == 0
                popUp.modalTransitionStyle = .crossDissolve
                present(popUp, animated: true, completion: nil)
            }
        }
    }

}

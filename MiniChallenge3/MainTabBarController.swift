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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtainedAchievements = AchievementsController.checkAllAchievements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if obtainedAchievements.count > 0 {
            showAchievementsPopUp()
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

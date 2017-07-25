//
//  AchievementPopUpViewController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 15/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AchievementPopUpViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var end: UIButton!
    
    @IBOutlet weak var achievementAsset: UIImageView!
    
    var achievement: Achievement?
    
    var isLastPopUpView: Bool?
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        popUpView.layer.cornerRadius = popUpView.frame.width / 10
        popUpView.clipsToBounds = true
        if let a = achievement {
            achievementAsset.image = UIImage(named: a.assetIdentifier!)
        }
        if isLastPopUpView! {
            end.setTitle("Ok", for: .normal)
        } else {
            end.setTitle("Próxima", for: .normal)
        }
    }
    
    @IBAction func didClickToCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

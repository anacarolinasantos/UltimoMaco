//
//  AchievementsCollectionViewCollectionViewController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 14/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "achievementCell"

class AchievementsCollectionViewCollectionViewController: UICollectionViewController {
    
    var achievements: [Achievement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Conquistas"
        self.navigationController?.setToolbarHidden(false, animated: true)
        let back = UIBarButtonItem(title: "Voltar", style: .done, target: self, action: #selector(self.back))
        self.navigationItem.rightBarButtonItem = back
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            if let achievements = try DatabaseController.persistentContainer.viewContext.fetch(Achievement.fetchRequest()) as? [Achievement] {
                self.achievements = achievements
            }
        } catch _ as NSError {
            print("Error")
        }
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AchievementCollectionViewCell
        
        let achievement = achievements[indexPath.row]
        let achievementAsset = UIImage(named: achievement.assetIdentifier!)
        if achievement.hasAchievement {
            cell.achievementId.image = achievementAsset?.bwImage
        } else {
            cell.achievementId.image = achievementAsset
        }
        cell.count.text = String(achievement.amount)
        cell.count.layer.cornerRadius = cell.count.frame.size.width / 2
        cell.count.clipsToBounds = true
        cell.count.backgroundColor = UIColor.init(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.5)
        
        
        return cell
    }

}

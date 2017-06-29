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

class AchievementsCollectionViewCollectionViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Atributes
    var achievements: [Achievement] = []

    //MARK: - UIViewController life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Conquistas"
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
        cell.count.text = ""
        if !achievement.hasAchievement {
            let achievementAsset = UIImage(named: "bw" + achievement.assetIdentifier!)
            cell.achievementId.image = achievementAsset
            
            cell.achievementId.isUserInteractionEnabled = false
        } else {
            let achievementAsset = UIImage(named: achievement.assetIdentifier!)
            cell.achievementId.image = achievementAsset
            if achievement.amount > 1 {
                cell.count.text = String(achievement.amount)
                cell.count.layer.cornerRadius = cell.count.frame.size.width / 2
                cell.count.clipsToBounds = true
                cell.count.layer.borderWidth = 1;
                cell.count.layer.borderColor = UIColor.white.cgColor
            }
            
            cell.achievementId.restorationIdentifier = achievement.assetIdentifier
            
            cell.achievementId.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(AchievementsCollectionViewCollectionViewController.handleLongPress(recognizer:))))
            cell.achievementId.isUserInteractionEnabled = true
        }
        return cell
    }
    
    //MARK: - Recognizer Function
    func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        
        // set up activity view controller
        if let image = (recognizer.view as? UIImageView) {
            
            let imageToShare = UIImage(named: "share" + image.restorationIdentifier!)
            
            let activityViewController = UIActivityViewController(activityItems: [imageToShare as Any, "Conquista desbloqueada via Último Maço!" ], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
            
        }
        
    }
    
    
}

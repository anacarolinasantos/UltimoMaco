//
//  SLManager.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 16/02/2018.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class SLManager {
    
    static let shared: SLManager = SLManager()
    
    private init() {
    }
    
    func setSpotlightIndexes(forAchievements achievements: [Achievement]){
        var searchableItems = [CSSearchableItem]()
        
        for achievement in achievements {
            let attributeSet = self.setAttributeSet(for: achievement)
            searchableItems.append(CSSearchableItem(uniqueIdentifier: achievement.assetIdentifier, domainIdentifier: nil, attributeSet: attributeSet))
        }
        
        CSSearchableIndex.default().indexSearchableItems(searchableItems, completionHandler: { (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        })
    }
    
    func setAttributeSet(for achievement: Achievement) -> CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributeSet.keywords = ["Conquistas", "Fumar", "Parar", "Último maço!"]
        attributeSet.thumbnailData = UIImagePNGRepresentation(UIImage(named: achievement.assetIdentifier!)!)
        
        switch achievement.assetIdentifier! {
        case "threeDaysInARow.png":
            attributeSet.title = "Três dias seguidos!"
            attributeSet.contentDescription = "Parabéns, você diminuiu o número de cigarros de acordo com a meta durante 3 dias seguidos!"
            return attributeSet
        case "sevenDaysInARow.png":
            attributeSet.title = "Sete dias seguidos!"
            attributeSet.contentDescription = "Parabéns, você diminuiu o número de cigarros de acordo com a meta durante 7 dias seguidos!"
            return attributeSet
        case "remainedUnderGoal.png":
            attributeSet.title = "Fumou menos que a meta!"
            attributeSet.contentDescription = "Parabéns, você diminuiu o número de cigarros além da meta pela \(achievement.amount)º vez!"
            return attributeSet
        case "noSmokeForToday.png":
            attributeSet.title = "Não fumou hoje!"
            attributeSet.contentDescription = "Parabéns, você não fumou durante o dia todo pela \(achievement.amount)º vez!"
            return attributeSet
        case "halfCigarretes.png":
            attributeSet.title = "Chegou na metade!"
            attributeSet.contentDescription = "Parabéns, você atingiu a metade do caminho!"
            return attributeSet
        case "reducedFirstCiggarret.png":
            attributeSet.title = "Você diminuiu o seu primeiro cigarro!"
            attributeSet.contentDescription = "Parabéns, você diminuiu o número de cigarros pela 1ª vez!"
            return attributeSet
        case "lastPackOfCigarretes.png":
            attributeSet.title = "Chegou ao último maço!"
            attributeSet.contentDescription = "Parabéns, restam menos de 20 cigarros!"
            return attributeSet
        case "stoppedSmoking.png":
            attributeSet.title = "Você parou de fumar!"
            attributeSet.contentDescription = "Parabéns, você conseguiu parar de fumar!"
            return attributeSet
        default:
            return attributeSet
        }
    }
    
    func cleanIndexes(){
        CSSearchableIndex.default().deleteAllSearchableItems { (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
}


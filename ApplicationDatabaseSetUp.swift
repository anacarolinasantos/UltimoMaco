//
//  ApplicationDatabaseSetUp.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 11/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications
import UIKit

class ApplicationDatabaseSetUp {
    
    private static func getAll(fetch: NSFetchRequest<NSFetchRequestResult>) -> [NSManagedObject] {
        do {
            if let objects = try DatabaseController.persistentContainer.viewContext.fetch(fetch) as? [NSManagedObject] {
                return objects
            }
        } catch _ as NSError {
            print("Error")
        }
        return []
    }
    
    public static func nukeEverything(view: UITabBarController) {
        var entities: [NSManagedObject] = []
        entities.append(contentsOf: getAll(fetch: CigaretteEntry.fetchRequest()))
        entities.append(contentsOf: getAll(fetch: Achievement.fetchRequest()))
        entities.append(contentsOf: getAll(fetch: User.fetchRequest()))
        entities.append(contentsOf: getAll(fetch: FagerstromTest.fetchRequest()))
        entities.append(contentsOf: getAll(fetch: Motivation.fetchRequest()))
        _ = entities.map({ DatabaseController.persistentContainer.viewContext.delete($0) })
        DatabaseController.saveContext()
        NotificationController.center.removeAllPendingNotificationRequests()
        UserDefaults.standard.set(true, forKey: "isFirstTimeInApp")
        if let tutorialPageView = UIStoryboard(name: "InitialPageViewController", bundle: nil).instantiateInitialViewController() {
            view.present(tutorialPageView, animated: true, completion: nil)
        }
    }
    
}

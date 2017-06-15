
//  Page5ViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class Page5ViewController: PageModelViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var allowNotifications: UIButton!
    
    //MARK: - ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
    }
    
    @IBAction func startUsingApp(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {(granted, error) in
            if let vcs = (self.pageViewController as? InitialPageViewController)?.allViewControllers {
                
                let name = (vcs[0] as! Page1ViewController).nameTextField.text
                let img = (vcs[0] as! Page1ViewController).userPhoto.image
                let cigsDaily = (vcs[1] as! Page2ViewController).cigaretteNumber
                let cigsYears = (vcs[2] as! Page3ViewController).yearsNumber
                let weeksStop = (vcs[3] as! Page4ViewController).selectedWeeks
                let reminderTime = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())
                
                let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: DatabaseController.persistentContainer.viewContext) as! User
                user.name = name
                if let i = img {
                    user.imageAsMedia(image: i)
                }
                
                user.enableReminder = true
                user.achievementNotifier = true
                user.reminderTime = reminderTime as NSDate?
                
                for i in 0...(weeksStop! * 7)+1 {
                    let cigEntry = NSEntityDescription.insertNewObject(forEntityName: "CigaretteEntry", into: DatabaseController.persistentContainer.viewContext) as! CigaretteEntry
                    cigEntry.date = Calendar.current.date(byAdding: .day, value: i - 1, to: Date())! as NSDate
                    if i == 0 {
                        cigEntry.cigaretteNumber = Int32(cigsDaily)
                    } else {
                        cigEntry.cigaretteNumber = -1
                    }
                }
                
                AchievementsController.generateAchievements()
                
                DatabaseController.saveContext()
                
                UserDefaults.standard.set(false, forKey: "isFirstTimeInApp")
                UserDefaults.standard.set(cigsDaily / 20 * cigsYears, forKey: "smokingLoad")
                UserDefaults.standard.synchronize()
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                self.present(vc!, animated: true, completion: nil)
            }            
        })
    }
}

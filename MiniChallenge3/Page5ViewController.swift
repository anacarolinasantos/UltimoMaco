
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
            
            let vcs = InitialViewController.pages
            
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
            
            NotificationController.prepareAll(daysFromToday: weeksStop! * 7)
            NotificationController.sendNotificationDaily(["lembreteNoturno",
                                                          "Boa noite!",
                                                          "Não se esqueça de inserir toda a quantia de cigarros que você consumiu hoje."],
                                                         Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!)
            
            UserDefaults.standard.set(false, forKey: "isFirstTimeInApp")
            UserDefaults.standard.set(cigsDaily / 20 * cigsYears, forKey: "smokingLoad")
            UserDefaults.standard.set(true, forKey: "isEnabledDailyReminder")
            UserDefaults.standard.set(true, forKey: "isEnabledInfoNotification")
            UserDefaults.standard.set(Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!, forKey: "reminderHour")
            UserDefaults.standard.synchronize()
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            self.present(vc!, animated: true, completion: {
                let alert = UIAlertController(title: "Seja bem vindo!",
                                              message: "Gostaria de ver um tutorial sobre as principais funções do aplicativo?",
                                              preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Não",
                                                 style: .default)
                
                let confirmAction = UIAlertAction(title: "Sim",
                                                  style: .default) {
                                                    _ in
                                                    if let t = UIStoryboard(name: "TutorialPageView", bundle: nil).instantiateInitialViewController() {
                                                        vc?.present(t, animated: true, completion: nil)
                                                    }
                }
                
                alert.addAction(cancelAction)
                alert.addAction(confirmAction)
                
                vc?.present(alert, animated: true)
            })
        })
    }
}

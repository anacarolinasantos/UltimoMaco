
//  Page5ViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class Page5ViewController: PageModelViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var mainView: UIView!
    
    //MARK: - Atributes
    
    var pageController: UIPageViewController?
    
    //MARK: - ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        datePicker.datePickerMode = .time
    }
    
    @IBAction func startUsingApp(_ sender: Any) {
        //TODO: capture date, and finish storyboard
        
        if let vcs = (pageController as? InitialPageViewController)?.allViewControllers {
            
            let name = (vcs[0] as! Page1ViewController).nameTextField.text
            let img = (vcs[0] as! Page1ViewController).userPhoto.image
            let cigsDaily = (vcs[1] as! Page2ViewController).cigaretteNumber
            let cigsYears = (vcs[2] as! Page3ViewController).yearsNumber
            let weeksStop = (vcs[3] as! Page4ViewController).selectedWeeks
            let remiderTime = self.datePicker.date
            
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: DatabaseController.persistentContainer.viewContext) as! User
            user.name = name
            if let i = img {
                user.imageAsMedia(image: i)
            }
            
            user.enableReminder = true
            user.achievementNotifier = true
            user.reminderTime = remiderTime as NSDate
            
            for i in 1...((weeksStop! * 7) + 1) {
                let cigEntry = NSEntityDescription.insertNewObject(forEntityName: "CigaretteEntry", into: DatabaseController.persistentContainer.viewContext) as! CigaretteEntry
                cigEntry.date = Calendar.current.date(byAdding: .day, value: i - 1, to: Date())! as NSDate
                cigEntry.cigaretteNumber = -1
            }
            
            DatabaseController.saveContext()
            
            do {
                let firstEntry = (try DatabaseController.persistentContainer.viewContext.fetch(CigaretteEntry.fetchRequest()))[0] as! CigaretteEntry
                firstEntry.cigaretteNumber = Int32(cigsDaily!)
            } catch _ as NSError {
                print("Error")
            }
            
            DatabaseController.saveContext()
            
            UserDefaults.standard.set(false, forKey: "isFirstTimeInApp")
            UserDefaults.standard.set(cigsDaily! / 20 * cigsYears!, forKey: "smokingLoad")
            UserDefaults.standard.synchronize()
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
}

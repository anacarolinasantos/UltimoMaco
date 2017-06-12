//
//  ViewControllerTeste.swift
//  MiniChallenge3
//
//  Created by Ana Carolina Silva on 12/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerTeste: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    //MARK: - Atributes
    var cigaretteNumberPoints: Int = 0
    var addictionIndex: Int = 0
    
    //MARK: - UIViewController life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        self.navigationController?.navigationBar.isHidden = true
        
        do {
            // Verify if user exists, and gets profile image and name
            if let user = (try DatabaseController.persistentContainer.viewContext.fetch(User.fetchRequest()) as? [User]) {
                
                if user.count != 0 {
                    userImage.image = user[0].getImageAsMedia()
                    nameLabel.text = user[0].name
                }
            }
            
            // Verify if cigaretteEntry exists, and gets cigarettes number
            if let cigaretteEntry = (try DatabaseController.persistentContainer.viewContext.fetch(CigaretteEntry.fetchRequest()) as? [CigaretteEntry]) {
                
                if cigaretteEntry.count != 0 {
                    if cigaretteEntry[0].cigaretteNumber > 30 {
                        cigaretteNumberPoints = 3
                    } else if cigaretteEntry[0].cigaretteNumber > 20{
                        cigaretteNumberPoints = 2
                    } else if cigaretteEntry[0].cigaretteNumber > 10{
                        cigaretteNumberPoints = 1
                    } else {
                        cigaretteNumberPoints = 0
                    }
                }
            }
            
            // Verufy if fagerstromTest exists, and calculate addiction index
            if let fagerstromTest = (try DatabaseController.persistentContainer.viewContext.fetch(FagerstromTest.fetchRequest()) as? [FagerstromTest]) {
                
                if fagerstromTest.count != 0 {
                    addictionIndex = Int(fagerstromTest[0].cigarreteRestriction + fagerstromTest[0].cigQtyFirstHours + fagerstromTest[0].firstCigarrete + fagerstromTest[0].morningCigarrete + fagerstromTest[0].sickSmoking) + cigaretteNumberPoints
                }
                
            }
            
        } catch _ as NSError {
            print("Error")
        }
        
    }
    
    //MARK: - UITableViewController
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }
        return self.tableView.sectionHeaderHeight
    }
    
    //MARK: - Actions

    @IBAction func editTap(_ sender: UIButton) {
    }
    
}

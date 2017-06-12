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
    @IBOutlet weak var fagerstromLabel: UILabel!
    @IBOutlet weak var smokingLoadLabel: UILabel!
    
    //MARK: - Atributes
    var cigaretteNumberPoints: Int = 0
    var addictionIndex: Int = -1
    
    //MARK: - UIViewController life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        self.navigationController?.navigationBar.isHidden = true
        
        fagerstromCalculate()
        
        do {
            // Verify if user exists, and gets profile image and name
            if let user = (try DatabaseController.persistentContainer.viewContext.fetch(User.fetchRequest()) as? [User]) {
                
                if user.count != 0 {
                    userImage.image = user[0].getImageAsMedia()
                    nameLabel.text = user[0].name
                }
            }
            
            
        } catch _ as NSError {
            print("Error")
        }
        
    }
    
    func fagerstromCalculate() {
        
        do {
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
        
        addictionIndex = 10
        
        switch addictionIndex {
        case 0, 1:
            fagerstromLabel.text = "Muito baixo"
            fagerstromLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            break
        case 2, 3:
            fagerstromLabel.text = "Moderado"
            fagerstromLabel.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            break
        case 4, 5:
            fagerstromLabel.text = "Acima da média"
            fagerstromLabel.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            break
        case 6, 7:
            fagerstromLabel.text = "Muito alto"
            fagerstromLabel.textColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            break
        case 8, 9, 10:
            fagerstromLabel.text = "Grave"
            fagerstromLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            break
        default:
            fagerstromLabel.text = "Calcular"
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

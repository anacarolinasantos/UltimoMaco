//
//  HealthInformationMainViewController.swift
//  MiniChallenge3
//
//  Created by Ana Carolina Silva on 17/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class HealthInformationMainViewController: UIViewController {
    
    //MARK: - UIViewController life cicle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination: HealthInformationTableViewController = segue.destination as! HealthInformationTableViewController
        
        if let identifier = segue.identifier {
            switch identifier {
            case "healthInformation":
                destination.informations = HealthInformationDB.getInformation(from: .health)
            case "helpInformation":
                destination.informations = HealthInformationDB.getInformation(from: .help)
            case "tipsInformation":
                destination.informations = HealthInformationDB.getInformation(from: .tips)
            case "fissureInformation":
                destination.informations = HealthInformationDB.getInformation(from: .fissure)
            case "habitsInformation":
                destination.informations = HealthInformationDB.getInformation(from: .habits)
            default:
                break
            }
        }
    }

    
}

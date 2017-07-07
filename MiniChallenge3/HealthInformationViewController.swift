//
//  HealthInformationTableViewController.swift
//  MiniChallenge3
//
//  Created by Ana Carolina Silva on 17/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class HealthInformationViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var informationImageView: UIImageView!
    
    //MARK: - Atributes
    var informations: [HealthInformationModel]?
    
    //MARK: - UIViewController life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for information in informations! {
            informationTextView.text?.append(information.information)
            informationTextView.text?.append("\n\n")
        }
        if let informationImage = informations?[0].image {
            informationImageView.image = UIImage(named: informationImage)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

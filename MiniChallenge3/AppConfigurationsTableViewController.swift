//
//  AppConfigurationsTableViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 17/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AppConfigurationsTableViewController: UITableViewController {

    //MARK: - Outlets
    
    //MARK: - Atributes
    static var enableNotifications = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Actions
    
    @IBAction func notificationSwitchChangeValue(_ sender: UISwitch) {
        AppConfigurationsTableViewController.enableNotifications = sender.isOn
        print(AppConfigurationsTableViewController.enableNotifications)
    }

}

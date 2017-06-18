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
    @IBOutlet weak var pickerCell: UITableViewCell!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    //MARK: - Atributes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // -- SETUP
        pickerCell.isHidden = true
        datePickerOutlet.datePickerMode = .time
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            pickerCell.isHidden = !pickerCell.isHidden
        }
    }
    
    //MARK: - Actions
    
    // -- SWITCH DID CHANGE VALUE
    @IBAction func notificationSwitchChangeValue(_ sender: UISwitch) {
        // this atribute is a boolean and returns the switch state
        print(sender.isOn)
    }

    @IBAction func pickerDidChangeValue(_ sender: UIDatePicker) {
//        sender.
        NotificationController.sendNotificationDaily(["lembreteNoturno","Boa noite!","Não se esqueça de inserir toda a quantia de cigarros que você consumiu hoje."], Calendar.current.date(bySettingHour:21, minute: 0, second: 0, of: Date())!)
    }
}

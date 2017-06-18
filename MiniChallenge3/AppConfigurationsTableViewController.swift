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
    @IBOutlet weak var hourLabel: UILabel!
    
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
        // -- NOTIFICAÇÃO LEMBRETE
        
        // this atribute is a boolean and returns the switch state
        print(sender.isOn)
    }

    @IBAction func informativeNotificationDidChangeValue(_ sender: UISwitch){
        // -- NOTIFICAÇÕES INFORMATIVAS
        
    }
    @IBAction func pickerDidChangeValue(_ sender: UIDatePicker) {
        
        let datePicker = Calendar.current.dateComponents([.hour,.minute,.second,], from:sender.date)
        
        hourLabel.text = "\(datePicker.hour!):\(datePicker.minute!)"
        
        NotificationController.sendNotificationDaily(["lembreteNoturno","Boa noite!","Não se esqueça de inserir toda a quantia de cigarros que você consumiu hoje."], Calendar.current.date(bySettingHour:datePicker.hour!, minute: datePicker.minute!, second: 0, of: Date())!)
    }
}

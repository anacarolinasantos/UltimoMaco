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
    @IBOutlet weak var hourCell: UITableViewCell!
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
        if indexPath.row == 2{
            pickerCell.isHidden = !pickerCell.isHidden
        }
    }
    
    //MARK: - Actions
    
    // -- SWITCH DID CHANGE VALUE
    @IBAction func notificationSwitchChangeValue(_ sender: UISwitch) {
        // -- NOTIFICAÇÃO LEMBRETE
     
        if sender.isOn {
            NotificationController.prepareAll(daysFromToday: LineChartData().getDaysUntilTheZeroPoint())
            hourCell.isHidden = false
        }else{
            NotificationController.center.removeAllPendingNotificationRequests()
            let hour = Int((hourLabel.text?.substring(to: (hourLabel.text?.index((hourLabel.text?.startIndex)!, offsetBy: 2))!))!)
            let minute = Int((hourLabel.text?.substring(from: (hourLabel.text?.index((hourLabel.text?.startIndex)!, offsetBy: 3))!))!)

            NotificationController.sendNotificationDaily(["lembreteNoturno",messageFrom(hour: hour!),
                                                          "Não se esqueça de inserir toda a quantia de cigarros que você consumiu hoje."],
                                                         Calendar.current.date(bySettingHour: hour!, minute: minute!, second: 0, of: Date())!)
            hourCell.isHidden = true
        }
        
    }

    @IBAction func informativeNotificationDidChangeValue(_ sender: UISwitch){
        // -- NOTIFICAÇÕES INFORMATIVAS
        
    }
    @IBAction func pickerDidChangeValue(_ sender: UIDatePicker) {
        
        NotificationController.getPendingNotifications()
        
        let datePicker = Calendar.current.dateComponents([.hour,.minute,.second,], from:sender.date)
        
        if datePicker.minute! < 10{
            hourLabel.text = "\(datePicker.hour!):0\(datePicker.minute!)"
        }else{
            hourLabel.text = "\(datePicker.hour!):\(datePicker.minute!)"
        }
        
        
        NotificationController.sendNotificationDaily(["lembreteNoturno", messageFrom(date: datePicker.date!),"Não se esqueça de inserir toda a quantia de cigarros que você consumiu hoje."], Calendar.current.date(bySettingHour:datePicker.hour!, minute: datePicker.minute!, second: 0, of: Date())!)
    }
    
    private func messageFrom(date: Date) -> String {
        let hour = Calendar.current.component(.hour, from: date)
        return hour < 12 ? "Bom dia" : hour < 18 ? "Boa tarde" : "Boa noite"
    }
    
    private func messageFrom(hour: Int) -> String {
        return hour < 12 ? "Bom dia" : hour < 18 ? "Boa tarde" : "Boa noite"
    }
}

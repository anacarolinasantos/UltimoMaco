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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationController.getPendingNotifications()
        if let date = UserDefaults.standard.object(forKey: "reminderHour") as? Date {
            let hour = Calendar.current.component(.hour, from: date)
            let minute = Calendar.current.component(.minute, from: date)
            if minute < 10{
                hourLabel.text = "\(hour):0\(minute)"
            } else {
                hourLabel.text = "\(hour):\(minute)"
            }
        }
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
            
            var hour = 21
            var minute = 0
            
            if let date = UserDefaults.standard.object(forKey: "reminderHour") as? Date {
                hour = Calendar.current.component(.hour, from: date)
                minute = Calendar.current.component(.minute, from: date)
            }
            
            UserDefaults.standard.set(at(hour: hour, minute: minute),
                                      forKey: "reminderHour")
            
            NotificationController.sendNotificationDaily(["lembreteNoturno",
                                                          messageBy(hour: hour),
                                                          "Não se esqueça de inserir toda a quantia de cigarros que você consumiu hoje."],
                                                          at(hour: hour, minute: minute))
            
            hourCell.isHidden = false
        } else {
            hourCell.isHidden = true
            NotificationController.center.removePendingNotificationRequests(withIdentifiers: ["lembreteNoturno"])
        }
        
    }

    @IBAction func informativeNotificationDidChangeValue(_ sender: UISwitch){
        // -- NOTIFICAÇÕES INFORMATIVAS

        if sender.isOn {
            NotificationController.prepareAll(daysFromToday: LineChartData().getDaysUntilTheZeroPoint())
        } else {
            let notifications = NotificationsDatabase.notifications.map({ $0.identifier })
            NotificationController.center.removePendingNotificationRequests(withIdentifiers: notifications)
        }
    }
    @IBAction func pickerDidChangeValue(_ sender: UIDatePicker) {
        
        NotificationController.getPendingNotifications()
        
        let datePicker = Calendar.current.dateComponents([.hour,.minute,.second,], from:sender.date)
        
        if datePicker.minute! < 10 {
            hourLabel.text = "\(datePicker.hour!):0\(datePicker.minute!)"
        } else {
            hourLabel.text = "\(datePicker.hour!):\(datePicker.minute!)"
        }
        
        UserDefaults.standard.set(at(hour: datePicker.hour!, minute: datePicker.minute!),
                                  forKey: "reminderHour")
        
        
        NotificationController.sendNotificationDaily(["lembreteNoturno",
                                                      messageBy(hour: datePicker.hour!),
                                                      "Não se esqueça de inserir toda a quantia de cigarros que você consumiu hoje."],
                                                      at(hour: datePicker.hour!, minute: datePicker.minute!))
    }
    
    private func messageBy(hour: Int) -> String {
        return hour < 12 ? "Bom dia" : hour < 18 ? "Boa tarde" : "Boa noite"
    }
    
    private func at(hour: Int, minute: Int) -> Date {
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
    }
}

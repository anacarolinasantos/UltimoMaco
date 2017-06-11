//
//  NotificationHandler.swift
//  MandaNotificação
//
//  Created by Osniel Lopes Teixeira on 09/06/17.
//  Copyright © 2017 br.mackenzie.MackMobile. All rights reserved.
//

import Foundation
import UserNotifications

public class NotificationControler{
    
    public static let center = UNUserNotificationCenter.current()
    
    private static func validateAuthorization() -> Bool{
        
        var statusOfValidation = true
        
        
        //Request authorization for notifications
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if error != nil{
                statusOfValidation = false
            }
            
        }
        return statusOfValidation
        
    }
    
    //Use this method to schedule a notification that will not be repeated
    //The first parameter must be a string vector containing, respectively, the unique identifier of the notification, the title, and the message
    public static func sendNotification(_ textContent:[String],_ when:Date) -> Bool{
        
        var validationOfAuthorization = validateAuthorization()
        
        if validationOfAuthorization{
            
            let content = UNMutableNotificationContent()
            content.title = textContent[1]
            content.body = textContent[2]
            content.sound = UNNotificationSound.default()
            
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: when)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,repeats: false)
            
            let identifier = textContent[0]
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            center.add(request, withCompletionHandler: { (error) in
                if error != nil {
                    validationOfAuthorization = false
                    print("Error while adding the notification to the NotificationCenter")
                }
            })
        }
        
        return validationOfAuthorization
        
    }
    
    //Use this method to create a notification that will be repeated daily
    //The first parameter must be a string vector containing, respectively, the unique identifier of the notification, the title, and the message
    public static func sendNotificationDaily(_ textContent:[String],_ when:Date) -> Bool{
        
        var validationOfAuthorization = validateAuthorization()
        
        if validationOfAuthorization{
            
            let content = UNMutableNotificationContent()
            content.title = textContent[1]
            content.body = textContent[2]
            content.sound = UNNotificationSound.default()
            content.badge = 1
            
            let triggerDate = Calendar.current.dateComponents([.hour,.minute,.second,], from: when)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            
            let identifier = textContent[0]
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            center.add(request, withCompletionHandler: { (error) in
                if error != nil {
                    validationOfAuthorization = false
                    print("Error while adding the notification to the NotificationCenter")
                }
            })
        }
        
        return validationOfAuthorization
        
    }
    
    //Prints pending notifications in the console
    public static func getPendingNotifications(){
        center.getPendingNotificationRequests(completionHandler: { (notifications) in
            print("There are ",notifications.count," pending notifications: -----------")
            if notifications.count > 0{
                for notification in notifications{
                    let trigger = notification.trigger as! UNCalendarNotificationTrigger
                    print(notification.identifier," at ",trigger.nextTriggerDate() ?? "No date for the next trigger")
                }
            }
        })
    }
    
}

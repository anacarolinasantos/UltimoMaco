//
//  WatchManager.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 02/05/2018.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import WatchKit
import WatchConnectivity

class WSManager: NSObject, WCSessionDelegate {
    
    public static let shared = WSManager()
    public var recievedNumberOfCigarettes: ((Int) -> Void)?
    public var recievedNumberOfCigarettesToday: ((Int) -> Void)?
    
    // Properties
    public var numberOfCigarretesSmoked: Int = -1
    public var numberOfCigarettesCanSmokeToday: Int = -1
    public var numberOfDaysToEnd: Int = -1
    
    override private init() {
        super.init()
        
        if WCSession.isSupported() {
            let defaultSession = WCSession.default
            defaultSession.delegate = self
            defaultSession.activate()
        }
    }
    
    // Recieve message
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let smokedToday = message["NumberOfCigarettes"] as? Int {
            self.numberOfCigarretesSmoked = smokedToday
            if let recievedNumberOfCigarettes = self.recievedNumberOfCigarettes{
                recievedNumberOfCigarettes(smokedToday)
            }
            
            if let complications = CLKComplicationServer.sharedInstance().activeComplications{
                for complication in complications {
                    CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
                }
            }
        }
       
        if let canSmokedToday = message["NumberOfCigarettesToday"] as? Int {
            self.numberOfCigarettesCanSmokeToday = canSmokedToday
            if let recievedNumberOfCigarettesToday = self.recievedNumberOfCigarettesToday{
                recievedNumberOfCigarettesToday(canSmokedToday)
            }
        }
        
        if let daysToEnd = message["DaysToEnd"] as? Int {
            self.numberOfDaysToEnd = daysToEnd
        }
        
    }
    
    // send message
    func sendNumberOfCigarettes(_ number: Int){
        if WCSession.default.isReachable {
            let message = ["NumberOfCigarettes": number]
            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("watch recebeu")
    }
    
}

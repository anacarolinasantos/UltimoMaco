//
//  WatchManager.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 02/05/2018.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import WatchConnectivity

class WSManager: NSObject, WCSessionDelegate {
    
    public static let shared = WSManager()
    public var recievedNumberOfCigarettes: ((Int) -> Void)?
    public var recievedNumberOfCigarettesToday: ((Int) -> Void)?
    
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
            if let recievedNumberOfCigarettes = self.recievedNumberOfCigarettes{
                recievedNumberOfCigarettes(smokedToday)
            }
        }
       
        if let canSmokedToday = message["NumberOfCigarettesToday"] as? Int{
            if let recievedNumberOfCigarettesToday = self.recievedNumberOfCigarettesToday{
                recievedNumberOfCigarettesToday(canSmokedToday)
            }
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

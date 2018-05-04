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
    public var recievedMessage: (([String : Any]) -> Void)?
    
    override private init() {
        super.init()
        
        if WCSession.isSupported() {
            WCSession.default().delegate = self
            if WCSession.default().activationState != .activated {
                WCSession.default().activate()
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    // Recieve message
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let recievedMessage = self.recievedMessage {
            recievedMessage(message)
        }
    }
    
    // send message
    func sendNumberOfCigarettes(_ number: Int){
        if WCSession.default().isReachable {
            let message = ["NumberOfCigarettes": number]
            WCSession.default().sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("iOS recebeu")
    }
}

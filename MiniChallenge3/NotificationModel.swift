//
//  NotificationModel.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 14/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class NotificationModel{
    
    let identifier:String
    let title:String
    let message:String
    
    init(identifier:String, title: String, message:String){
        self.identifier = identifier
        self.title = title
        self.message = message
    }
    
}

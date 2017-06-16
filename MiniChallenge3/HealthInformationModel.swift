//
//  AssistanceModel.swift
//  MiniChallenge3
//
//  Created by Ana Carolina Silva on 15/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

enum HealthInformationCategory {
    case habits
    case health
    case help
    case tips
    case fissure
}

class HealthInformationModel {
    
    let category: HealthInformationCategory
    let information: String
    
    init(category: HealthInformationCategory, information: String) {
        self.category = category
        self.information = information
    }
}

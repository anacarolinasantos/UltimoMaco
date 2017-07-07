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
    let image: String
    
    init(category: HealthInformationCategory, information: String) {
        self.category = category
        self.information = information
        switch category {
        case .habits:
            self.image = "habitosButton.png"
        case .fissure:
            self.image = "fissuraButton.png"
        case .health:
            self.image = "healthButton.png"
        case .help:
            self.image = "helpButton.png"
        case .tips:
            self.image = "tipsButton.png"
        }
    }
}

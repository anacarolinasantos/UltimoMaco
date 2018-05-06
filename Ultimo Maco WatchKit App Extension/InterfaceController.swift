//
//  InterfaceController.swift
//  Ultimo Maco WatchKit App Extension
//
//  Created by Osniel Lopes Teixeira on 02/05/2018.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import WatchKit
import Foundation
import SpriteKit


class InterfaceController: WKInterfaceController, WKCrownDelegate {
    

    @IBOutlet var containerScene: RingContainerSCN!
    var scene: RingSCN!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let CENACOMLABEL = SKScene(fileNamed: "RingScene") else {
            fatalError("impossible to get the scene")
        }
        guard let label = CENACOMLABEL.childNode(withName: "label") else {
            fatalError("IMpossible to get the label")
        }
        
        self.scene = RingSCN(size: contentFrame.size)
        self.containerScene.presentScene(scene)
        
        self.scene.addLabel(l: label.copy() as! SKLabelNode)
        
        crownSequencer.delegate = self
        
        // SETUP
        WSManager.shared.recievedNumberOfCigarettes = { smokedToday in
            self.scene.numberOfCigarretes = smokedToday
            self.scene.ring.arcEnd = CGFloat(Float(smokedToday) * self.scene.aCigarret)
            print("Has smoked \(smokedToday) cigarettes")
        }
        
        WSManager.shared.recievedNumberOfCigarettesToday = { canSmokedToday in
            self.scene.totalCigarretes = canSmokedToday
            print("CanSmoke \(canSmokedToday) cigarettes")
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        crownSequencer.focus()
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        self.scene.didRotateCrown(with: rotationalDelta)
    }
    
    func crownDidBecomeIdle(_ crownSequencer: WKCrownSequencer?) {
        self.scene.isRotating = false
    }

}

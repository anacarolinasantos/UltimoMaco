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
        
        self.scene = RingSCN(size: contentFrame.size)
        self.containerScene.presentScene(scene)
        
        crownSequencer.delegate = self
        
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

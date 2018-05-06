//
//  RingSCN.swift
//  MiniChallenge3
//
//  Created by Osniel Lopes Teixeira on 02/05/2018.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import WatchKit
import SpriteKit

class RingContainerSCN: WKInterfaceSKScene {

}

class RingSCN: SKScene {

    var ring: RingSKNode!
    var label: SKLabelNode!
    
    var aCigarret: Float {
        get {
            return 1/Float(totalCigarretes)
        }
    }
    let totalCigarretes = 20
    var numberOfCigarretes = 0 {
        didSet {
            if numberOfCigarretes > totalCigarretes {
                WKInterfaceDevice.current().play(WKHapticType.failure)
            } else if numberOfCigarretes > oldValue {
                WKInterfaceDevice.current().play(WKHapticType.directionUp)
            } else {
                WKInterfaceDevice.current().play(WKHapticType.directionDown)
            }
            
            self.label.text = String(self.numberOfCigarretes)+"/\(self.totalCigarretes)"
        }
    }
    
    public var isRotating = false {
        didSet {
            if isRotating == false {
                self.addedCigarretes = 0
            }
        }
    }
    var addedCigarretes = 0
    
    override func sceneDidLoad() {
        self.backgroundColor = .black
        
        self.ring = RingSKNode(diameter: self.size.width-10)
        self.ring.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.ring.zPosition = -1
        self.addChild(ring)
        
        self.label = SKLabelNode(text: "0")
        self.label.position = CGPoint(x: self.frame.midX, y: self.frame.maxY)
        self.addChild(label)
    }
    
    //MARK: - Auxiliar Functions
    func didRotateCrown(with delta: Double) {
        isRotating = true
        if delta > Double(addedCigarretes+1)*0.025 && delta > 0 {

            addedCigarretes += 1
            ring.arcEnd += CGFloat(aCigarret)
            numberOfCigarretes += 1
            WSManager.shared.sendNumberOfCigarettes(self.numberOfCigarretes)
        }
        else if delta < Double(addedCigarretes-1)*0.025 && delta < 0{
            if numberOfCigarretes != 0 {
                addedCigarretes -= 1
                ring.arcEnd -= CGFloat(aCigarret)
                numberOfCigarretes -= 1
                WSManager.shared.sendNumberOfCigarettes(self.numberOfCigarretes)
            }
        }

    }
    
    func addLabel(l: SKLabelNode){
        l.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(l)
        self.label = l

    }
}

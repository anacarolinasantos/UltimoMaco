//
//  RingSCNNode.swift
//  Ultimo Maco WatchKit App Extension
//
//  Created by Osniel Lopes Teixeira on 02/05/2018.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import SpriteKit

class RingSKNode: SKNode {
    
    private(set) var diameter: CGFloat
    private(set) var thickness: CGFloat // thickness is decimal percentage of radius, 0...1
    
    var color = SKColor(cgColor: #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.737254902, alpha: 1)) {
        didSet {
            update()
        }
    }
    
    var arcEnd: CGFloat = 0 { // decimal percentage of circumference, usually 0...1
        didSet {
            if arcEnd > 1 {
                self.color = SKColor(cgColor: #colorLiteral(red: 0.8745098039, green: 0.4705882353, blue: 0.4588235294, alpha: 1))
            } else {
                self.color = SKColor(cgColor: #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.737254902, alpha: 1))
            }
            update()
        }
    }
    
    var radius: CGFloat {
        return diameter / 2
    }
    
    private var foregroundShape = SKShapeNode()
//    private var backgroundShape = SKShapeNode()
    
    init(diameter: CGFloat, thickness: CGFloat = 0.2) {
        self.diameter = diameter
        self.thickness = thickness
        
        super.init()
        
        foregroundShape.lineCap = .butt
        foregroundShape.zPosition = 2
//        backgroundShape.lineCap = .butt
//        backgroundShape.zPosition = 1
        
        update()
        
//        self.addChild(backgroundShape)
        self.addChild(foregroundShape)
    }
    
    required init?(coder decoder: NSCoder) {
        diameter = 0
        thickness = 0
        super.init(coder: decoder)
    }
    
    private func update() {
        foregroundShape.strokeColor = color
//        backgroundShape.strokeColor = foregroundShape.strokeColor.withAlphaComponent(0.14)
        
        foregroundShape.lineWidth = diameter / 2 * thickness
//        backgroundShape.lineWidth = foregroundShape.lineWidth
        
        let radius = diameter / 2 - foregroundShape.lineWidth / 2
        let startAngle = CGFloat.pi / 2
        let endAngle = startAngle - 2 * .pi * (arcEnd + 0.001) // never exactly zero so that the background arc can always be drawn
        
        // The filled part of the ring
        let foregroundPath = UIBezierPath(arcCenter: CGPoint(), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        foregroundShape.path = foregroundPath.cgPath
        
        // The empty part of the ring
//        let backgroundPath = UIBezierPath(arcCenter: CGPoint(), radius: radius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
//        backgroundShape.path = backgroundPath.cgPath
    }
}

//class SKTRingColorEffect: SKTEffect {
//    var startColor: SKColor?
//    let endColor: SKColor
//
//    init(for node: SKRingNode, from startColor: SKColor? = nil, to endColor: SKColor, duration: TimeInterval) {
//        self.startColor = startColor
//        self.endColor = endColor
//        super.init(node: node, duration: duration)
//    }
//
//    override func update(_ t: CGFloat) {
//        if startColor == nil {
//            // purposefully not set until now to get current value during action sequence
//            startColor = (node as! SKRingNode).color
//        }
//        let newColor = lerp(start: startColor!, end: endColor, t: t)
//        (node as! SKRingNode).color = newColor
//    }
//}

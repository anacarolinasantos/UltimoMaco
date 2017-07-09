//
//  TutorialViewController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 08/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialViewController1: UIViewController {
    
    @IBOutlet weak var top: UIView!
    
    @IBOutlet weak var center: UIImageView!
    
    @IBOutlet weak var bottom: UIView!
    
    var topOrigin: CGPoint!
    
    override func viewDidLoad() {
        center.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let point = CGPoint(x: top.frame.origin.x, y: -700)
        let size = top.frame.size
        let newFrame = CGRect(origin: point, size: size)
        top.frame = newFrame
    }
    
    
    @IBAction func touch(_ sender: UITapGestureRecognizer) {
        center.shake()
    }
}

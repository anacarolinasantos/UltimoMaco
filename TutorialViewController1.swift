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
        
    override func viewDidLoad() {
        center.isUserInteractionEnabled = true
        center.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 15, options: .curveLinear, animations: {
            var point = CGPoint(x: self.top.frame.origin.x, y: 700)
            var size = self.top.frame.size
            var newFrame = CGRect(origin: point, size: size)
            self.top.frame = newFrame
            
            point = CGPoint(x: self.bottom.frame.origin.x, y: -700)
            size = self.bottom.frame.size
            newFrame = CGRect(origin: point, size: size)
            self.bottom.frame = newFrame
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.center.alpha = 1
            })
        })
    }
    
    
    @IBAction func touch(_ sender: UITapGestureRecognizer) {
        center.shake()
    }
}

//
//  TutorialViewController7.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 10/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialViewController7: UIViewController {
    
    @IBOutlet weak var finish: UIButton!

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var text: UILabel!
    
    var hasAlreadyPlayed = false
    
    var tY: CGFloat?
    
    var iY: CGFloat?
    
    var fY: CGFloat?
    
    var mainViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.finish.layer.cornerRadius = self.finish.frame.size.width / 10
        self.finish.clipsToBounds = true
        self.finish.layer.borderWidth = 1.5
        self.finish.layer.borderColor = #colorLiteral(red: 0.3008416891, green: 0.3039609194, blue: 0.2998201549, alpha: 1).cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tY = self.text.frame.origin.y
        iY = self.img.frame.origin.y
        fY = self.finish.frame.origin.y
        self.text.frame.changeOriginY(to: 700)
        self.img.frame.changeOriginY(to: 700)
        self.finish.frame.changeOriginY(to: 700)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !hasAlreadyPlayed {
            hasAlreadyPlayed = true
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 15, options: [], animations: {
                self.text.frame.changeOriginY(to: self.tY!)
            }, completion: {_ in
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 15, options: [], animations: {
                    self.img.frame.changeOriginY(to: self.iY!)
                }, completion: {_ in
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 15, options: [], animations: {
                        self.finish.frame.changeOriginY(to: self.fY!)
                    }, completion: {_ in })
                })
            })
        }
    }
    @IBAction func end(_ sender: Any) {
        mainViewController?.dismiss(animated: true, completion: nil)
    }
}

//
//  TutorialViewController5.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 09/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialViewController5: UIViewController {
    
    @IBOutlet weak var slideShow: SlideShowEffect!
    
    @IBOutlet weak var slideShow0: SlideShowEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideShow.setUpSlideShow(imageNames: ["profTut0.png", "profTut1.png"], timeBetweenImages: 0.5, transitionDuration: 1)
        slideShow0.setUpSlideShow(imageNames: ["profTut0.png", "profTut6.png"], timeBetweenImages: 0.5, transitionDuration: 1)
        slideShow.slideShow()
        slideShow0.slideShow()
    }
}

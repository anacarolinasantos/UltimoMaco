//
//  TutorialViewController3.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 09/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialViewController3: UIViewController {

    @IBOutlet weak var slideShow: SlideShowEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideShow.setUpSlideShow(imageNames: ["progTut0.png", "progTut2.png", "progTut3.png"], timeBetweenImages: 0.5, transitionDuration: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        slideShow.slideShow()
    }

}

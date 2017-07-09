//
//  TutorialViewController4.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 09/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialViewController4: UIViewController {
    
    @IBOutlet weak var slideShow: SlideShowEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideShow.setUpSlideShow(imageNames: ["infoTut0.png", "infoTut1.png"], timeBetweenImages: 0.5, transitionDuration: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        slideShow.slideShow()
    }

}

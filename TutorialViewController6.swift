//
//  TutorialViewController6.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 09/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialViewController6: UIViewController {


    @IBOutlet weak var slideShow: SlideShowEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideShow.setUpSlideShow(imageNames: ["profTut0.png", "profTut5.png", "profTut4.png", "profTut2.png"], timeBetweenImages: 0.5, transitionDuration: 1)
        slideShow.slideShow()
    }

}

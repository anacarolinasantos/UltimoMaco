//
//  TutorialViewController2.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 09/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialViewController2: UIViewController {
    
    @IBOutlet weak var mainImage: SlideShowEffect!
    @IBOutlet weak var mainImageView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.setUpSlideShow(imageNames: ["progTut0.png", "progTut1.png"], timeBetweenImages: 0.5, transitionDuration: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainImage.slideShow()
    }
}

//
//  EndViewController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 25/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var dismiss: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = popUpView.frame.width / 10
        popUpView.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set(true, forKey: "endViewDidAppeared")
    }
    
    @IBAction func didDismissed(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }

}

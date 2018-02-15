//
//  CompactChartViewController.swift
//  UltimoMacoMessages
//
//  Created by Guilherme Paciulli on 15/02/18.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import UIKit

class ExpandedChartViewController: UIViewController {
    
    @IBOutlet weak var chart: LineChart!
    
    var delegate: SendMessage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.didSendChart(on: UIImage(view: self.chart))
    }
}

//Copyright - Stackoverflow
extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}

protocol SendMessage {
    func didSendChart(on image: UIImage)
}

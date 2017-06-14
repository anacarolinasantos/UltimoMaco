//
//  PageModelViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class PageModelViewController: UIViewController {
    
    var index: Int? = nil
    
    var pageViewController: UIPageViewController? 
    
    public func shouldContinueToNextViewController() -> Bool {
        return true
    }
    
    public func shouldGoBackToPreviousViewController() -> Bool {
        return true
    }

}

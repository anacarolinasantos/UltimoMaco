//
//  TutorialPageViewController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 08/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    @IBOutlet weak var pageControlDisplay: UIPageControl!

    var pageViewController: UIPageViewController!
    var tutorialPages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        for i in 0...5 {
            tutorialPages.append((self.storyboard?.instantiateViewController(withIdentifier: "tutorialPage\(i)"))!)
        }
        pageViewController.setViewControllers([tutorialPages.first!], direction: .forward, animated: true, completion: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        view.addSubview(pageViewController.view)
        
        pageControlDisplay.numberOfPages = tutorialPages.count
        pageControlDisplay.currentPage = 0
        view.bringSubview(toFront: pageControlDisplay)
    }
}

extension TutorialPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentIndex = tutorialPages.index(of: viewController) {
            return currentIndex == 0 ? nil : tutorialPages[currentIndex - 1]
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentIndex = tutorialPages.index(of: viewController) {
            return currentIndex == tutorialPages.count ? nil : tutorialPages[currentIndex + 1]
        }
        return nil
    }
    
}

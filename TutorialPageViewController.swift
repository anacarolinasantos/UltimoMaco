//
//  TutorialPageViewController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 08/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIViewController {
    
    @IBOutlet weak var pageDotsController: UIPageControl!
    
    var pageViewController: UIPageViewController!
    
    var tutorialPages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        for i in 1...4 {
            tutorialPages.append((self.storyboard?.instantiateViewController(withIdentifier: "tutorialPage\(i)"))!)
        }
        pageViewController.setViewControllers([tutorialPages.first!], direction: .forward, animated: true, completion: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        view.addSubview(pageViewController.view)
        
        view.bringSubview(toFront: pageDotsController)
        pageDotsController.numberOfPages = tutorialPages.count
        pageDotsController.currentPage = 0
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
            return currentIndex == tutorialPages.count - 1 ? nil : tutorialPages[currentIndex + 1]
        }
        return nil
    }
}

extension TutorialPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let lastViewController = previousViewControllers.last {
                if let index = tutorialPages.index(of: lastViewController) {
                    pageDotsController.currentPage = index + 1
                }
            }
        }
    }
    
}

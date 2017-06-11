//
//  InitilaPageViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class InitialPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    //MARK: - Atributes
    let pagesCount:Int = 5
    
    //MARK: - ViewController Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        self.dataSource = self
        
        let startingViewController: PageModelViewController = self.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        self.providesPresentationContextTransitionStyle = true
        self.setViewControllers([startingViewController], direction: .forward, animated: false, completion: {done in })
        
    }
    
    // ViewController 'get' method
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> PageModelViewController? {
        
        switch index {
        case 0:
            let pageController = storyboard.instantiateViewController(withIdentifier: "Page1") as! PageModelViewController
            pageController.index = 0
            return pageController
        case 1:
            let pageController = storyboard.instantiateViewController(withIdentifier: "Page2") as! PageModelViewController
            pageController.index = 1
            return pageController
        case 2:
            let pageController = storyboard.instantiateViewController(withIdentifier: "Page3") as! PageModelViewController
            pageController.index = 2
            return pageController
        case 3:
            let pageController = storyboard.instantiateViewController(withIdentifier: "Page4") as! PageModelViewController
            pageController.index = 3
            return pageController
        case 4:
            let pageController = storyboard.instantiateViewController(withIdentifier: "Page5") as! PageModelViewController
            pageController.index = 4
            return pageController
        default:
            return nil
        }
        
    }
    
    //MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as! PageModelViewController).index {
            if (index == 0) {
                return nil
            }
            index -= 1
            return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
        }
        return self.viewControllerAtIndex(0, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as! PageModelViewController).index {
            if (index == 5) {
                return nil
            }
            index += 1
            return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
        }
        return self.viewControllerAtIndex(0, storyboard: viewController.storyboard!)

    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pagesCount
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

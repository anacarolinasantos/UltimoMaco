//
//  InitilaPageViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class InitialPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    //MARK: - Atributes
    
    var allViewControllers: [PageModelViewController] = []
    
    var timer = Timer()
    
    var isAbleToContinue = true
    
    var userInfo: [Any] = []
    
    //MARK: - ViewController Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...5 {
            allViewControllers.append(storyboard?.instantiateViewController(withIdentifier: "Page\(i)") as! PageModelViewController)
            allViewControllers[i - 1].index = i - 1
            allViewControllers[i - 1].pageViewController = self
        }
        
        (allViewControllers[4] as! Page5ViewController).pageController = self
        
        // -- SETUP
        self.dataSource = self
        self.delegate = self
        
        let startingViewController: PageModelViewController = self.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        self.providesPresentationContextTransitionStyle = true
        self.setViewControllers([startingViewController], direction: .forward, animated: false, completion: {done in})
        
        timer = .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.verify), userInfo: nil, repeats: true)
        
    }
    
    func verify() {
        if !isAbleToContinue {
            self.dataSource = nil
            self.dataSource = self
        }
        isAbleToContinue = true
    }
        
    // ViewController 'get' method
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> PageModelViewController? {
        return allViewControllers[index]
    }
    
    //MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        isAbleToContinue = false

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
        let currentViewController = (viewController as! PageModelViewController)
        
        if !currentViewController.shouldContinueToNextViewController() {
            isAbleToContinue = false
            return nil
        }
        if var index = currentViewController.index {
            if (index == 4) {
                return nil
            }
            index += 1
            return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
        }
        return self.viewControllerAtIndex(0, storyboard: viewController.storyboard!)
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return allViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

}

//
//  FagerstromViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 16/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class FagerstromViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //MARK: - Outlets
    // The custom UIPageControl
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Atributes
    var isAbleToContinue = true
    var timer = Timer()
    var forward = false
    var backward = false
    // The UIPageViewController
    var pageContainer: UIPageViewController!
    // The pages it contains
    var pages = [PageModelViewController]()
    // Track the current index
    var currentIndex: Int? = 0
    private var pendingIndex: Int?
    
    // MARK: - ViewController Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the pages
        let storyboard = UIStoryboard(name: "FagerstromFormPageViewController", bundle: nil)
        
        for i in 1...6 {
            pages.append(storyboard.instantiateViewController(withIdentifier: "Fargerstrom\(i)") as! PageModelViewController)
            pages[i-1].index = i-1
        }
        
        // Create the page container
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        pageContainer.dataSource = self
        pageContainer.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        
        // Add it to the view
        view.addSubview(pageContainer.view)
        
        // Configure our custom pageControl
        view.bringSubview(toFront: pageControl)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        // Timer to keep pageContainer delegate active
        timer = .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.verify), userInfo: nil, repeats: true)
        
    }
    
    // MARK: - UIPageViewController delegates
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentViewController = (viewController as! PageModelViewController)
        isAbleToContinue = false
        
        if !currentViewController.shouldGoBackToPreviousViewController() {
            isAbleToContinue = false
            return nil
        }
        
        let currentIndex = currentViewController.index!
        if currentIndex == 0 {
            return nil
        }
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentViewController = (viewController as! PageModelViewController)
        if !currentViewController.shouldContinueToNextViewController() {
            isAbleToContinue = false
            if forward{
                currentViewController.view.shake()
            }
            return nil
        }
        
        let currentIndex = currentViewController.index!
        if currentIndex == pages.count-1 {
            return nil
        }
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.index(of: pendingViewControllers.first! as! PageModelViewController)
        forward = false
        backward = false
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
            }
        }
    }
    
    //MARK: - Auxiliary functions
    func verify() {
        if !isAbleToContinue {
            pageContainer.dataSource = nil
            pageContainer.dataSource = self
        }
        
        if (pageContainer.scrollView?.panGestureRecognizer.translation(in: pages[currentIndex!].view).x)! < CGFloat(0) {
            forward = true
            backward = false
        } else {
            forward = false
            backward = true
        }
        
        isAbleToContinue = true
    }
}

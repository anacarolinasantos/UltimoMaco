//
//  FagerstromViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 16/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class FagerstromViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //MARK: - Outlets
    // The custom UIPageControl
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Atributes
    var isAbleToContinue = true
    public var timer = Timer()
    var forward = false
    var backward = false
    // The UIPageViewController
    var pageContainer: UIPageViewController!
    // The pages it contains
    static var pages = [PageModelViewController]()
    // Track the current index
    var currentIndex: Int? = 0
    private var pendingIndex: Int?
    
    // MARK: - ViewController Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the pages
        let storyboard = UIStoryboard(name: "FagerstromFormPageViewController", bundle: nil)
        
        
        if !fagestromTestHasAlreadyBeenMade() {
            for i in 1...6 {
                FagerstromViewController.pages.append(storyboard.instantiateViewController(withIdentifier: "Fargerstrom\(i)") as! PageModelViewController)
                FagerstromViewController.pages[i-1].index = i-1
            }
        } else {
            FagerstromViewController.pages.append(storyboard.instantiateViewController(withIdentifier: "Fargerstrom6") as! PageModelViewController)
            FagerstromViewController.pages[0].index = 0
        }
        
        // Create the page container
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        pageContainer.dataSource = self
        pageContainer.setViewControllers([FagerstromViewController.pages.first!], direction: .forward, animated: false, completion: nil)
        
        // Add it to the view
        view.addSubview(pageContainer.view)
        
        // Configure our custom pageControl
        view.bringSubview(toFront: pageControl)
        pageControl.numberOfPages = FagerstromViewController.pages.count
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
        let previousIndex = abs((currentIndex - 1) % FagerstromViewController.pages.count)
        return FagerstromViewController.pages[previousIndex]
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
        if currentIndex == FagerstromViewController.pages.count-1 {
            return nil
        }
        let nextIndex = abs((currentIndex + 1) % FagerstromViewController.pages.count)
        return FagerstromViewController.pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = FagerstromViewController.pages.index(of: pendingViewControllers.first! as! PageModelViewController)
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
        
        if (pageContainer.scrollView?.panGestureRecognizer.translation(in: FagerstromViewController.pages[currentIndex!].view).x)! < CGFloat(0) {
            forward = true
            backward = false
        } else {
            forward = false
            backward = true
        }
        
        if let page6 = FagerstromViewController.pages[currentIndex!] as? FagerstromPage6 {
            if page6.pressed {
                timer.invalidate()
                FagerstromViewController.pages.removeAll()
                self.dismiss(animated: true, completion: nil)
            } else if page6.redo {
                FagerstromViewController.pages.removeAll()
                reSetAll()
            }
        }
        
        isAbleToContinue = true
    }
    
    private func fagestromTestHasAlreadyBeenMade() -> Bool {
        var ft: [FagerstromTest] = []
        do {
            ft = try DatabaseController.persistentContainer.viewContext.fetch(FagerstromTest.fetchRequest()) as! [FagerstromTest]
        } catch _ as NSError { print("Error") }
        return ft.count != 0
    }
    
    private func reSetAll() {
        pageContainer.dataSource = nil
        pageContainer.delegate = nil

        let storyboard = UIStoryboard(name: "FagerstromFormPageViewController", bundle: nil)
        for i in 1...6 {
            FagerstromViewController.pages.append(storyboard.instantiateViewController(withIdentifier: "Fargerstrom\(i)") as! PageModelViewController)
            FagerstromViewController.pages[i-1].index = i-1
        }
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        pageContainer.dataSource = self
        pageContainer.setViewControllers([FagerstromViewController.pages.first!], direction: .forward, animated: false, completion: nil)
        view.addSubview(pageContainer.view)
        view.bringSubview(toFront: pageControl)
        pageControl.numberOfPages = FagerstromViewController.pages.count
        pageControl.currentPage = 0
    }
}

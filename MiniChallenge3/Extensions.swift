//
//  Extensions.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 10/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String {
    public func isValid() -> Bool {
        return !(self.isEmpty || self.trimmingCharacters(in: .whitespaces).isEmpty)
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIImage {
    var bwImage: UIImage? {
        guard let cgImage = cgImage,
            let bwContext = bwContext else {
                return nil
        }
        
        let rect = CGRect(origin: .zero, size: size)
        bwContext.draw(cgImage, in: rect)
        let bwCgImage = bwContext.makeImage()
        
        return bwCgImage.flatMap { UIImage(cgImage: $0) }
    }
    
    private var bwContext: CGContext? {
        let bwContext = CGContext(data: nil,
                                  width: Int(size.width * scale),
                                  height: Int(size.height * scale),
                                  bitsPerComponent: 8,
                                  bytesPerRow: Int(size.width * scale),
                                  space: CGColorSpaceCreateDeviceGray(),
                                  bitmapInfo: CGImageAlphaInfo.none.rawValue)
        
        bwContext?.interpolationQuality = .high
        bwContext?.setShouldAntialias(false)
        
        return bwContext
    }
}

extension UIPageViewController {
    
    public var scrollView: UIScrollView? {
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                return scrollView
            }
        }
        return nil
    }
    
}

extension CGRect {
    
    mutating func changeOrigin(toX: CGFloat, andYTo: CGFloat) {
        let point = CGPoint(x: toX, y: andYTo)
        let size = self.size
        let newFrame = CGRect(origin: point, size: size)
        self = newFrame
    }
    
    mutating func changeOriginX(to: CGFloat) {
        let point = CGPoint(x: to, y: self.origin.y)
        let size = self.size
        let newFrame = CGRect(origin: point, size: size)
        self = newFrame
    }
    
    mutating func changeOriginY(to: CGFloat) {
        let point = CGPoint(x: self.origin.x, y: to)
        let size = self.size
        let newFrame = CGRect(origin: point, size: size)
        self = newFrame
    }
}

class SlideShowEffect: UIImageView {
    
    private var slideShowCount = 0
    
    private var duration = 1.0
    
    private var delay = 1.0
    
    private var imageNames: [String] = []
    
    private var hasAlreadyPlayed = false
    
    func setUpSlideShow(imageNames: [String], timeBetweenImages: Double, transitionDuration: Double) {
        self.imageNames = imageNames
        self.delay = timeBetweenImages
        self.duration = transitionDuration
        self.image = UIImage(named: imageNames[0])
    }
    
    func slideShow() {
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: .allowUserInteraction, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.slideShowCount = self.slideShowCount + 1 < self.imageNames.count ? self.slideShowCount + 1 : 0
            self.image = UIImage(named: self.imageNames[self.slideShowCount])
            UIView.animate(withDuration: TimeInterval(self.duration), delay: 0, options: .allowUserInteraction, animations: {
                self.alpha = 1
            }, completion: { _ in
                self.slideShow()
            })
        })
    }
    
}

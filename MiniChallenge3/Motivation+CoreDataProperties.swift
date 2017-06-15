//
//  Motivation+CoreDataProperties.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Motivation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Motivation> {
        return NSFetchRequest<Motivation>(entityName: "Motivation")
    }

    @NSManaged public var desMotivation: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var title: String?

    public func imageAsMedia(image: UIImage) {
        photo = NSData(data: UIImageJPEGRepresentation(image, 0.9)!)
    }
    
    public func getImageAsMedia() -> UIImage? {
        if let ret = self.photo {
            return UIImage(data: ret as Data)!
        }
        return nil
    }
}

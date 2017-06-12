//
//  User+CoreDataProperties.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 12/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var achievementNotifier: Bool
    @NSManaged public var enableReminder: Bool
    @NSManaged public var name: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var reminderTime: NSDate?
    
    public func imageAsMedia(image: UIImage) {
        photo = NSData(data: UIImageJPEGRepresentation(image, 0.9)!)
    }
    
    public func getImageAsMedia() -> UIImage {
        return UIImage(data: self.photo! as Data)!
    }
    
}

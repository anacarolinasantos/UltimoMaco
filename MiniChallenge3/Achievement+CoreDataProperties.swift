//
//  Achievement+CoreDataProperties.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData


extension Achievement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Achievement> {
        return NSFetchRequest<Achievement>(entityName: "Achievement")
    }

    @NSManaged public var amount: Int16
    @NSManaged public var assetIdentifier: String?
    @NSManaged public var hasAchievement: Bool

}

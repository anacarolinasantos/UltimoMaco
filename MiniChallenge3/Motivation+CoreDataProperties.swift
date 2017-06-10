//
//  Motivation+CoreDataProperties.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData


extension Motivation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Motivation> {
        return NSFetchRequest<Motivation>(entityName: "Motivation")
    }

    @NSManaged public var title: String?
    @NSManaged public var desMotivation: String?
    @NSManaged public var photo: NSData?

}

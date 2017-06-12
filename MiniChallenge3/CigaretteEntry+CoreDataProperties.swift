//
//  CigaretteEntry+CoreDataProperties.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 12/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData


extension CigaretteEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CigaretteEntry> {
        return NSFetchRequest<CigaretteEntry>(entityName: "CigaretteEntry")
    }

    @NSManaged public var cigaretteNumber: Int32
    @NSManaged public var date: NSDate?

}

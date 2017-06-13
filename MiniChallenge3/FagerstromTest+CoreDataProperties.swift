//
//  FagerstromTest+CoreDataProperties.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData


extension FagerstromTest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FagerstromTest> {
        return NSFetchRequest<FagerstromTest>(entityName: "FagerstromTest")
    }

    @NSManaged public var cigarreteRestriction: Int16
    @NSManaged public var cigQtyFirstHours: Int16
    @NSManaged public var firstCigarrete: Int16
    @NSManaged public var morningCigarrete: Int16
    @NSManaged public var sickSmoking: Int16

}

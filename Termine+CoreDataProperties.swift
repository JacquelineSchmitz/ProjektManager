//
//  Termine+CoreDataProperties.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 26.01.23.
//
//

import Foundation
import CoreData


extension Termine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Termine> {
        return NSFetchRequest<Termine>(entityName: "Termine")
    }

    @NSManaged public var termin1: Date?
    @NSManaged public var termin2: Date?
    @NSManaged public var termin3: Date?

}

extension Termine : Identifiable {

}

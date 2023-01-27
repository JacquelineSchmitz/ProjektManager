//
//  Termine+CoreDataProperties.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 27.01.23.
//
//

import Foundation
import CoreData


extension Termine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Termine> {
        return NSFetchRequest<Termine>(entityName: "Termine")
    }

    @NSManaged public var termin1: String?
    @NSManaged public var termin2: String?
    @NSManaged public var termin3: String?

}

extension Termine : Identifiable {

}

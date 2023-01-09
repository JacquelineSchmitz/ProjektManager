//
//  User+CoreDataProperties.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 05.01.23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var birthdate: Date?
    @NSManaged public var email: String?
    @NSManaged public var firma: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}

//
//  User+CoreDataProperties.swift
//  talk_iOS
//
//  Created by User on 2023/02/11.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String
    @NSManaged public var id: Int32
    @NSManaged public var loggedFrom: String
    @NSManaged public var name: String
    @NSManaged public var personalColor: String
    @NSManaged public var profileImage: String

}

extension User : Identifiable {

}

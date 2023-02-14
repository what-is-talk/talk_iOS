//
//  User+CoreDataProperties.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/11.
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
    @NSManaged public var token:String
    @NSManaged public var name: String
    @NSManaged public var personalColor: String
    @NSManaged public var profileImage: String
    @NSManaged public var currentMeetingId:Int32

}

extension User : Identifiable {

}

//
//  Member+CoreDataClass.swift
//  talk_iOS
//
//  Created by User on 2023/02/08.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }


}

extension User:Identifiable{
    @NSManaged public var email: String
    @NSManaged public var id: Int32
    @NSManaged public var loggedFrom: String
    @NSManaged public var name: String
    @NSManaged public var personalColor: String
    @NSManaged public var profileImage: String
}

//
//  Member_Meeting+CoreDataProperties.swift
//  talk_iOS
//
//  Created by User on 2023/02/08.
//
//

import Foundation
import CoreData


extension Member_Meeting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member_Meeting> {
        return NSFetchRequest<Member_Meeting>(entityName: "Member_Meeting")
    }

    @NSManaged public var joinedDate: Date?
    @NSManaged public var meeting: Meeting?
    @NSManaged public var member: Member?

}

extension Member_Meeting : Identifiable {
    
}

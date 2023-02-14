//
//  Meeting+CoreDataProperties.swift
//  talk_iOS
//
//  Created by User on 2023/02/14.
//
//

import Foundation
import CoreData


extension Meeting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meeting> {
        return NSFetchRequest<Meeting>(entityName: "Meeting")
    }

    @NSManaged public var id: Int32
    @NSManaged public var inviteCode: String?
    @NSManaged public var joinedDate: Date?
    @NSManaged public var memberCount: Int16
    @NSManaged public var name: String?
    @NSManaged public var profileImage: String?
    @NSManaged public var currentMeetingId: Int32

}

extension Meeting : Identifiable {

}

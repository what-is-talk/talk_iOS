//
//  Schedule+CoreDataProperties.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/10.
//
//

import Foundation
import CoreData


extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule")
    }

    @NSManaged public var desc: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var id: Int32
    @NSManaged public var includingEndDate: Bool
    @NSManaged public var includingTime: Bool
    @NSManaged public var reminder: Date?
    @NSManaged public var startDate: Date
    @NSManaged public var title: String
    @NSManaged public var meeting: Meeting

}

extension Schedule : Identifiable {

}

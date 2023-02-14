//
//  Position+CoreDataProperties.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/10.
//
//

import Foundation
import CoreData


extension Position {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Position> {
        return NSFetchRequest<Position>(entityName: "Position")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var meeting: Meeting

}

extension Position : Identifiable {

}

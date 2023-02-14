//
//  Member_Position+CoreDataProperties.swift
//  talk_iOS
//
//  Created by User on 2023/02/10.
//
//

import Foundation
import CoreData


extension Member_Position {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member_Position> {
        return NSFetchRequest<Member_Position>(entityName: "Member_Position")
    }

    @NSManaged public var member: Member?
    @NSManaged public var position: Position?

}

extension Member_Position : Identifiable {

}

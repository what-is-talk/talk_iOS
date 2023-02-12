//
//  Member+CoreDataProperties.swift
//  talk_iOS
//
//  Created by User on 2023/02/08.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member")
    }

    @NSManaged public var email: String
    @NSManaged public var id: Int32
    @NSManaged public var loggedFrom: String
    @NSManaged public var name: String
    @NSManaged public var personalColor: String
    @NSManaged public var profileImage: String

}

extension User : Identifiable {

    
    func saveMember(member:MemberData){
        let context = CoreDataStack.shared.viewContext
        let memberEntity = Member(context: context)
        memberEntity.id = member.id
        memberEntity.email = member.email
        memberEntity.name = member.name
        memberEntity.loggedFrom = member.loggedFrom
        memberEntity.personalColor = member.personalColor
        memberEntity.profileImage = member.profileImage
        
        do {
            let fetchRequest = Member_Meeting.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "", <#T##args: CVarArg...##CVarArg#>)
            try context.save()
        } catch let error as NSError {
            print("Could not save member. \(error), \(error.userInfo)")
        }
    }


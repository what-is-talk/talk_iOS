//
//  CoreDataClient+Member.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/10.
//

import Foundation


extension CoreDataClient{
    /// User 데이터 불러오는 함수
    /// (로컬에는 최대 하나의 유저만 존재한다)
    func getUser() -> UserData?{
        guard let user = try? ctx.fetch(User.fetchRequest()).first else {return nil}
        return UserData(user)
    }
    
    /**
     Creates or updates a User entity in Core Data.
     
     - Parameters:
         - user: The `UserData` model to be stored or updated in Core Data.
     
     - Throws:
        `CoreDataError.validationError` if there is a problem in fetching the existing User entity.
     
     - Note:
        If a User with the given `id` exists in Core Data, the existing User entity will be updated with the new `UserData` values.
        If no User entity with the given `id` exists, a new User entity will be created with the values from `UserData`.
     
     */
    func createOrUpdateUser(_ user:UserData) throws{
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", user.id)
        
        // 이미 User가 있다면 업데이트
        if let existingUser = try? ctx.fetch(fetchRequest).first{
            existingUser.name = user.name
            existingUser.email = user.email
            existingUser.profileImage = user.profileImage
            existingUser.loggedFrom = user.loggedFrom
            existingUser.token = user.token
            existingUser.personalColor = user.personalColor
            existingUser.currentMeetingId = user.currentMeetingId
            
        // User가 없다면 새로 생성
        } else{
            let newUser = User(context: ctx)
            newUser.id = user.id
            newUser.name = user.name
            newUser.email = user.email
            newUser.profileImage = user.profileImage
            newUser.loggedFrom = user.loggedFrom
            newUser.token = user.token
            newUser.personalColor = user.personalColor
            newUser.currentMeetingId = user.currentMeetingId
        }
        try ctx.save()
    }
    
    /// Deletes a User from CoreData with the given userId.
    ///
    /// - Parameter userId: The id of the User to be deleted.
    /// - Throws: A CoreDataError.validationError if the User with the given id cannot be found.
    func deleteUser(userId:Int32) throws{
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", userId)
        guard let user = try? ctx.fetch(fetchRequest).first else {throw CoreDataError.validationError(message: "주어진 id의 User를 찾을 수 없음")}
        ctx.delete(user)
        try ctx.save()
    }
    
    /**
     Delete all User entities stored in Core Data.

    - Throws: If there was an error saving the context after deleting all User entities, a `CoreDataError` is thrown.
    */
    func resetUser() throws {
        let fetchRequest = User.fetchRequest()
        let users = try ctx.fetch(fetchRequest)
        for user in users {
            ctx.delete(user)
        }
        try ctx.save()
    }
}

//
//  CoreDataClient+Position.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/12.
//

import Foundation

extension CoreDataClient{
    
    /// Meeting에 속한 모든 Positions(역할) 가져오는 함수
    /// - Parameters:
    ///   - meetingId: Int
    /// - Returns: [PositionData]
    func getPositions(meetingId:Int32) -> [PositionData]{
        guard let positions = try? ctx.fetch(Position.fetchRequest()) else {return []}
        return positions
            .filter{ position in position.meeting.id == meetingId}
            .map{ position in PositionData(position)}
    }
    
    
    /**
     Creates or updates the position in CoreData based on the given position data.

     - Parameters:
         - position: PositionData object which will be used to create or update the position in CoreData.
     - Throws:
         - CoreDataError.validationError: When meeting associated with the position is not found in CoreData.
         - CoreDataError.saveError: When there is an error while saving the changes in CoreData.
     
     - Returns:
         - None
    */
    func createOrUpdatePosition(_ position:PositionData) throws{
        let meetingFetchRequest = Meeting.fetchRequest()
        meetingFetchRequest.predicate = NSPredicate(format: "id == %d", position.meeting.id)
        guard let meeting = try? ctx.fetch(meetingFetchRequest).first else {throw CoreDataError.validationError(message: "Position이 속한 Meeting을 찾을 수 없음")}
        
        let positionFetchRequest = Position.fetchRequest()
        positionFetchRequest.predicate = NSPredicate(format: "id == %d", position.id)
        
        // 이미 역할이 있다면 업데이트
        if let existingPosition = try? ctx.fetch(positionFetchRequest).first{
            existingPosition.name = position.name
            existingPosition.meeting = meeting
    
        // 역할이 없다면 새로 생성
        } else{
            let newPosition = Position(context: ctx)
            newPosition.id = position.id
            newPosition.name = position.name
            newPosition.meeting = meeting
        }
        
        try ctx.save()
    }
    
    /// Deletes a Position from CoreData with the given positionId.
    ///
    /// - Parameter positionId: The id of the Position to be deleted.
    /// - Throws: A CoreDataError.validationError if the Position with the given id cannot be found.
    func deletePosition(positionId:Int32) throws{
        let fetchRequest = Position.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", positionId)
        guard let position = try? ctx.fetch(fetchRequest).first else {throw CoreDataError.validationError(message: "주어진 id의 Position을 찾을 수 없음")}
        ctx.delete(position)
        try ctx.save()
    }
    
    /// 주어진 meeting의 모든 position을 삭제하는 함수
    /// (meeting 삭제 시 사용)
    ///
    /// - Parameter meetingId: 삭제할 position이 속한 meeting의 id
    /// - Throws: `CoreData` related errors if any while fetching or deleting the `Position` entities.
    func deletePositions(meetingId:Int32) throws{
        let fetchRequest = Position.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "meeting.id == %d", meetingId)
        let positions = try ctx.fetch(fetchRequest)
        for position in positions {
            ctx.delete(position)
        }
        try ctx.save()
    }
    
    /**
     Delete all Position entities stored in Core Data.

    - Throws: If there was an error saving the context after deleting all Position entities, a `CoreDataError` is thrown.
    */
    func resetPosition() throws {
        let fetchRequest = Position.fetchRequest()
        let positions = try ctx.fetch(fetchRequest)
        for position in positions {
            ctx.delete(position)
        }
        try ctx.save()
    }
    
}

//
//  CoreDataClient+Meeting.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/10.
//

import Foundation

extension CoreDataClient{
    
    /// (유저가 속해있는) 모든 Meeting return
    func getMeetings() -> [MeetingData]{
        do {
            let meetings = try ctx.fetch(Meeting.fetchRequest())
            return meetings.map{ MeetingData($0) }
        } catch {
            return []
        }
    }
    
    /// 주어진 id를 가진 meeting을 반환하는 함수
    func getMeeting(meetingId:Int) -> MeetingData?{
        let fetchRequest = Meeting.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", meetingId)
        guard let meeting = try? ctx.fetch(fetchRequest).first else {return nil}
        return MeetingData(meeting)
    }
    
    /// Creates or updates a meeting in the core data storage.
    ///
    /// - Parameter meeting: The meeting data to be saved or updated.
    /// - Throws: CoreDataError.validationError if the meeting with the given ID is not found in the storage.
    func createOrUpdateMeeting(_ meeting:MeetingData) throws{
        
        let fetchRequest = Meeting.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", meeting.id)
        if let existingMeeting = try? ctx.fetch(fetchRequest).first{
            // 이미 해당 모임이 있다면 업데이트
            existingMeeting.name = meeting.name
            existingMeeting.inviteCode = meeting.inviteCode
            existingMeeting.profileImage = meeting.profileImage
            existingMeeting.joinedDate = meeting.joinedDate
            existingMeeting.memberCount = meeting.memberCount
        } else{
            // 새로운 모임 생성
            let meetingEntity = Meeting(context: ctx)
            meetingEntity.id = meeting.id
            meetingEntity.name = meeting.name
            meetingEntity.inviteCode = meeting.inviteCode
            meetingEntity.profileImage = meeting.profileImage
            meetingEntity.joinedDate = meeting.joinedDate
            meetingEntity.memberCount = meeting.memberCount
        }
        
        try ctx.save()
    }
    
    /**
     Deletes a meeting with a given `meetingId` from the Core Data storage.
     
     - Parameters:
        - meetingId: The id of the meeting to be deleted.
     
     - Throws:
        - CoreDataError.validationError: If the meeting with the given `meetingId` cannot be found in the Core Data storage.
        - Any error thrown by `ctx.save()`.
     
     - Note:
        The method first fetches the meeting with the given `meetingId` using a fetch request with the `meetingId` as a predicate.
        If the meeting is found, it is deleted from the Core Data storage and the changes are saved.
     */
    func deleteMeeting(meetingId:Int32) throws{
        let fetchRequest = Meeting.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", meetingId)
        guard let meeting = try? ctx.fetch(fetchRequest).first else {throw CoreDataError.validationError(message: "주어진 id의 Schedule을 찾을 수 없음")}
        ctx.delete(meeting)
        try ctx.save()
    }
    
    /**
     Delete all Meeting entities stored in Core Data.

    - Throws: If there was an error saving the context after deleting all Meeting entities, a `CoreDataError` is thrown.
    */
    func resetMeeting() throws {
        let fetchRequest = Meeting.fetchRequest()
        let meetings = try ctx.fetch(fetchRequest)
        for meeting in meetings {
            ctx.delete(meeting)
        }
        try ctx.save()
    }
}

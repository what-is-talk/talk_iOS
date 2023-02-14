//
//  CoreDataClient+Schedule.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/10.
//

import Foundation

extension CoreDataClient{
    
    /// Meeting에 속한 모든 Schedules 가져오는 함수
    /// - Parameters:
    ///   - meetingId: Int
    /// - Returns: [ScheduleData]
    func getSchedules(meetingId:Int32) -> [ScheduleData]{
        guard let schedules = try? ctx.fetch(Schedule.fetchRequest()) else {return []}
        return schedules
            .filter{ schedule in schedule.meeting.id == meetingId}
            .map{ schedule in ScheduleData(schedule)}
    }
    
    /**
     Creates or updates the schedule in CoreData based on the given schedule data.

     - Parameters:
         - schedule: ScheduleData object which will be used to create or update the schedule in CoreData.
     - Throws:
         - CoreDataError.validationError: When meeting associated with the schedule is not found in CoreData.
         - CoreDataError.saveError: When there is an error while saving the changes in CoreData.
     
     - Returns:
         - None
    */
    func createOrUpdateSchedule(_ schedule:ScheduleData) throws{
        let meetingFetchRequest = Meeting.fetchRequest()
        meetingFetchRequest.predicate = NSPredicate(format: "id == %d", schedule.meeting.id)
        guard let meeting = try? ctx.fetch(meetingFetchRequest).first else {throw CoreDataError.validationError(message: "Schedule이 속한 Meeting을 찾을 수 없음")}
        
        let scheduleFetchRequest = Schedule.fetchRequest()
        scheduleFetchRequest.predicate = NSPredicate(format: "id == %d", schedule.id)
        
        // 이미 스케줄이 있다면 업데이트
        if let existingSchedule = try? ctx.fetch(scheduleFetchRequest).first{
            existingSchedule.title = schedule.title
            existingSchedule.desc = schedule.desc
            existingSchedule.startDate = schedule.startDate
            existingSchedule.endDate = schedule.endDate
            existingSchedule.includingTime = schedule.includingTime
            existingSchedule.includingEndDate = schedule.includingEndDate
            existingSchedule.meeting = meeting
            
        // 스케줄이 없다면 새로 생성
        } else{
            let newSchedule = Schedule(context: ctx)
            newSchedule.id = schedule.id
            newSchedule.title = schedule.title
            newSchedule.desc = schedule.desc
            newSchedule.startDate = schedule.startDate
            newSchedule.endDate = schedule.endDate
            newSchedule.includingTime = schedule.includingTime
            newSchedule.includingEndDate = schedule.includingEndDate
            newSchedule.meeting = meeting
        }
        
        try ctx.save()
    }
    
    /// Deletes a Schedule from CoreData with the given scheduleId.
    ///
    /// - Parameter scheduleId: The id of the Schedule to be deleted.
    /// - Throws: A CoreDataError.validationError if the Schedule with the given id cannot be found.
    func deleteSchedule(scheduleId:Int32) throws{
        let fetchRequest = Schedule.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", scheduleId)
        guard let schedule = try? ctx.fetch(fetchRequest).first else {throw CoreDataError.validationError(message: "주어진 id의 Schedule을 찾을 수 없음")}
        ctx.delete(schedule)
        try ctx.save()
    }
    
    /**
     Delete all Schedule entities stored in Core Data.

    - Throws: If there was an error saving the context after deleting all Schedule entities, a `CoreDataError` is thrown.
    */
    func resetSchedule() throws {
        let fetchRequest = Schedule.fetchRequest()
        let schedules = try ctx.fetch(fetchRequest)
        for schedule in schedules {
            ctx.delete(schedule)
        }
        try ctx.save()
    }
}

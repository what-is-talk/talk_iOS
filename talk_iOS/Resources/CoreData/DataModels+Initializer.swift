//
//  DataModels+Initializer.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/12.
//  

import Foundation

extension MeetingData{
    init(_ meeting:Meeting){
        self.id = meeting.id
        self.inviteCode = meeting.inviteCode
        self.name = meeting.name
        self.profileImage = meeting.profileImage
        self.joinedDate = meeting.joinedDate
        self.memberCount = meeting.memberCount
    }
}

extension UserData{
    init(_ user:User){
        self.id = user.id
        self.email = user.email
        self.name = user.name
        self.loggedFrom = user.loggedFrom
        self.token = user.token
        self.personalColor = user.personalColor
        self.profileImage = user.profileImage
        self.currentMeetingId = user.currentMeetingId
    }
}

extension ScheduleData{
    init(_ schedule:Schedule){
        self.id = schedule.id
        self.title = schedule.title
        self.desc = schedule.desc
        self.startDate = schedule.startDate
        self.endDate = schedule.endDate
        self.includingTime = schedule.includingTime
        self.includingEndDate = schedule.includingEndDate
        self.reminder = schedule.reminder
        self.meeting = MeetingData(schedule.meeting)
    }
}

extension PositionData{
    init(_ position:Position){
        self.id = position.id
        self.name = position.name
        self.meeting = MeetingData(position.meeting)
    }
}

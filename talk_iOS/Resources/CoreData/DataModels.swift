//
//  DataModels.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/09.
//

import Foundation



struct UserData:Codable{
    let id: Int32
    let email: String
    var name: String
    let loggedFrom: String
    var token:String
    var personalColor:String
    var profileImage:String
    var currentMeetingId:Int32
}


struct MeetingData:Codable{
    let id: Int32
    let inviteCode: String
    var name: String
    var profileImage:String
    let joinedDate:Date?
    var memberCount:Int16
}

struct ScheduleData:Codable{
    let id:Int32
    let title:String
    let desc:String?
    let startDate:Date
    let endDate:Date?
    let includingTime:Bool
    let includingEndDate:Bool
    let reminder:Date?
    let meeting:MeetingData
}

struct PositionData:Codable{
    let id:Int32
    var name:String
    let meeting:MeetingData
}


// 사용 X
struct newData{
    let newAnnoCount = 1
    let newChatCount = 1
    let newVoteCount = 1
    let memberCount:Int
    let newScheduleCount = 1
    let newTodo = 1
}




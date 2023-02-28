

import Foundation
/*
struct Root: Codable {
    let data : [ScheduleResponse]
    //let tableViewData: [TableViewData]
}
    struct ScheduleResponse: Codable {
        let id : Int
        let title : String
        let desc : String
        let startDate : Date
        let endDate : Date
        let includingTime : Bool
        let includingEndDate : Bool
        
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case desc
        case startDate
        case endDate
        case includingTime
        case includingEndDate
    }
  }*/
/*
struct Root: Decodable {
    let group_id: Int
    let group_name: String
    let start_year: String
    let schedules: [ScheduleResponse]
    
}

struct ScheduleResponse: Decodable {
    let id: Int
    let title: String
    let desc: String
    let startDate: String
    let endDate: String
    let includingTime: Bool
    let includingEndDate: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case desc
        case startDate
        case endDate
        case includingTime
        case includingEndDate
    }
}
*/

struct ScheduleMain: Codable {
    let groupName: String
    let scheduleDetail: [ScheduleDetail]
    let startYear: Int
}

struct ScheduleDetail: Codable {
    let scheduleId: Int
    let groupName: String
    let title: String
    let description: String
    let startDate: String
    let endDate: String
    let includingEndDate: Bool
    let includeingTime: Bool
    let reminder: String
}
/*
struct ScheduleMain: Codable {
    let scheduleData: [GroupSchedule]
}

struct GroupSchedule: Codable {
    let schedules: ScheduleDetail
}

struct ScheduleDetail: Codable {
    let id: Int
    let title: String
    let desc: String
    let startDate: String
    let endDate: String
    let includingEndDate: Bool
    let includingTime: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case desc
        case startDate
        case endDate
        case includingTime
        case includingEndDate
    }
}
*/

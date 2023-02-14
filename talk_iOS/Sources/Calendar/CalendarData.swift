//
//  CalendarData.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/02/13.
//

import Foundation

struct Root: Decodable {
    let data : [ScheduleResponse]
    //let tableViewData: [TableViewData]
}
    struct ScheduleResponse: Decodable {
        //let id : Int
        let title : String
        let desc : String
        let startDate : String
        //let endDate : String
        //let includingTime : Bool
        //let includingEndDate : Bool
        
    enum CodingKeys: String, CodingKey {
        //case id
        case title
        case desc
        case startDate
        //case endDate
        //case includingTime
        //case includingEndDate
    }
  }
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

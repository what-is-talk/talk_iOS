//
//  JoinDataModel.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/07.
//

import Foundation

struct JoinResponseDataModel:Codable{
    let token:String
    let userId:Int
    let userName:String
}

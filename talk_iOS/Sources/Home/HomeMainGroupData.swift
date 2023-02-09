//
//  HomeMainGroupData.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/31.
//

import UIKit



struct HomeMainGroup:Decodable{
    let groupName:String
    let imageName:String
    var selecting:Bool
    
    var image:UIImage{
        return UIImage(named: imageName) ?? UIImage()
    }
}

// O 읽지 않음
struct HomeMainGroupDetail:Decodable{
    let newAnno:Int
    let newChat:Int
    let newVote:Int
    let memberCount:Int
    let newSchedule:Int
    let newTodo:Int
}

//
//  ChattingLog.swift
//  talk_iOS
//
//  Created by 김혜연 on 2023/01/11.
//

import Foundation
import UIKit

struct ChattLog: Codable, Identifiable{
    let id: UUID = UUID()
    let FriendName:String
    let LastMsg:String
    var headCount:Int
    var IconName:BtnIcon
}
extension Friend:Codable{}
extension Friend:Identifiable{}
extension Friend:Equatable{}

let ChattLogSamples=[
    ChattLog(FriendName: "채팅방 이름", LastMsg: "가장 최근 메세지가 이곳에 표시됩니다", headCount: 26, IconName: "pin")
    ChattLog(FriendName: "채팅방 이름", LastMsg: "가장 최근 메세지가 이곳에 표시됩니다", headCount: 5, IconName: "bell.slash")
    ChattLog(FriendName: "채팅방 이름", LastMsg: "가장 최근 메세지가 이곳에 표시됩니다", headCount:0 , IconName: "none")
   
]
struct BtnIcon:Codable{
    var msg:String
    var isNotification:Bool
    var isPin:Bool
    var isChat:Bool
    init(_ msg: String ="None", _ Notification: Bool, _ Pin: Bool, _ Chat: Bool) {
        self.msg = msg
        self.isNotification = Notification
        self.isPin = Pin
        self.isChat = Chat
    }
}
struct ContentView:View{
    var body: some View{
        List{
            ForEach(ChattLogSamples){
                ChattLogView($0.FriendName, $0.LastMsg, $0.headCount, $0.IconName)
            }
        }
    }
}
struct ChatLogView:View{
    let widthText:CGFloat =300
    let ImageWH:CGFloat =40
    
    var ImgName:String
    var FriendName:String
    var LastMsg:String
    var headCount:Int
    var IconName:BtnIcon
}

struct ChatLogView:View{
    
    init(_ name:String,
         _ msg:String="noMsg",
         _ count:Int=2,
         _ btnState:BtnIcon=BtnIcon("none", true, true, true))
    {
        self.FriendName = name
        self.LastMsg = msg
        self.headCount = count
        self.IconName = btnState
        self.ImgName = "none"
        setImgName(UserName: self.FriendName)
        
        print("Image Name: \(ImgName)")
    }
}

struct ChatLogView: View{
    var body: some View{
        HStack{
            Image(self.ImgName) //"01"
                .resizable()
                .frame(width: ImageWH, height:ImageWH)
                .clipShape(Circle())
            
            VStack{
                NotificationOption
                    .frame(width:widthText, height: 20,alignment: .leading)
                
                lastMsg
                    .frame(width:widthText, height:20, alignment: .leading)
            }
            .frame(width:300., height:40)
        }
    }
}

private extension ChatLogView{
    HStack{
        Text(FriendName)
            .font(.headline)
        
        Text(getCount(count : headCount))
            .font(.footnote)
        
        if IconName.isNotification{
            Image(systemName: "bell")
        }
        else{
            Image(systemName:"bell.slash")
        }
        
        if IconName.isPin{
            Image(systemName: "pin")
        }
        else{
            Image(systemName: "pin.fill")
        }
        
        if IconName.isChat{
            Image(systemName: "message")
        }
        else{
            Image(systemName: "message.fill")
        }
    }
}

var lastMsg: some View{
    HStack{
        Text(LastMsg)
            .font(.footnote)
    }
}

mutating func setImgName( UserName:String){
    for friend in FriendSamples{
        if friend.UserName == UserName{
            self.ImgName = friend.ImgName
            break
        }
    }
}

func getCount ( count:Int) -> String{
    let CountString = String(count)
    return CountString
}

Image(systemName: "bell")
Image(systemName:"bell.slash")
class ChattingLog: TableViewController {

}

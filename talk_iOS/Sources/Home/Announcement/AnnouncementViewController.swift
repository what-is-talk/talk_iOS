//
//  AnnouncementViewController.swift
//  talk_iOS
//
//  Created by 박상민 on 2023/02/14.
//

import UIKit
import SnapKit

class AnnouncementViewController:UIViewController{
    
    static let identifier = "AnnouncementViewController"
    let table = UITableView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.title = "공지사항"
        view.addSubview(upperView)
        upperView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(120)
            $0.height.equalTo(56)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
        }

    

    }

    let upperView : UIView = {
//        ddf?/
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.cornerRadius = 8.0

        //dfdffdfdfdf
        let upperViewLabel = UILabel()
        upperViewLabel.font = UIFont.boldSystemFont(ofSize: 16)
        upperViewLabel.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        upperViewLabel.text = "공지사항"
        view.addSubview(upperViewLabel)
        upperViewLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(23)
            }
    
        let upperViewIcon = UIImageView(image: UIImage(named: "btnDown"))
        view.addSubview(upperViewIcon)
        upperViewIcon.frame = CGRect(x: 0, y: 0, width:0, height:5)
        upperViewIcon.layer.cornerRadius = 8
        upperViewIcon.layer.masksToBounds = true
        upperViewIcon.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(upperViewLabel.snp.trailing).inset(-5)
        }
            
        let upperViewArt = UIImageView(image: UIImage(named: "AnnouncementViewIcon"))
        view.addSubview(upperViewArt)
        upperViewArt.layer.cornerRadius = 8
        upperViewArt.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        upperViewArt.contentMode = .scaleAspectFill
        upperViewArt.clipsToBounds = true
        upperViewArt.snp.makeConstraints{
            $0.centerY.height.equalToSuperview()
//            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
            
            
    return view
    }()
            
            
            
            //Data Structure 짜기
            struct Announce:Codable{
                let id:Int32
                let createBy:Member
                let title:String
                let message:String
            }
            
            struct Member:Codable{
                let name:String
                let profileImageUrl:String
            }
            //
            //    var announces:[Announce] = []
            //        announces.append([
            //            Announce(id: 23, createBy: Member(name: "saxasc",profileImageUrl: "sacas"), title: "제목", message: "메시지"),
            //            Announce(id: 23, createBy: Member(name: "saxasc",profileImageUrl: "sacas"), title: "제목", message: "메시지"),
            //            Announce(id: 23, createBy: Member(name: "saxasc",profileImageUrl: "sacas"), title: "제목", message: "메시지"),
            //            Announce(id: 23, createBy: Member(name: "saxasc",profileImageUrl: "sacas"), title: "제목", message: "메시지"),
            //            Announce(id: 23, createBy: Member(name: "saxasc",profileImageUrl: "sacas"), title: "제목", message: "메시지")])
            
            
            
    }
    


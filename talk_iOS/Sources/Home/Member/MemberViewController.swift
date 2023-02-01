//
//  MemberViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/01.
//

import UIKit

class MemberViewController: UIViewController {
    
    static let identifier = "MemberViewController"
    let table =  UITableView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "모임명"
        view.addSubview(upperView)
        upperView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(120)
            $0.height.equalTo(56)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
        upperView.addSubview(upperViewLabel)
        upperView.addSubview(upperViewIcon)
        upperView.addSubview(upperViewArt)
        upperViewLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(23)
        }
        upperViewIcon.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(upperViewLabel.snp.trailing).inset(-5)
        }
        upperViewArt.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        view.addSubview(teamLeaderLabel)
        view.addSubview(teamLeaderBar)
        teamLeaderLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(upperView.snp.bottom).inset(-23)
        }
        teamLeaderBar.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(teamLeaderLabel.snp.bottom).inset(-12)
            $0.height.equalTo(1)
        }
        view.addSubview(profileImage)
        view.addSubview(memberName)
        profileImage.snp.makeConstraints{
            $0.width.height.equalTo(36)
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(teamLeaderBar.snp.bottom).inset(-22)
        }
        memberName.snp.makeConstraints{
            $0.leading.equalTo(profileImage.snp.trailing).inset(-15)
            $0.centerY.equalTo(profileImage.snp.centerY)
        }
        view.addSubview(teamMemberLabel)
        view.addSubview(teamMemberBar)
        teamMemberLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(profileImage.snp.bottom).inset(-53)
        }
        teamMemberBar.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(teamMemberLabel.snp.bottom).inset(-12)
            $0.height.equalTo(1)
        }
        view.addSubview(addTeamMember)
        addTeamMember.snp.makeConstraints{
            $0.trailing.equalTo(teamMemberBar.snp.trailing)
            $0.bottom.equalTo(teamMemberBar.snp.top).inset(-12)
        }
        table.delegate = self
        table.dataSource = self
        layout()
        attribute()
        table.separatorStyle = .none
    }
    
    func layout() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.snp.makeConstraints{
            $0.top.equalTo(teamMemberBar.snp.bottom)
            $0.bottom.equalTo(view.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
        }
    }

    struct memberDataModel{
        var memberName : String
        var memberColor : String
    }
    
    func attribute(){
        table.register(MemberViewControllerTableViewCell.classForCoder()
                       , forCellReuseIdentifier: "cell")
    }
        var sampleData: [memberDataModel] = [
            memberDataModel(memberName: "김희윤", memberColor: "red"),
            memberDataModel(memberName: "박상민", memberColor: "blue"),
            memberDataModel(memberName: "박지수", memberColor: "yellow"),
            memberDataModel(memberName: "경유진", memberColor: "orange"),
            memberDataModel(memberName: "장우석", memberColor: "pink"),
            memberDataModel(memberName: "박시영", memberColor: "red"),
            memberDataModel(memberName: "채은", memberColor: "blue"),
            memberDataModel(memberName: "김혜연", memberColor: "yellow")
        ]

    
    var upperView : UIView = {
        let upperView = UIView()
        upperView.backgroundColor = .white
        upperView.frame = CGRect(x: 0, y: 0, width: 375, height: 56)
        upperView.layer.cornerRadius = 8.0
        upperView.layer.shadowOpacity = 1
        upperView.layer.shadowRadius = 8.0
        upperView.layer.shadowOffset = CGSize(width: 0, height: 0)
        upperView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        upperView.translatesAutoresizingMaskIntoConstraints = false
        return upperView
    }()
    
    var upperViewLabel : UILabel = {
        let upperViewLabel = UILabel()
        upperViewLabel.font = UIFont.boldSystemFont(ofSize: 16)
        upperViewLabel.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        upperViewLabel.text = "멤버"
        return upperViewLabel
    }()
    
    var upperViewIcon: UIImageView = {
        let image = UIImage(named: "btnDown")
        let upperViewIcon = UIImageView(image: image)
        upperViewIcon.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return upperViewIcon
    }()
    
    var upperViewArt : UIImageView = {
        let image = UIImage(named: "upperViewArt")
        let upperViewArt = UIImageView(image: image)
        upperViewArt.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return upperViewArt
    }()
    
    var teamLeaderLabel : UILabel = {
        let teamLeaderLabel = UILabel()
        teamLeaderLabel.font = UIFont.boldSystemFont(ofSize: 20)
        teamLeaderLabel.textColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        teamLeaderLabel.text = "모임장"
        return teamLeaderLabel
    }()
    
    
    var teamLeaderBar : UIView = {
        let teamLeaderBar = UIView()
        teamLeaderBar.frame = CGRect(x: 0, y: 0, width: 358, height: 1)
        teamLeaderBar.layer.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1).cgColor
        return teamLeaderBar
    }()
    
    var profileImage:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        view.layer.cornerRadius = view.frame.height/2
        return view
    }()
    
    var memberName:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.text = "사용자 이름"
        return label
    }()
    
    var teamMemberLabel : UILabel = {
        let teamMemberLabel = UILabel()
        teamMemberLabel.font = UIFont.boldSystemFont(ofSize: 20)
        teamMemberLabel.textColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        teamMemberLabel.text = "모임원"
        return teamMemberLabel
    }()
    
    
    var teamMemberBar : UIView = {
        let teamMemberBar = UIView()
        teamMemberBar.frame = CGRect(x: 0, y: 0, width: 358, height: 1)
        teamMemberBar.layer.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1).cgColor
        return teamMemberBar
    }()
    
    var addTeamMember : UIImageView = {
        let image = UIImage(named: "addTeamMember")
        let upperViewArt = UIImageView(image: image)
        upperViewArt.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return upperViewArt
    }()
    
    
}

extension MemberViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemberViewControllerTableViewCell.identifier, for:indexPath) as? MemberViewControllerTableViewCell else {return UITableViewCell()}
        let rowIndex = indexPath.row
        let member : memberDataModel
        member = self.sampleData[rowIndex]
        // MyView
        cell.contentView.addSubview(cell.myView)
        cell.myView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        cell.myView.addSubview(cell.profileImage)
        cell.profileImage.snp.makeConstraints{
            $0.width.height.equalTo(36)
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalToSuperview().inset(16)
        }
        
        cell.myView.addSubview(cell.memberName)
        cell.memberName.snp.makeConstraints{
            $0.centerY.equalTo(cell.profileImage.snp.centerY)
            $0.leading.equalTo(cell.profileImage.snp.trailing).inset(-15)
        }
        cell.memberName.text = member.memberName
        tableView.rowHeight = 56
        cell.myView.addSubview(cell.memberColor)
        cell.myView.addSubview(cell.memberIcon1)
        cell.myView.addSubview(cell.memberIcon2)
        cell.memberIcon2.snp.makeConstraints{
            $0.centerY.equalTo(cell.profileImage.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        cell.memberIcon1.snp.makeConstraints{
            $0.centerY.equalTo(cell.profileImage.snp.centerY)
            $0.trailing.equalTo(cell.memberIcon2.snp.leading).inset(-15)
        }
        cell.memberColor.snp.makeConstraints{
            $0.centerY.equalTo(cell.profileImage.snp.centerY)
            $0.leading.equalTo(cell.memberName.snp.trailing).inset(-8)
            $0.width.equalTo(53)
            $0.height.equalTo(20)
        }
        
        switch member.memberColor {
        case "red":
            cell.memberColor.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        case "blue":
            cell.memberColor.backgroundColor = UIColor(red: 0.271, green: 0.553, blue: 0.784, alpha: 1)
        case "yellow":
            cell.memberColor.backgroundColor = UIColor(red: 0.976, green: 0.788, blue: 0.286, alpha: 1)
        case "orange":
            cell.memberColor.backgroundColor = UIColor(red: 0.988, green: 0.502, blue: 0.227, alpha: 1)
        case "pink":
            cell.memberColor.backgroundColor = UIColor(red: 0.988, green: 0.447, blue: 0.447, alpha: 1)
            default:
            print("멍멍")
        }
       return cell
    }
        
}



class MemberViewControllerTableViewCell:UITableViewCell{
    static let identifier = "cell"
    let myView = UIView()
    var profileImage:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        view.layer.cornerRadius = view.frame.height/2
        return view
        
    }()
    
    var memberName:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    var memberColor : UIView = {
        let memberColor = UIView()
        memberColor.frame = CGRect(x: 0, y: 0, width: 53, height: 20)
       return memberColor
    }()
    
    
    
    var memberIcon1 : UIImageView = {
        let image = UIImage(named: "memberIcon1")
        let memberIcon1 = UIImageView(image: image)
        memberIcon1.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return memberIcon1
    }()
    
    var memberIcon2 : UIImageView = {
        let image = UIImage(named: "memberIcon2")
        let memberIcon2 = UIImageView(image: image)
        memberIcon2.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return memberIcon2
    }()
    



    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: InviteChattingPartnerTableViewCell.identifier)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

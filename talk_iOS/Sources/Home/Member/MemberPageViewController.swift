
//
//  MemberInformationViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/07.
//

import UIKit

class MemberPageViewController: UIViewController {
    static let identifier = "MemberPageViewController"
    
    var userName : String = ""
    var joined_date : String = ""
    
    struct Role{
        let title:String
        let color:UIColor
    }
    
    var roleData = ["","",""]
    
    var roleColor = [UIColor.black, UIColor.black, UIColor.black]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "btnSetting"),
                                                                 style: UIBarButtonItem.Style.plain, target: self, action: #selector(addButton))
        let userNameLabel = UILabel()
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        userNameLabel.textColor = .TalkRed
        userNameLabel.text = userName
        let roleBox1 = TalkRollBox(title: roleData[0], color: roleColor[0], selected: true)
        let roleBox2 = TalkRollBox(title: roleData[1], color: roleColor[1], selected: true)
        let roleBox3 = TalkRollBox(title: roleData[2], color: roleColor[2], selected: true)
        
        view.addSubview(profileImage)
        profileImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(120)
            $0.height.equalTo(150)
            $0.width.equalTo(150)
        }
        view.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints{
            $0.top.equalTo(profileImage.snp.bottom).inset(-34)
            $0.centerX.equalTo(profileImage.snp.centerX)
        }
        view.addSubview(userInformationView)
        userInformationView.snp.makeConstraints{
            $0.top.equalTo(userNameLabel.snp.bottom).inset(-33)
            $0.leading.equalToSuperview().inset(68)
            $0.trailing.equalToSuperview().inset(68)
            $0.height.equalTo(87)
        }
        userInformationView.addSubview(joinTime)
        joinTime.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        userInformationView.addSubview(joinTimeValue)
        joinTimeValue.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalTo(joinTime.snp.trailing).inset(-17)
        }
        joinTimeValue.text = joined_date
        
    
        userInformationView.addSubview(role)
        role.snp.makeConstraints{
            $0.top.equalTo(joinTime.snp.bottom).inset(-19)
            $0.leading.equalToSuperview()
        }
        userInformationView.addSubview(roleBox1)
        roleBox1.snp.makeConstraints{
            $0.top.equalTo(role.snp.top)
            $0.leading.equalTo(joinTimeValue.snp.leading)
            $0.width.equalTo(60)
            $0.height.equalTo(20)
        }
        if roleBox2.color != .black{
            userInformationView.addSubview(roleBox2)
            roleBox2.snp.makeConstraints{
                $0.top.equalTo(role.snp.top)
                $0.leading.equalTo(roleBox1.snp.trailing).inset(-5)
                $0.width.equalTo(60)
                $0.height.equalTo(20)
            }
        }
        if roleBox3.color != .black{
            userInformationView.addSubview(roleBox3)
            roleBox3.snp.makeConstraints{
                $0.top.equalTo(role.snp.top)
                $0.leading.equalTo(roleBox2.snp.trailing).inset(-5)
                $0.width.equalTo(60)
                $0.height.equalTo(20)
            }
        }
        view.addSubview(memberTaskView)
        memberTaskView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.height.equalTo(92)
            $0.leading.equalToSuperview().inset(119)
            $0.trailing.equalToSuperview().inset(119)
            $0.width.equalTo(152)
            $0.top.equalTo(userInformationView.snp.bottom).inset(-110)
        }
        memberTaskView.addSubview(memberTaskButton1)
        memberTaskButton1.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        memberTaskButton1.memberLayout()
        
        memberTaskView.addSubview(memberTaskButton2)
        memberTaskButton2.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(60)
        }
        memberTaskButton2.memberLayout()
    }
    
    var profileImage:UIImageView = {
        let profileImage = UIImageView()
        profileImage.backgroundColor = .gray
        profileImage.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    
    var userInformationView : UIView = {
        let userInformationView = UIView()
        return userInformationView
    }()
    
    var joinTime : UILabel = {
        let joinTime = UILabel()
        joinTime.font = UIFont.boldSystemFont(ofSize: 12)
        joinTime.textColor = .black
        joinTime.text = "가입 시기"
        return joinTime
    }()
    
    var joinTimeValue : UILabel = {
        let joinTimeValue = UILabel()
        joinTimeValue.font = UIFont.systemFont(ofSize: 12)
        joinTimeValue.textColor = UIColor(red: 0.567, green: 0.557, blue: 0.557, alpha: 1)
        return joinTimeValue
    }()
    
    var role : UILabel = {
        let role = UILabel()
        role.font = UIFont.boldSystemFont(ofSize: 12)
        role.textColor = .black
        role.text = "역할"
        return role
    }()
    
    


    
    @objc fileprivate func addButton(){
        let alert = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
        let title = UIAlertAction(title: "000님을 정말 탈퇴시키겠습니까?", style: .default)
        let out = UIAlertAction(title: "탈퇴", style: .default)
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(title)
        alert.addAction(out)
        alert.addAction(cancle)
        self.present(alert, animated: true)
    }
    
    var memberTaskView : UIView = {
        let memberTaskView = UIView()
        return memberTaskView
    }()
    
    var memberTaskButton1 : MemeberButtonClass = {
        let view = MemeberButtonClass(label: "할 일 부여", imageName: "btnGiveTask")
        return view
    }()
    
    var memberTaskButton2 : MemeberButtonClass = {
        let view = MemeberButtonClass(label: "1:1 대화", imageName: "memberIcon2")
        return view
    }()
    
}

class MemeberButtonClass : UIView{
        
    var imageName : String
    
    var memberButtonBox : UIView = {
        let view = UIView()
       return view
    }()
    
    var memberTaskButtonView : UIView = {
        let memberTaskButtonView = UIView()
        memberTaskButtonView.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.2)
        memberTaskButtonView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        memberTaskButtonView.layer.cornerRadius = memberTaskButtonView.frame.height/2
        return memberTaskButtonView
    }()
    
    let memberButtonIcon = UIImageView()

    
    var label : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black

        return label
    }()
    
    init(label: String, imageName : String) {
        self.label.text = label
        self.imageName = imageName
        memberButtonIcon.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        memberButtonIcon.tintColor = .black

        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func memberLayout(){
        self.addSubview(memberButtonBox)
        memberButtonBox.snp.makeConstraints{
            $0.width.equalTo(60)
            $0.height.equalTo(92)
        }
        memberButtonBox.addSubview(memberTaskButtonView)
        memberTaskButtonView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        memberTaskButtonView.addSubview(memberButtonIcon)
        memberButtonIcon.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        memberButtonBox.addSubview(label)
        label.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(memberTaskButtonView)
        }
    }
}

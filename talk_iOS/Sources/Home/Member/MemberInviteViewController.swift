//
//  MemberInviteViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/10.
//

import UIKit

class MemberInviteViewController: UIViewController {
    static let identifier = "MemberInviteViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "초대코드"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        // Do any additional setup after loading the view.
        view.addSubview(inviteBox)
        inviteBox.snp.makeConstraints{
            $0.top.equalToSuperview().inset(132)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(475)
        }
    }
    
    var inviteBox:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1).cgColor
        let image = UIImage(named: "inviteMemberExampleImage")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        imageView.layer.masksToBounds = true

        imageView.backgroundColor = .white
        view.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(350)
        }
        let groupNameLabel = UILabel()
        groupNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        groupNameLabel.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        groupNameLabel.text = "모임명"
        view.addSubview(groupNameLabel)
        groupNameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(31)
            $0.top.equalTo(imageView.snp.bottom).inset(-26.6)
        }
        let inviteCodeLabel = UILabel()
        inviteCodeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        inviteCodeLabel.textColor = .white
        inviteCodeLabel.text = "AX35T"
        view.addSubview(inviteCodeLabel)
        inviteCodeLabel.snp.makeConstraints{
            $0.leading.equalTo(groupNameLabel)
            $0.top.equalTo(groupNameLabel.snp.bottom).inset(-20)
        }
        return view
        
        
    }()

}

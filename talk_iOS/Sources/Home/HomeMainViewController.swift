//
//  MainTabBarController.swift
//  talk_iOS
//
//  Created by User on 2023/01/06.
//

import UIKit
import SwiftUI
import SnapKit

class HomeMainViewController : UIViewController {
    static let identifier = "HomeMainViewController"
    
    let btn = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNaviBar()
        self.view.addSubview(btn)
        btn.backgroundColor = .black
        btn.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBtn)))
        view.addSubview(tapToChattingButton)
        view.addSubview(tapToMemberButton)
        tapToChattingButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(100)
        }
        tapToMemberButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(500)
        }
        
    }
    
    private func setUpNaviBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.red]
        self.navigationController?.navigationBar.tintColor = .black
        let backBarButton = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
    }
    
    @objc private func tapBtn(){
        self.pushViewController(target: self, storyBoardName: "InviteChattingPartner", identifier: InviteChattingPartnerViewController.identifier)
    }
    func pushViewController(target:UIViewController, storyBoardName:String, identifier:String){
        print("여기")
       let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
       let afterVC = storyBoard.instantiateViewController(withIdentifier: identifier)
       afterVC.modalPresentationStyle = .fullScreen
       afterVC.modalTransitionStyle = .crossDissolve
       target.navigationController?.pushViewController(afterVC, animated: true)
   }

    

    
    var tapToChattingButton:UIButton = {
        let testButton = UIButton()
        testButton.setTitle("채팅으로 임시 버튼!", for: .normal)
        testButton.frame = CGRect(x: 0, y: 0, width: 375, height: 140)
        testButton.backgroundColor = .black
        testButton.translatesAutoresizingMaskIntoConstraints = false
        testButton.layer.cornerRadius = 8
        testButton.addTarget(self, action: #selector(btnSend1), for: .touchUpInside)
        return testButton
    }()
    
    
    var tapToMemberButton:UIButton = {
        let testButton = UIButton()
        testButton.setTitle("멤버로 임시 버튼!", for: .normal)
        testButton.frame = CGRect(x: 0, y: 0, width: 375, height: 140)
        testButton.backgroundColor = .black
        testButton.translatesAutoresizingMaskIntoConstraints = false
        testButton.layer.cornerRadius = 8
        testButton.addTarget(self, action: #selector(btnSend2), for: .touchUpInside)
        return testButton
    }()

    @objc func btnSend1(){
        let chattingTableVC = UIStoryboard.init(name: "ChattingTable", bundle: nil)
        guard let viewController = chattingTableVC.instantiateViewController(identifier: "ChattingTableViewController") as? ChattingTableViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func btnSend2(){
        let memberViewVC = UIStoryboard.init(name: "Member", bundle: nil)
        guard let viewController = memberViewVC.instantiateViewController(identifier: "MemberViewController") as? MemberViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
        
}

//
//  MainTabBarController.swift
//  talk_iOS
//
//  Created by User on 2023/01/06.
//

import UIKit
import SwiftUI
import SnapKit
import CoreData

class HomeMainViewController:UIViewController {
    static let identifier = "HomeMainViewController"
    
//    var container:NSPersistentContainer!
    let btn = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNaviBar()
//        guard container != nil else {
//            fatalError("This view needs a persistent container.")
//        }
        self.view.addSubview(btn)
        btn.backgroundColor = .black
        btn.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBtn)))
        tapToChattingButton()
        
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
       let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
       let afterVC = storyBoard.instantiateViewController(withIdentifier: identifier)
       afterVC.modalPresentationStyle = .fullScreen
       afterVC.modalTransitionStyle = .crossDissolve
       target.navigationController?.pushViewController(afterVC, animated: true)
   }
    

    
    func tapToChattingButton() {
        let testButton = UIButton()
        testButton.setTitle("채팅으로 임시 버튼!", for: .normal)
        testButton.frame = CGRect(x: 0, y: 0, width: 375, height: 140)
        testButton.backgroundColor = .black

        testButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(testButton)
        
        testButton.snp.makeConstraints{
            $0.top.equalTo(btn.snp.bottom).inset(-2)

        }

        testButton.layer.cornerRadius = 8

        testButton.addTarget(self, action: #selector(self.btnSend), for: .touchUpInside)
        
//        ChattingTableViewController

    }

    @IBAction func btnSend(_ sender: UIButton) {
        let chattingTableVC = UIStoryboard.init(name: "ChattingTable", bundle: nil)
        guard let viewController = chattingTableVC.instantiateViewController(identifier: "ChattingTableViewController") as? ChattingTableViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
//        self.present(nextVC, animated: true, completion: nil)
    }

   

}



//
//  MainTabBarController.swift
//  talk_iOS
//
//  Created by User on 2023/01/06.
//

import UIKit
import SwiftUI
import SnapKit

class HomeMainViewController:UIViewController {
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
    

   

}



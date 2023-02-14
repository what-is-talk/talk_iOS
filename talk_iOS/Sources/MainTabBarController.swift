//
//  MainTabBarController.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/13.
//

import UIKit
import CoreData
import SnapKit

class MainTabBarController: UITabBarController {
    static let identifier = "MainTabBarController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.tintColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(a)))
    }

    @objc func a(){
        print("tabbar 터치")
    }

    

}

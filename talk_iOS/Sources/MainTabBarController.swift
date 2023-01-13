//
//  MainTabBarController.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/13.
//

import UIKit

class MainTabBarController: UITabBarController {
    static let identifier = "MainTabBarController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = .black
    }
    

    

}

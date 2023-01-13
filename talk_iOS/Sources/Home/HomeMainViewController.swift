//
//  MainTabBarController.swift
//  talk_iOS
//
//  Created by User on 2023/01/06.
//

import UIKit
import SwiftUI
import SnapKit

class HomeMainViewController: TalkViewController {
    static let identifier = "HomeMainViewController"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @objc private func goPreviousScene(){
        self.presentingViewController?.dismiss(animated: true)
    }
    

   

}



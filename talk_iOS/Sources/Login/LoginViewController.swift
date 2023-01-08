//
//  LoginViewController.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/05.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func tapKakaoLoginButton(_ sender: UIButton) {
        loginWithKakaoTalk(launchMethod: <#T##LaunchMethod?#>, channelPublicIds: <#T##[String]?#>, serviceTerms: <#T##[String]?#>, nonce: <#T##String?#>, completion: <#T##(OAuthToken?, Error?) -> Void#>)
    }
    
}

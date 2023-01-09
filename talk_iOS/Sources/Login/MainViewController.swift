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

class MainViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        kakaoLogin()
    }
    
    func kakaoLogin(){
        if(UserApi.isKakaoTalkLoginAvailable()){
            UserApi.shared.loginWithKakaoTalk{(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    print(oauthToken ?? "")
                }
            }
            UserApi.shared.me{(user, error) in
                if let error = error {
                        print(error)
                    }
                else{
                    print("me 진입")
                    guard let user = user else {return}
                    print(user.kakaoAccount?.profile?.nickname ?? "없음")
                }
            }
        }
    }


    
}

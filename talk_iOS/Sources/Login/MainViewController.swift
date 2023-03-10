//
//  MainViewController.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/11.
//

// 중앙의 로고 이미지 크기가 원래 315x315 이지만
// 작은 화면에는 맞지 않아서 270x270 임시로 설정했습니다

import UIKit
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import CoreData
import Alamofire

//struct NoticeData{
//    let
//}

class MainViewController: UIViewController {
    static let identifier = "MainViewController"
    var container:NSPersistentContainer!
    var noticeEntity:NSEntityDescription?
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    let subTitleLabel = UILabel()
    let mainTitleLabel = UILabel()
    let logoImage = UIImageView(image: .init(named: "LoginImage"))
    let appleLoginButton = UIView()
    let kakaoLoginButton = UIView()
    let naverLoginButton = UIView()
    
    let kakaoLogo = UIImageView()
    let naverLogo = UIImageView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTest()
        configureView()
    }
    
    private func noticeTest(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        self.noticeEntity = NSEntityDescription.entity(forEntityName: "Notification", in: self.container.viewContext)
        
    }
    
    private func configureView(){
        
        // subTitleLabel
        subTitleLabel.text = "모임에 혁신을 더하다"
        subTitleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        self.view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.centerX.equalTo(self.view.snp.centerX)
        }
        
        // mainTitleLabel
        mainTitleLabel.text = "모임톡"
        mainTitleLabel.font = .systemFont(ofSize: 36, weight: .bold)
//        self.mainTitleLabel.font = UIFont(name: "SFPro-Regular", size: 36)
        mainTitleLabel.textColor = .init(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        view.addSubview(mainTitleLabel)
        mainTitleLabel.snp.makeConstraints{
            $0.top.equalTo(subTitleLabel.snp.bottom).inset(-10)
            $0.centerX.equalTo(self.view.snp.centerX)
        }
        
        // logoImage
        // iphone 14 pro screen height -> 852
        // iphone se 2 -> 667
        let screenHeight = UIScreen.main.bounds.size.height
        let imageHeight = screenHeight > 800 ? 270 : screenHeight > 700 ? 250 : 200
        self.view.addSubview(self.logoImage)
        logoImage.snp.makeConstraints{
            $0.width.height.equalTo(imageHeight)
            $0.top.equalTo(mainTitleLabel.snp.bottom).inset(-50)
            $0.centerX.equalTo(self.view)
        }
        
        // Login Buttons
        [appleLoginButton, kakaoLoginButton, naverLoginButton].forEach{
            $0.layer.cornerRadius = 12
            self.view.addSubview($0)
            $0.snp.makeConstraints{
                $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
                $0.height.equalTo(60)
            }
        }
        
        let loginButtonLabelColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        
        // appleLoginButton
        appleLoginButton.backgroundColor = .white
        appleLoginButton.layer.borderWidth = 1
        appleLoginButton.layer.borderColor = UIColor(.black).cgColor
        appleLoginButton.snp.makeConstraints{
            $0.top.equalTo(self.logoImage.snp.bottom).inset(-28)
        }
        let appleLogo = UIImageView(image: .init(named: "appleLoginLogo"))
        appleLoginButton.addSubview(appleLogo)
        appleLogo.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(22)
            $0.centerY.equalToSuperview()
        }
        let appleLoginLabel = UILabel()
//        appleLoginLabel.text = "Apple로 계속하기"
//        appleLoginLabel.text = "이거 누르면 홈으로 넘어가여"
        appleLoginLabel.text = "Apple로 계속하기"
        appleLoginLabel.font = .systemFont(ofSize: 16, weight: .regular)
        appleLoginLabel.textColor = loginButtonLabelColor
        appleLoginButton.addSubview(appleLoginLabel)
        appleLoginLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        appleLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAppleLoginButton)))
        
        
        // kakaoLoginButton
        kakaoLoginButton.backgroundColor = UIColor(red: 0.996, green: 0.898, blue: 0, alpha: 1)
        kakaoLoginButton.snp.makeConstraints{
            $0.top.equalTo(appleLoginButton.snp.bottom).inset(-20)
        }
        let kakaoLogo = UIImageView(image: .init(named: "kakaoLoginLogo"))
        kakaoLoginButton.addSubview(kakaoLogo)
        kakaoLogo.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(21)
            $0.centerY.equalToSuperview()
        }
        let kakaoLoginLabel = UILabel()
        kakaoLoginLabel.text = "카카오로 계속하기"
        kakaoLoginLabel.font = .systemFont(ofSize: 16, weight: .regular)
        kakaoLoginLabel.textColor = loginButtonLabelColor
        kakaoLoginButton.addSubview(kakaoLoginLabel)
        kakaoLoginLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        kakaoLoginButton.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapKakaoLoginButton)))
        
        
        // naverLoginButton
        naverLoginButton.backgroundColor = UIColor(red: 0.012, green: 0.78, blue: 0.353, alpha: 1)
        naverLoginButton.snp.makeConstraints{
            $0.top.equalTo(kakaoLoginButton.snp.bottom).inset(-20)
        }
        let naverLogo = UIImageView(image: .init(named: "naverLoginLogo"))
        naverLoginButton.addSubview(naverLogo)
        naverLogo.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        let naverLoginLabel = UILabel()
        naverLoginLabel.text = "네이버로 계속하기"
        naverLoginLabel.font = .systemFont(ofSize: 16, weight: .regular)
        naverLoginLabel.textColor = loginButtonLabelColor
        naverLoginButton.addSubview(naverLoginLabel)
        naverLoginLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        naverLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapNaverLoginButton)))
    }

    @objc private func tapAppleLoginButton(sender:UITapGestureRecognizer){
        goNextScene( target: self, storyBoardName: "HomeNoGroup", identifier: HomeNoGroupViewController.identifier)

//        let navigationController = UINavigationController(rootViewController: self)
//        present(navigationController, animated: true)

        let nextVC = JoinViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc private func tapKakaoLoginButton(sender:UITapGestureRecognizer){
        guard UserApi.isKakaoTalkLoginAvailable() else{
            self.alertLoginIsUnavailable(title: "Failed", msg: "카카오톡을 실행할 수 없음")
            return
        }
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
                
            }
        }
        
    }
    
    @objc private func tapNaverLoginButton(sender:UITapGestureRecognizer){
        print("naver")
    }
    
    private func alertLoginIsUnavailable(title:String, msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
  
    
    private func fetchLoginRequest(id:String){
        
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        let params = ["id":id]
        let url = ""
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
            .responseData{ response in
                switch response.result{
                case .success(let data):
                    // decode
                    do{
                        let result = try JSONDecoder().decode(UserData.self, from: data)
                        // 유저 로그인 처리
                    } catch{
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
   

}

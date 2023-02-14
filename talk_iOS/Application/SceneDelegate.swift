//
//  SceneDelegate.swift
//  talk_iOS
//
//  Created by User on 2023/01/03.
//

import UIKit
import KakaoSDKAuth
import Alamofire

let dummyUser:UserData = .init(id: 1, email: "a00366@naver.com", name: "김희윤", loggedFrom: "kakao", token: "X32FT5", personalColor: "000000", profileImage: "", currentMeetingId: 1)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private struct Group:Codable{
        let id:Int32
        let name:String
        let imageUrl:String
        let memberCount:Int16
        
        enum CodingKeys:String,CodingKey{
            case id
            case name
            case imageUrl = "image_url"
            case memberCount = "member_count"
        }
    }
    
    private struct ResponseData:Codable{
        let authProvider:String
        let token:String
        let userId:Int32
        let userName:String
        let groupList:[Group]
      
        enum CodingKeys : String, CodingKey{
            case authProvider = "auth_provider"
            case token
            case userId = "user_id"
            case userName = "user_name"
            case groupList = "group_list"
        }
    }

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
   
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        // 유저 jwt 토큰 검증
        let client = CoreDataClient()
        try? client.createOrUpdateUser(dummyUser)
        
        guard var user = client.getUser() else { return moveToLoginPage() }
        // 서버에서 검증
        fetchVerifyUser(user: user, completionHandler: { result in
            switch result{
            case let .success(result):
                user.token = result.token // 새로운 토큰 발급
                try? client.createOrUpdateUser(user)
                
                
                // 서버에서 유저가 인증되면 그룹 정보도 한번에 준다
                // 그 정보를 코어데이터에 바로 최신화한다.
                // 홈에 들어가면 코어데이터에서 바로 꺼내 사용한다.
                // 앱 진입할 때의 API를 따로 만들어서 구현하는게 좋아보임
                let meetings = client.getMeetings()
                // 받아온 group_list에 원래있던 group의 정보를 더해서 CoreData에 저장
                let newMeetings = result.groupList.map{group in
                    if var sameMeeting = meetings.filter({$0.id == group.id}).first{
                        // CoreData에 같은 meeting이 있으면 더해서 ㄱㄱ
                        sameMeeting.name = group.name
                        sameMeeting.profileImage = group.imageUrl
                        sameMeeting.memberCount = group.memberCount
                        return sameMeeting
                    } else{
                        // 없으면 새로 MeetingData 생성해서 나머지는 빈값으로 ㄱㄱ
                        return MeetingData(id: group.id, inviteCode: "", name: group.name,profileImage:group.imageUrl, joinedDate:nil, memberCount: group.memberCount)
                    }
                }
                do{
                    try client.createOrUpdateMeeting(newMeetings)
                } catch let error{
                    print(error)
                }
                // 데이터를 한번 더 가져와서 확인 (이 데이터를 신뢰함 -> Home을 로드할 때는 서버에서 데이터를 가져오지 않고 CoreData를 사용할 거임)
                let updateMeetings = client.getMeetings()
                
                if updateMeetings.count > 0{
                    // 홈으로 보냄
                    let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(withIdentifier: MainTabBarController.identifier)
                    self.window?.rootViewController = mainTabBarController
                } else{
                    let storyboard = UIStoryboard(name: "HomeNoGroup", bundle: nil)
                    let homeNoGroupVC = storyboard.instantiateViewController(withIdentifier: HomeNoGroupViewController.identifier) as! HomeNoGroupViewController
                    homeNoGroupVC.user = user
                    self.window?.rootViewController = homeNoGroupVC
                }
            case let .failure(error):
                print(error)
                self.moveToLoginPage()
            }
        })
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        debugPrint("scene delegate 함수")
        if let url = URLContexts.first?.url{
            if AuthApi.isKakaoTalkLoginUrl(url){
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    func changeRootVC(_ vc:UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        window.rootViewController = vc // 전환
        
        UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
    func moveToLoginPage() -> Void{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: MainViewController.identifier)
        self.window?.rootViewController = loginVC
    }
    
    private func fetchVerifyUser(user:UserData, completionHandler:@escaping (Result<ResponseData,Error>) -> Void){
//        let url = "https://what-is-talk-test.vercel.app/api/verify"
        let url = "https://what-is-talk-test.vercel.app/api/verify"
        let parameters:[String:Any] = [
            "userId":user.id,
            "token":user.token
        ]
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .responseData(completionHandler: {response in
                switch response.result{
                case let .success(data):
                    do{
                        let result = try JSONDecoder().decode(ResponseData.self, from: data)
                        completionHandler(.success(result))
                        
                    } catch{
                        completionHandler(.failure(error))
                    }
                // 실패하면 원래대로 로그인 화면
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            }
        )
    }
    
}


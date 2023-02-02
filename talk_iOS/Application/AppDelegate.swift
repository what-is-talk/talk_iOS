//
//  AppDelegate.swift
//  talk_iOS
//
//  Created by User on 2023/01/03.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // 카카오톡 초기화
        debugPrint("카카오톡 초기화")
        KakaoSDK.initSDK(appKey: "07992e426111200c0ab521541d0392f6")
        
        // CoreData
//        if let rootVC = window?.rootViewController as? MainViewController {
//            rootVC.container = persistentContainer
//        }
        
        
        
//        if let rootVC = window?.rootViewController as? HomeMainViewController{
//            rootVC.container = persistentContainer
//            print("CoreData 설정 완료")
//        }
//        let vc = HomeMainViewController()
//        vc.container = persistentContainer
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
        
    }
    
    // MARK: Core Data Stck
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "DataModel")
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Unable to load persistent stores: \(error)")
                }
            }
            return container
        }()
    
}


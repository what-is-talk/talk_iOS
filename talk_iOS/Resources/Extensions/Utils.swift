//
//  Utils.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/31.
//  공통 함수 정의 파일

import UIKit

// NavigationController와 관계없이 바로 특정 StoryBoard로 넘어가게 하는 함수
// 사용법
// goNextScene (storyBoardName:스토리보드 파일명, identifier:스토리보드에 연결되어 있는 VC 이름, target:VC.self)
func goNextScene(target:UIViewController, storyBoardName:String, identifier:String){
    let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
    let afterVC = storyBoard.instantiateViewController(withIdentifier: identifier)
    afterVC.modalPresentationStyle = .fullScreen
    afterVC.modalTransitionStyle = .crossDissolve
    target.present(afterVC, animated: true)
}


// NavigationController 에서 push 해서 넘어가는 함수
// 사용법
// pushViewController(target:VC.self, storyBoardName:스토리보드 파일명, identifier:스토리보드에 연결되어 있는 VC 이름)
func pushViewController(target:UIViewController, storyBoardName:String, identifier:String){
    print("여기")
   let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
   let afterVC = storyBoard.instantiateViewController(withIdentifier: identifier)
   afterVC.modalPresentationStyle = .fullScreen
   afterVC.modalTransitionStyle = .crossDissolve
   target.navigationController?.pushViewController(afterVC, animated: true)
}

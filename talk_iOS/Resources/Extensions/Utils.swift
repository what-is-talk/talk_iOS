//
//  Utils.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/31.
//  공통 함수 정의 파일

import UIKit

func goNextScene(storyBoardName:String, identifier:String, target:UIViewController){
    let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
    let afterVC = storyBoard.instantiateViewController(withIdentifier: identifier)
    afterVC.modalPresentationStyle = .fullScreen
    afterVC.modalTransitionStyle = .crossDissolve
    target.present(afterVC, animated: true)
}

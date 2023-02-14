//
//  Utils.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/31.
//  공통 함수 정의 파일

import UIKit


/**
NavigationController와 관계없이 바로 특정 StoryBoard로 넘어가게 하는 함수
- Parameters:
  - target: VC.self
  - storyBoardName: 스토리보드 파일명
  - identifier: 스토리보드에 연결되어 있는 VC 이름
*/
func goNextScene(target:UIViewController, storyBoardName:String, identifier:String){
    let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
    let afterVC = storyBoard.instantiateViewController(withIdentifier: identifier)
    afterVC.modalPresentationStyle = .fullScreen
    afterVC.modalTransitionStyle = .crossDissolve
    target.present(afterVC, animated: true)
}

/**
NavigationController 에서 push 해서 넘어가는 함수
- Parameters:
  - target: VC.self
  - storyBoardName: 스토리보드 파일명
  - identifier: 스토리보드에 연결되어 있는 VC 이름
*/
func pushViewController(target:UIViewController, storyBoardName:String, identifier:String){
   let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
   let afterVC = storyBoard.instantiateViewController(withIdentifier: identifier)
   afterVC.modalPresentationStyle = .fullScreen
   afterVC.modalTransitionStyle = .crossDissolve
   target.navigationController?.pushViewController(afterVC, animated: true)
}



/// 비동기적으로 데이터를 Fetch 하는 함수
/// 데이터를 받아온 뒤 completion 함수는 main thread에 푸쉬한다.
///
/// - Parameters:
///   - fetch: error 나거나 `T` 타입의 데이터를 반환하는 함수
///   - completion: 반환된 `T` 타입으로 화면 UI를 업데이트하는 함수
func fetchData<T>(fetch: @escaping () throws -> T, completion: @escaping (Result<T, Error>) -> Void) {
    DispatchQueue.global().async {
        do {
            let result = try fetch()
            DispatchQueue.main.async {
                completion(.success(result))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}





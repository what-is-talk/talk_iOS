//
//  SlideInPresentationManager.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/02/28.
//

import Foundation
import UIKit

// 프로토콜을 준수하기 위해선 해당 클래스가 NSObjectProtocol을 준수해야 하기 때문에 NSObject와
// UIViewControllerTransitioningDelegate를 준수한다.
class SlideInPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
        // 뷰의 사이즈를 지정하고 present와 dismiss할 때 어떤 걸 처리할 지에 대한 함수
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SlideInPresentationController(presentedViewController: presented, presenting: presenting)
    }
    // present할 때 어떤 애니메이션을 적용할 지에 대한 함수
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(isPresenting: true)
    }
    // dismiss할 때 어떤 애니메이션을 적용할 지에 대한 함수
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(isPresenting: false)
    }
}

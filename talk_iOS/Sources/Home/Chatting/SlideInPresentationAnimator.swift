//
//  SlideInPresentationAnimator.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/02/28.
//

import Foundation
import UIKit

class SlideInPresentationAnimator: NSObject {

    var isPresenting: Bool

    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()

    }
}

extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
    // 얼마나 애니메이션이 지속되는지
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
/*
UIViewControllerContextTransitioning는 두 ViewController 사이에서 일어나는 Transition
Animation에 대한 정보를 갖고 있는 프로토콜

Transition에 포함된 ViewController와 View에 대한 정보를 갖고 있다

*/
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // UITransitionContextViewControllerKey presented (이미 존재한 VC)가 .to
                // 새로운 VC가 .from
                let key: UITransitionContextViewControllerKey = isPresenting ? .to : .from

        guard let controller = transitionContext.viewController(forKey: key) else { return }

        transitionContext.containerView.addSubview(controller.view)

                // 트랜지션이 끝났을 때의 frame을 반환한다
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.x = transitionContext.containerView.frame.size.width


        let initialFrame = isPresenting ? dismissedFrame : presentedFrame
        let finalFrame = isPresenting ? presentedFrame : dismissedFrame

         let animationDuration = transitionDuration(using: transitionContext)
         controller.view.frame = initialFrame
         UIView.animate(
           withDuration: animationDuration,
           animations: {
            controller.view.frame = finalFrame
         }, completion: { finished in
           if !self.isPresenting {
             controller.view.removeFromSuperview()
           }
                // Transition 애니메이션을 커스텀 할 때 completeTransition(_:) 메서드를 호출해야 UIKit이 애니메이션이 끝났다고 인지한다.
           transitionContext.completeTransition(finished)
         })
    }
}

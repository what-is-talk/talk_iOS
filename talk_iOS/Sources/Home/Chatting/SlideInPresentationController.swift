//
//  SlideInPresentationController.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/02/28.
//

import Foundation
import UIKit

class SlideInPresentationController: UIPresentationController {

        // 뒷 배경을 어둡게 처리하기 위한 뷰
        // 뒷 배경을 터치하면 dismiss 되도록 처리
    let blurEffectView: UIVisualEffectView?
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView?.isUserInteractionEnabled = true
        self.blurEffectView?.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc
    func dismissController(gesture: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }

    /*
        presentation이 실제로 일어나는 뷰를 containerView라고 한다 presented ViewController
        의 View의 ancestor은 항상 containerView이고 뷰의 전환이 일어나면 presenting ViewController
        의 View의 ancestor도 containerView가 된다.

        */
    override func presentationTransitionWillBegin() {
        guard let blurView = blurEffectView,
              let containerBound = containerView?.bounds else {
            return
        }
        containerView?.addSubview(blurView)
        blurView.frame = containerBound

/*
현재 진행중인 transition이 있으면 해당 transitionCoordinator를 반환하고 없으면 nil을 반환한다.

transitionCoordinator를 사용해서 transition과 연관된 작업을 수행할 수 있지만 animator과 작업이 분리되어야 한다.
animator에선 새로운 ViewController의 컨텐츠를 띄우는 것에 대한 애니메이션을 진행하기 때문에 그 외의 애니메이션 작업이 필요할 때
transitionCoordinator를 사용한다.
*/

        guard let coordinator = presentedViewController.transitionCoordinator else {
            blurView.alpha = 0.7
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            blurView.alpha = 0.7
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let blurView = blurEffectView else {
            return
        }

        guard let coordinator = presentedViewController.transitionCoordinator else {
            blurView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            blurView.alpha = 0.0
        })
    }


    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        // parentSize로 바꿔도 될듯
        return CGSize(width: (UIScreen.main.bounds.width)*4 / 5, height: UIScreen.main.bounds.height)
    }

        // 모달의 frame을 위한 변수
    override var frameOfPresentedViewInContainerView: CGRect {
        if let containerSize = containerView?.bounds.size {
            var frame: CGRect = .zero
            frame.size = size(forChildContentContainer: presentedViewController,
                              withParentContainerSize: containerSize)
            frame.origin = CGPoint(x: UIScreen.main.bounds.width / 5,
                                   y: 0)

            return frame
        }
        return CGRect()
    }
}

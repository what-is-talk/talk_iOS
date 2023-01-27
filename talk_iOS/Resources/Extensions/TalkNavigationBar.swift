//
//  TalkNavigationBar.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/13.
//  이거 쓰지 마세요

import UIKit
import SnapKit


class TalkNavigationBar: UIView {

    let naviView = UIView()
    
    private var leftBtns = [UIButton]()
    private var rightBtns = [UIButton]()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        return label
    }()
    
    let subtitleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        return label
    }()
    
    let height:Int = 45
    
    enum BtnType:String{
        case back = "btnBack"
        case close = "btnClose"
    }

    struct NaviButton{
        let btnType:BtnType
        let gestureReconizer:UIGestureRecognizer
        
//        init?(btnType: BtnType, target:Any?) {
//            switch btnType{
//            case .back:
//                self.btnType = btnType
//                self.gestureReconizer = .init(target: target, action: <#T##Selector?#>)
//            default:
//                return nil
//            }
//
//        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpNavBar(title: false, subTitle: false)
    }
    init(title:String){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        titleLabel.text = title
        setUpNavBar(title: true, subTitle: false)
        
        
    }
    init(title:String, subTitle:String){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.titleLabel.text = title
        self.subtitleLabel.text = subTitle
        self.setUpNavBar(title: true, subTitle: true)
    }
    
    private func setUpNavBar(title:Bool, subTitle:Bool){
        naviView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.height)
        }
        if title && !subTitle{
            naviView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints{
                $0.centerX.centerY.equalToSuperview()
            }
        } else if title && subTitle{
            naviView.addSubview(titleLabel)
            naviView.addSubview(subtitleLabel)
//            titleLabel
        }
    }
    
    func addLeftButton(_ btnType:BtnType){
        let btn = UIButton()
        btn.setImage(UIImage(named: btnType.rawValue), for: .normal)
        self.leftBtns.append(btn)
    }
    
    func addRightButton(_ btnType:BtnType){
        let btn = UIButton()
        btn.setImage(UIImage(named: btnType.rawValue), for: .normal)
        self.rightBtns.append(btn)
    }
    
    @objc static func popViewController(target:UIViewController){
        target.navigationController?.popViewController(animated: true)
    }
    
    @objc static func pushViewController(target:UIViewController, storyBoardName:String, identifier:String){
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let afterVC = storyBoard.instantiateViewController(withIdentifier: identifier)
        afterVC.modalPresentationStyle = .fullScreen
        afterVC.modalTransitionStyle = .crossDissolve
        target.navigationController?.pushViewController(afterVC, animated: true)
    }
    
    @objc static func pushViewController(target:UIViewController, afterVC:UIViewController){
        afterVC.modalPresentationStyle = .fullScreen
        afterVC.modalTransitionStyle = .crossDissolve
        target.navigationController?.pushViewController(afterVC, animated: true)
    }
    
    @objc static func goPreviousScene(target:UIViewController){
        target.presentingViewController?.dismiss(animated: true)
    }
    
    @objc static func goNextScene(target:UIViewController, storyBoardName:String, identifier:String){
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let afterVC = storyBoard.instantiateViewController(withIdentifier: identifier)
        afterVC.modalPresentationStyle = .fullScreen
        afterVC.modalTransitionStyle = .crossDissolve
        target.present(afterVC, animated: true)
    }
    
    @objc static func goNextScene(target:UIViewController, afterVC:UIViewController){
        afterVC.modalPresentationStyle = .fullScreen
        afterVC.modalTransitionStyle = .crossDissolve
        target.present(afterVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}



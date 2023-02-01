//
//  HomeNoGroupViewController.swift
//  talk_iOS
//
//  Created by User on 2023/01/31.
//

import UIKit
import SnapKit

class HomeNoGroupViewController: UIViewController {
    static let identifier = "HomeNoGroupViewController"
    
    let label:UILabel = {
        let l = UILabel()
        l.text = "아직 가입 중인 모임이 없어요"
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        return l
    }()
    
    let mainImage =  UIImageView(image: .init(named: "NoGroupImage"))
    
    let joinBtn:UIView = {
        let btn = UIView()
        btn.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        btn.layer.cornerRadius = 12
        
        
        let label = UILabel()
        label.text = "모임 가입하기"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        btn.addSubview(label)
        label.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
        }
        return btn
    }()
    
    let createBtn:UIView = {
        let btn = UIView()
        btn.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        btn.layer.borderColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1).cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 12
        
        let label = UILabel()
        label.text = "새로운 모임 생성하기"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        btn.addSubview(label)
        label.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
        }
        return btn
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
    }
    
    private func configureView(){
        
        // label
        self.view.addSubview(label)
        label.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(100)
            make.centerX.equalToSuperview()
        }
        
        // mainImage
        self.view.addSubview(mainImage)
        mainImage.snp.makeConstraints{ make in
            make.width.height.equalTo(300)
            make.top.equalTo(label.snp.bottom).inset(-78)
            make.centerX.equalToSuperview()
        }
        
        // joinBtn
        self.view.addSubview(joinBtn)
        joinBtn.snp.makeConstraints{ make in
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(26)
        }
        
        joinBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapJoinBtn))
        )
        
        // createBtn
        self.view.addSubview(createBtn)
        createBtn.snp.makeConstraints{ make in
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(joinBtn.snp.bottom).inset(-20)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(26)
        }
        
    }
    
    @objc private func tapJoinBtn(sender:UITapGestureRecognizer){
        print("클릭")
        goNextScene(storyBoardName: "HomeMain", identifier: HomeMainViewController.identifier, target: self)
    }
 

}

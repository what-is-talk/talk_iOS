//
//  RollBox.swift
//  talk_iOS
//
//  Created by User on 2023/01/14.
//

import UIKit
import SnapKit



// select 되었을 때 색 반전 함수
// width, height (CGSize) 정의 함수/init (기본 60 20)
// 안에 들어갈 글자 (init)
class TalkRollBox: UIView {
    
    let title:String

    let label:UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .bold)
        return l
    }()
    
    var selected:Bool{
        didSet{
            self.setColor()
        }
    }
    let color:UIColor
    
   
    
    init(title:String, color:UIColor, selected:Bool = false){
        self.title = title
        self.label.text = title
        self.selected = selected
        self.color = color
        super.init(frame: .init(x: 0, y: 0, width: 0, height: 0))
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.addSubview(label)
        label.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        // 프로퍼티 1차 초기화에는 didSet에서 self.키워드 작동하지 않으므로 처음만 직접 선언해줌
        self.setColor()
    }
    
    // Selected 상태면 해제하고
    // Unselected 상태면 Select
    func toggleSelect(){
        self.selected = !self.selected
    }
    
    func select(){
        self.selected = true
        self.selected = true
    }
    
    func unSelect(){
        self.selected = false
    }
    
    // selected 대로 배경과 글자색을 바꿔주는 함수
    private func setColor(){
        if self.selected{
            self.backgroundColor = self.color
            self.label.textColor = .white
        } else{
            self.backgroundColor = .white
            self.label.textColor = self.color
        }
    }
    
    
    required init?(coder: NSCoder) {
        self.title = ""
        self.selected = false
        self.color = .red
        super.init(coder: coder)
    }
}



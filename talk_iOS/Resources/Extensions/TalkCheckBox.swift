//
//  TalkCheckBox.swift
//  talk_iOS
//
//  Created by User on 2023/01/16.
//

import UIKit
import SnapKit

class TalkCheckBox:UIView{
    private let checkImage:UIImageView = .init(image: UIImage(named: "btnCheckBox"))
    var selected:Bool{
        didSet{
            self.changeView()
        }
    }
    
    init(selected:Bool=false){
        self.selected = selected
        super.init(frame: .init(x: 0, y: 0, width: 0, height: 0))
        self.configureView()
    }
    
    override init(frame: CGRect) {
        self.selected = false
        super.init(frame: frame)
        self.configureView()
    }
    
    private func configureView(){
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 11
        self.addCheckImage()
        // 프로퍼티 1차 초기화에는 didSet에서 self.키워드 작동하지 않으므로 처음만 직접 선언해줌
        self.changeView()
    }
    
    private func addCheckImage(){
        self.addSubview(checkImage)
        checkImage.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    private func changeView(){
        if self.selected{
            self.addCheckImage()
            self.backgroundColor = .TalkRed
            self.layer.borderColor = UIColor.TalkRed.cgColor
        } else{
            self.checkImage.removeFromSuperview()
            self.backgroundColor = .white
            self.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
        }
    }
    
    func select(){
        self.selected = true
    }
    
    func unSelect(){
        self.selected = false
    }
    
    // Selected 상태면 해제하고
    // Unselected 상태면 Select
    func toggleSelect(){
        self.selected = !self.selected
    }
    
    required init?(coder: NSCoder) {
        self.selected = false
        super.init(coder: coder)
    }
}

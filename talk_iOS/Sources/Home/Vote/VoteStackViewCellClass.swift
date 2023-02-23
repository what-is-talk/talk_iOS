//
//  voteStackViewCellClass.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/23.
//

import UIKit


class VoteStackViewCellClass : UIView {
    
    var checkBox : TalkCheckBox = {
        let box = TalkCheckBox()
       return box
        
    }()
    
    
    
    var multiSelection = false
    
    @objc func checkBoxTapped(){
        print("클릭!")
        checkBox.toggleSelect()
    }
    

    
    var voteCategoryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    var progressView : UIProgressView = {
        let view = UIProgressView()
        view.progress = 0.5 // Set initial progress value (0.0 ~ 1.0)
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.progressTintColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        view.trackTintColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)

        return view
    }()
    

    
    var selectCount : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    init(voteCategoryLabel:String, selectCount:Int, participants : Int, multiSelection : Bool){
        self.voteCategoryLabel.text = voteCategoryLabel
        self.selectCount.text = "\(selectCount)명"
        self.multiSelection = multiSelection
        super.init(frame: .init(x: 0, y: 0, width: 0, height: 0))
        self.addSubview(checkBox)
        checkBox.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(22)
        }
        
        self.addSubview(self.voteCategoryLabel)
        self.voteCategoryLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkBox.snp.trailing).inset(-20)
        }
        self.progressView.progress = Float(selectCount)/Float(participants)
        self.addSubview(self.progressView)
        self.progressView.snp.makeConstraints{
            $0.top.equalTo(checkBox.snp.bottom).inset(-11)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(self.selectCount)
        self.selectCount.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkBoxTapped))
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(tapGesture)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


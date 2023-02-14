//
//  HomeMainCollectionViewCell.swift
//  talk_iOS
//
//  Created by User on 2023/02/01.
//

import UIKit
import SnapKit
import Kingfisher

class HomeMainCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeMainCollectionViewCell"
    
    var groupName:String = ""
    var selecting = false
    var imageView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "profileBasic"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    var imageUrl = URL(string:""){
        didSet{
            self.imageView.kf.setImage(with: self.imageUrl)
        }
    }
    let groupNameView = UIView()
    let groupNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.8)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.layer.borderWidth = self.selecting ? 1 : 0
        self.layer.borderColor = UIColor.TalkRed.cgColor
        
        setGroupImage()
        setGroupNameView()
    }
    
    private func setGroupImage(){
        self.addSubview(imageView)
        imageView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(135)
        }
            
    }
    
    private func setGroupNameView(){
        self.groupNameView.backgroundColor = self.selecting ? UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.1) : UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        groupNameLabel.text = groupName
        groupNameLabel.textColor = self.selecting ? .TalkRed : UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
//        groupNameView.backgroundColor = self.selecting ? UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.1) : UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        
        groupNameView.addSubview(groupNameLabel)
        groupNameLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
        
        self.addSubview(groupNameView)
        groupNameView.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.groupNameView.backgroundColor = self.selecting ? UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.1) : UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
//        self.groupNameLabel.textColor = self.selecting ? .TalkRed : UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
    }
}

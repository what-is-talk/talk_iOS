//
//  ChattingBubbleCell.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/02/28.
//

import Foundation

import UIKit
import SnapKit

class ChattingBubbleCell: UITableViewCell {
    
    static let chattingBubbleCell = "chattingBubbleCell"
    
    public var userNameLabel : UILabel!
    public var verticalLine : UIView!
    public var messageLabel : UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstraints()
    }
    
    private func setUI() {
        userNameLabel = UILabel()
        userNameLabel.textColor = UIColor.TalkBlue
        userNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        verticalLine = UIView()
        verticalLine.backgroundColor = UIColor.TalkBlue
        
        messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
    }
    
    private func setConstraints() {
        self.addSubview(userNameLabel)
        self.addSubview(verticalLine)
        self.addSubview(messageLabel)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.left.equalToSuperview().offset(21)
        }
        verticalLine.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(21)
        }
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalTo(verticalLine.snp.right).offset(7)
            make.right.equalToSuperview().offset(-67)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implmented")
    }
}

struct BubbleData {
    let userName: String
    let messageContent: String
}

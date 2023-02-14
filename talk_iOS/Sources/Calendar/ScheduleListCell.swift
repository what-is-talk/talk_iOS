//
//  ScheduleListCell.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/02/01.
//

import Foundation
import UIKit
import SnapKit

class ScheduleListCell: UITableViewCell {
    
    static let scheduleListCell = "scheduleListCell"
    
    public var verticalLine : UIView!
    public var groupNameLabel : UILabel!
    public var scheduleLabel : UILabel!
    public var timeLabel : UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstraints()
    }
    
    private func setUI() {
        verticalLine = UIView()
        verticalLine.backgroundColor = UIColor(red: 0.988, green: 0.447, blue: 0.447, alpha: 1)
        
        groupNameLabel = UILabel()
        groupNameLabel.textColor = UIColor(red: 0.988, green: 0.447, blue: 0.447, alpha: 1)
        groupNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        scheduleLabel = UILabel()
        scheduleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        timeLabel = UILabel()
        timeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    private func setConstraints() {
        self.addSubview(verticalLine)
        self.addSubview(groupNameLabel)
        self.addSubview(scheduleLabel)
        self.addSubview(timeLabel)
        
        verticalLine.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.height.equalTo(44)
            make.top.equalToSuperview().offset(19)
            make.left.equalToSuperview().offset(15)
        }
        groupNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.left.equalTo(verticalLine.snp.right).offset(7)
        }
        scheduleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(groupNameLabel)
            make.left.equalTo(groupNameLabel.snp.right).offset(7)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(groupNameLabel.snp.bottom).offset(9)
            make.left.equalTo(verticalLine.snp.right).offset(7)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implmented")
    }
}



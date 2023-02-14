//
//  CalendarContentViewController.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/26.
//

import UIKit
import SnapKit

class CalendarContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigation()
        setUpView()
        setConstraints()
    }
    
    func initNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(backMainPage))
        backButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let titleLabel = UILabel()
        titleLabel.text = "일정 내용"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        let editButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(scheduleEditOpen))
        
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = editButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.TalkRed
    }
    
    @objc func backMainPage() {
        self.navigationController?.popViewController(animated: true)
        print("전 페이지로") // pop 표시
    }
    
    @objc func scheduleEditOpen() {
        guard let eVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarEditViewController") as? CalendarEditViewController else { return }
        
        self.navigationController?.pushViewController(eVC, animated: true)
    }
    
    let contentView_1: CustomView = CustomView()
    lazy var firstLine = contentView_1.setLine
    lazy var scheduleContentLabel = contentView_1.setTextLabel
    
    lazy var scheduleTitleLabel: UILabel = {
        let scheduleTitleLabel = UILabel()
        scheduleTitleLabel.text = "일정 제목"
        scheduleTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return scheduleTitleLabel
    }()
    
    lazy var firstView: UIView = {
        let firstView = UIView()
        firstView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        firstView.layer.cornerRadius = 8
        // 뷰 테두리
        firstView.layer.masksToBounds = false
        firstView.layer.shadowOffset = CGSize(width: 0, height: 0)
        firstView.layer.shadowRadius = 8
        firstView.layer.shadowOpacity = 0.1
        
        scheduleContentLabel.text = "일정 소개"
        scheduleContentLabel.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.6)
        
        firstView.addSubview(scheduleTitleLabel)
        firstView.addSubview(scheduleContentLabel)
        
        firstView.addSubview(firstLine)
        
        return firstView
    }()
    
    let contentView_3: CustomView = CustomView()
    lazy var secondLine = contentView_3.setLine
    lazy var startLabel = contentView_3.setTextLabel
    
    let contentView_4: CustomView = CustomView()
    lazy var endLabel = contentView_4.setTextLabel
    
    lazy var startDateLabel: UILabel = {
        let startDateLabel = UILabel()
        return startDateLabel
    }()
    
    lazy var startTimeLabel: UILabel = {
        let startTimeLabel = UILabel()
        return startTimeLabel
    }()
    
    lazy var endDateLabel: UILabel = {
        let endDateLabel = UILabel()
        return endDateLabel
    }()
    
    lazy var endTimeLabel: UILabel = {
        let endTimeLabel = UILabel()
        return endTimeLabel
    }()
    
    lazy var secondView: UIView = {
        let secondView = UIView()
        secondView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        secondView.layer.cornerRadius = 8
        // 뷰 테두리
        secondView.layer.masksToBounds = false
        secondView.layer.shadowOffset = CGSize(width: 0, height: 0)
        secondView.layer.shadowRadius = 8
        secondView.layer.shadowOpacity = 0.1
        
        secondView.addSubview(secondLine)
        return secondView
    }()
    
    let contentView_5: CustomView = CustomView()
    lazy var groupNameLabel = contentView_5.setTextLabel
    
    lazy var thirdView: UIView = {
        let thirdView = UIView()
        thirdView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        thirdView.layer.cornerRadius = 8
        // 뷰 테두리
        thirdView.layer.masksToBounds = false
        thirdView.layer.shadowOffset = CGSize(width: 0, height: 0)
        thirdView.layer.shadowRadius = 8
        thirdView.layer.shadowOpacity = 0.1
        
        groupNameLabel.text = "UMC"
        
        thirdView.addSubview(groupNameLabel)
        
        return thirdView
    }()
    
    
    
    lazy var fourthView: UIView = {
        let fourthView = UIView()
        fourthView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        fourthView.layer.cornerRadius = 8
        // 뷰 테두리
        fourthView.layer.masksToBounds = false
        fourthView.layer.shadowOffset = CGSize(width: 0, height: 0)
        fourthView.layer.shadowRadius = 8
        fourthView.layer.shadowOpacity = 0.1
        
        let reminderLabel = UILabel()
        reminderLabel.text = "리마인더"
        reminderLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        fourthView.addSubview(reminderLabel)
        
        reminderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(22)
        }
        return fourthView
    }()
    
    func setUpView() {
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
        self.view.addSubview(thirdView)
        self.view.addSubview(fourthView)
    }
    
    func setConstraints() {
        firstView.snp.makeConstraints { make in
            make.height.equalTo(112)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        firstLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
            make.right.left.equalToSuperview()
        }
        scheduleTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-27)
            make.left.equalToSuperview().offset(22)
        }
        scheduleContentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scheduleTitleLabel.snp.centerY).offset(56)
            make.left.equalToSuperview().offset(22)
        }
        secondView.snp.makeConstraints { make in
            make.height.equalTo(112)
            make.top.equalTo(firstView.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        secondLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
            make.right.left.equalToSuperview()
        }
        thirdView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(secondView.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        groupNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(22)
        }
        fourthView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(thirdView.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
    }
}


/*
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = CalendarContentViewController
    
    func makeUIViewController(context: Context) -> CalendarContentViewController {
            return CalendarContentViewController()
    }

    func updateUIViewController(_ uiViewController: CalendarContentViewController, context: Context) {
    }
}

@available(iOS 16.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}*/

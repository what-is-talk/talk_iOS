//
//  CalendarAddViewController.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/26.
//

import UIKit

class CalendarAddViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        setUpView()
        setConstraints()
    }
    

    func initNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(backMain))
        backButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let titleLabel = UILabel()
        titleLabel.text = "일정 추가"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(sendData))
        
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
    }
    
    @objc func backMain() {
        _ = self.navigationController?.popViewController(animated: true)
        print("페이지 pop") // pop 표시
    }
    
    @objc func sendData() {
        /*
         백에 데이터 전송
         */
        _ = self.navigationController?.popViewController(animated: true)
        print("페이지 pop")
    }
    
    lazy var groupName: UILabel = {
        let groupName = UILabel()
        groupName.text = "모임 이름"
        groupName.textColor = UIColor.TalkRed
        groupName.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return groupName
    }()
    
    let customView_1: CustomView = CustomView()
    lazy var firstLine = customView_1.setLine
    lazy var groupLabel = customView_1.setTextLabel
    lazy var btnRoundNext = customView_1.setbtnRoundNext
    
    let customView_2: CustomView = CustomView()
    
    lazy var firstView: UIView = {
        let firstView = UIView()
        firstView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        firstView.layer.cornerRadius = 8
        // 뷰 테두리
        firstView.layer.masksToBounds = false
        firstView.layer.shadowOffset = CGSize(width: 0, height: 0)
        firstView.layer.shadowRadius = 8
        firstView.layer.shadowOpacity = 0.1
        
        groupLabel.text = "UMC"
        
        firstView.addSubview(self.firstLine)
        firstView.addSubview(self.groupName)
        firstView.addSubview(self.groupLabel)
        firstView.addSubview(self.btnRoundNext)
        
        return firstView
    }()
    
    let customView_3: CustomView = CustomView()
    lazy var secondLine = customView_3.setLine
    lazy var titleField = customView_3.setTextField
    
    let customView_4: CustomView = CustomView()
    lazy var memoField = customView_4.setTextField
    
    lazy var secondView: UIView = {
        let secondView = UIView()
        secondView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        secondView.layer.cornerRadius = 8
        // 뷰 테두리
        secondView.layer.masksToBounds = false
        secondView.layer.shadowOffset = CGSize(width: 0, height: 0)
        secondView.layer.shadowRadius = 8
        secondView.layer.shadowOpacity = 0.1
        
        // 각 textfield placeholder 지정
        titleField.placeholder = "일정 제목을 입력해주세요"
        memoField.placeholder = "일정 내용"
        
        secondView.addSubview(self.titleField)
        secondView.addSubview(self.secondLine)
        secondView.addSubview(self.memoField)
        
        return secondView
    }()
    
    let customView_5: CustomView = CustomView()
    lazy var third1_Line = customView_5.setLine
    lazy var startTimeLabel = customView_5.setTextLabel
    lazy var startTimeSwitch = customView_5.setSwitch
    
    let customView_6: CustomView = CustomView()
    lazy var third2_Line = customView_6.setLine
    lazy var endTimeLabel = customView_6.setTextLabel
    lazy var endTimeSwitch = customView_6.setSwitch
    
    let customView_7: CustomView = CustomView()
    lazy var selectDateLabel = customView_7.setTextLabel
    
    lazy var thirdView: UIView = {
        let thirdView = UIView()
        thirdView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        thirdView.layer.cornerRadius = 8
        // 뷰 테두리
        thirdView.layer.masksToBounds = false
        thirdView.layer.shadowOffset = CGSize(width: 0, height: 0)
        thirdView.layer.shadowRadius = 8
        thirdView.layer.shadowOpacity = 0.1
        
        startTimeLabel.text = "시작 상세 설정"
        endTimeLabel.text = "종료일 설정"
        selectDateLabel.text = "2023년 1월 30일"
        selectDateLabel.textColor = UIColor.TalkRed
        
        thirdView.addSubview(startTimeLabel)
        thirdView.addSubview(startTimeSwitch)
        thirdView.addSubview(third1_Line)
        thirdView.addSubview(endTimeLabel)
        thirdView.addSubview(endTimeSwitch)
        thirdView.addSubview(third2_Line)
        thirdView.addSubview(selectDateLabel)
        
        return thirdView
    }()
    
    let customView_8: CustomView = CustomView()
    lazy var reminderLabel = customView_8.setTextLabel
    lazy var reminderSwitch = customView_8.setSwitch
    
    lazy var fourthView: UIView = {
        let fourthView = UIView()
        fourthView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        fourthView.layer.cornerRadius = 8
        // 뷰 테두리
        fourthView.layer.masksToBounds = false
        fourthView.layer.shadowOffset = CGSize(width: 0, height: 0)
        fourthView.layer.shadowRadius = 8
        fourthView.layer.shadowOpacity = 0.1
        
        reminderLabel.text = "리마인더"
        
        fourthView.addSubview(reminderLabel)
        fourthView.addSubview(reminderSwitch)
        
        return fourthView
    }()
    
    let customView_9: CustomView = CustomView()
    lazy var noticeLabel = customView_9.setTextLabel
    lazy var noticeSwitch = customView_9.setSwitch
    
    lazy var fifthView: UIView = {
        let fifthView = UIView()
        fifthView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        fifthView.layer.cornerRadius = 8
        // 뷰 테두리
        fifthView.layer.masksToBounds = false
        fifthView.layer.shadowOffset = CGSize(width: 0, height: 0)
        fifthView.layer.shadowRadius = 8
        fifthView.layer.shadowOpacity = 0.1
        
        noticeLabel.text = "공지사항에 업로드"
        
        fifthView.addSubview(noticeLabel)
        fifthView.addSubview(noticeSwitch)
        
        return fifthView
    }()
    
    func setUpView() {
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
        self.view.addSubview(thirdView)
        self.view.addSubview(fourthView)
        self.view.addSubview(fifthView)
    }
    
    func setConstraints() {
        firstView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        groupName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(23)
        }
        groupLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(116)
        }
        btnRoundNext.snp.makeConstraints { make in
            make.height.width.equalTo(18.18)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-23)
        }
        secondView.snp.makeConstraints { make in
            make.height.equalTo(112)
            make.top.equalTo(firstView.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        titleField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-28)
            make.left.equalToSuperview().offset(23)
        }
        secondLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        memoField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(28)
            make.left.equalToSuperview().offset(23)
        }
        thirdView.snp.makeConstraints { make in
            make.height.equalTo(168)
            make.top.equalTo(secondView.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        startTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.left.equalToSuperview().offset(23)
        }
        startTimeSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(startTimeLabel.snp.centerY)
            make.right.equalToSuperview().offset(-22)
        }
        third1_Line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalToSuperview().offset(54)
            make.left.right.equalToSuperview()
        }
        endTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(23)
        }
        endTimeSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(endTimeLabel.snp.centerY)
            make.right.equalToSuperview().offset(-22)
        }
        third2_Line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(-54)
            make.left.right.equalToSuperview()
        }
        selectDateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-17)
            make.right.equalToSuperview().offset(-22)
        }
        fourthView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(thirdView.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        reminderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(23)
        }
        reminderSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-22)
        }
        fifthView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(fourthView.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        noticeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(23)
        }
        noticeSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-22)
        }
    }
    
}

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = CalendarAddViewController
    
    func makeUIViewController(context: Context) -> CalendarAddViewController {
            return CalendarAddViewController()
        }

        func updateUIViewController(_ uiViewController: CalendarAddViewController, context: Context) {
        }
}

@available(iOS 16.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}


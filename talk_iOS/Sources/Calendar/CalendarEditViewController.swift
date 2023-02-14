//
//  CalendarEditViewController.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/26.
//

import UIKit
import SnapKit

protocol EditPageDelegate: AnyObject {
    func sendGroup(groupname: String)
}

class CalendarEditViewController: UIViewController, EditPageDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigation()
        setUpView()
        setConstraints()
    }
    
    // 네비게이션 바
    func initNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(backContentPage))
        backButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let titleLabel = UILabel()
        titleLabel.text = "일정 수정"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        let editButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(sendData))
        
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = editButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.TalkRed
    }
    // CalendarContentViewController로 이동하는 함수
    @objc func backContentPage() {
        self.navigationController?.popViewController(animated: true)
        print("전 페이지로") // pop 표시
    }
    // CalendarMainViewController로 이동하는 함수
    @objc func sendData() {
        self.navigationController?.popToRootViewController(animated: true)
        print("메인 페이지로")
    }
    
    // 첫번째 뷰
    let editView_1: CustomView = CustomView()
    lazy var groupNameLabel = editView_1.setTextLabel
    lazy var groupRoundBtn = editView_1.setbtnRoundNext
    
    lazy var groupLabel: UILabel = {
        let groupLabel = UILabel()
        groupLabel.text = "모임 이름"
        groupLabel.textColor = UIColor.TalkRed
        groupLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return groupLabel
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
        
        groupNameLabel.text = "UMC"
        groupRoundBtn.addTarget(self, action: #selector(modalGroupName), for: .touchUpInside)
        
        firstView.addSubview(groupLabel)
        firstView.addSubview(groupNameLabel)
        firstView.addSubview(groupRoundBtn)
        
        return firstView
    }()
    // 모달뷰 -> edit 페이지 데이터 전달
    func sendGroup(groupname: String) {
        self.groupNameLabel.text = groupname
    }
    // 모임 모달 뷰 열기
    @objc func modalGroupName() {
        let groupListVC = EditPageGroupListViewController()
        groupListVC.delegate = self
        self.present(groupListVC, animated: true, completion: nil)
    }
    
    // 두번째 뷰
    let editView_2: CustomView = CustomView()
    lazy var secondViewLine = editView_2.setLine
    lazy var scheduleTitleTF = editView_2.setTextField
    
    let editView_3: CustomView = CustomView()
    lazy var scheduleContentTF = editView_3.setTextField
    
    lazy var secondView: UIView = {
        let secondView = UIView()
        secondView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        secondView.layer.cornerRadius = 8
        // 뷰 테두리
        secondView.layer.masksToBounds = false
        secondView.layer.shadowOffset = CGSize(width: 0, height: 0)
        secondView.layer.shadowRadius = 8
        secondView.layer.shadowOpacity = 0.1
        
        scheduleTitleTF.text = "일정 내용"
        scheduleContentTF.text = "일정 소개"
        
        secondView.addSubview(secondViewLine)
        secondView.addSubview(scheduleTitleTF)
        secondView.addSubview(scheduleContentTF)
        
        return secondView
    }() 
    
    // 세번째 뷰
    let editView_4: CustomView = CustomView()
    lazy var startTimeLabel = editView_4.setTextLabel
    lazy var startTimeSwitch = editView_4.setSwitch
    lazy var thirdViewLine_1 = editView_4.setLine
    
    let editView_5: CustomView = CustomView()
    lazy var endTimeLabel = editView_5.setTextLabel
    lazy var endTimeSwitch = editView_5.setSwitch
    lazy var thirdViewLine_2 = editView_5.setLine
    
    lazy var startDatePicker: UIDatePicker = {
        let startDatePicker = UIDatePicker()
        startDatePicker.preferredDatePickerStyle = .compact
        startDatePicker.locale = Locale(identifier: "ko-KR")
        startDatePicker.datePickerMode = .date
        startDatePicker.tintColor = UIColor.TalkRed
        
        /*
        if selectedDateData == "" {
            startDatePicker.date = Date()
        }
        else {
            startDatePicker.date = selectedFormatter.date(from: selectedDateData) ?? Date()
        }*/
        return startDatePicker
    }()
    
    lazy var startTimePicker: UIDatePicker = {
        let startTimePicker = UIDatePicker()
        startTimePicker.preferredDatePickerStyle = .compact
        startTimePicker.locale = Locale(identifier: "ko-KR")
        startTimePicker.datePickerMode = .dateAndTime
        startTimePicker.tintColor = UIColor.TalkRed
        // datePicker에 처음 나타나는 날짜
        /*
        if selectedDateData == "" {
            startTimePicker.date = Date()
        }
        else {
            startTimePicker.date = selectedFormatter.date(from: selectedDateData) ?? Date()
        }*/
        
        return startTimePicker
    }()
    
    lazy var endTimePicker: UIDatePicker = {
        let endTimePicker = UIDatePicker()
        endTimePicker.preferredDatePickerStyle = .compact
        endTimePicker.locale = Locale(identifier: "ko-KR")
        endTimePicker.datePickerMode = .dateAndTime
        endTimePicker.tintColor = UIColor.TalkRed
        /*
        if selectedDateData == "" {
            endTimePicker.date = Date()
        }
        else {
            endTimePicker.date = selectedFormatter.date(from: selectedDateData) ?? Date()
        }*/
        
        return endTimePicker
    }()
    
    lazy var thirdView: UIView = {
        let thirdView = UIView()
        thirdView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        thirdView.layer.cornerRadius = 8
        // 뷰 테두리
        thirdView.layer.masksToBounds = false
        thirdView.layer.shadowOffset = CGSize(width: 0, height: 0)
        thirdView.layer.shadowRadius = 8
        thirdView.layer.shadowOpacity = 0.1
        
        startTimeLabel.text = "시간 상세 설정"
        endTimeLabel.text = "종료일 설정"
        
        startTimeSwitch.addTarget(self, action: #selector(onStartTimeSwitch(sender:)), for: .valueChanged)
        endTimeSwitch.addTarget(self, action: #selector(thirdViewChange(sender:)), for: .valueChanged)
        
        thirdView.addSubview(startTimeLabel)
        thirdView.addSubview(startTimeSwitch)
        thirdView.addSubview(thirdViewLine_1)
        thirdView.addSubview(endTimeLabel)
        thirdView.addSubview(endTimeSwitch)
        thirdView.addSubview(thirdViewLine_2)
        thirdView.addSubview(startDatePicker)
        
        return thirdView
    }()
    
    @objc func onStartTimeSwitch(sender: UISwitch) {
        if sender.isOn {
            startDatePicker.removeFromSuperview()
            self.thirdView.addSubview(startTimePicker)
            
            startTimePicker.snp.makeConstraints { make in
                make.centerY.equalTo(endTimeLabel.snp.centerY).offset(58)
                make.right.equalToSuperview().offset(-22)
            }
        }
        else {
            startTimePicker.removeFromSuperview()
            self.thirdView.addSubview(startDatePicker)
            
            startDatePicker.snp.makeConstraints { make in
                make.centerY.equalTo(endTimeLabel.snp.centerY).offset(58)
                make.right.equalToSuperview().offset(-22)
            }
        }
    }
    
    let thirdCustomView: CustomView = CustomView()
    lazy var thirdAddLine = thirdCustomView.setLine
    
    lazy var startLabel: UILabel = {
        let startLabel = UILabel()
        startLabel.text = "시작"
        return startLabel
    }()
    
    lazy var endLabel: UILabel = {
        let endLabel = UILabel()
        endLabel.text = "종료"
        return endLabel
    }()
    
    @objc func thirdViewChange(sender: UISwitch) {
        if sender.isOn {
            self.thirdView.snp.remakeConstraints { make in
                make.height.equalTo(224)
                make.top.equalTo(secondView.snp.bottom).offset(20)
                make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
                make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
            }
            
            self.thirdView.addSubview(thirdAddLine)
            self.thirdView.addSubview(startLabel)
            startDatePicker.removeFromSuperview()
            self.thirdView.addSubview(startTimePicker)
            self.thirdView.addSubview(endLabel)
            self.thirdView.addSubview(endTimePicker)
            
            thirdAddLine.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.centerY.equalToSuperview()
                make.right.left.equalToSuperview()
            }
            startLabel.snp.makeConstraints { make in
                make.centerY.equalTo(endTimeLabel.snp.centerY).offset(58)
                make.left.equalToSuperview().offset(23)
            }
            endLabel.snp.makeConstraints { make in
                make.centerY.equalTo(startLabel.snp.centerY).offset(58)
                make.left.equalToSuperview().offset(23)
            }
            startTimePicker.snp.makeConstraints { make in
                make.centerY.equalTo(endTimeLabel.snp.centerY).offset(58)
                make.right.equalToSuperview().offset(-22)
            }
            endTimePicker.snp.makeConstraints { make in
                make.centerY.equalTo(endLabel.snp.centerY)
                make.right.equalToSuperview().offset(-22)
            }
            
        }
        else {
            self.thirdView.snp.makeConstraints { make in
                make.height.equalTo(168)
                make.top.equalTo(secondView.snp.bottom).offset(20)
                make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
                make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
            }
            thirdAddLine.removeFromSuperview()
            startLabel.removeFromSuperview()
            startTimePicker.removeFromSuperview()
            endLabel.removeFromSuperview()
            endTimePicker.removeFromSuperview()
            
            self.thirdView.addSubview(startDatePicker)
            
            startDatePicker.snp.makeConstraints { make in
                make.centerY.equalTo(endTimeLabel.snp.centerY).offset(58)
                make.right.equalToSuperview().offset(-22)
            }
        }
    }
    
    let editView_6: CustomView = CustomView()
    lazy var reminderLabel = editView_6.setTextLabel
    
    lazy var reminderTimeLabel: UILabel = {
        let reminderTimeLabel = UILabel()
        reminderTimeLabel.text = "없음"
        reminderTimeLabel.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.6)
        reminderTimeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return reminderTimeLabel
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
        
        reminderLabel.text = "리마인더"
        
        fourthView.addSubview(reminderLabel)
        fourthView.addSubview(reminderTimeLabel)
        
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
            make.height.equalTo(56)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        groupLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(23)
        }
        groupNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(116)
        }
        groupRoundBtn.snp.makeConstraints { make in
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
        scheduleTitleTF.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-28)
            make.left.equalToSuperview().offset(23)
        }
        secondViewLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        scheduleContentTF.snp.makeConstraints { make in
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
        thirdViewLine_1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalToSuperview().offset(54)
            make.left.right.equalToSuperview()
        }
        endTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(startTimeLabel.snp.centerY).offset(56)
            make.left.equalToSuperview().offset(23)
        }
        endTimeSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(endTimeLabel.snp.centerY)
            make.right.equalToSuperview().offset(-22)
        }
        thirdViewLine_2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(-55)
            make.left.right.equalToSuperview()
        }
        startDatePicker.snp.makeConstraints { make in
            make.centerY.equalTo(endTimeLabel.snp.centerY).offset(58)
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
        reminderTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(reminderLabel.snp.right).offset(36)
        }
    }
    
    // 화면 터치시 키보드 내려가기
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
    
    // Return키 눌렀을 때 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // TextField 비활성화
            return true
    }
}

class EditPageGroupListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var groupname: String?
    weak var delegate: EditPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(groupTopView)
        view.addSubview(groupTableView)
        
        groupTopView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        groupTableView.snp.makeConstraints { make in
            make.top.equalTo(self.groupTopView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        attribute()
    }
    
    lazy var groupBackBtn: UIButton = {
        let groupBackBtn = UIButton()
        groupBackBtn.setBackgroundImage(UIImage(named: "btnBack"), for: .normal)
        groupBackBtn.addTarget(self, action: #selector(backToMainPage), for: .touchUpInside)
        return groupBackBtn
    }()
    
    @objc func backToMainPage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var groupTopLabel: UILabel = {
        let groupTopLabel = UILabel()
        groupTopLabel.text = "모임 이름"
        groupTopLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return groupTopLabel
    }()
    
    lazy var groupDoneBtn: UIButton = {
        let groupDoneBtn = UIButton()
        groupDoneBtn.setTitle("완료", for: .normal)
        groupDoneBtn.setTitleColor(UIColor.TalkRed, for: .normal)
        groupDoneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        groupDoneBtn.addTarget(self, action: #selector(doneAndBackToMainPage), for: .touchUpInside)
        return groupDoneBtn
    }()
    
    @objc func doneAndBackToMainPage() {
        self.delegate?.sendGroup(groupname: selectedGroup)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
    }
    
    lazy var groupTopView: UIView = {
        let groupTopView = UIView()
        groupTopView.addSubview(groupBackBtn)
        groupTopView.addSubview(groupDoneBtn)
        groupTopView.addSubview(groupTopLabel)
        
        groupDoneBtn.alpha = 0
        
        groupBackBtn.snp.makeConstraints { make in
            make.height.equalTo(18.93)
            make.width.equalTo(10.9)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10.14)
        }
        groupTopLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(60)
        }
        groupDoneBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        return groupTopView
    }()
    
    lazy var groupTableView: UITableView = {
        let groupTableView = UITableView()
        groupTableView.separatorStyle = .none
        groupTableView.rowHeight = 50
        return groupTableView
    }()
    
    let group: [EditPageGroupList] = [
                              EditPageGroupList(groupLabel_e: "모임 1", groupCheckImg_e: UIImage(named: "btnCheckBox")!),
                              EditPageGroupList(groupLabel_e: "모임 2",groupCheckImg_e: UIImage(named: "btnCheckBox")!),
                              EditPageGroupList(groupLabel_e: "모임 3",groupCheckImg_e: UIImage(named: "btnCheckBox")!),
                              EditPageGroupList(groupLabel_e: "모임 4",groupCheckImg_e: UIImage(named: "btnCheckBox")!)
                                ]
    
    func attribute() {
        groupTableView.register(EditPageGroupListTableViewCell.self, forCellReuseIdentifier: EditPageGroupListTableViewCell.editGroupCell)
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.count
    }
    
    var selectedGroup: String = ""
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCell(withIdentifier: EditPageGroupListTableViewCell.editGroupCell, for: indexPath) as! EditPageGroupListTableViewCell
        cell.groupLabel_e.text = group[indexPath.row].groupLabel_e
        cell.selectionStyle = .none
        
        if cell.groupLabel_e.text == selectedGroup {
            cell.groupCheckImg_e.alpha = 1
        }
        else {
            cell.groupCheckImg_e.alpha = 0
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groupDoneBtn.alpha = 1 //윗부분 완료 버튼 나타남
        selectedGroup = group[indexPath.row].groupLabel_e
        print(selectedGroup)
        tableView.reloadData()
    }
}

struct EditPageGroupList {
    let groupLabel_e: String
    let groupCheckImg_e: UIImage
}

class EditPageGroupListTableViewCell: UITableViewCell {
    
    static let editGroupCell = "editGroupCell"
    let groupLabel_e = UILabel()
    let groupCheckImg_e = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        groupCheckImg_e.image = UIImage(named: "btnCheckBox")
        addSubview(groupLabel_e)
        addSubview(groupCheckImg_e)
            
        groupLabel_e.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(60)
        }
        groupCheckImg_e.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/*
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = CalendarEditViewController
    
    func makeUIViewController(context: Context) -> CalendarEditViewController {
            return CalendarEditViewController()
    }

    func updateUIViewController(_ uiViewController: CalendarEditViewController, context: Context) {
    }
}

@available(iOS 16.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}*/

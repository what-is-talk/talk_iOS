//
//  CalendarAddViewController.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/26.
//

import UIKit
import SnapKit

protocol SendDelegate: AnyObject {
    func sendGroup(groupname: String)
    func sendReminder(remindername: String)
    
}

class CalendarAddViewController: UIViewController, UITextFieldDelegate, SendDelegate {
    
    func sendGroup(groupname: String) {
        self.groupLabel.text = groupname
    }
    
    func sendReminder(remindername: String) {
        self.reminderTimeLabel.text = remindername
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedFormatter.dateFormat = "yyyy-MM-dd"
        
        initNavigation()
        setUpView()
        setConstraints()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    }
    
    
    var selectedDateData: String = ""
    let selectedFormatter = DateFormatter()

    func initNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(backMainPage))
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
    
    @objc func backMainPage() {
        self.navigationController?.popViewController(animated: true)
        print("페이지 pop") // pop 표시
    }
    
    @objc func sendData() {
        // 백에 데이터 전송
        sendDataToServer()
        
        self.navigationController?.popViewController(animated: true)
        print("페이지 pop")
    }
    
    func sendDataToServer() {
        
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
    lazy var groupRoundNext = customView_1.setbtnRoundNext
    
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
        
        groupLabel.text = "모임 선택"
        groupRoundNext.addTarget(self, action: #selector(modalGroupName), for: .touchUpInside)
        
        firstView.addSubview(self.firstLine)
        firstView.addSubview(self.groupName)
        firstView.addSubview(self.groupLabel)
        firstView.addSubview(self.groupRoundNext)
        
        return firstView
    }()
    
    @objc func modalGroupName() {
        let groupListVC = GroupListViewController()
        groupListVC.delegate = self
        self.present(groupListVC, animated: true, completion: nil)
    }
    
    let customView_3: CustomView = CustomView()
    lazy var secondLine = customView_3.setLine
    lazy var titleField = customView_3.setTextField
    lazy var startLabel = customView_3.setTextLabel
    
    let customView_4: CustomView = CustomView()
    lazy var memoField = customView_4.setTextField
    lazy var endLabel = customView_4.setTextLabel
    
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
        titleField.delegate = self
        memoField.delegate = self
        
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
    lazy var thirdAddLine = customView_7.setLine
    lazy var selectDateLabel = customView_7.setTextLabel
    
    lazy var startDatePicker: UIDatePicker = {
        let startDatePicker = UIDatePicker()
        startDatePicker.preferredDatePickerStyle = .compact
        startDatePicker.locale = Locale(identifier: "ko-KR")
        startDatePicker.datePickerMode = .date
        startDatePicker.tintColor = UIColor.TalkRed
        
        if selectedDateData == "" {
            startDatePicker.date = Date()
        }
        else {
            startDatePicker.date = selectedFormatter.date(from: selectedDateData) ?? Date()
        }
        return startDatePicker
    }()
    
    lazy var startTimePicker: UIDatePicker = {
        let startTimePicker = UIDatePicker()
        startTimePicker.preferredDatePickerStyle = .compact
        startTimePicker.locale = Locale(identifier: "ko-KR")
        startTimePicker.datePickerMode = .dateAndTime
        startTimePicker.tintColor = UIColor.TalkRed
        // datePicker에 처음 나타나는 날짜
        if selectedDateData == "" {
            startTimePicker.date = Date()
        }
        else {
            startTimePicker.date = selectedFormatter.date(from: selectedDateData) ?? Date()
        }
        
        return startTimePicker
    }()
    
    lazy var endTimePicker: UIDatePicker = {
        let endTimePicker = UIDatePicker()
        endTimePicker.preferredDatePickerStyle = .compact
        endTimePicker.locale = Locale(identifier: "ko-KR")
        endTimePicker.datePickerMode = .dateAndTime
        endTimePicker.tintColor = UIColor.TalkRed
        if selectedDateData == "" {
            endTimePicker.date = Date()
        }
        else {
            endTimePicker.date = selectedFormatter.date(from: selectedDateData) ?? Date()
        }
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
        
        startTimeLabel.text = "시작 상세 설정"
        endTimeLabel.text = "종료일 설정"
        startLabel.text = "시작"
        endLabel.text = "종료"
        
        startTimeSwitch.addTarget(self, action: #selector(onStartTimeSwitch(sender:)), for: .valueChanged)
        endTimeSwitch.addTarget(self, action: #selector(thirdViewChange(sender:)), for: .valueChanged)
        
        thirdView.addSubview(startTimeLabel)
        thirdView.addSubview(startTimeSwitch)
        thirdView.addSubview(third1_Line)
        thirdView.addSubview(endTimeLabel)
        thirdView.addSubview(endTimeSwitch)
        thirdView.addSubview(third2_Line)
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
    
    let customView_8: CustomView = CustomView()
    lazy var reminderLabel = customView_8.setTextLabel
    lazy var reminderRoundNext = customView_8.setbtnRoundNext
    
    var selectedReminderData: String?
    
    lazy var reminderTimeLabel: UILabel = {
        let reminderTimeLabel = UILabel()
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
        reminderRoundNext.addTarget(self, action: #selector(modalReminder), for: .touchUpInside)
        
        fourthView.addSubview(reminderLabel)
        fourthView.addSubview(reminderTimeLabel)
        fourthView.addSubview(reminderRoundNext)
        
        return fourthView
    }()
    
    
    @objc func modalReminder() {
        let reminderVC = ReminderViewController()
        reminderVC.delegate = self
        self.present(reminderVC, animated: true, completion: nil)
    }
    
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
        groupRoundNext.snp.makeConstraints { make in
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
            make.centerY.equalTo(startTimeLabel.snp.centerY).offset(56)
            make.left.equalToSuperview().offset(23)
        }
        endTimeSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(endTimeLabel.snp.centerY)
            make.right.equalToSuperview().offset(-22)
        }
        third2_Line.snp.makeConstraints { make in
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
        reminderRoundNext.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-23)
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

class GroupListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var groupname: String?
    weak var delegate: SendDelegate?
    
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
    
    let group: [GroupList] = [
                              GroupList(groupLabel: "모임 1", groupCheckImg: UIImage(named: "btnCheckBox")!),
                              GroupList(groupLabel: "모임 2",groupCheckImg: UIImage(named: "btnCheckBox")!),
                              GroupList(groupLabel: "모임 3",groupCheckImg: UIImage(named: "btnCheckBox")!),
                              GroupList(groupLabel: "모임 4",groupCheckImg: UIImage(named: "btnCheckBox")!)
                                ]
    
    func attribute() {
        groupTableView.register(GroupListTableViewCell.self, forCellReuseIdentifier: GroupListTableViewCell.groupCell)
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.count
    }
    
    var selectedGroup: String = ""
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCell(withIdentifier: GroupListTableViewCell.groupCell, for: indexPath) as! GroupListTableViewCell
        cell.groupLabel.text = group[indexPath.row].groupLabel
        cell.selectionStyle = .none
        
        if cell.groupLabel.text == selectedGroup {
            cell.groupCheckImg.alpha = 1
        }
        else {
            cell.groupCheckImg.alpha = 0
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groupDoneBtn.alpha = 1 //윗부분 완료 버튼 나타남
        selectedGroup = group[indexPath.row].groupLabel
        print(selectedGroup)
        tableView.reloadData()
    }
}

struct GroupList {
    let groupLabel: String
    let groupCheckImg: UIImage
}

class GroupListTableViewCell: UITableViewCell {
    
    static let groupCell = "groupCell"
    let groupLabel = UILabel()
    let groupCheckImg = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        groupCheckImg.image = UIImage(named: "btnCheckBox")
        addSubview(groupLabel)
        addSubview(groupCheckImg)
            
        groupLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(60)
        }
        groupCheckImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// 리마인더 뷰컨트롤러
class ReminderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var remindername: String?
    weak var delegate: SendDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(reminderTopView)
        view.addSubview(reminderTableView)
        reminderTopView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        reminderTableView.snp.makeConstraints { make in
            make.top.equalTo(self.reminderTopView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        attribute()
    }
    
    lazy var reminderBackBtn: UIButton = {
        let reminderBackBtn = UIButton()
        reminderBackBtn.setBackgroundImage(UIImage(named: "btnBack"), for: .normal)
        reminderBackBtn.addTarget(self, action: #selector(backToAddPage), for: .touchUpInside)
        return reminderBackBtn
    }()
    
    @objc func backToAddPage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var reminderTopLabel: UILabel = {
        let reminderTopLabel = UILabel()
        reminderTopLabel.text = "리마인더"
        reminderTopLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return reminderTopLabel
    }()
    
    lazy var reminderDoneBtn: UIButton = {
        let reminderDoneBtn = UIButton()
        reminderDoneBtn.setTitle("완료", for: .normal)
        reminderDoneBtn.setTitleColor(UIColor.TalkRed, for: .normal)
        reminderDoneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        reminderDoneBtn.addTarget(self, action: #selector(doneAndBackToAddPage), for: .touchUpInside)
        return reminderDoneBtn
    }()
    
    @objc func doneAndBackToAddPage() {
        self.delegate?.sendReminder(remindername: selectedReminder)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    lazy var reminderTopView: UIView = {
        let reminderTopView = UIView()
        reminderTopView.addSubview(reminderBackBtn)
        reminderTopView.addSubview(reminderDoneBtn)
        reminderTopView.addSubview(reminderTopLabel)
        
        reminderDoneBtn.alpha = 0
        
        reminderBackBtn.snp.makeConstraints { make in
            make.height.equalTo(18.93)
            make.width.equalTo(10.9)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10.14)
        }
        reminderTopLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(60)
        }
        reminderDoneBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        return reminderTopView
    }()
    
    lazy var reminderTableView: UITableView = {
        let reminderTableView = UITableView()
        reminderTableView.separatorStyle = .none
        reminderTableView.rowHeight = 50
        return reminderTableView
    }()
    
    let reminder: [Reminder] = [Reminder(reminderLabel: "없음", reminderCheckImg: UIImage(named: "btnCheckBox")!),
                                Reminder(reminderLabel: "10분전",reminderCheckImg: UIImage(named: "btnCheckBox")!),
                                Reminder(reminderLabel: "한시간 전",reminderCheckImg: UIImage(named: "btnCheckBox")!),
                                Reminder(reminderLabel: "하루 전",reminderCheckImg: UIImage(named: "btnCheckBox")!)
                                ]
    
    func attribute() {
        reminderTableView.register(ReminderTableViewCell.self, forCellReuseIdentifier: ReminderTableViewCell.reminderCell)
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminder.count
    }
    
    var selectedReminder: String = ""
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reminderTableView.dequeueReusableCell(withIdentifier: ReminderTableViewCell.reminderCell, for: indexPath) as! ReminderTableViewCell
        cell.reminderLabel.text = reminder[indexPath.row].reminderLabel
        cell.selectionStyle = .none
        
        if cell.reminderLabel.text == selectedReminder {
            cell.reminderCheckImg.alpha = 1
        }
        else {
            cell.reminderCheckImg.alpha = 0
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        reminderDoneBtn.alpha = 1 //윗부분 완료 버튼 나타남
        selectedReminder = reminder[indexPath.row].reminderLabel
        print(selectedReminder)
        tableView.reloadData()
    }
    
}

struct Reminder {
    let reminderLabel: String
    let reminderCheckImg: UIImage
}
    
class ReminderTableViewCell: UITableViewCell {
    
    static let reminderCell = "reminderCell"
    let reminderLabel = UILabel()
    let reminderCheckImg = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        reminderCheckImg.image = UIImage(named: "btnCheckBox")
        addSubview(reminderLabel)
        addSubview(reminderCheckImg)
            
        reminderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(60)
        }
        reminderCheckImg.snp.makeConstraints { make in
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
*/

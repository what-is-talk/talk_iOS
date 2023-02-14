//
//  CalendarViewController.swift
//  talk_iOS
//
//  Created by User on 2023/01/13.
//

import UIKit
import SnapKit
import FSCalendar
import Alamofire

protocol SendGroupDelegate: AnyObject {
    func sendGroup(groupname: String)
}

class CalendarMainViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource, SendGroupDelegate {
    
    static let identifier = "CalendarMainViewController"
    
    var dataSource: [ScheduleResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        calendar.delegate = self
        calendar.dataSource = self
        
        initNavigation()
        setUpView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*
        fetchCalendarOverView(completionHandler: { result in
            switch result {
            case let .success(data):
                print(result)
            case let .failure(error):
                print("에러")
            }
        })*/
        fetchCalendarOverView()
    }
    
    // 네비게이션 바 설정
    func initNavigation() {
        let leftLabel = UILabel()
        leftLabel.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        leftLabel.text = "일정"
        leftLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        let addButton = UIBarButtonItem(image: UIImage(named: "btnAdd"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(scheduleAddOpen))
        addButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)

        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftLabel)
        self.navigationItem.title = " "
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func scheduleAddOpen() {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "CalendarAddViewController") as? CalendarAddViewController else { return }
        uvc.selectedDateData = selectedDate
        //self.present(uvc, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    
    // 모임 선택하는 뷰
    lazy var selectView: UIView = {
        let selectView = UIView()
        selectView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        selectView.layer.cornerRadius = 8
        // 뷰 테두리
        selectView.layer.masksToBounds = false
        selectView.layer.shadowOffset = CGSize(width: 0, height: 0)
        selectView.layer.shadowRadius = 8
        selectView.layer.shadowOpacity = 0.1
        
        selectView.addSubview(allgroupLabel)
        selectView.addSubview(nextButton)
        return selectView
    }()
    
    lazy var allgroupLabel: UILabel = {
        let allgroupLabel = UILabel()
        allgroupLabel.text = "모든 모임"
        allgroupLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return allgroupLabel
    }()
    
    lazy var nextButton: UIButton = {
        let nextButton = UIButton()
        let nextButtonImg = UIImage(named: "btnDown")
        nextButton.setBackgroundImage(nextButtonImg, for: .normal)
        nextButton.addTarget(self, action: #selector(modalGroupView), for: .touchUpInside)
        return nextButton
    }()
    
    @objc func modalGroupView() {
        let groupVC = GroupViewController()
        groupVC.delegate = self
        self.present(groupVC, animated: true, completion: nil)
    }
    
    func sendGroup(groupname: String) {
        self.allgroupLabel.text = groupname
    }
    
    var selectedDate: String = ""
    let dateFormatter = DateFormatter()
    
    // 캘린더 뷰
    private let calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        
        calendar.locale = Locale(identifier: "ko_KR")
        
        calendar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        
        // 캘린더 헤더 설정
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        calendar.appearance.headerTitleColor = UIColor.TalkRed
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.headerHeight = 60
        
        // 캘린더 요일 라인 설정
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 10, weight: .regular)
        calendar.appearance.weekdayTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        calendar.weekdayHeight = 15
        
        // 캘린더 날짜 설정
        calendar.placeholderType = .none // 전&다음 월 날짜 표시 없애기
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        calendar.appearance.titleDefaultColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        calendar.appearance.selectionColor = UIColor.TalkRed
        calendar.appearance.todayColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        calendar.appearance.titleTodayColor = UIColor.TalkRed
        
        // 요일 텍스트 설정 // 얘가 맨뒤에 있어야 적용됨..
        calendar.calendarWeekdayView.weekdayLabels[0].text = "S"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "M"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "T"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "W"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "T"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "F"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "S"
        // 토요일 일요일 회색으로
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        return calendar
    }()
    
    let eventsArray = [Date]()
    
    lazy var scheduleList: UITableView = {
        let scheduleList = UITableView()
        scheduleList.rowHeight = 90
        return scheduleList
    }()
    /*
     scheduleListData(groupNameLabel: "UMC", scheduleLabel: "일정 내용", timeLabel: "2월 2일 10:00 ~ 2월 3일 11:00"),
     scheduleListData(groupNameLabel: "UMC", scheduleLabel: "내용", timeLabel: "14:00"),
     scheduleListData(groupNameLabel: "UMC", scheduleLabel: "내용", timeLabel: "14:00")
     */
    
    
    
    func attribute() {
        scheduleList.register(ScheduleListCell.classForCoder(), forCellReuseIdentifier: ScheduleListCell.scheduleListCell)
        scheduleList.delegate = self
        scheduleList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleListCell.scheduleListCell, for: indexPath) as! ScheduleListCell
        /*
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        let stringDate = myFormatter.string(from: dataSource[indexPath.row].startDate)*/
        cell.groupNameLabel.text = dataSource[indexPath.row].title
        cell.scheduleLabel.text = dataSource[indexPath.row].desc
        cell.timeLabel.text = dataSource[indexPath.row].startDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarContentViewController") as? CalendarContentViewController else { return }
        
        self.navigationController?.pushViewController(cVC, animated: true)
    }
    
    func setUpView() {
        self.view.addSubview(selectView)
        self.view.addSubview(calendar)
        self.attribute()
        self.view.addSubview(scheduleList)
    }
    
    func setConstraints() {
        selectView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(7)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-7)
        }
        allgroupLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(23)
        }
        nextButton.snp.makeConstraints { make in
            make.height.width.equalTo(18.18)
            make.centerY.equalToSuperview()
            make.left.equalTo(allgroupLabel.snp.right).offset(7)
        }
        calendar.snp.makeConstraints { make in
            make.top.equalTo(self.selectView.snp.bottom).offset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-250)
            make.width.equalToSuperview()
        }
        scheduleList.snp.makeConstraints { make in
            make.top.equalTo(self.calendar.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
        }
    }
    
    func fetchCalendarOverView() {
        let url = "https://what-is-talk-test.vercel.app/api/schedule/detail?scheduleId=1"
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
            .responseData{ response in
                switch response.result {
                case let .success(data):
                    do {
                        let result = try JSONDecoder().decode(Root.self, from: data).data
                        print(result)
                    } catch {
                        print(error)
                    }
                    
                case .failure(let err):
                    print(err)
                }
            }
    }
    /*
    func fetchCalendarOverView() {
        let url = "https://what-is-talk-test.vercel.app/api/schedule?groupId=1&year=2023/detail?scheduleId~=1"
        AF.request(url)
            .responseJSON { response in
                switch response.result {
                case let .success(res):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                        let json = try JSONDecoder().decode(Root.self, from: jsonData).data
                        print(json)
                        self.dataSource = json
                        DispatchQueue.main.async {
                            self.scheduleList.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                    
                case .failure(let err):
                    print(err)
                }
            }
    }*/
    /*
    func fetchCalendarOverView() {
            let url = "https://what-is-talk-test.vercel.app/api/schedule?groupId=1"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
                .responseData{ response in
                    switch response.result {
                    case let .success(data):
                        do{
                            let result = try JSONDecoder().decode(Root.self, from: data).data
                            self.dataSource = result
                            self.scheduleList.reloadData()
                        } catch{
                            print(error)
                        }
                        
                    case .failure(let err):
                        print(err)
                    }
                }
    }*/
}

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var groupname: String?
    weak var delegate: SendGroupDelegate?
    
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
    
    let group: [Group] = [Group(groupLabel: "모든 모임", groupCheckImg: UIImage(named: "btnCheckBox")!),
                          Group(groupLabel: "모임 1", groupCheckImg: UIImage(named: "btnCheckBox")!),
                          Group(groupLabel: "모임 2",groupCheckImg: UIImage(named: "btnCheckBox")!),
                          Group(groupLabel: "모임 3",groupCheckImg: UIImage(named: "btnCheckBox")!),
                          Group(groupLabel: "모임 4",groupCheckImg: UIImage(named: "btnCheckBox")!)
                        ]
    
    func attribute() {
        groupTableView.register(GroupTableViewCell.self, forCellReuseIdentifier: GroupTableViewCell.groupCell)
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.count
    }
    
    var selectedGroup: String = ""
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.groupCell, for: indexPath) as! GroupTableViewCell
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

struct Group {
    let groupLabel: String
    let groupCheckImg: UIImage
}

class GroupTableViewCell: UITableViewCell {
    
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


/*
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = CalendarMainViewController
    
    func makeUIViewController(context: Context) -> CalendarMainViewController {
            return CalendarMainViewController()
        }

        func updateUIViewController(_ uiViewController: CalendarMainViewController, context: Context) {
        }
}

@available(iOS 16.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}
*/

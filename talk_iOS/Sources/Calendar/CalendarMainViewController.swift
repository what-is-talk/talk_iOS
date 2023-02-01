//
//  CalendarViewController.swift
//  talk_iOS
//
//  Created by User on 2023/01/13.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarMainViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "CalendarMainViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        
        initNavigation()
        setUpView()
        setConstraints()
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
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "CalendarAddViewController") else {
                    return
                }
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
        selectView.addSubview(downButton)
        return selectView
    }()
    
    lazy var allgroupLabel: UILabel = {
        let allgroupLabel = UILabel()
        allgroupLabel.text = "모든 모임"
        allgroupLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return allgroupLabel
    }()
    
    lazy var downButton: UIButton = {
        let downButton = UIButton()
        let downBtnImg = UIImage(named: "btnDown")
        downButton.setBackgroundImage(downBtnImg, for: .normal)
        downButton.addTarget(self, action: #selector(openView), for: .touchUpInside)
        return downButton
    }()
    
    @objc func openView() {
        
    }
    
    var selectedDate: Date = Date()
    
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
    
    lazy var scheduleList: UITableView = {
        let scheduleList = UITableView()
        scheduleList.rowHeight = 90
        return scheduleList
    }()
    
    let testData: [scheduleListData] = [
                                        scheduleListData(groupNameLabel: "UMC", scheduleLabel: "일정 내용", timeLabel: "2월 2일 10:00 ~ 2월 3일 11:00"),
                                        scheduleListData(groupNameLabel: "UMC", scheduleLabel: "내용", timeLabel: "14:00"),
                                        scheduleListData(groupNameLabel: "UMC", scheduleLabel: "내용", timeLabel: "14:00")
                                        ]
    
    func attribute() {
        scheduleList.register(ScheduleListCell.classForCoder(), forCellReuseIdentifier: ScheduleListCell.scheduleListCell)
        scheduleList.delegate = self
        scheduleList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleListCell.scheduleListCell, for: indexPath) as! ScheduleListCell
        cell.groupNameLabel.text = testData[indexPath.row].groupNameLabel
        cell.scheduleLabel.text = testData[indexPath.row].scheduleLabel
        cell.timeLabel.text = testData[indexPath.row].timeLabel
        return cell
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
        downButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.allgroupLabel.snp.right).offset(5)
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

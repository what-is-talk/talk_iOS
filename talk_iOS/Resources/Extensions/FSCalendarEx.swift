//
//  FSCalendarEx.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/31.
//

import Foundation
import FSCalendar

extension CalendarMainViewController {
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        selectedDate = dateFormatter.string(from: date)
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
        selectedDate = ""
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.eventsArray.contains(date) {
            return 1
        }
        return 0
    }
}

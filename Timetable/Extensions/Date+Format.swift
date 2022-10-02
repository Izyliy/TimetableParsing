//
//  Date+Format.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//

import UIKit

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE"
        let stringDate = dateFormatter.string(from: self)
        return stringDate.capitalized
    }

    func timetableTitle() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        let stringDate = dateFormatter.string(from: self)
        return dayOfWeek() + " | " + stringDate.capitalized
    }
}

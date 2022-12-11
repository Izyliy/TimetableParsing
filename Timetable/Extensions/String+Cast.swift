//
//  String+Cast.swift
//  Timetable
//
//  Created by Павел Грабчак on 02.10.2022.
//

import UIKit

extension String {
    func dateFromTimetableDay() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " yyyy"
        let string = self + dateFormatter.string(from: Date())
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE | dd MMMM yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        guard let date = dateFormatter.date(from: string) else { return nil }
        
        return Calendar.current.startOfDay(for: date)
    }
    
}

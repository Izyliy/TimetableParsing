//
//  ExtendedTimetableModel.swift
//  Timetable
//
//  Created by Павел Грабчак on 17.09.2022.
//

import UIKit

struct Professor {
    let name: String?
    let link: String?
}

struct TimetableLesson {
    let startTime: String?
    let endTime: String?
    let isLection: Bool?
    let professor: Professor?
    let cabinet: String?
    let className: String?
}

struct TimetableDay {
    let date: String?
    var lessons: [TimetableLesson]
}

struct GroupTimetable {
    let firstWeek: [TimetableDay]
    let secondWeek: [TimetableDay]
}

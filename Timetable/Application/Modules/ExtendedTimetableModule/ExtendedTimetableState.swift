//
//  ExtendedTimetableState.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//

import UIKit

enum TimetalbeMode {
    case extended
    case preview
}

enum TimetableType: String {
    case group
    case cabinet
}

class ExtendedTimetableState {
    var timetable: Timetable?
}

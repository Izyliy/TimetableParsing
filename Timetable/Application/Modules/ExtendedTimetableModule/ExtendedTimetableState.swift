//
//  ExtendedTimetableState.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//

import UIKit

enum TimetableMode {
    case extended
    case preview
}

class ExtendedTimetableState {
    var name: String?
    var type: TimetableType?
    
    var timetable: Timetable?
}

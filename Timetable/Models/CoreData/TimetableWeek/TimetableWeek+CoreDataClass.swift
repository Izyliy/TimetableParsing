//
//  TimetableWeek+CoreDataClass.swift
//  Timetable
//
//  Created by Павел Грабчак on 03.02.2023.
//
//

import Foundation
import CoreData

@objc(TimetableWeek)
public class TimetableWeek: NSManagedObject {
    
    public var daysArray: [TimetableDay] {
        let set = days as? Set<TimetableDay> ?? []
        return set.sorted {
            $0.date ?? Date() < $1.date ?? Date().advanced(by: 1)
        }
    }
}

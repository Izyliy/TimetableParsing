//
//  Timetable+CoreDataClass.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//
//

import Foundation
import CoreData

@objc(Timetable)
public class Timetable: NSManagedObject {
    
    public var firstWeekArray: [TimetableDay] {
        let set = firstWeek as? Set<TimetableDay> ?? []
        return set.sorted {
            $0.date ?? Date() < $1.date ?? Date().advanced(by: 1)
        }
    }
    
    public var secondWeekArray: [TimetableDay] {
        let set = secondWeek as? Set<TimetableDay> ?? []
        return set.sorted {
            $0.date ?? Date() < $1.date ?? Date().advanced(by: 1)
        }
    }
    
}

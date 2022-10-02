//
//  TimetableDay+CoreDataClass.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//
//

import Foundation
import CoreData

@objc(TimetableDay)
public class TimetableDay: NSManagedObject {
    
    public var lessonsArray: [TimetableLesson] {
        let set = lessons as? Set<TimetableLesson> ?? []
        return set.sorted {
            $0.startTime ?? "0" < $1.startTime ?? "1"
        }
    }
    
}

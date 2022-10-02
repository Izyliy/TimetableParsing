//
//  TimetableLesson+CoreDataClass.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//
//

import Foundation
import CoreData

@objc(TimetableLesson)
public class TimetableLesson: NSManagedObject {
    
    public var professorsArray: [Professor] {
        let set = professors as? Set<Professor> ?? []
        return set.sorted {
            $0.name ?? "0" < $1.name ?? "1"
        }
    }
    
}

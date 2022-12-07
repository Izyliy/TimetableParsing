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
    
    public func getPreviewDays(for date: Date) -> [TimetableDay] {
        let firstWeek = firstWeekArray
        let secondWeek = secondWeekArray
        
        guard let firstDate = firstWeek.first?.date,
              let secondDate = secondWeek.first?.date
        else { return [] }
        
        var fullDaysArray: [TimetableDay] = []
        
        if firstDate.timeIntervalSince(secondDate) > 0 {
            fullDaysArray = firstWeekArray + secondWeekArray
        } else {
            fullDaysArray = secondWeekArray + firstWeekArray
        }
        
        if let index = try? fullDaysArray.firstIndex(where: { $0.date == date }) {
            
        }
        
        return []
    }
}

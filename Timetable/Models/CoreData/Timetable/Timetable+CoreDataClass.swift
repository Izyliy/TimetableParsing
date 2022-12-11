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
    
    public func getPreviewDays(for date: Date, _ count: Int = 3) -> [TimetableDay] {
        if count <= 0 { return [] }
        
        let fullDaysArray = firstWeekArray + secondWeekArray
        var datesArray: [Date] = []
        var previewDays: [TimetableDay] = []
        var sundayCount: Int = 0
        
        for i in 1...count {
            var dateComponent = DateComponents()
            dateComponent.day = i + sundayCount - 1
            guard var newDate = Calendar.current.date(byAdding: dateComponent, to: date) else { continue }
            
            if Calendar.current.dateComponents([.weekday], from: newDate).weekday == 1 {
                sundayCount += 1
                
                dateComponent.day = i + sundayCount - 1
                newDate = Calendar.current.date(byAdding: dateComponent, to: date) ?? Date()
            }
            
            datesArray.append(newDate)
        }
        
        for date in datesArray {
            if let day = fullDaysArray.first(where: { $0.date == date }) {
                previewDays.append(day)
            } else {
                ///Tries to find a day if timetable has not been updated for a long time
                ///Do it up to 8 times ( 4 months ), no point in searching further
                for i in 1...8 {
                    var dateComponent = DateComponents()
                    dateComponent.day = -i * 14
                    let newDate = Calendar.current.date(byAdding: dateComponent, to: date)
                    
                    guard let day = fullDaysArray.first(where: { $0.date == newDate }) else { continue }
                    previewDays.append(day)
                }
            }
        }
        
        return previewDays
    }
}

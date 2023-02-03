//
//  TimetableWeek+CoreDataProperties.swift
//  Timetable
//
//  Created by Павел Грабчак on 03.02.2023.
//
//

import Foundation
import CoreData


extension TimetableWeek {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimetableWeek> {
        return NSFetchRequest<TimetableWeek>(entityName: "TimetableWeek")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: Int64  //defaults to 0?
    @NSManaged public var days: NSSet?
    @NSManaged public var timetable: Timetable?

}

// MARK: Generated accessors for days
extension TimetableWeek {

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: TimetableDay)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: TimetableDay)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSSet)

}

extension TimetableWeek : Identifiable {

}

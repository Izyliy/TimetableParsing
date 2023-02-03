//
//  Timetable+CoreDataProperties.swift
//  Timetable
//
//  Created by Павел Грабчак on 03.02.2023.
//
//

import Foundation
import CoreData


extension Timetable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timetable> {
        return NSFetchRequest<Timetable>(entityName: "Timetable")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var weeks: NSSet?

}

// MARK: Generated accessors for weeks
extension Timetable {

    @objc(addWeeksObject:)
    @NSManaged public func addToWeeks(_ value: TimetableWeek)

    @objc(removeWeeksObject:)
    @NSManaged public func removeFromWeeks(_ value: TimetableWeek)

    @objc(addWeeks:)
    @NSManaged public func addToWeeks(_ values: NSSet)

    @objc(removeWeeks:)
    @NSManaged public func removeFromWeeks(_ values: NSSet)

}

extension Timetable : Identifiable {

}

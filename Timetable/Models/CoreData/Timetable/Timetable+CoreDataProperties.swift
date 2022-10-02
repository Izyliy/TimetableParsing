//
//  Timetable+CoreDataProperties.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//
//

import Foundation
import CoreData


extension Timetable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timetable> {
        return NSFetchRequest<Timetable>(entityName: "Timetable")
    }

    @NSManaged public var type: String?
    @NSManaged public var name: String?
    @NSManaged public var firstWeek: NSSet?
    @NSManaged public var secondWeek: NSSet?

}

// MARK: Generated accessors for firstWeek
extension Timetable {

    @objc(addFirstWeekObject:)
    @NSManaged public func addToFirstWeek(_ value: TimetableDay)

    @objc(removeFirstWeekObject:)
    @NSManaged public func removeFromFirstWeek(_ value: TimetableDay)

    @objc(addFirstWeek:)
    @NSManaged public func addToFirstWeek(_ values: NSSet)

    @objc(removeFirstWeek:)
    @NSManaged public func removeFromFirstWeek(_ values: NSSet)

}

// MARK: Generated accessors for secondWeek
extension Timetable {

    @objc(addSecondWeekObject:)
    @NSManaged public func addToSecondWeek(_ value: TimetableDay)

    @objc(removeSecondWeekObject:)
    @NSManaged public func removeFromSecondWeek(_ value: TimetableDay)

    @objc(addSecondWeek:)
    @NSManaged public func addToSecondWeek(_ values: NSSet)

    @objc(removeSecondWeek:)
    @NSManaged public func removeFromSecondWeek(_ values: NSSet)

}

extension Timetable : Identifiable {

}

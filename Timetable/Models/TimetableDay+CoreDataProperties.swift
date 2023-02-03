//
//  TimetableDay+CoreDataProperties.swift
//  Timetable
//
//  Created by Павел Грабчак on 03.02.2023.
//
//

import Foundation
import CoreData


extension TimetableDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimetableDay> {
        return NSFetchRequest<TimetableDay>(entityName: "TimetableDay")
    }

    @NSManaged public var date: Date?
    @NSManaged public var weekDay: String?
    @NSManaged public var lessons: NSSet?
    @NSManaged public var week: TimetableWeek?

}

// MARK: Generated accessors for lessons
extension TimetableDay {

    @objc(addLessonsObject:)
    @NSManaged public func addToLessons(_ value: TimetableLesson)

    @objc(removeLessonsObject:)
    @NSManaged public func removeFromLessons(_ value: TimetableLesson)

    @objc(addLessons:)
    @NSManaged public func addToLessons(_ values: NSSet)

    @objc(removeLessons:)
    @NSManaged public func removeFromLessons(_ values: NSSet)

}

extension TimetableDay : Identifiable {

}

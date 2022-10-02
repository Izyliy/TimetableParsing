//
//  TimetableLesson+CoreDataProperties.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//
//

import Foundation
import CoreData


extension TimetableLesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimetableLesson> {
        return NSFetchRequest<TimetableLesson>(entityName: "TimetableLesson")
    }

    @NSManaged public var startTime: String?
    @NSManaged public var endTime: String?
    @NSManaged public var isLection: Bool
    @NSManaged public var cabinets: [String]?
    @NSManaged public var name: String?
    @NSManaged public var professors: NSSet?
    @NSManaged public var day: TimetableDay?

}

// MARK: Generated accessors for professors
extension TimetableLesson {

    @objc(addProfessorsObject:)
    @NSManaged public func addToProfessors(_ value: Professor)

    @objc(removeProfessorsObject:)
    @NSManaged public func removeFromProfessors(_ value: Professor)

    @objc(addProfessors:)
    @NSManaged public func addToProfessors(_ values: NSSet)

    @objc(removeProfessors:)
    @NSManaged public func removeFromProfessors(_ values: NSSet)

}

extension TimetableLesson : Identifiable {

}

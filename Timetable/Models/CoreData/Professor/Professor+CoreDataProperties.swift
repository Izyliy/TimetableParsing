//
//  Professor+CoreDataProperties.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//
//

import Foundation
import CoreData


extension Professor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Professor> {
        return NSFetchRequest<Professor>(entityName: "Professor")
    }

    @NSManaged public var link: String?
    @NSManaged public var name: String?
    @NSManaged public var lesson: TimetableLesson?

}

extension Professor : Identifiable {

}

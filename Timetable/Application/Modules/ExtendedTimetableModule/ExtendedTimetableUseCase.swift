//
//  ExtendedTimetableUseCase.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//

import UIKit
import CoreData
import Promises

class ExtendedTimetableUseCase {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let gateway = ExtendedTimetableGateway()

    func getTimetable(for str: String) -> Timetable? {
        do {
            let request = Timetable.fetchRequest() as NSFetchRequest<Timetable>
            let predicate = NSPredicate(format: "name CONTAINS %@", str)
            
            request.predicate = predicate
            
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func getTimetableHtml(for str: String, type: TimetableType) -> Promise<String> {
        return gateway.getTimetableHtmlFor(name: str, type: type)
    }
    
    func createTimetableAndSave(name: String,
                                type: TimetableType,
                                firstWeek: [TimetableDay],
                                secondWeek: [TimetableDay]) -> Timetable? {
        let timetable = Timetable(context: context)
        
        timetable.name = name
        timetable.type = type.getTypeString()
        timetable.creationDate = Date()
        
        guard let firstWeekSet = Set(firstWeek) as? NSSet,
              let secondWeekSet = Set(secondWeek) as? NSSet
        else {
            return nil
        }
        
        timetable.addToFirstWeek(firstWeekSet)
        timetable.addToSecondWeek(secondWeekSet)
        
        do {
            try context.save()
            return timetable
        } catch {
            return nil
        }
    }
    
    func getNewDay(with date: Date) -> TimetableDay {
        let day = TimetableDay(context: context)
        
        day.date = date
        
        return day
    }
    
    func getNewProfessor(name: String?, link: String?) -> Professor? {
        guard let name = name else { return nil }
        
        let professor = Professor(context: context)
        
        professor.name = name
        professor.link = link
        
        return professor
    }
    
    func getNewLesson(startTime: String,
                      endTime: String,
                      isLection: Bool,
                      professors: [Professor],
                      cabinets: [String],
                      name: String) -> TimetableLesson {
        let lesson = TimetableLesson(context: context)
        
        lesson.startTime = startTime
        lesson.endTime = endTime
        lesson.isLection = isLection
        lesson.cabinets = cabinets
        lesson.name = name
        
        for professor in professors {
            lesson.addToProfessors(professor)
        }

        return lesson
    }
}

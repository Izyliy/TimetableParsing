//
//  TimetableUseCase.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//

import UIKit
import CoreData
import Promises

class TimetableUseCase {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let gateway = TimetableGateway()

    func getTimetable(for str: String) -> Timetable? {
        do {
            let request = Timetable.fetchRequest() as NSFetchRequest<Timetable>
            let predicate = NSPredicate(format: "name CONTAINS %@", str)
            
            request.predicate = predicate
            
            return try context.fetch(request).last
        } catch {
            return nil
        }
    }
    
    func getTimetableHtml(for str: String, type: TimetableType) -> Promise<String> {
        return gateway.getTimetableHtmlFor(name: str, type: type)
    }
    
    func deleteTimetablesWith(name: String) -> Bool {
        do {
            let request = Timetable.fetchRequest() as NSFetchRequest<Timetable>
            let predicate = NSPredicate(format: "name CONTAINS %@", name)
            
            request.predicate = predicate
            
            let timetables = try context.fetch(request)
            
            for timetable in timetables {
                context.delete(timetable)
            }
            
            try context.save()
            
            return true
        } catch {
            return false
        }
    }
    
    func createTimetableAndSave(name: String,
                                type: TimetableType,
                                weeks: [TimetableWeek]) -> Timetable? {
        
        _ = deleteTimetablesWith(name: name)
        
        let timetable = Timetable(context: context)
        
        timetable.name = name
        timetable.type = type.getTypeString()
        timetable.creationDate = Date()
        
        for week in weeks {
            timetable.addToWeeks(week)
        }
        
        do {
            try context.save()
            return timetable
        } catch {
            return nil
        }
    }
    
    func getNewWeek(id: Int, days: [TimetableDay], title: String? = nil) -> TimetableWeek {
        let week = TimetableWeek(context: context)
        
        week.id = Int64(id)
        week.title = title
        
        for day in days {
            week.addToDays(day)
        }
        
        return week
    }
    
    func getNewDay(with date: Date) -> TimetableDay {
        let day = TimetableDay(context: context)
        
        day.date = date
        
        return day
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
    
    func getNewProfessor(name: String?, link: String?) -> Professor? {
        guard let name = name else { return nil }
        
        let professor = Professor(context: context)
        
        professor.name = name
        professor.link = link
        
        return professor
    }
}

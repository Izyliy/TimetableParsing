//
//  NotificationManager.swift
//  Timetable
//
//  Created by Павел Грабчак on 27.02.2023.
//

import CoreData
import NotificationCenter
import UserNotifications

class NotificationManager {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func scheduleNotifications(for timetableName: String, handler: ((Bool, Error?) -> Void) ) {
        guard let timetable = try? getTimetable(for: timetableName) else {
            handler(false, NSError(domain: "No timetable", code: 0))
            return
        }
        
        let todayDate: Date = Calendar.current.startOfDay(for: Date())
        let daysForNotifs = timetable.getPreviewDays(for: todayDate, 12)
        
        for day in daysForNotifs {
            guard day.date != nil else { continue }
            for lesson in day.lessonsArray {
                if let name = lesson.name, name != "" {
                    createNotification(for: lesson, of: timetableName)
                }
            }
        }
    }
    
    func createNotification(for lesson: TimetableLesson, of group: String) {
        guard
            let name = lesson.name,
            let professor = lesson.professorsArray.first?.name,
            let cabinet = lesson.cabinets?.first,
            let startTime = lesson.startTime,
            let date = lesson.day?.date
        else {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = "Расписание " + group
        content.subtitle = name
        if cabinet.lowercased() == "дистанционно" {
            content.body = startTime + " - " + professor
        } else {
            content.body = startTime + " - " + cabinet + " - " + professor
        }
        
        let time = startTime.components(separatedBy: ":")
        let hour = time.last == "00" ? (Int(time.first ?? "0") ?? 0) - 1 : (Int(time.first ?? "0") ?? 0)
        let minute = time.last == "00" ? 55 : (Int(time.last ?? "0") ?? 0)
        
        var dateComp = DateComponents()
        dateComp.calendar = .current
        dateComp.year = Calendar.current.component(.year, from: date)
        dateComp.month = Calendar.current.component(.month, from: date)
        dateComp.day = Calendar.current.component(.day, from: date)
        dateComp.hour = hour
        dateComp.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    
    func getTimetable(for str: String) throws -> Timetable? {
        let request = Timetable.fetchRequest() as NSFetchRequest<Timetable>
        let predicate = NSPredicate(format: "name CONTAINS %@", str)
        
        request.predicate = predicate
        
        return try context.fetch(request).last
    }
    
    func clearAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

//Testings
extension NotificationManager {
    func createTestNotif() {
        let content = UNMutableNotificationContent()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        dateFormatter.timeZone = .current
        content.title = "Task Fired!"
        content.body = dateFormatter.string(from: date)
        content.sound = UNNotificationSound.default

        var dateComp = DateComponents()
        dateComp.calendar = .current
        dateComp.year = 2023
        dateComp.month = 2
        dateComp.day = 28
        dateComp.hour = 16
        dateComp.minute = 58
        
        let triggerDate = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerDate)

        UNUserNotificationCenter.current().add(request)
    }
}

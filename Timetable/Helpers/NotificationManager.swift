//
//  NotificationManager.swift
//  Timetable
//
//  Created by iMac iOS Павел on 27.02.2023.
//

import CoreData
import NotificationCenter

class NotificationManager {
    func createTestNotif() {
        let content = UNMutableNotificationContent()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        dateFormatter.timeZone = .current
        content.title = "Task Fired!"
        content.body = dateFormatter.string(from: date)
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}

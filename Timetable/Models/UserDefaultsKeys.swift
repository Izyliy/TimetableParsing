//
//  UserDefaultsKeys.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.01.2023.
//
//  String keys for UserDefaults
//  Used to rule out the possibility of typo in project

import Foundation

enum UDKeys {
    enum Settings {
        /// Permission to send local notifications
        /// - Returns: Bool
        static let allowNotifications = "AllowLocalNotifications"
        
        /// Permission to cache timetables
        /// - Returns: Bool
        static let allowCache = "AllowCache"
        
        /// Permission to update timetables after a week
        /// - Returns: Bool
        static let autoUpdates = "AutoUpdates"
    }
    
    enum Develop {
        /// Should application display things, that only developer can see (netfox; additional settings)
        /// - Returns: Bool
        static let isDev = "DevMode"
        
        /// Should application display things, that only developer can see (netfox; additional settings)
        /// - Returns: Bool
        static let devAlerts = "DevAlertsOn"
    }
    
    enum State {
        /// Favourite timetable displayed at first screen of application
        /// - Returns: String
        static let mainTimetable = "MainTimetable"
    }
}

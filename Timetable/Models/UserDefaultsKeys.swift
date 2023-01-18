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
        /// Bool
        static let allowNotifications = "allowLocalNotifications"
        
        /// Permission to cache timetables
        /// Bool
        static let allowCache = "allowCache"
    }
    
    enum State {
        /// Should application display things, that only developer can see
        /// Bool
        static let isDev = "DevMode"
        
        /// Favourite timetable displayed at first screen of application
        /// String
        static let mainTimetable = "MainTimetable"
    }
}

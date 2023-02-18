//
//  MainSettingsUseCase.swift
//  Timetable
//
//  Created by Павел Грабчак on 15.01.2023.
//

import UIKit
//import CoreData

class MainSettingsUseCase {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func clearCache() {
        guard let timetables = try? context.fetch(Timetable.fetchRequest()) else { return }
        let favName = UserDefaults.standard.string(forKey: UDKeys.State.mainTimetable)
        
        for timetable in timetables {
            guard timetable.name == nil || timetable.name != favName else { continue }
            self.context.delete(timetable)
        }
        
        do {
            try self.context.save()
            print("cache cleared")
        } catch { }
    }
}

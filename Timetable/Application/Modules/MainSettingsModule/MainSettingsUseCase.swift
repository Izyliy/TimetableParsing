//
//  MainSettingsUseCase.swift
//  Timetable
//
//  Created by Павел Грабчак on 15.01.2023.
//

import Foundation

class MainSettingsUseCase {
    func getSections() -> [SettingsSection] {
        var array: [SettingsSection] = []
        
        array.append(.init(objects: [
            .init(title: "пукпук", type: .switcher, handler: { print(1) }),
            .init(title: "кхекхе", type: .disclosure, handler: { print(2) }),
            .init(title: "хахаха", type: .disclosure, handler: { print(3) }),
        ], hint: "Секция 1 для всякой хуйни"))
        
        array.append(.init(objects: [
            .init(title: "123", type: .disclosure, handler: { print(11) }),
            .init(title: "456", type: .switcher, handler: { print(22) }),
        ], hint: "Секция 2 тоже для всякой хуйни"))
        
        return array
    }
}

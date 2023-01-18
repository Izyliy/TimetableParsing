//
//  MainSettingsState.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.10.2022.
//

import UIKit

enum SettingsCellType {
    case switcher
    case disclosure
}

struct SettingsObject {
    var title: String
    var type: SettingsCellType
    var isOn: Bool?
    
    var handler: ((Bool?) -> Void)
}

struct SettingsSection {
    var objects: [SettingsObject]
    var hint: String?
}

struct MainSettingsState {
    var sections: [SettingsSection]
}

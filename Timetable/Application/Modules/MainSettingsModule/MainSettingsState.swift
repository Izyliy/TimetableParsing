//
//  MainSettingsState.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.10.2022.
//

import UIKit

struct SettingsTableObject {
    var title: String
    var icon: UIImage?
    
    var handler: (() -> Void)
}

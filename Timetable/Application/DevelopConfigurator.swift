//
//  DevelopConfigurator.swift
//  Timetable
//
//  Created by Павел Грабчак on 06.02.2023.
//

import Foundation
import netfox

class DevelopConfigurator {
    static let sharedInstance = DevelopConfigurator()
    
    func setDev(to isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: UDKeys.Develop.isDev)
        
        if isOn {
            NFX.sharedInstance().start()
        } else {
            NFX.sharedInstance().stop()
        }
    }
}

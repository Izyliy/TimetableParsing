//
//  UINavigationBar+Appearance.swift
//  Timetable
//
//  Created by Павел Грабчак on 23.03.2022.
//

import UIKit

extension UINavigationBar {
    
    func defaultAppearance() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor(red: 247/256, green: 248/256, blue: 249/256, alpha: 1)

        self.standardAppearance = standardAppearance
        self.scrollEdgeAppearance = standardAppearance
        self.compactAppearance = standardAppearance
    }
}

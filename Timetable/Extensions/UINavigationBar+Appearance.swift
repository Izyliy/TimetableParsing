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
        standardAppearance.backgroundColor = UIColor(named: "BrandGreen") //(red: 120/256, green: 175/256, blue: 90/256, alpha: 1)
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        tintColor = .white
        
        self.standardAppearance = standardAppearance
        self.scrollEdgeAppearance = standardAppearance
        self.compactAppearance = standardAppearance
    }
}

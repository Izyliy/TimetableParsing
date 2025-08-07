//
//  MainMapDisplayManager.swift
//  Timetable
//
//  Created by Павел Грабчак on 07.08.2025.
//

import UIKit

class MainMapDisplayManager: NSObject {
    weak var view: MainMapViewController?
    
    init(view: MainMapViewController) {
        self.view = view
        
        super.init()
    }
    
//    func updateTableView(with sections: [SettingsSection]) {
//        self.timetableSections = sections
//        
//        tableView.reloadData()
//    }
}

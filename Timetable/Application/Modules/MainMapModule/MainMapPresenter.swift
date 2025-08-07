//
//  MainMapPresenter.swift
//  Timetable
//
//  Created by Павел Грабчак on 07.08.2025.
//

import Foundation

class MainMapPresenter {
    private var state = MainMapState()
    
    weak var view: MainMapViewController?

    init(view: MainMapViewController? = nil) {
        self.view = view
    }
    
    func setupInitialState() {
        
    }
}

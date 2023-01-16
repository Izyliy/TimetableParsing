//
//  MainSettingsPresenter.swift
//  Timetable
//
//  Created by Павел Грабчак on 15.01.2023.
//

import Foundation

class MainSettingsPresenter {
    private let useCase = MainSettingsUseCase()
    private var state = MainSettingsState(sections: [])
    
    weak var view: MainSettingsViewController?

    init(view: MainSettingsViewController? = nil) {
        self.view = view
    }
    
    func setupInitialState() {
        state.sections = useCase.getSections()
        
        view?.updateTableView(with: state.sections)
    }
}

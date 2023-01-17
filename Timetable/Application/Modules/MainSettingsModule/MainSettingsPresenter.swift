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
        state.sections = getSections()
        
        view?.updateTableView(with: state.sections)
    }
    
    private func getSections() -> [SettingsSection] {
        var array: [SettingsSection] = []
        
        array.append(.init(objects: [
            .init(title: "пукпук", type: .switcher, handler: setNotif),
            .init(title: "кхекхе", type: .disclosure, handler: setNotif),
            .init(title: "хахаха", type: .disclosure, handler: setNotif),
        ], hint: "Секция 1 для всякой фигни"))
        
        array.append(.init(objects: [
            .init(title: "123", type: .disclosure, handler: setNotif),
            .init(title: "456", type: .switcher, handler: setNotif),
        ], hint: "Секция 2 тоже для всякой хуйни"))
        
        return array
    }
    
    private func setNotif(to isOn: Bool?) {
        print(isOn)
    }
}

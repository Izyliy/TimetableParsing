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
            .init(title: "Разрешить уведомления", type: .switcher, handler: setNotif),
        ], hint: "Уведомления позволяют приложению напоминать о парах"))
        
        array.append(.init(objects: [
            .init(title: "Кэширование расписаний", type: .switcher, handler: setNotif),
            .init(title: "Очистить кэш", type: .disclosure, handler: setNotif),
        ], hint: "Кэш содержит данные о расписании ранее открытых групп. Расписание кэшированной группы можно открыть без "))
        
        array.append(.init(objects: [
            .init(title: "123", type: .disclosure, handler: setNotif),
        ], hint: "Разраб"))
        
        return array
    }
    
    private func setNotif(to isOn: Bool?) {
        print(isOn)
    }
}

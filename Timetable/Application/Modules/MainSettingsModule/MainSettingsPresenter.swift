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
            .init(title: "Разрешить уведомления", type: .switcher, handler: setNotification),
        ], hint: "Уведомления позволяют приложению напоминать о парах"))
        
        array.append(.init(objects: [
            .init(title: "Кэширование расписаний", type: .switcher, handler: setCache),
            .init(title: "Очистить кэш", type: .disclosure, handler: clearCache),
        ], hint: "Кэш содержит данные о расписании ранее открытых групп. Расписание кэшированной группы можно открыть без доступа к интернету"))
        
        array.append(.init(objects: [
            .init(title: "Обновление расписаний", type: .switcher, handler: disableDevMode),
        ], hint: "Автоматическое обновление кэша позваляет актуализировать расписания при доступе к интернету и всегда видеть правильное расписание"))
        
        array.append(.init(objects: [
            .init(title: "Выключить", type: .disclosure, handler: disableDevMode),
        ], hint: "Режим разработчика включен!"))
        
        return array
    }
    
    private func setNotification(to isOn: Bool?) {
        guard let isOn else { return }
        print("set notifications to \(isOn)")
    }
    
    private func setCache(to isOn: Bool?) {
        guard let isOn else { return }
        print("set cache to \(isOn)")
    }
    
    private func clearCache(_ isOn: Bool?) {
        print("cache cleared")
    }
    
    private func disableDevMode(_ isOn: Bool?) {
        print("dev mode disabled")
    }
}

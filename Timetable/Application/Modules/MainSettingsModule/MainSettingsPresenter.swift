//
//  MainSettingsPresenter.swift
//  Timetable
//
//  Created by Павел Грабчак on 15.01.2023.
//

import Foundation
import UserNotifications
import netfox
import FirebaseAnalytics

class MainSettingsPresenter {
    private let useCase = MainSettingsUseCase()
    private var state = MainSettingsState(sections: [])
    private let defaults = UserDefaults.standard
    
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
            .init(title: "Разрешить уведомления", type: .switcher, isOn: defaults.bool(forKey: UDKeys.Settings.allowNotifications), handler: setNotification),
        ], hint: "Уведомления позволяют приложению напоминать о парах"))
        
        //TODO: implement allowing cache
        array.append(.init(objects: [
//            .init(title: "Кэширование расписаний", type: .switcher, isOn: defaults.bool(forKey: UDKeys.Settings.allowCache), handler: setCache),
            .init(title: "Очистить кэш", type: .disclosure, handler: clearCache),
        ], hint: "Кэш содержит данные о расписании ранее открытых групп. Расписание кэшированной группы можно открыть без доступа к интернету"))
        
        array.append(.init(objects: [
            .init(title: "Обновление расписаний", type: .switcher, isOn: defaults.bool(forKey: UDKeys.Settings.autoUpdates), handler: setAutoUpdates),
        ], hint: "Автоматическое обновление кэша позваляет актуализировать расписания при доступе к интернету и всегда видеть правильное расписание"))
        
        guard UserDefaults.standard.bool(forKey: UDKeys.Develop.isDev) == true else { return array }
                
        array.append(.init(objects: [
            .init(title: "Выключить devMode", type: .disclosure, handler: disableDevMode),
            .init(title: "Просмотр CoreData", type: .disclosure, handler: viewCoreDataObjects),
            .init(title: "Создать уведомление", type: .disclosure, handler: testNotification),
            .init(title: "Test Crush", type: .disclosure, handler: testCrush),
            .init(title: "FIRAnalytics Test Log", type: .disclosure, handler: testLog),
            .init(title: "Debug Alerts", type: .switcher, handler: { _ in  }),
        ], hint: "Режим разработчика включен!"))
        
        return array
    }
    
    private func setNotification(to isOn: Bool?) {
        guard let isOn else { return }
        
        tryToSetNotifications(to: isOn)
    }
    
    private func setCache(to isOn: Bool?) {
        guard let isOn else { return }
        defaults.set(isOn, forKey: UDKeys.Settings.allowCache)
    }
    
    private func clearCache(_ isOn: Bool?) {
        view?.showConfirmMessage("Очистка кэша приведет к потере всех сохраненных расписаний, для повторного просмотра будет необходимо интернет соединение",
                                 title: "Вы уверены?",
                                 handler: {  _ in self.useCase.clearCache() })
    }
    
    private func setAutoUpdates(to isOn: Bool?) {
        guard let isOn else { return }
        defaults.set(isOn, forKey: UDKeys.Settings.autoUpdates)
    }
    
    private func disableDevMode(_ isOn: Bool?) {
        DevelopConfigurator.sharedInstance.setDev(to: false)
        setupInitialState()
    }
    
    private func viewCoreDataObjects(_ isOn: Bool?) {
        view?.openCoreDataView?()
    }
    
    private func testNotification(_ isOn: Bool?) {
        createTestNotification()
    }
    
    private func testCrush(_ isOn: Bool?) {
        let n = [0]
        let _ = n[1]
    }
    
    private func testLog(_ isOn: Bool?) {
        Analytics.logEvent("test_log", parameters: [
            "test": "123"
        ])
    }
}

extension MainSettingsPresenter {
    private func tryToSetNotifications(to isOn: Bool) {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { (settings) in
            let status = settings.authorizationStatus
            
            switch status {
            case .notDetermined:
                current.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        self.defaults.set(isOn, forKey: UDKeys.Settings.allowNotifications)
                        DispatchQueue.main.async {
                            self.scheduleNotifications(with: isOn)
                        }
                    } else {
                        self.defaults.set(false, forKey: UDKeys.Settings.allowNotifications)
                        DispatchQueue.main.async {
                            self.scheduleNotifications(with: isOn)
                            self.view?.updateTableView(with: self.getSections())
                        }
                    }
                }
            case .denied:
                DispatchQueue.main.async {
                    self.view?.showMessage("Разрешение на уведомление ранее было отклонено, для получения уведомлений разрешите их отправку в настройках телефона")
                    self.view?.updateTableView(with: self.getSections())
                }
            case .authorized:
                self.defaults.set(isOn, forKey: UDKeys.Settings.allowNotifications)
                DispatchQueue.main.async {
                    self.scheduleNotifications(with: isOn)
                }
            default:
                return
            }
        })
    }
        
    private func scheduleNotifications(with isOn: Bool) {
        let notificManager = NotificationManager()
        
        if isOn {
            guard let groupName = UserDefaults.standard.string(forKey: UDKeys.State.mainTimetable) else {
                DispatchQueue.main.async {
                    self.defaults.set(false, forKey: UDKeys.Settings.allowNotifications)
                    self.view?.updateTableView(with: self.getSections())
                    self.view?.showError(message: "Уведомления устанавливаются для избранного расписания.\nДобавьте расписание в избранное для получения уведомлений о парах")
                }
                return
            }
            
            notificManager.scheduleNotifications(for: groupName) { success, error in
                if success {
                    //all done, nice
                } else if let error = error {
                    DispatchQueue.main.async {
                        self.defaults.set(false, forKey: UDKeys.Settings.allowNotifications)
                        self.view?.updateTableView(with: self.getSections())
                        self.view?.showError(message: "Что-то пошло не так")
                    }
                    print(error.localizedDescription)
                } else {
                    self.defaults.set(false, forKey: UDKeys.Settings.allowNotifications)
                    self.view?.updateTableView(with: self.getSections())
                    self.view?.showError(message: "Что-то пошло не так")
                }
            }
        } else {
            notificManager.clearAllNotifications()
        }
    }
    
    private func createTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Расписание ПИ2241"
        content.subtitle = "Иностранный язык делового и профессионального общения"
        content.body = "11:35 - 222гл - Замотайлова Д.А."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
        print("notif created")
    }
}

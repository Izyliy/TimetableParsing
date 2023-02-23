//
//  TimetablePresenter.swift
//  Timetable
//
//  Created by Павел Грабчак on 01.10.2022.
//

import UIKit
import SwiftSoup

class TimetablePresenter {
    private let useCase = TimetableUseCase()
    private let state = TimetableState()
    
    weak var view: TimetableViewController?

    init(view: TimetableViewController? = nil) {
        self.view = view
    }
    
    func setupInitialState(name: String?, type: TimetableType, mode: TimetableMode) {
        state.name = name
        state.type = type
        state.mode = mode
        
        guard let name else { return }
        
        if let timetable = useCase.getTimetable(for: name) {
            if UserDefaults.standard.bool(forKey: UDKeys.Settings.autoUpdates) &&
                Date().timeIntervalSince(timetable.creationDate ?? Date()) > 60 * 60 * 24 * 7 {
                fetchTimetable(forReload: true)
            }
            state.timetable = timetable
            let week = formDaysArray(mode: mode)
            view?.updateTimetable(week: week)
        } else {
            fetchTimetable(forReload: false)
        }
    }
    
    func getWeek(index: Int) -> [TimetableDay]? {
        if index == 0 {
            return state.timetable?.firstWeekArray
        } else {
            return state.timetable?.secondWeekArray
        }
    }
    
    func setFavourite() {
        if UserDefaults.standard.string(forKey: UDKeys.State.mainTimetable) != state.name {
            UserDefaults.standard.set(state.name, forKey: UDKeys.State.mainTimetable)
            UserDefaults.standard.set(state.type == .group, forKey: UDKeys.State.isGroupMainType)
            view?.showMessage("Избранное расписание записано")
        } else {
            view?.showError(message: "Данное расписание уже является избранным") //TODO: вместо ошибки убирать из избранного
        }
    }
    
    func showFullTimetable() {
        view?.showFullTimetable?()
    }
    
    func fetchTimetable(forReload: Bool) {
        guard let name = state.name,
              let type = state.type,
              let mode = state.mode
        else { return }
        
        view?.startIndication()
        useCase.getTimetableHtml(for: name, type: type).then { html in
            self.parseTimetable(with: html, name: name, type: type)
            let week = self.formDaysArray(mode: mode)
            self.view?.updateTimetable(week: week)
        }.catch { _ in
            self.view?.showError(message: "Не удалось \(forReload ? "обновить" : "загрузить") расписание, проверьте соединение с интернетом и попробуйте снова", handler: { _ in
                guard !forReload else { return }
                self.view?.popModule?()
            })
        }.always {
            self.view?.stopIndication()
        }
    }
    
    func refreshViewIfNeeded() {
        guard state.mode == .preview else { return }
        
        if let timetableName = UserDefaults.standard.string(forKey: UDKeys.State.mainTimetable), timetableName != state.name {
            state.name = timetableName
            
            view?.title = timetableName
            view?.updateVisuals(hasName: state.name != nil)
            view?.setNavButtonAction(for: state.mode ?? .preview)
            
            if let timetable = useCase.getTimetable(for: timetableName) {
                state.timetable = timetable
                let week = formDaysArray(mode: state.mode ?? .extended)
                view?.updateTimetable(week: week)
            } else {
                fetchTimetable(forReload: false)
            }
        }
    }
    
    func getMode() -> TimetableMode? {
        state.mode
    }
    
    private func formDaysArray(mode: TimetableMode) -> [TimetableDay] {
        switch mode {
        case .extended:
            return state.timetable?.firstWeekArray ?? []
        case .preview:
            guard let timetable = state.timetable else { return [] }
            
            let date = Calendar.current.startOfDay(for: Date())
            
            return timetable.getPreviewDays(for: date)
        }
    }
    
    private func parseTimetable(with html: String, name: String, type: TimetableType) {
        do {
            let doc = try SwiftSoup.parse(html)
            
            let firstWeekDoc = try doc.select("div").filter({ try $0.classNames().contains("schedule-first-week") }).first
            let secondWeekDoc = try doc.select("div").filter({ try $0.classNames().contains("schedule-second-week") }).first
            
            var weekArray: [TimetableWeek] = []
            
            if let firstWeek = try parseWeek(with: firstWeekDoc, id: 0) {
                weekArray.append(firstWeek)
            }
            
            if let secondWeek = try parseWeek(with: secondWeekDoc, id: 1) {
                weekArray.append(secondWeek)
            }
                        
            state.timetable = useCase.createTimetableAndSave(name: name,
                                                             type: type,
                                                             weeks: weekArray)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func parseWeek(with html: Element?, id: Int, title: String? = nil) throws -> TimetableWeek? {
        guard let dayDocs = try html?.select("div").filter({ try !$0.className().contains("week") }) else { return nil }
        var daysArray: [TimetableDay] = []
        
        for dayDoc in dayDocs {
            let lessons = try dayDoc.select("tr")
            let dayDate = try dayDoc.select("h4").first()?.text() ?? ""
            let date = dayDate.dateFromTimetableDay() ?? Date()
            
            let day = useCase.getNewDay(with: date)
            
            for lesson in lessons {
                let timeMas = try lesson.select("td")
                    .filter({ try $0.classNames().contains("time") })
                    .first?
                    .text()
                    .split(separator: " ")
                
                let startTime = String(timeMas?.first ?? "")
                let endTime = String(timeMas?.last ?? "")

                let isLection = try lesson.select("td")
                    .filter({ try $0.classNames().contains("lection") })
                    .first?
                    .className()
                    .contains("yes") ?? false
                
                var profArray: [Professor?] = []
                let profDocs = try lesson.select("td")
                    .filter({ try $0.classNames().contains("diss") })
                    .first?
                    .select("a")
                
                if let profDocs = profDocs {
                    for profDoc in profDocs {
                        let profName = try profDoc.text()
                        let profLink = try profDoc.attr("href")
                        
                        profArray.append(useCase.getNewProfessor(name: profName, link: profLink))
                    }
                }
                
//                let profName = try profDoc?.text()
//                let profLink = try profDoc?.attr("href")
//                let professor = useCase.getNewProfessor(name: profName, link: profLink)

                let cabinet = try lesson.select("td")
                    .filter({ try $0.classNames().contains("who-where") })
                    .first?
                    .text() ?? ""
                
//
//                let className = try lesson.select("td")
//                    .filter({ try $0.classNames().contains("diss") })
//                    .first?
//                    .select("strong")
//                    .first()?
//                    .text()
                
                var dropNumber = 0
                for prof in profArray {
                    dropNumber += prof?.name?.count ?? 0
                    dropNumber += 1
                }
                
                let classNameSubstring = try lesson.select("td")
                    .filter({ try $0.classNames().contains("diss") })
                    .first?
                    .text()
                    .dropLast(dropNumber)
                let className = String(classNameSubstring ?? "")
                                
                let lsn = useCase.getNewLesson(startTime: startTime,
                                               endTime: endTime,
                                               isLection: isLection,
                                               professors: profArray.compactMap{ $0 } ,
                                               cabinets: [cabinet],
                                               name: className)
                
                day.addToLessons(lsn)
            }
            
            daysArray.append(day)
        }
        
        return useCase.getNewWeek(id: id, days: daysArray, title: title)
    }
}

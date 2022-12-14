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
    
    func setupInitialState(name: String, type: TimetableType, mode: TimetableMode) {
        state.name = name
        state.type = type
        state.mode = mode
        
        if let timetable = useCase.getTimetable(for: name) {
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
        if UserDefaults.standard.string(forKey: "MainTimetable") != state.name {
            UserDefaults.standard.set(state.name, forKey: "MainTimetable")
            view?.showMessage("Избранное расписание записано")
        } else {
            view?.showError(message: "Данное расписание уже является избранным") //TODO: вместо ошибки убирать из избранного
        }
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
            self.view?.showError(message: "Не удалось загрузить расписание, проверьте соединение с интернетом и попробуйте снова", handler: { _ in
                guard !forReload else { return }
                self.view?.popModule?()
            })
        }.always {
            self.view?.stopIndication()
        }
    }
    
    func refreshViewIfNeeded() {
        guard state.mode == .preview else { return }
        
        if let timetableName = UserDefaults.standard.string(forKey: "MainTimetable"), timetableName != state.name {
            state.name = timetableName
            view?.title = timetableName
            if let timetable = useCase.getTimetable(for: timetableName) {
                state.timetable = timetable
                let week = formDaysArray(mode: state.mode ?? .extended)
                view?.updateTimetable(week: week)
            } else {
                fetchTimetable(forReload: false)
            }
        }
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
            
            let firstWeek = try parseWeek(with: firstWeekDoc)
            let secondWeek = try parseWeek(with: secondWeekDoc)
            
            state.timetable = useCase.createTimetableAndSave(name: name,
                                                             type: type,
                                                             firstWeek: firstWeek,
                                                             secondWeek: secondWeek)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func parseWeek(with html: Element?) throws -> [TimetableDay] {
        guard let dayDocs = try html?.select("div").filter({ try !$0.className().contains("week") }) else { return [] }
        var week: [TimetableDay] = []
        
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
                
                let profDoc = try lesson.select("td")
                    .filter({ try $0.classNames().contains("diss") })
                    .first?
                    .select("a")
                    .first()
                
                let profName = try profDoc?.text()
                let profLink = try profDoc?.attr("href")
                let professor = useCase.getNewProfessor(name: profName, link: profLink)

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
                
                let classNameSubstring = try lesson.select("td")
                    .filter({ try $0.classNames().contains("diss") })
                    .first?
                    .text()
                    .dropLast(professor?.name?.count ?? 0)
                let className = String(classNameSubstring ?? "")
                                
                let lsn = useCase.getNewLesson(startTime: startTime,
                                               endTime: endTime,
                                               isLection: isLection,
                                               professors: [professor].compactMap{ $0 } ,
                                               cabinets: [cabinet],
                                               name: className)
                
                day.addToLessons(lsn)
            }
            
            week.append(day)
        }
        
        return week
    }
}

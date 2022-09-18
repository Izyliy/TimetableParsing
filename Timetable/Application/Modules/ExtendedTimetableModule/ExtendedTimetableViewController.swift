//
//  ExtendedTimetableViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 17.09.2022.
//

import UIKit
import SwiftSoup

class ExtendedTimetableViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .grouped)
                
        return tableView
    }()
    
    let gateway = ExtendedTimetableGateway()
    var displayManager: ExtendedTimetableDisplayManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        displayManager = ExtendedTimetableDisplayManager(tableView: tableView, view: self)
        
        tableView.delegate = displayManager
        tableView.dataSource = displayManager
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height)
        }

        view.backgroundColor = .lightGray
    }
    
    func configure(group: String) {
        
        gateway.getTimetableHtmlFor(group).then { html in
            self.parseTimetableWith(html: html)
        }
    }
    
    func parseTimetableWith(html: String) {
        do {
            let doc = try SwiftSoup.parse(html)
            
            let firstWeekDoc = try doc.select("div").filter({ try $0.classNames().contains("schedule-first-week") }).first
            let secondWeekDoc = try doc.select("div").filter({ try $0.classNames().contains("schedule-second-week") }).first
            
            let firstWeek = try parseWeekWith(html: firstWeekDoc)
            let secondWeek = try parseWeekWith(html: secondWeekDoc)

            displayManager?.updateTableView(with: firstWeek)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func parseWeekWith(html: Element?) throws -> [TimetableDay] {
        guard let dayDocs = try html?.select("div").filter({ try !$0.className().contains("week") }) else { return [] }
        var week: [TimetableDay] = []
        
        for day in dayDocs {
            let lessons = try day.select("tr")
            var day = TimetableDay(date: "", lessons: [])
            
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
                    .contains("yes")
                
                let profDoc = try lesson.select("td")
                    .filter({ try $0.classNames().contains("diss") })
                    .first?
                    .select("a")
                    .first()
                
                let profName = try profDoc?.text()
                let profLink = try profDoc?.attr("href")
                let professor = Professor(name: profName, link: profLink)

                let cabinet = try lesson.select("td")
                    .filter({ try $0.classNames().contains("who-where") })
                    .first?
                    .text()
                
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
                    .dropLast(professor.name?.count ?? 0)
                let className = String(classNameSubstring ?? "")
                
                let lsn = TimetableLesson(
                    startTime: startTime,
                    endTime: endTime,
                    isLection: isLection,
                    professor: professor,
                    cabinet: cabinet,
                    className: className)
                
                day.lessons.append(lsn)
            }
            
            week.append(day)
        }
        
        print(week)
        return week
    }
}

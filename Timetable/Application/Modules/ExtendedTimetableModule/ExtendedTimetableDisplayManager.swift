//
//  ExtendedTimetableDisplayManager.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.09.2022.
//

import UIKit

class ExtendedTimetableDisplayManager: NSObject {
    var tableView: UITableView
    var timetableWeek: [TimetableDay]
    weak var view: ExtendedTimetableViewController?
    
    init(tableView: UITableView, view: ExtendedTimetableViewController) {
        self.tableView = tableView
        self.timetableWeek = []
        self.view = view
        super.init()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(LessonTableViewCell.self, forCellReuseIdentifier: "LessonTableViewCell")
        
        tableView.reloadData()
    }
    
    func createCell(indexPath: IndexPath) -> LessonTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LessonTableViewCell") as? LessonTableViewCell else { return LessonTableViewCell() }

        let section = indexPath.section
        let row = indexPath.row

        cell.setup(lesson: timetableWeek[section].lessons[row])

        return cell
    }
    
    func updateTableView(with week: [TimetableDay]) {
        self.timetableWeek = week
        
        tableView.reloadData()
    }
}

extension ExtendedTimetableDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}

extension ExtendedTimetableDisplayManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        timetableWeek.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timetableWeek[section].lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }
}

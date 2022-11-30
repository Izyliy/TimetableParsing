//
//  TimetableDisplayManager.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.09.2022.
//

import UIKit

class TimetableDisplayManager: NSObject {
    var tableView: UITableView
    var timetableWeek: [TimetableDay]
    weak var view: TimetableViewController?
    private var mode: TimetableMode?
    
    init(tableView: UITableView, view: TimetableViewController) {
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

        cell.setup(lesson: timetableWeek[section].lessonsArray[row])

        return cell
    }
    
    func updateTableView(with week: [TimetableDay], mode: TimetableMode) {
        self.timetableWeek = week
        self.mode = mode
        
        tableView.reloadData()
    }
}

extension TimetableDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension//64
    }
}

extension TimetableDisplayManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        timetableWeek[section].date?.timetableTitle()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        timetableWeek.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timetableWeek[section].lessonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }
}

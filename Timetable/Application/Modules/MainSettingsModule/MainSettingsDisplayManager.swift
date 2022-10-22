//
//  MainSettingsDisplayManager.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.10.2022.
//

import UIKit

class MainSettingsDisplayManager: NSObject {
    var tableView: UITableView
    weak var view: MainSettingsViewController?
    
    var timetableObjects: [SettingsTableObject]
    
    init(tableView: UITableView, view: MainSettingsViewController) {
        self.tableView = tableView
        self.view = view
        self.timetableObjects = []
        super.init()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset = .zero

        tableView.register(IconTitleTableViewCell.self, forCellReuseIdentifier: "IconTitleTableViewCell")
        
        tableView.reloadData()
    }
    
    func createCell(indexPath: IndexPath) -> IconTitleTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IconTitleTableViewCell") as? IconTitleTableViewCell else { return IconTitleTableViewCell() }
        
        let object = timetableObjects[indexPath.row]

        cell.configure(title: object.title, icon: object.icon)

        return cell
    }
    
    func updateTableView(with objects: [SettingsTableObject]) {
        self.timetableObjects = objects
        
        tableView.reloadData()
    }
}

extension MainSettingsDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        timetableObjects[indexPath.row].handler()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
//        64
    }
}

extension MainSettingsDisplayManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timetableObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }
}

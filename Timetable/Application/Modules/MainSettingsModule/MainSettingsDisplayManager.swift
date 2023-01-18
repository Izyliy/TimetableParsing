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
    
    var timetableSections: [SettingsSection]
    
    init(tableView: UITableView, view: MainSettingsViewController) {
        self.tableView = tableView
        self.view = view
        self.timetableSections = []
        super.init()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset = .zero

        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        
        tableView.reloadData()
    }
    
    func createCell(indexPath: IndexPath) -> SettingsTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as? SettingsTableViewCell else { return SettingsTableViewCell() }
        
        let object = timetableSections[indexPath.section].objects[indexPath.row]

        cell.configure(with: object)
        
        if let isOn = object.isOn {
            cell.switchView.setOn(isOn, animated: false)
        }

        return cell
    }
    
    func updateTableView(with sections: [SettingsSection]) {
        self.timetableSections = sections
        
        tableView.reloadData()
    }
}

extension MainSettingsDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard timetableSections[indexPath.section].objects[indexPath.row].type != .switcher else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        timetableSections[indexPath.section].objects[indexPath.row].handler(nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
//        64
    }
}

extension MainSettingsDisplayManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        timetableSections[section].hint
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        timetableSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timetableSections[section].objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }
}

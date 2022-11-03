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

        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        
        tableView.reloadData()
    }
    
    func createCell(indexPath: IndexPath, switchable: Bool) -> SettingsTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as? SettingsTableViewCell else { return SettingsTableViewCell() }
        
        let object = timetableObjects[indexPath.row]
        
        if switchable {
            cell.selectionStyle = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }

        cell.configure(title: object.title, switchable: switchable)

        return cell
    }
    
    func updateTableView(with objects: [SettingsTableObject]) {
        self.timetableObjects = objects
        
        tableView.reloadData()
    }
}

extension MainSettingsDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        switch indexPath.row {
        case 2:
            return createCell(indexPath: indexPath, switchable: false)
        default:
            return createCell(indexPath: indexPath, switchable: true)
        }
    }
}

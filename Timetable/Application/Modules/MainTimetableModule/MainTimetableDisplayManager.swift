//
//  MainTimetableDisplayManager.swift
//  Timetable
//
//  Created by Павел Грабчак on 15.09.2022.
//

import UIKit

class MainTimetableDisplayManager: NSObject {
    var tableView: UITableView
    var groupList: GroupList
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.groupList = .init()
        super.init()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(SuggestedGroupTableViewCell.self, forCellReuseIdentifier: "SuggestedGroupTableViewCell")
        
        tableView.reloadData()
    }
    
    func createCell(indexPath: IndexPath) -> SuggestedGroupTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedGroupTableViewCell") as? SuggestedGroupTableViewCell else { return SuggestedGroupTableViewCell() }
        
        let index = indexPath.row
        cell.setup(group: groupList.suggestions[index])
        
        return cell
    }
    
    func updateTableView(with groups: GroupList) {
        self.groupList = groups
        
        tableView.reloadData()
    }
}

extension MainTimetableDisplayManager: UITableViewDelegate {
    
}

extension MainTimetableDisplayManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupList.suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }
}

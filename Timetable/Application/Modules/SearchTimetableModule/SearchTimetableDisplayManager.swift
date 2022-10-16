//
//  SearchTimetableDisplayManager.swift
//  Timetable
//
//  Created by Павел Грабчак on 15.09.2022.
//

import UIKit

class SearchTimetableDisplayManager: NSObject {
    var tableView: UITableView
    var groupList: GroupList
    weak var view: SearchTimetableViewController?
    
    init(tableView: UITableView, view: SearchTimetableViewController) {
        self.tableView = tableView
        self.groupList = .init()
        self.view = view
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

extension SearchTimetableDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        view?.openTimetableForGroup?(groupList.suggestions[row].value)
    }
}

extension SearchTimetableDisplayManager: UITableViewDataSource {
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

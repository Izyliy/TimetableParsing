//
//  SearchTimetableDisplayManager.swift
//  Timetable
//
//  Created by Павел Грабчак on 15.09.2022.
//

import UIKit

class SearchTimetableDisplayManager: NSObject {
    var tableView: UITableView
    var suggestionsList: SuggestionsList
    weak var view: SearchTimetableViewController?
    
    init(tableView: UITableView, view: SearchTimetableViewController) {
        self.tableView = tableView
        self.suggestionsList = SuggestionsList(query: "", suggestions: [])
        self.view = view
        super.init()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false

        tableView.register(SuggestionTableViewCell.self, forCellReuseIdentifier: "SuggestionTableViewCell")
        
        tableView.reloadData()
    }
    
    func createCell(indexPath: IndexPath) -> SuggestionTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionTableViewCell") as? SuggestionTableViewCell else { return SuggestionTableViewCell() }
        
        let index = indexPath.row
        cell.setup(group: suggestionsList.suggestions[index])
        
        return cell
    }
    
    func updateTableView(with groups: SuggestionsList) {
        self.suggestionsList = groups
        
        tableView.reloadData()
    }
}

extension SearchTimetableDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let name = suggestionsList.suggestions[row].value
        let type = view?.getTimetableType() ?? .group
        
        view?.openTimetableForGroup?(name, type)
    }
}

extension SearchTimetableDisplayManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        suggestionsList.suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }
}

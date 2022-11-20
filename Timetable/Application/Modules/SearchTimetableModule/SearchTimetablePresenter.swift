//
//  SearchTimetablePresenter.swift
//  Timetable
//
//  Created by Павел Грабчак on 11.09.2022.
//

import Foundation

class SearchTimetablePresenter {
    private let gateway = SearchTimetableUseCase()
    private var state = SearchTimetableState()
    
    weak var view: SearchTimetableViewController?
    
    init(view: SearchTimetableViewController? = nil) {
        self.view = view
    }
    
    func fetchGroupList(for name: String, of type: TimetableType) {
        let date = Date()
        gateway.getGroupsSuggestionDataFor(name: name, type: type).then { list in
            guard self.state.reloadDate < date else { return }
            
            self.state.list = list
            self.state.reloadDate = date
            self.view?.updateTimetable(with: list)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}

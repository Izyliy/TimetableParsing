//
//  SearchTimetableUseCase.swift
//  Timetable
//
//  Created by Павел Грабчак on 20.11.2022.
//

import Foundation
import Promises

class SearchTimetableUseCase {
    let gateway = SearchTimetableGateway()
    
    func getGroupsSuggestionDataFor(name: String, type: TimetableType) -> Promise<SuggestionsList> {
        gateway.getGroupsSuggestionDataFor(name: name, type: type)
    }
}

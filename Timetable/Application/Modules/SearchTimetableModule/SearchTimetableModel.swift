//
//  SearchTimetableModel.swift
//  Timetable
//
//  Created by Павел Грабчак on 11.09.2022.
//

import UIKit

// https://s.kubsau.ru/bitrix/components/atom/atom.education.schedule-real/get.php?query=%D0%9F%D0%9822&type_schedule=1

// MARK: - GroupList Models
struct SuggestionsList: Codable {
    let query: String
    let suggestions: [Suggestion]
    
    struct Suggestion: Codable {
        let value: String
        let data: String
    }
}

enum SearchType: Int {
    case group = 0
    case cabinet = 1
    
    func getRequestInt() -> String {
        switch self {
        case .group:
            return "1"
        case .cabinet:
            return "3"
        }
    }
}

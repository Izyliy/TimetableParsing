//
//  MainTimetableModel.swift
//  Timetable
//
//  Created by Павел Грабчак on 11.09.2022.
//

import UIKit

// https://s.kubsau.ru/bitrix/components/atom/atom.education.schedule-real/get.php?query=%D0%9F%D0%9822&type_schedule=1

// MARK: - GroupList Models
struct GroupList: Codable {
    let query: String
    let suggestions: [GroupSuggestion]
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(GroupList.self, from: data)
    }
    
    init() {
        query = ""
        suggestions = []
    }
}

struct GroupSuggestion: Codable {
    let value: String
    let data: String
}

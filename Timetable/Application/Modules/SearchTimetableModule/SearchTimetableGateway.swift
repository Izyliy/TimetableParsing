//
//  SearchTimetableGateway.swift
//  Timetable
//
//  Created by Павел Грабчак on 12.09.2022.
//

import UIKit
import URLRequestBuilder
import Promises

class SearchTimetableGateway {

    //https://s.kubsau.ru/bitrix/components/atom/atom.education.schedule-real/get.php?query=%D0%9F%D0%9822&type_schedule=1
    func getGroupsSuggestionDataFor(name: String, type: SearchType) -> Promise<SuggestionsList> {
        let url = URL(string: "https://s.kubsau.ru")!
        
        let urlRequest = URLRequestBuilder(path: "/bitrix/components/atom/atom.education.schedule-real/get.php")
            .method(.get)
            .timeout(60)
            .queryItems([
                .init(name: "type_schedule", value: type.getRequestInt()),
                .init(name: "query", value: name)
            ])
            .makeRequest(withBaseURL: url)
        
        return RequestManager.sharedInstance.makeRequest(urlRequest)
    }
}

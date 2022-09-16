//
//  MainTimetableGateway.swift
//  Timetable
//
//  Created by Павел Грабчак on 12.09.2022.
//

import UIKit
import URLRequestBuilder
import Promises

class MainTimetableGateway {

    //https://s.kubsau.ru/bitrix/components/atom/atom.education.schedule-real/get.php?query=%D0%9F%D0%9822&type_schedule=1
    func getGroupsSuggestionDataFor(_ text: String) -> Promise<GroupList> {
        let promise = Promise<GroupList>.pending()
        let url = URL(string: "https://s.kubsau.ru")!
        
        let urlRequest = URLRequestBuilder(path: "/bitrix/components/atom/atom.education.schedule-real/get.php")
            .method(.get)
            .timeout(60)
            .queryItems([
                .init(name: "type_schedule", value: "1"),
                .init(name: "query", value: text)
            ])
            .makeRequest(withBaseURL: url)
        
        RequestManager.sharedInstance.makeRequest(urlRequest).then { data in
            do {
                let groupList = try JSONDecoder().decode(GroupList.self, from: data)
                promise.fulfill(groupList)
            } catch {
                promise.reject(error)
            }
        }.catch { error in
            promise.reject(error)
        }
        
        return promise
    }
}

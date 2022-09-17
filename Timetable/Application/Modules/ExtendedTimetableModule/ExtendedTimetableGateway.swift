//
//  ExtendedTimetableGateway.swift
//  Timetable
//
//  Created by Павел Грабчак on 17.09.2022.
//

import UIKit
import Promises
import URLRequestBuilder

class ExtendedTimetableGateway {
    
    //https://s.kubsau.ru/?type_schedule=1&val=ПИ2241
    func getTimetableHtmlFor(_ group: String) -> Promise<String> {
        let promise = Promise<String>.pending()
        var url = URL(string: "https://s.kubsau.ru/")!
        
        let urlRequest = URLRequestBuilder(path: "")
            .method(.get)
            .timeout(60)
            .queryItems([
                .init(name: "type_schedule", value: "1"),
                .init(name: "val", value: group)
            ])
            .makeRequest(withBaseURL: url)
            
        RequestManager.sharedInstance.makeRequest(urlRequest).then { data in
            if let contents = String(data: data, encoding: .utf8) {
                promise.fulfill(contents)
            } else {
                promise.reject(NSError(domain: "Can't get string out of data", code: 0))
            }
        }.catch { error in
            promise.reject(error)
        }
        
        return promise
    }
    
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

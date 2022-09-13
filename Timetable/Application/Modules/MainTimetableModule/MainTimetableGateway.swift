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
    let defaultPromise = Promise<Data> { fulfill, reject in
        fulfill(Data())
    }
    
    func exampleRequest() {
        guard let url = URL(string: "https://cdn.igromania.ru") else { return }
        
        let urlRequest = URLRequestBuilder(path: "mnt/news/e/7/3/5/f/7/114069/165b2a269068aa78_1920xH.jpg")
            .method(.get)
            .timeout(20)
            .queryItem(name: "city", value: "San Francisco")
            .makeRequest(withBaseURL: url)
        
        RequestManager.sharedInstance.makeRequest(urlRequest).then { data in
            let _ = UIImage(data: data)
        }.catch { error in
            print(error)
        }
    }
    
    // https://s.kubsau.ru/bitrix/components/atom/atom.education.schedule-real/get.php?query=%D0%9F%D0%9822&type_schedule=1
    func getGroupsSuggestionData() -> Promise<GroupList> {
        let promise = Promise<GroupList>.pending()
        let url = URL(string: "https://s.kubsau.ru")!
        
        let urlRequest = URLRequestBuilder(path: "/bitrix/components/atom/atom.education.schedule-real/get.php")
            .method(.get)
            .timeout(20)
            .queryItems([
                .init(name: "type_schedule", value: "1"),
                .init(name: "query", value: "ПИ22fwecwxwc")
            ])
            .makeRequest(withBaseURL: url)
        
        RequestManager.sharedInstance.makeRequest(urlRequest).then { data in
            let groupList = try JSONDecoder().decode(GroupList.self, from: data)
            
            promise.fulfill(groupList)
        }.catch { error in
            promise.reject(error)
        }
        
        return promise
    }
}

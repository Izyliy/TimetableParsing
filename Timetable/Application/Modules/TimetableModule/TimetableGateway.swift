//
//  TimetableGateway.swift
//  Timetable
//
//  Created by Павел Грабчак on 17.09.2022.
//

import UIKit
import Promises
import URLRequestBuilder

class TimetableGateway {
    
    //https://s.kubsau.ru/?type_schedule=1&val=ПИ2241
    func getTimetableHtmlFor(name: String, type: TimetableType) -> Promise<String> {
        let promise = Promise<String>.pending()
        let url = URL(string: "https://s.kubsau.ru/")!
        
        let urlRequest = URLRequestBuilder(path: "")
            .method(.get)
            .timeout(60)
            .queryItems([
                .init(name: "type_schedule", value: type.getTypeNumber()),
                .init(name: "val", value: name)
            ])
            .makeRequest(withBaseURL: url)
            
        RequestManager.sharedInstance.makeDataRequest(urlRequest).then { data in
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
}

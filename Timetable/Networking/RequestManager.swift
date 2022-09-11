//
//  RequestManager.swift
//  Timetable
//
//  Created by Павел Грабчак on 11.09.2022.
//

import UIKit
import Promises

class RequestManager {
    static let sharedInstance = RequestManager()
    
    private let queue = OperationQueue()
    
    private func execute<T: Operation>(operation: T) {
        queue.addOperation(operation)
    }
    
    func makeRequest(_ request: URLRequest) -> Promise<Data> {
        return Promise { [unowned self] fulfill, reject in
            let operation = RequestOperation(request: request) { data, response, error in
                if let error = error {
                    reject(error)
                } else if let data = data {
                    fulfill(data)
                }
            }
            
            execute(operation: operation)
        }
    }
}

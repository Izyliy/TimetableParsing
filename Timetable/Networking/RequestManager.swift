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
    
    func makeRequest<T: Codable>(_ request: URLRequest) -> Promise<T> {
        return Promise { [unowned self] fulfill, reject in
            let operation = RequestOperation(request: request) { data, response, error in
                if let error = error {
                    reject(error)
                } else if let data = data {
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        fulfill(object)
                    } catch {
                        reject(error)
                    }
                }
            }
            
            execute(operation: operation)
        }
    }
    
    func makeDataRequest(_ request: URLRequest) -> Promise<Data> {
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

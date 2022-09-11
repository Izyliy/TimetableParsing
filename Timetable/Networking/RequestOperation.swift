//
//  RequestOperation.swift
//  Timetable
//
//  Created by Павел Грабчак on 11.09.2022.
//

import UIKit
import Promises

//            if let data = data {
//                let image = UIImage(data: data)
//                print("varv")
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//            }

class RequestOperation: Operation {
    
    let request: URLRequest
    let callback: ((Data?, URLResponse?, Error?) -> ())
    
    override func main() {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.callback(data, response, error)
        }
        
        task.resume()
    }
    
    required init(request: URLRequest, callback: @escaping ((Data?, URLResponse?, Error?) -> ())) {
        self.request = request
        self.callback = callback
    }
}

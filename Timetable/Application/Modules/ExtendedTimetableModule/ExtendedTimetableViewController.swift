//
//  ExtendedTimetableViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 17.09.2022.
//

import UIKit

class ExtendedTimetableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configure(group: String) {
        
        guard var urlComps = URLComponents(string: "https://s.kubsau.ru/") else { return }
        
        urlComps.queryItems = [
            URLQueryItem(name: "type_schedule", value: "1"),
            URLQueryItem(name: "val", value: group)
        ]
        
        guard let url = urlComps.url else { return }
            
        do {
            let contents = try String(contentsOf: url)
            print(contents)
        } catch {
            // contents could not be loaded
        }
    }
}

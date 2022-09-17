//
//  ExtendedTimetableViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 17.09.2022.
//

import UIKit
import SwiftSoup

class ExtendedTimetableViewController: UIViewController {
    
    let gateway = ExtendedTimetableGateway()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configure(group: String) {
        
        gateway.getTimetableHtmlFor(group).then { html in
            self.parseTimetableWith(html: html)
        }
    }
    
    func parseTimetableWith(html: String) {
        do {
            let doc = try SwiftSoup.parse(html)
            let firstWeekDoc = try doc.select("div").filter({ try $0.classNames().contains("schedule-first-week") }).first
            let secondWeekDoc = try doc.select("div").filter({ try $0.classNames().contains("schedule-second-week") }).first
            try parseWeekWith(html: secondWeekDoc)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func parseWeekWith(html: Element?) throws {
        let haha = try html?.text()
        print(haha)
    }
}

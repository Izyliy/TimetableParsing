//
//  UIViewController+Alerts.swift
//  Timetable
//
//  Created by Павел Грабчак on 16.11.2022.
//

import UIKit

extension UIViewController {
    func showError(message: String, title: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        present(alert, animated: true)
    }
}

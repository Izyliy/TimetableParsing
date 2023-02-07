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
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showActionSheet(title: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            for action in actions { alert.addAction(action) }
        }
        
        present(alert, animated: true)
    }
    
    func showDebugMsg(title: String?, actions: [UIAlertAction]) {
        if UserDefaults.standard.bool(forKey: UDKeys.Develop.isDev) {
            showActionSheet(title: title, actions: actions)
        }
    }
}

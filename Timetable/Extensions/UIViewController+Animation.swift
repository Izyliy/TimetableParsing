//
//  UIViewController+Animation.swift
//  Timetable
//
//  Created by Павел Грабчак on 17.11.2022.
//

import UIKit

extension UIViewController {
    func startIndication() {
        view.startIndication()
    }

    func stopIndication() {
        view.stopIndication()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

//
//  UIView+Animation.swift
//  Timetable
//
//  Created by Павел Грабчак on 21.06.2022.
//

import UIKit

extension UIView {
    func startInditation() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        backgroundView.tag = 475647
            
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
            
        backgroundView.addSubview(activityIndicator)

        self.addSubview(backgroundView)
    }

    func stopIndication() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}

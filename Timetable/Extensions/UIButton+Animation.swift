//
//  UIButton+Animation.swift
//  Timetable
//
//  Created by Павел Грабчак on 14.06.2022.
//

import UIKit

extension UIButton {
    func setPressingAnimation() {
        addTarget(self, action: #selector(didTouchDown(_:)), for: .touchDown)
        addTarget(self, action: #selector(didTouchUp(_:)), for: .touchUpInside)
        addTarget(self, action: #selector(didTouchUp(_:)), for: .touchUpOutside)
    }
}

extension UIButton {
    @objc
    private func didTouchDown(_ sender: Any) {
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc
    private func didTouchUp(_ sender: Any) {
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform.identity
        }
    }
}

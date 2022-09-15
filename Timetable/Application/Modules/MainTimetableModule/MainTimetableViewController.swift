//
//  MainTimetableViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 10.09.2022.
//

import UIKit
import SnapKit
import URLRequestBuilder

class MainTimetableViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .blue
        button.setTitle("Кнопка", for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.textColor = .white
        
        return button
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .line
        
        return textField
    }()

    let gateway = MainTimetableGateway()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        view.addSubview(button)
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(150)
            make.bottom.equalTo(button.snp.top).offset(-15)
        }
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        let text = textField.text ?? ""
        gateway.getGroupsSuggestionDataFor(text).then { list in
            print(list)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}

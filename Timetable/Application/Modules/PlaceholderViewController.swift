//
//  PlaceholderViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 08.10.2022.
//

import UIKit

class PlaceholderViewController: UIViewController {

    let label: UILabel = {
        let elem = UILabel()
        
        elem.text = "Placeholder"
        
        return elem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

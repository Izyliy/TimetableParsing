//
//  ViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 10.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        
        label.text = "  Настройки  "
        label.font = .systemFont(ofSize: 26)
        label.backgroundColor = .brown
        label.textColor = .white
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white //UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}


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
        
        label.text = "fcwefdcwe"
        label.backgroundColor = .brown
        label.textColor = .white
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }

}


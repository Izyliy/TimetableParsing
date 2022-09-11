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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        
        guard let url = URL(string: "https://cdn.igromania.ru") else { return }
        
        let urlRequest = URLRequestBuilder(path: "mnt/news/e/7/3/5/f/7/114069/165b2a269068aa78_1920xH.jpg")
            .method(.get)
            .timeout(20)
            .queryItem(name: "city", value: "San Francisco")
            .makeRequest(withBaseURL: url)
        
        RequestManager.sharedInstance.makeRequest(urlRequest).then { data in
            let img = UIImage(data: data)
            print(img)
        }.catch { error in
            print(error)
        }
    }
}

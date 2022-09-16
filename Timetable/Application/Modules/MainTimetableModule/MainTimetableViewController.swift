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
    
    let textField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .line
        
        return textField
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()

    let gateway = MainTimetableGateway()
    var displayManager: MainTimetableDisplayManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        view.addSubview(textField)
        view.addSubview(tableView)
        displayManager = MainTimetableDisplayManager(tableView: tableView)

        tableView.delegate = displayManager
        tableView.dataSource = displayManager
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(150)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(400)
        }
        
        textField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        let text = textField.text ?? ""
        gateway.getGroupsSuggestionDataFor(text).then { list in
            self.displayManager?.updateTableView(with: list)
            print(list)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}

//
//  SearchTimetableViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 10.09.2022.
//

import UIKit
import SnapKit
import URLRequestBuilder

class SearchTimetableViewController: UIViewController, UITextFieldDelegate {
    
    let textField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .line
        
        return textField
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    let typeControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Group", "Cabinet"])
        
        view.selectedSegmentIndex = 0
        
        return view
    }()

    let gateway = SearchTimetableGateway()
    var displayManager: SearchTimetableDisplayManager?
    
    var openTimetableForGroup: ((String, TimetableType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        view.addSubview(textField)
        view.addSubview(tableView)
        view.addSubview(typeControl)
        displayManager = SearchTimetableDisplayManager(tableView: tableView, view: self)

        tableView.delegate = displayManager
        tableView.dataSource = displayManager
        
        title = "Поиск"
        
        typeControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
        }

        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(150)
            make.top.equalTo(typeControl.snp.bottom).offset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(400)
        }
        
        textField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textField {
            if let group = textField.text, group.count > 5, group.count < 9 {
                openTimetableForGroup?(group, getTimetableType())
            }
            
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        let name = textField.text ?? ""
        let type = getTimetableType()
        
        gateway.getGroupsSuggestionDataFor(name: name, type: type).then { list in
            if list.query == textField.text {
                self.displayManager?.updateTableView(with: list)
            }
        }.catch { error in
            print(error.localizedDescription)
        }
    }
    
    func getTimetableType() -> TimetableType {
        TimetableType(rawValue: typeControl.selectedSegmentIndex) ?? .group
    }
}

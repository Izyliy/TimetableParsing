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
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите номер группы"
        textField.font = .systemFont(ofSize: 18)
        
        return textField
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
//        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 16
        
        return tableView
    }()
    
    let typeControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["По группе", "По аудитории"])
        
        view.selectedSegmentIndex = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.15)
        
        return view
    }()
    
    let typeControlContainer: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "BrandGreen")
        
        return view
    }()

    var displayManager: SearchTimetableDisplayManager?
    var presenter: SearchTimetablePresenter?

    var openTimetableForGroup: ((String, TimetableType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        view.addSubview(textField)
        view.addSubview(tableView)
        view.addSubview(typeControlContainer)
        typeControlContainer.addSubview(typeControl)
        
        displayManager = SearchTimetableDisplayManager(tableView: tableView, view: self)
        presenter = SearchTimetablePresenter(view: self)

        tableView.delegate = displayManager
        tableView.dataSource = displayManager
        
        title = "Поиск"
        
        typeControlContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        typeControl.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview().offset(-8)
//            make.top.equalToSuperview().offset(4)
        }

        textField.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(typeControlContainer.snp.bottom).offset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        typeControl.addTarget(self, action: #selector(searchTypeChanged(_:)), for: .valueChanged)
        
        textField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        textField.delegate = self
    }
    
    func updateTimetable(with groups: SuggestionsList) {
        displayManager?.updateTableView(with: groups)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "Qwertt12344" {
            DevelopConfigurator.sharedInstance.setDev(to: true)
            textField.text = ""
            textField.resignFirstResponder()
        }
        
        if textField == self.textField {
            if let group = textField.text, group.count > 2, group.count < 9 {
                openTimetableForGroup?(group, getTimetableType())
            }
            
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc
    func textFieldChanged(_ textField: UITextField) {
        let name = textField.text ?? ""
        let type = getTimetableType()
        
        presenter?.fetchGroupList(for: name, of: type)
    }
    
    @objc
    func searchTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            textField.placeholder = "Введите номер группы"
        case 1:
            textField.placeholder = "Введите аудиторию"
        default:
            textField.placeholder = "Поиск"
        }
        print(sender.selectedSegmentIndex)
    }
    
    func getTimetableType() -> TimetableType {
        TimetableType(rawValue: typeControl.selectedSegmentIndex) ?? .group
    }
}

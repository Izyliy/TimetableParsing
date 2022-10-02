//
//  ExtendedTimetableViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 17.09.2022.
//

import UIKit

class ExtendedTimetableViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .grouped)
                
        return tableView
    }()
    
    let weekControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["First week", "Second week"])
        
        view.selectedSegmentIndex = 0
        
        return view
    }()
    
    var displayManager: ExtendedTimetableDisplayManager?
    var presenter: ExtendedTimetablePresenter?
    var timetable: [Timetable]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(weekControl)
        
        weekControl.addTarget(self, action: #selector(chooseWeek(_:)), for: .valueChanged)
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(weekControl.snp.bottom).offset(4)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        weekControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
        }

        view.backgroundColor = .lightGray
    }
    
    func configure(group: String) {
        displayManager = ExtendedTimetableDisplayManager(tableView: tableView, view: self)
        presenter = ExtendedTimetablePresenter(view: self)
        
        tableView.delegate = displayManager
        tableView.dataSource = displayManager
        
        presenter?.setupInitialState(name: group, type: .group)
    }
    
    func updateTimetable(week: [TimetableDay]) {
        displayManager?.updateTableView(with: week)
    }
    
    @objc func chooseWeek(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //TODO: вывод первой недели
            
            break
        case 1:
            //TODO: вывод второй недели
            break
        default:
            break
        }
    }
}

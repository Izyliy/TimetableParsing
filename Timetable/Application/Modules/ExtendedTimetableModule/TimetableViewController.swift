//
//  ExtendedTimetableViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 17.09.2022.
//

import UIKit

class TimetableViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .grouped)
                
        return tableView
    }()
    
    let weekControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["First week", "Second week"])
        
        view.selectedSegmentIndex = 0
        
        return view
    }()
    
    let optionsButton: UIButton = {
        let button = UIButton()
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .medium, scale: .large)
        button.setImage(UIImage(systemName: "ellipsis", withConfiguration: imageConfiguration), for: .normal)
        
        return button
    }()
    
    var displayManager: TimetableDisplayManager?
    var presenter: TimetablePresenter?
    var timetable: [Timetable]?
    
    var popModule: (() -> Void)?

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
    
    func configure(name: String, mode: TimetableMode, type: TimetableType) {
        displayManager = TimetableDisplayManager(tableView: tableView, view: self)
        presenter = TimetablePresenter(view: self)
        
        tableView.delegate = displayManager
        tableView.dataSource = displayManager
        
        title = name
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionsButton)
        setNavButtonAction(name: name)
        
        presenter?.setupInitialState(name: name, type: type)
    }
    
    func updateTimetable(week: [TimetableDay]) {
        displayManager?.updateTableView(with: week)
        weekControl.selectedSegmentIndex = 0
    }
    
    func setNavButtonAction(name: String) {
        if #available(iOS 14.0, *) {
            let actions: [UIAction] = [
                UIAction(title: "Избранное", image: UIImage(systemName: "star"), handler: { _ in
                    self.presenter?.setFavourite()
                }),
                UIAction(title: "Обновить", image: UIImage(systemName: "arrow.clockwise"), handler: { _ in
                    self.presenter?.fetchTimetable(forReload: true)
                }),
            ]
            
            optionsButton.showsMenuAsPrimaryAction = true
            optionsButton.menu = UIMenu(title: "",
                                        image: nil,
                                        identifier: nil,
                                        options: [],
                                        children: actions)
        } else {
            optionsButton.addTarget(self, action: #selector(tapOnBarItem(_:)), for: .touchUpInside)
        }
        
    }
        
    @objc func tapOnBarItem(_ sender: UIButton) {
        showActionSheet(title: nil, actions: [
            UIAlertAction(title: "Избранное", style: .default, handler: { _ in
                self.presenter?.setFavourite()
            }),
            UIAlertAction(title: "Обновить", style: .default, handler: { _ in
                self.presenter?.fetchTimetable(forReload: true)
            }),
            UIAlertAction(title: "Отмена", style: .cancel)
        ])
    }
    
    @objc func chooseWeek(_ sender: UISegmentedControl) {
        let timetable = presenter?.getWeek(index: sender.selectedSegmentIndex)
        displayManager?.updateTableView(with: timetable ?? [])
    }
}

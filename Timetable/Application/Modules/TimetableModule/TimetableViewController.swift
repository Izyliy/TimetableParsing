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
        let view = UISegmentedControl(items: ["Первая неделя", "Вторая неделя"])
        
        view.selectedSegmentIndex = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.15) //UIColor(named: "DarkGreen")
        
        return view
    }()
    
    let optionsButton: UIButton = {
        let button = UIButton()
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .medium, scale: .large)
        button.setImage(UIImage(systemName: "ellipsis", withConfiguration: imageConfiguration), for: .normal)
        
        return button
    }()
    
    let noNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "ты лог хахаха \nхахахахах ахахаххаdfqwdqwdd"
        label.font = UIFont.systemFont(ofSize: 32)
        label.numberOfLines = 0
        
        return label
    }()
    
    var displayManager: TimetableDisplayManager?
    var presenter: TimetablePresenter?
    var timetable: [Timetable]?
    
    var popModule: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.refreshViewIfNeeded()
    }
    
    func configure(name: String?, mode: TimetableMode, type: TimetableType) {
        presenter = TimetablePresenter(view: self)
        displayManager = TimetableDisplayManager(tableView: tableView, view: self)
        
        tableView.delegate = displayManager
        tableView.dataSource = displayManager
        
        presenter?.setupInitialState(name: name, type: type, mode: mode)
        
        title = name != nil ? name : "Избранное"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionsButton)
        
        setNavButtonAction()
        setVisuals(for: mode)
        updateVisuals(hasName: name != nil)
    }
    
    func updateVisuals(hasName: Bool) {
        noNameLabel.isHidden = hasName
        tableView.isHidden = !hasName
    }
    
    func setVisuals(for mode: TimetableMode) {
        view.addSubview(noNameLabel)
        view.addSubview(tableView)
        
        view.backgroundColor = mode == .extended ? UIColor(named: "BrandGreen") : UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)

        weekControl.addTarget(self, action: #selector(chooseWeek(_:)), for: .valueChanged)
        
        noNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()

            guard mode == .preview else { return }
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        guard mode == .extended else { return }
        
        hidesBottomBarWhenPushed = true
        view.addSubview(weekControl)

        weekControl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.top.equalTo(weekControl.snp.bottom).offset(8)
        }
    }
    
    func updateTimetable(week: [TimetableDay]) {
        displayManager?.updateTableView(with: week)
        weekControl.selectedSegmentIndex = 0
    }
    
    func setNavButtonAction() {
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

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
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .medium, scale: .large)
        button.setImage(UIImage(systemName: "ellipsis", withConfiguration: imageConfiguration), for: .normal)
        
        return button
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
    
    func configure(name: String, mode: TimetalbeMode) {
        displayManager = ExtendedTimetableDisplayManager(tableView: tableView, view: self)
        presenter = ExtendedTimetablePresenter(view: self)
        
        tableView.delegate = displayManager
        tableView.dataSource = displayManager
        
        title = name
        favoriteButton.addTarget(self, action: #selector(tapOnFavorite(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        
        presenter?.setupInitialState(name: name, type: .group)
    }
    
    func updateTimetable(week: [TimetableDay]) {
        displayManager?.updateTableView(with: week)
    }
        
    @objc func tapOnFavorite(_ sender: UIButton) {
        presenter?.setFavourite()
    }
    
    @objc func chooseWeek(_ sender: UISegmentedControl) {
        let timetable = presenter?.getWeek(index: sender.selectedSegmentIndex)
        displayManager?.updateTableView(with: timetable ?? [])
    }
}

//
//  MainSettingsViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.10.2022.
//

import UIKit

class MainSettingsViewController: UIViewController {
    
    let tableView: UITableView = {
        let view = UITableView(frame: CGRectZero, style: .insetGrouped)
        
        view.isScrollEnabled = false
        
        return view
    }()
    
    var displayManager: MainSettingsDisplayManager?
    var presenter: MainSettingsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setVisuals()
        presenter?.setupInitialState()
    }
    
    func updateTableView(with sections: [SettingsSection]) {
        displayManager?.updateTableView(with: sections)
    }
    
    private func configure() {
        displayManager = MainSettingsDisplayManager(tableView: tableView, view: self)
        presenter = MainSettingsPresenter(view: self)
        
        title = "Настройки"
    }
    
    private func setVisuals() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
}

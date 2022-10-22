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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        title = "Настройки"
        
        configure()
    }
    
    func configure() {
        displayManager = MainSettingsDisplayManager(tableView: tableView, view: self)
        
        displayManager?.updateTableView(with: [
            .init(title: "title1", icon: UIImage(systemName: "doc"), handler: { print(1) }),
            .init(title: "title2", handler: { print(2) }),
            .init(title: "title3", icon: UIImage(systemName: "doc.text")?.withTintColor(.systemPink), handler: { print(3) }),
            .init(title: "title4", icon: UIImage(systemName: "doc.zipper"), handler: { print(4) }),
        ])
    }
}

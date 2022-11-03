//
//  SettingsTableViewCell.swift
//  Timetable
//
//  Created by Павел Грабчак on 22.10.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    var handler: ((Bool) -> Void)?
    
    let label: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    let switchView: UISwitch = {
        let view = UISwitch()
        
        view.onTintColor = UIColor(named: "LightGreen")
        
        return view
    }()
    
    func configure(title: String, switchable: Bool) {
        setUp(switchable: switchable)
        
        label.text = title
    }
    
    private func setUp(switchable: Bool) {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        if switchable {
            switchView.addTarget(self, action: #selector(switchTurned(_:)), for: .valueChanged)

            contentView.addSubview(switchView)
            switchView.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-16)
                make.centerY.equalToSuperview()
            }
        }
    }
    
    @objc
    private func switchTurned(_ sender: UISwitch) {
        print(123)
        handler?(sender.isOn)
    }
}

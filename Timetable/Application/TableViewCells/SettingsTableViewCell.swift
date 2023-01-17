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
    
    func configure(with object: SettingsObject) {
        setUp(for: object.type)
        
        handler = object.handler
        label.text = object.title
    }
    
    private func setUp(for type: SettingsCellType) {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        if type == .switcher {
            self.selectionStyle = .none
            self.accessoryType = .none
            switchView.isHidden = false
            switchView.addTarget(self, action: #selector(switchTurned(_:)), for: .valueChanged)

            contentView.addSubview(switchView)
            switchView.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-16)
                make.centerY.equalToSuperview()
            }
        } else {
            self.accessoryType = .disclosureIndicator
            self.selectionStyle = .default
            switchView.isHidden = true
        }
    }
    
    @objc
    private func switchTurned(_ sender: UISwitch) {
        handler?(sender.isOn)
    }
}

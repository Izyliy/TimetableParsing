//
//  IconTitleTableViewCell.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.10.2022.
//

import UIKit
import SnapKit

class IconTitleTableViewCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    let iconView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    func configure(title: String, icon: UIImage?, font: UIFont? = nil) {
        setUp()
        
        label.text = title
        iconView.image = icon
        
        iconView.tintColor = UIColor(named: "LightGreen")
        
        if let font = font {
            label.font = font
        }
    }
    
    private func setUp() {
        contentView.addSubview(label)
        contentView.addSubview(iconView)
        
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(32).priority(900)
            make.top.greaterThanOrEqualToSuperview().offset(8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
            
//            make.left.greaterThanOrEqualTo(label.snp.right)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            
            make.left.equalTo(iconView.snp.right).offset(16)
        }
    }
}

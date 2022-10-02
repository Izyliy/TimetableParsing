//
//  TextTableViewCell.swift
//  Timetable
//
//  Created by Павел Грабчак on 02.10.2022.
//

import UIKit
import SnapKit

class TextTableViewCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        
        label.text = "Not Configured"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    func setup(_ txt: String) {
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        label.text = txt
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SuggestedGroupTableViewCell.swift
//  Timetable
//
//  Created by Павел Грабчак on 15.09.2022.
//

import UIKit
import SnapKit

class SuggestedGroupTableViewCell: UITableViewCell {
    var group: GroupSuggestion?
    
    let label: UILabel = {
        let label = UILabel()
        
        label.text = "Not Configured"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    func setup(group: GroupSuggestion) {
        self.group = group
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        label.text = group.value
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

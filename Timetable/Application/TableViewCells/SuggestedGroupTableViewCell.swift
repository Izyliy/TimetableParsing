//
//  SuggestedGroupTableViewCell.swift
//  Timetable
//
//  Created by Павел Грабчак on 15.09.2022.
//

import UIKit
import SnapKit

class SuggestionTableViewCell: UITableViewCell {
    var group: SuggestionsList.Suggestion?
    
    let label: UILabel = {
        let label = UILabel()
        
        label.text = "Not Configured"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    func setup(group: SuggestionsList.Suggestion) {
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

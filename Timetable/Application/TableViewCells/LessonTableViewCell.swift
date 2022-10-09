//
//  TimetableDayTableViewCell.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.09.2022.
//

import UIKit
import SnapKit

class LessonTableViewCell: UITableViewCell {
    var timetableLesson: TimetableLesson?
    
    let lectionView: UIView = {
        let view = UIView()
        
        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Not Configured"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        
        return label
    }()
    
    let professorTextField: UITextField = {
        let field = UITextField()
        
        field.text = "Not Configured"
        field.font = .systemFont(ofSize: 14)
        field.isUserInteractionEnabled = false
        
        return field
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Not Configured"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        
        return label
    }()
    
    let cabinetLabel: UILabel = {
        let label = UILabel()
        
//        label.text = " "
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    func setup(lesson: TimetableLesson) {
        self.timetableLesson = lesson
        contentView.addSubview(lectionView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(professorTextField)
        contentView.addSubview(timeLabel)
        contentView.addSubview(cabinetLabel)
        
        
        lectionView.backgroundColor = lesson.isLection ? .yellow : .gray
        
        nameLabel.text = lesson.name
        
        let attributedString = NSMutableAttributedString(string: lesson.professorsArray.first?.name ?? "")
        attributedString.addAttribute(.link,
                                      value: lesson.professorsArray.first?.link ?? "",
                                      range: NSRange(location: 0, length: lesson.professorsArray.first?.name?.count ?? 0))
        professorTextField.attributedText = attributedString
        
        timeLabel.text = (lesson.startTime ?? "") + " - " + (lesson.endTime ?? "")
        
        cabinetLabel.text = lesson.cabinets?.joined(separator: "|")
        
        
        lectionView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(8)
            make.height.greaterThanOrEqualTo(55)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(lectionView.snp.right).offset(4)
            make.right.lessThanOrEqualTo(timeLabel.snp.left)
        }
        
        professorTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(lectionView.snp.right).offset(4)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.width.equalTo(105)
        }
        
        cabinetLabel.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().offset(-4)
        }
    }
}

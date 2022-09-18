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
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let professorTextField: UITextField = {
        let field = UITextField()
        
        field.text = "Not Configured"
        field.font = .systemFont(ofSize: 16)
        field.isUserInteractionEnabled = false
        
        return field
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Not Configured"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let cabinetLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Not Configured"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    func setup(lesson: TimetableLesson) {
        self.timetableLesson = lesson
        self.addSubview(lectionView)
        self.addSubview(nameLabel)
        self.addSubview(professorTextField)
        self.addSubview(timeLabel)
        self.addSubview(cabinetLabel)
        
        
        lectionView.backgroundColor = (lesson.isLection ?? false) ? .yellow : .gray
        
        nameLabel.text = lesson.className
        
        let attributedString = NSMutableAttributedString(string: lesson.professor?.name ?? "")
        attributedString.addAttribute(.link,
                                      value: lesson.professor?.link ?? "",
                                      range: NSRange(location: 0, length: lesson.professor?.name?.count ?? 0))
        professorTextField.attributedText = attributedString
        
        timeLabel.text = (lesson.startTime ?? "") + " - " + (lesson.endTime ?? "")
        
        cabinetLabel.text = lesson.cabinet
        
        
        lectionView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(lectionView.snp.right).offset(4)
        }
        
        professorTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(lectionView.snp.right).offset(4)
//            make.height.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
        }
        
        cabinetLabel.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview()
        }
    }
}

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
    
    let professorTextView: UITextView = {
        let view = UITextView()
        
        view.text = "Not Configured"
        view.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return view
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
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    func setup(lesson: TimetableLesson) {
        self.timetableLesson = lesson
        contentView.addSubview(lectionView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(professorTextView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(cabinetLabel)
        
        lectionView.backgroundColor = lesson.isLection ? .yellow : .gray
        
        nameLabel.text = lesson.name
        
        let attributes: [NSAttributedString.Key: Any] = [
            .link: lesson.professorsArray.first?.link ?? "",
            .font: UIFont.systemFont(ofSize: 15),
        ]
        let attributedString = NSAttributedString(string: lesson.professorsArray.first?.name ?? "", attributes: attributes)
        
        professorTextView.attributedText = attributedString
        
        timeLabel.text = (lesson.startTime ?? "") + " - " + (lesson.endTime ?? "")
        
        cabinetLabel.text = lesson.cabinets?.joined(separator: "|")
        
        
        lectionView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(8)
            make.height.greaterThanOrEqualTo(55)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(lectionView.snp.right).offset(8)
            make.right.lessThanOrEqualTo(timeLabel.snp.left)
        }
        
        professorTextView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(lectionView.snp.right).offset(4)
            make.height.equalTo(20)
            make.width.equalToSuperview().dividedBy(2)
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

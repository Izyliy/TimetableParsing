//
//  TimetableDayTableViewCell.swift
//  Timetable
//
//  Created by Павел Грабчак on 18.09.2022.
//

import UIKit
import SnapKit

class LessonTableViewCell: UITableViewCell {
    private let lectionView: UIView = {
        let view = UIView()
        
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Not Configured"
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let professorTextView: UITextView = {
        let view = UITextView()
        
        view.text = "Not Configured"
        view.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.isEditable = false
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Not Configured"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 0
        
        return label
    }()
    
    private let cabinetLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    func setup(lesson: TimetableLesson) {
        selectionStyle = .none
        setConstraints()
        fillElements(for: lesson)
    }
    
    private func setConstraints() {
        contentView.addSubview(lectionView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(professorTextView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(cabinetLabel)
        
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
            make.top.greaterThanOrEqualTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(lectionView.snp.right).offset(4)
            make.height.equalTo(20)
//            make.right.equalTo(cabinetLabel.le)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-6)
            make.width.equalTo(100)
        }
        
        cabinetLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-4)
            make.right.equalToSuperview().offset(-6)
            make.left.greaterThanOrEqualTo(professorTextView.snp.right).offset(6)
            make.top.greaterThanOrEqualTo(timeLabel.snp.bottom).offset(6)
        }
    }
    
    private func fillElements(for lesson: TimetableLesson) {
        //lectionView
        lectionView.backgroundColor = lesson.isLection ? UIColor(named: "Lecture") : .lightGray
        
        //nameLabel
        nameLabel.text = lesson.name
        
        //professorTextView
        let mutableProfessorsString = NSMutableAttributedString()
        var firstPassed = false
        
        for professor in lesson.professorsArray {
            var string = ""
            
            if firstPassed {
                string = ", " + (professor.name ?? "")
            } else {
                firstPassed = true
                string = professor.name ?? ""
            }
            
            let attributes: [NSAttributedString.Key: Any] = [
                .link: professor.link ?? "",
                .font: UIFont.systemFont(ofSize: 15),
            ]
            
            let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
            mutableProfessorsString.append(attributedString)
        }
        
        professorTextView.attributedText = mutableProfessorsString
        
        //timeLabel
        let attributedTimeString = NSMutableAttributedString(string: (lesson.startTime ?? "") + "-" + (lesson.endTime ?? ""))
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = .right
        attributedTimeString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedTimeString.length))
        
        timeLabel.attributedText = attributedTimeString
        
        //cabinetLabel
        cabinetLabel.text = lesson.cabinets?.joined(separator: "\n")
    }
}

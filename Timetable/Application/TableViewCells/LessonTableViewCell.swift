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
    
    private let linkButton: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Ссылка на занятие", for: .normal)
        btn.setTitleColor(.link, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.backgroundColor = .clear
        
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.link.cgColor
        btn.layer.borderWidth = 1
        
        return btn
    }()
    
    var distantLink: String?
    
    func setup(lesson: TimetableLesson) {
        selectionStyle = .none
        let haveLink = !(lesson.distantLinks?.isEmpty ?? true)
        setConstraints(haveLink: haveLink)
        fillElements(for: lesson)
    }
    
    private func setConstraints(haveLink: Bool) {
        contentView.addSubview(lectionView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(professorTextView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(cabinetLabel)
        contentView.addSubview(linkButton)
        
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
//            make.bottom.equalToSuperview().offset(-4)
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
        
        if !haveLink {
            professorTextView.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-4)
            }
            
            linkButton.snp.makeConstraints { make in
                make.height.equalTo(0)
            }
            return
        }
        
        linkButton.snp.makeConstraints { make in
            make.top.equalTo(professorTextView.snp.bottom).offset(6)
            make.left.equalTo(lectionView.snp.right).offset(4)
            make.height.equalTo(25)
            make.width.equalTo(140)
            make.bottom.equalToSuperview().offset(-4)
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
        
        //linkButton
        if let link = lesson.distantLinks?.first {
            distantLink = link
            linkButton.setTitle("Ссылка на занятие", for: .normal)
            linkButton.addTarget(self, action: #selector(distantLinkPressed(_:)), for: .touchUpInside)
        } else {
            linkButton.setTitle("", for: .normal)
        }
    }
    
    @objc
    func distantLinkPressed(_ button: UIButton) {
        guard let url = URL(string: distantLink ?? "") else { return }
        UIApplication.shared.open(url)
//        print(distantLink)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        linkButton.snp.removeConstraints()
        lectionView.snp.removeConstraints()
        nameLabel.snp.removeConstraints()
        professorTextView.snp.removeConstraints()
        timeLabel.snp.removeConstraints()
        cabinetLabel.snp.removeConstraints()
    }
}

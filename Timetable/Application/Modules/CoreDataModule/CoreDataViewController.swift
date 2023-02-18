//
//  ViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 10.09.2022.
//

import UIKit
import SnapKit
import CoreData

enum toDisplay {
    case professors
    case lessons
    case days
    case timetables
}

class CoreDataViewController: UIViewController {
    
    let professorsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(" professors ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.tintColor = .white
        
        return button
    }()
    
    let lessonsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(" lessons ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.tintColor = .white
        
        return button
    }()
    
    let daysButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(" days ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.tintColor = .white
        
        return button
    }()
    
    let timetableButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(" timetable ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.tintColor = .white
        
        return button
    }()
    
    let table: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var professors: [Professor]?
    var lessons: [TimetableLesson]?
    var days: [TimetableDay]?
    var timetables: [Timetable]?
    
    var display: toDisplay = .timetables

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        view.addSubview(professorsButton)
        view.addSubview(lessonsButton)
        view.addSubview(daysButton)
        view.addSubview(timetableButton)
        view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
        table.register(TextTableViewCell.self, forCellReuseIdentifier: "TextTableViewCell")
                        
        professorsButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(4)
            make.right.equalTo(view.snp.centerX).offset(-2)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.height.equalTo(40)
        }
        
        lessonsButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-4)
            make.left.equalTo(view.snp.centerX).offset(2)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.height.equalTo(40)
        }
        
        daysButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(4)
            make.right.equalTo(view.snp.centerX).offset(-2)
            make.top.equalTo(professorsButton.snp.bottom).offset(4)
            make.height.equalTo(40)
        }
        
        timetableButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-4)
            make.left.equalTo(view.snp.centerX).offset(2)
            make.top.equalTo(lessonsButton.snp.bottom).offset(4)
            make.height.equalTo(40)
        }
        
        table.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.top.equalTo(timetableButton.snp.bottom).offset(8)
        }
        
        getData()
        setTargets()
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        table.reloadData()
    }
    
    func getData() {
        do {
            professors = try context.fetch(Professor.fetchRequest())
            lessons = try context.fetch(TimetableLesson.fetchRequest())
            days = try context.fetch(TimetableDay.fetchRequest())
            timetables = try context.fetch(Timetable.fetchRequest())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func setTargets() {
        professorsButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        lessonsButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        daysButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        timetableButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    @objc
    func buttonPressed(_ sender: UIButton) {
        if sender == professorsButton {
            display = .professors
        } else if sender == lessonsButton {
            display = .lessons
        } else if sender == daysButton {
            display = .days
        } else if sender == timetableButton {
            display = .timetables
        }
        
        table.reloadData()
    }
}

extension CoreDataViewController: UITableViewDelegate, UITableViewDataSource {
    func createCell(indexPath: IndexPath) -> TextTableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "TextTableViewCell") as? TextTableViewCell else { return TextTableViewCell() }
        
        let index = indexPath.row
        var message = ""
        switch display {
        case .professors:
            message = professors?[index].name ?? " no name "
        case .lessons:
            message = "\(lessons?[index].day?.date?.timetableTitle()  ?? "no date") | \(lessons?[index].startTime ?? "no time")"
        case .days:
            message = days?[index].date?.timetableTitle() ?? "no date"
        case .timetables:
            message = timetables?[index].name ?? "no name"
        }
        cell.setup(message)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch display {
        case .professors:
            return professors?.count ?? 0
        case .lessons:
            return lessons?.count ?? 0
        case .days:
            return days?.count ?? 0
        case .timetables:
            return timetables?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createCell(indexPath: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if display == .timetables {
            let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
                guard let timetable = self.timetables?[indexPath.row] else { return }
                
                self.context.delete(timetable)
                
                do {
                    try self.context.save()
                } catch { }
                
                self.getData()
                self.table.reloadData()
            }
            
            return UISwipeActionsConfiguration(actions: [action])
        }
        
        return nil
    }
}

//
//  TimetableCoordinator.swift
//  Timetable
//
//  Created by Павел Грабчак on 08.10.2022.
//

import UIKit

protocol TimetableCoordinatorProtocol: Coordinator {
    func showTimetableCoordinator()
}

class TimetableCoordinator: TimetableCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .settings }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showTimetableCoordinator()
    }
    
    deinit {
        print("SettingsCoordinator deinit")
    }
    
    func showTimetableCoordinator() {
        let name = UserDefaults.standard.string(forKey: "MainTimetable")
    
        navigationController.pushViewController(getTimetableModule(for: name), animated: true)
    }
    
    //MARK: - Methods for creating modules
    
    func getTimetableModule(for name: String?) -> TimetableViewController {
        let viewController = TimetableViewController()
        
        //TODO: set mode
        viewController.configure(name: name, mode: .preview, type: .group)
        navigationController.popViewController(animated: true)
        
        viewController.popModule = {
            self.navigationController.popViewController(animated: true)
        }
        
        return viewController
    }
}

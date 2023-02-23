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
        let name = UserDefaults.standard.string(forKey: UDKeys.State.mainTimetable)
        let type: TimetableType = UserDefaults.standard.bool(forKey: UDKeys.State.isGroupMainType) ? .group : .cabinet

        let viewController = getTimetableModule(for: name, mode: .preview, type: type)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //MARK: - Methods for creating modules
    
    func getTimetableModule(for name: String?, mode: TimetableMode, type: TimetableType) -> TimetableViewController {
        let viewController = TimetableViewController()
        
        //TODO: set mode
        viewController.configure(name: name, mode: mode, type: type)
        navigationController.popViewController(animated: true)
        
        viewController.popModule = {
            self.navigationController.popViewController(animated: true)
        }
        
        viewController.showFullTimetable = {
            let fullTimetableVC = self.getTimetableModule(for: name, mode: .extended, type: type)
            
            self.navigationController.pushViewController(fullTimetableVC, animated: true)
        }
        
        return viewController
    }
}

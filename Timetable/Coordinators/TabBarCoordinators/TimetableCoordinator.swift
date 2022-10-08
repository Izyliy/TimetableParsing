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
        navigationController.pushViewController(getMainModule(), animated: true)
    }
    
    //MARK: - Methods for creating modules
    func getMainModule() -> PlaceholderViewController {
        let viewController = PlaceholderViewController()
                
        return viewController
    }
}

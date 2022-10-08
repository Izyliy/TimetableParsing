//
//  SettingsCoordinator.swift
//  Timetable
//
//  Created by Павел Грабчак on 08.10.2022.
//

import UIKit

protocol SettingsCoordinatorProtocol: Coordinator {
    func showSettingsCoordinator()
}

class SettingsCoordinator: SettingsCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .settings }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showSettingsCoordinator()
    }
    
    deinit {
        print("SettingsCoordinator deinit")
    }
    
    func showSettingsCoordinator() {
        navigationController.pushViewController(getMainSettingsModule(), animated: true)
    }
    
    //MARK: - Methods for creating modules
    func getMainSettingsModule() -> MainViewController {
        let viewController = MainViewController()
                
        return viewController
    }
}

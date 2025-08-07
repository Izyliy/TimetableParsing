//
//  MapCoordinator.swift
//  Timetable
//
//  Created by Павел Грабчак on 07.08.2025.
//

import UIKit

protocol MapCoordinatorProtocol: Coordinator {
    func showMapCoordinator()
}

class MapCoordinator: MapCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .map }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showMapCoordinator()
    }
    
    deinit {
        print("SearchCoordinator deinit")
    }
    
    func showMapCoordinator() {
        navigationController.pushViewController(getMainMapModule(), animated: true)
    }
    
    //MARK: - Methods for creating modules
    func getMainMapModule() -> MainMapViewController {
        let viewController = MainMapViewController()
        
        return viewController
    }
    
//    func getGroupTimetableFor(name: String, type: TimetableType) -> TimetableViewController {
//        let viewController = TimetableViewController()
//        
//        //TODO: set mode
//        viewController.configure(name: name, mode: .extended, type: type)
//        navigationController.popViewController(animated: true)
//        
//        viewController.popModule = {
//            self.navigationController.popViewController(animated: true)
//        }
//        
//        return viewController
//    }
}

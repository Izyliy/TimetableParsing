//
//  SearchCoordinator.swift
//  Timetable
//
//  Created by Павел Грабчак on 10.09.2022.
//

import UIKit

protocol SearchCoordinatorProtocol: Coordinator {
    func showSearchCoordinator()
}

class SearchCoordinator: SearchCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .search }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showSearchCoordinator()
    }
    
    deinit {
        print("SearchCoordinator deinit")
    }
    
    func showSearchCoordinator() {
        navigationController.pushViewController(getMainTimetableModule(), animated: true)
    }
    
    //MARK: - Methods for creating modules
    func getMainTimetableModule() -> SearchTimetableViewController {
        let viewController = SearchTimetableViewController()
        
        viewController.openTimetableForGroup = { str, type in
            let vc = self.getGroupTimetableFor(name: str, type: type)
            self.navigationController.pushViewController(vc, animated: true)
        }
                
        return viewController
    }
    
    func getGroupTimetableFor(name: String, type: TimetableType) -> ExtendedTimetableViewController {
        let viewController = ExtendedTimetableViewController()
        
        //TODO: set mode
        viewController.configure(name: name, mode: .extended, type: type)
        navigationController.popViewController(animated: true)
        
        viewController.popModule = {
            self.navigationController.popViewController(animated: true)
        }
        
        return viewController
    }
}

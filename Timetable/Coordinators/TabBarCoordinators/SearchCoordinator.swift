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
    func getMainTimetableModule() -> MainTimetableViewController {
        let viewController = MainTimetableViewController()
        
        viewController.openTimetableForGroup = { str in // TODO: добавить weak self
            let vc = self.getGroupTimetableFor(group: str)
            self.navigationController.pushViewController(vc, animated: true)
        }
                
        return viewController
    }
    
    func getGroupTimetableFor(group: String) -> ExtendedTimetableViewController {
        let viewController = ExtendedTimetableViewController()
        
        viewController.configure(group: group)
        
        return viewController
    }
}

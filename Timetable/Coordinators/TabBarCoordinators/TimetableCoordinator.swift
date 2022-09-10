//
//  TimetableCoordinator.swift
//  Timetable
//
//  Created by Павел Грабчак on 10.09.2022.
//

import UIKit

protocol TimetableCoordinatorProtocol: Coordinator {
    func showTimetableCoordinator()
}

class TimetableCoordinator: TimetableCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .timetable }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showTimetableCoordinator()
    }
    
    deinit {
        print("TimetableCoordinator deinit")
    }
    
    func showTimetableCoordinator() {
        navigationController.pushViewController(getMainTimetableModule(), animated: true)
    }
    
    //MARK: - Methods for creating modules
    func getMainTimetableModule() -> MainTimetableViewController {
        let viewController = MainTimetableViewController()
                
        return viewController
    }
}




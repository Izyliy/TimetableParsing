//
//  TabCoordinator.swift
//  myRent
//
//  Created by Павел Грабчак on 16.02.2022.
//

import UIKit

enum TabBarPage {
    case timetable
    case search
    case map
    case settings

    init?(index: Int) {
        switch index {
        case 0:
            self = .timetable
        case 1:
            self = .search
        case 2:
            self = .map
        case 3:
            self = .settings
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .timetable:
            return "Избранное"
        case .search:
            return "Поиск"
        case .map:
            return "Карта"
        case .settings:
            return "Настройки"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .timetable:
            return 0
        case .search:
            return 1
        case .map:
            return 2
        case .settings:
            return 3
        }
    }
    
    func pageIcon() -> UIImage? {
        switch self {
        case .timetable:
            return UIImage(named: "Star")
        case .search:
            return UIImage(named: "Search")
        case .map:
            return UIImage(named: "Map")
        case .settings:
            return UIImage(named: "Settings")
        }
    }
    
    // Add tab icon selected / deselected color
    
    // etc
}


protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
        
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController

    var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        // Let's define which pages do we want to add into tab bar
        let pages: [TabBarPage] = [.timetable, .search, .map, .settings]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        // Initialization of ViewControllers or these pages
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func startTimetableFlow(navigationController: UINavigationController){
        let timetableCoordinator = TimetableCoordinator.init(navigationController)
        timetableCoordinator.finishDelegate = self
        timetableCoordinator.start()
        childCoordinators.append(timetableCoordinator)
    }
    
    private func startSearchFlow(navigationController: UINavigationController){
        let searchCoordinator = SearchCoordinator.init(navigationController)
        searchCoordinator.finishDelegate = self
        searchCoordinator.start()
        childCoordinators.append(searchCoordinator)
    }
    
    private func startMapFlow(navigationController: UINavigationController) {
        let mapCoordinator = MapCoordinator.init(navigationController)
        mapCoordinator.finishDelegate = self
        mapCoordinator.start()
        childCoordinators.append(mapCoordinator)
    }
    
    private func startSettingsFlow(navigationController: UINavigationController){
        let settingsCoordinator = SettingsCoordinator.init(navigationController)
        settingsCoordinator.finishDelegate = self
        settingsCoordinator.start()
        childCoordinators.append(settingsCoordinator)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        /// Set delegate for UITabBarController
        tabBarController.delegate = self
        /// Assign page's controllers
        tabBarController.setViewControllers(tabControllers, animated: true)
        /// Let set index
        tabBarController.selectedIndex = TabBarPage.timetable.pageOrderNumber()
        /// Styling
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.backgroundColor = .clear //UIColor(white: 0.85, alpha: 0.9)
        tabBarController.tabBar.tintColor = UIColor(named: "DarkGreen")
        
        /// In this step, we attach tabBarController to navigation controller associated with this coordanator
        navigationController.viewControllers = [tabBarController]
    }
      
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        navController.navigationBar.defaultAppearance()

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageIcon(),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .timetable:
            startTimetableFlow(navigationController: navController)
        case .search:
            startSearchFlow(navigationController: navController)
        case .map:
            startMapFlow(navigationController: navController)
        case .settings:
            startSettingsFlow(navigationController: navController)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? {
        TabBarPage.init(index: tabBarController.selectedIndex)
    }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}

extension TabCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .search:
            print("puk")
        default:
            break
        }
    }
}

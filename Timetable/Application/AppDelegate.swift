//
//  AppDelegate.swift
//  Timetable
//
//  Created by Павел Грабчак on 10.09.2022.
//

import UIKit
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        NFX.sharedInstance().start()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let navigationController: UINavigationController = .init()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator.init(navigationController)
        appCoordinator?.start()
                
        return true
    }
}


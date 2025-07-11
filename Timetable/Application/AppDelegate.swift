//
//  AppDelegate.swift
//  Timetable
//
//  Created by Павел Грабчак on 10.09.2022.
//

import UIKit
import CoreData
import netfox
import BackgroundTasks

import Firebase
import FirebaseCore
import FirebaseAnalytics
import FirebaseCrashlytics

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        #if DEBUG
        DevelopConfigurator.sharedInstance.setDev(to: true)
        #endif
        
        if !UserDefaults.standard.bool(forKey: UDKeys.State.notFirstLaunch) {
            UserDefaults.standard.set(true, forKey: UDKeys.State.notFirstLaunch)

            UserDefaults.standard.set(true, forKey: UDKeys.Settings.autoUpdates)
        }
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let navigationController: UINavigationController = .init()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        appCoordinator = AppCoordinator.init(navigationController)
        appCoordinator?.start()
        
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.kubsautimetables.task.notifications", using: nil) { task in
            self.handleNotificationsCreation(task: task as! BGAppRefreshTask)
        }
        
        return true
    }

    func handleNotificationsCreation(task: BGAppRefreshTask) {
        scheduleNotification()
        
        scheduleAppRefresh()
        task.setTaskCompleted(success: true)
    }
    
    func scheduleNotification() {
        guard
            UserDefaults.standard.bool(forKey: UDKeys.Settings.allowNotifications),
            let timetableName = UserDefaults.standard.string(forKey: UDKeys.State.mainTimetable)
        else { return }
        
        let notifManager = NotificationManager()
        notifManager.clearAllNotifications()
        notifManager.scheduleNotifications(for: timetableName, handler: { _, _ in  })
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.kubsautimetables.task.notifications")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 3)
            
        do {
            try BGTaskScheduler.shared.submit(request)
            print("submit(request)")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TimetableModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

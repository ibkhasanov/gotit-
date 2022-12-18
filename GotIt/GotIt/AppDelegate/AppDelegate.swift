//
//  AppDelegate.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// Текущее окно
    var window: UIWindow?
    /// Основной координатор
    var mainCoordinator: CoreCoordinator?
    /// Конфигуратор
    var appConfigurator: AppConfigurationProtocol?
    
    /// Запуск приложения
    /// - Parameters:
    ///   - application: Приложение
    ///   - launchOptions: Опции
    /// - Returns: Bool
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.startWindowSetup()
        return true
    }
    
    /// Приложение собирается уйти в фон
    /// - Parameter application: UIApplication
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    /// Приложение вошло в фон
    /// - Parameter application: UIApplication
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    /// Приложение вышло из фона
    /// - Parameter application: UIApplication
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    /// Приложение стало активным
    /// - Parameter application: UIApplication
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    /// Приложение было остановлено
    /// - Parameter application: UIApplication
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

/// MARK: AppDelegateWindowProtocol
extension AppDelegate: AppDelegateWindowProtocol {
    /// Начальная настройка окна приложения
    func startWindowSetup() {
        self.appConfigurator = AppConfiguration()
        self.appConfigurator?.configure()
        let _window = UIWindow(frame: UIScreen.main.bounds)
        self.window = _window
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        let router = RouterImplementation(navigationController: navigationController)
        
        let startCoordinator = NavigationFactory().makeStartCoordinator(router: router)
        self.mainCoordinator = startCoordinator
        startCoordinator.start()
    }
}

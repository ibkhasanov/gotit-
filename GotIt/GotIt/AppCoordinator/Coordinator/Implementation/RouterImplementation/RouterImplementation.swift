//
//  RouterImplementation.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

/// Реализация роутера
open class RouterImplementation: CoreRouter {
    // MARK: Параметры
    /// Навигационный контроллер
    private weak var navigationViewController: UINavigationController?
    /// Основной контроллер
    private weak var rootViewController: UIViewController?
    
    // MARK: Инициализаторы
    /// Cтартовый инициализатор приложения
    /// - Parameter appRootViewController: NavigationController
    public init(appRootViewController: NavigationController) {
        self.navigationViewController = appRootViewController
        self.rootViewController = appRootViewController.viewControllers.last
    }
    
    /// Инициализатор
    /// - Parameter rootViewController: NavigationController
    public init(rootViewController: UINavigationController) {
        self.navigationViewController = rootViewController
        self.rootViewController = rootViewController.viewControllers.last
    }
    
    /// Инициализатор
    /// - Parameter navigationController: NavigationController
    public init(navigationController: UINavigationController) {
        self.navigationViewController = navigationController
        self.rootViewController = navigationController.viewControllers.first
    }
    
    // MARK: Показ через present
    /// Показ UIViewController
    /// - Returns: UIViewController
    public func toPresent() -> UIViewController? {
        return self.navigationViewController
    }
    
    /// Показать экран через present
    /// - Parameter module: Presentable?
    public func present(_ module: CorePresentable?) {
        self.present(module, animated: true)
    }
    
    /// Показать экран через present с установкой анимации
    /// - Parameters:
    ///   - module: Presentable?
    ///   - animated: Bool
    public func present(_ module: CorePresentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.navigationViewController?.present(controller, animated: animated, completion: nil)
    }
    
    // MARK: Закрытие
    /// Закрыть экран
    public func dismiss() {
        self.dismiss(animated: true)
    }
    
    /// Закрыть экран с установкой анимации
    /// - Parameter animated: Bool
    public func dismiss(animated: Bool) {
        self.navigationViewController?.dismiss(animated: animated, completion: nil)
    }
    
    // MARK: Показ через push
    /// Показать экран через push
    /// - Parameter module: Presentable?
    public func push(_ module: CorePresentable?) {
        self.push(module, animated: true)
    }
    
    /// Показать экран через push с установкой анимации
    /// - Parameters:
    ///   - module: Presentable?
    ///   - animated: Bool
    public func push(_ module: CorePresentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.navigationViewController?.pushViewController(controller, animated: animated)
    }
    
    /// Показать экран через push с установкой анимации и скрыть TabBar
    /// - Parameters:
    ///   - module: Presentable?
    ///   - animated: Bool
    public func pushAndHideTabBarIfNeeded(_ module: CorePresentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        controller.hidesBottomBarWhenPushed = true
        self.push(controller, animated: animated)
    }
    
    // MARK: Назад через pop
    /// Вернуться назад
    public func pop() {
        self.pop(animated: true)
    }
    
    /// Вернуться назад с установкой анимации
    /// - Parameter animated: Bool
    public func pop(animated: Bool) {
        self.navigationViewController?.popViewController(animated: animated)
    }
    
    /// Вернуться к главному экрану  с установкой анимации
    /// - Parameter animated: Bool
    public func popToRoot(animated: Bool) {
        guard let rootViewController = rootViewController,
              let contains = self.navigationViewController?.viewControllers.contains(rootViewController),
            contains else {
                self.popAll(animated: animated)
            return
        }
        self.navigationViewController?.popToViewController(rootViewController, animated: animated)
    }
    
    /// Вернуться назад через все экраны  с установкой анимации
    /// - Parameter animated: Bool
    public func popAll(animated: Bool) {
        self.navigationViewController?.popToRootViewController(animated: animated)
    }
    
    /// Вернуться  к определенному экрану с установкой анимации
    /// - Parameters:
    ///   - type: UIViewController.Type
    ///   - animated: Bool
    public func popToViewController(withClass type: UIViewController.Type, animated: Bool) {
        self.navigationViewController?.popToViewControllerOrRoot(
            withClass: type,
            animated: animated
        )
    }
    
    /// Настройка м
    /// - Parameters:
    ///   - color: Цвет
    ///   - backImage: Изображение назад
    ///   - barColor: Цвет
    ///   - isHide: Скрыт
    public func setupNavigationBar(color: UIColor,
                                   backImage: UIImage?,
                                   barColor: UIColor,
                                   isHide: Bool) {
        // TO-DO: Доработать navigationItem
        self.navigationViewController?.navigationBar.shadowImage = UIImage()
        self.navigationViewController?.setNavigationBarHidden(isHide, animated: false)
        /// кастомизируем Navigation Bar предыдущие настройки не работают на ios 15
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.backgroundColor = barColor
            self.navigationViewController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationViewController?.navigationBar.standardAppearance = navBarAppearance
        }
        self.navigationViewController?.navigationBar.tintColor = color
        self.navigationViewController?.navigationBar.barTintColor = barColor
        self.navigationViewController?.navigationBar.isTranslucent = false
        self.navigationViewController?.navigationBar.backgroundColor = barColor
        self.navigationViewController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationViewController?.navigationBar.backIndicatorImage = backImage
        self.navigationViewController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
}


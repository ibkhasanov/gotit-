//
//  CoreRouter.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation
import UIKit

/// Протокол роутера навигации
public protocol CoreRouter: CorePresentable {
    /// Показать экран через present
    func present(_ module: CorePresentable?)
    /// Показать экран через present с установкой анимации
    func present(_ module: CorePresentable?, animated: Bool)
    /// Закрыть экран
    func dismiss()
    /// Закрыть экран с установкой анимации
    func dismiss(animated: Bool)
    /// Показать экран через push
    func push(_ module: CorePresentable?)
    /// Показать экран через push с установкой анимации
    func push(_ module: CorePresentable?, animated: Bool)
    /// Показать экран через push с установкой анимации и скрыть TabBar
    func pushAndHideTabBarIfNeeded(_ module: CorePresentable?, animated: Bool)
    /// Вернуться назад
    func pop()
    /// Вернуться назад с установкой анимации
    func pop(animated: Bool)
    /// Вернуться к главному экрану  с установкой анимации
    func popToRoot(animated: Bool)
    /// Вернуться назад через все экраны  с установкой анимации
    func popAll(animated: Bool)
    /// Вернуться  к определенному экрану с установкой анимации
    func popToViewController(withClass type: UIViewController.Type, animated: Bool)
    /// Настройка avigationBar
    func setupNavigationBar(color: UIColor, backImage: UIImage?, barColor: UIColor, isHide: Bool)
}

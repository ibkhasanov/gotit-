//
//  AppDelegateWindowProtocol.swift
//  GotIt
//
//  Created by user on 18.12.2022.
//

import Foundation
import UIKit

/// MARK: AppDelegateWindowProtocol
/// Протокол для окна приложения
protocol AppDelegateWindowProtocol {
    /// Окно приложения
    var window: UIWindow? { get set }
    /// Основной координатор
    var mainCoordinator: CoreCoordinator? { get set }
    /// Конфигуратор
    var appConfigurator: AppConfigurationProtocol? { get set }
    /// Начальная настройка окна приложения
    func startWindowSetup()
}

//
//  NavigationFactoryProtocol.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit


/// Протокол Фабрики координаторов навигации
public protocol NavigationFactoryProtocol {
    /// Создать координатор для старта приложения
    /// - Returns: Coordinator
    func makeStartCoordinator(router: CoreRouter) -> CoreCoordinator
}

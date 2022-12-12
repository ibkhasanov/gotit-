//
//  CoreBaseCoordinator.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

/// Основной координатор
open class CoreBaseCoordinator: NSObject, CoreCoordinator {
    /// Координаторы
    var childCoordinators: [CoreCoordinator] = []
    
    /// Старт
    open func start() {
    }
    
    public func cleanDependency() {
        self.childCoordinators.removeAll()
    }
    
    /// Добавление зависимостей
    /// - Parameter coordinator: Координатор
    public func addDependency(_ coordinator: CoreCoordinator) {
        for element in self.childCoordinators {
            if element === coordinator { return }
        }
        self.childCoordinators.append(coordinator)
    }
    
    /// Удаление зависимостей
    /// - Parameter coordinator: coordinator Координатор
    public func removeDependency(_ coordinator: CoreCoordinator?) {
        guard self.childCoordinators.isEmpty == false, coordinator != nil else { return }
        for (index, element) in self.childCoordinators.enumerated() {
            if element === coordinator! {
                self.childCoordinators.remove(at: index)
                break
            }
        }
    }
}

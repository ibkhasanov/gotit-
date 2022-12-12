//
//  EmailRegistrationCoordinator.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation
import UIKit

extension EmailRegistrationCoordinator {
    /// Интсруктор
    enum Instructor {
        /// Начальный флоу
        case startFlow
        /// Успешно
        case success
        
        static func setup(success: Bool?) -> Instructor {
            if let _success = success, _success {
                return .success
            } else {
                return .startFlow
            }
        }
    }
}

/// Протокол координатора для регистрации
protocol EmailRegistrationCoordinatorProtocol {
    /// Нажатие на ссылку
    var success: Bool? { get set }
    /// Финиш
    func finishActionFlow()
}

/// MARK: Координатор  для регистрации
final class EmailRegistrationCoordinator: CoreBaseCoordinator, EmailRegistrationCoordinatorProtocol {
    private let router: CoreRouter
    private let factoryCoordinators: RegistrationCoordinatorsFactoryProtocol
    
    var success: Bool?
    
    /// Инициализатор
    /// - Parameters:
    ///   - router: Роутер
    init(router: CoreRouter,
         factoryCoordinators: RegistrationCoordinatorsFactoryProtocol) {
        self.router = router
        self.factoryCoordinators = factoryCoordinators
    }
    
    /// Старт флоу
    override func start() {
        let instructor = Instructor.setup(success: self.success)
        /// Очитска значений
        self.success = nil
        /// Переходы
        switch instructor {
            /// Старт
            case .startFlow:
                self.performFlow()
            /// Переход к webView
            case .success:
                self.transitionToSuccess()
        }
    }
    
    /// Финиш
    func finishActionFlow() {
        self.start()
    }
}

extension EmailRegistrationCoordinator {
    /// Выполнение флоу
    private func performFlow() {
    }
    
    /// Переход к email
    private func transitionToSuccess() {
    }
}

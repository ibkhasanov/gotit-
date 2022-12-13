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
    ///  Успешно
    var success: Bool? { get set }
    /// Финиш
    func finishActionFlow()
}

/// MARK: Координатор  для регистрации
final class EmailRegistrationCoordinator: CoreBaseCoordinator, EmailRegistrationCoordinatorProtocol {
    private let router: CoreRouter
    private let factoryCoordinators: RegistrationCoordinatorsFactoryProtocol
    private let appearanceFactory: RegistrationAppearanceFactoryProtocol
    private let layoutFactory: RegistrationLayoutFactoryProtocol
    private let repository: RegistrationUnionRepositoryProtocol
    
    var success: Bool?
    
    /// Инициализатор
    /// - Parameters:
    ///   - router: Роутер
    init(router: CoreRouter,
         factoryCoordinators: RegistrationCoordinatorsFactoryProtocol,
         appearanceFactory: RegistrationAppearanceFactoryProtocol,
         layoutFactory: RegistrationLayoutFactoryProtocol,
         repository: RegistrationUnionRepositoryProtocol) {
        self.router = router
        self.factoryCoordinators = factoryCoordinators
        self.appearanceFactory = appearanceFactory
        self.layoutFactory = layoutFactory
        self.repository = repository
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
        let vm = EmailRegistrationViewModel(image: UIImage(named: "logo"),
                                            message: "Registration",
                                            agreements: "By tapping Continue your agree to our Terms and acknowledge that you have read Privacy Policy",
                                            repository: self.repository,
                                            currentState: .init(),
                                            confirmTitle: "Continue",
                                            coordinator: self)
        let vc = EmailRegistrationViewController(layout: self.layoutFactory.email,
                                                 appearance: self.appearanceFactory.email,
                                                 viewModel: vm)
        self.router.push(vc)
    }
    
    /// Переход к успеху
    private func transitionToSuccess() {
    }
}

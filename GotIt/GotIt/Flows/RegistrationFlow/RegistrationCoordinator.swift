//
//  EmulateSplashCoordinator.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

extension RegistrationCoordinator {
    /// Интсруктор
    enum Instructor {
        /// Начальный флоу
        case startFlow
        /// К WebView
        case toEmail
        
        static func setup(toEmail: Bool?) -> Instructor {
            if let _toEmail = toEmail, _toEmail {
                return .toEmail
            } else {
                return .startFlow
            }
        }
    }
}

/// Протокол координатора для регистрации
protocol RegistrationCoordinatorProtocol {
    /// Нажатие на ссылку
    var toEmail: Bool? { get set }
    /// Финиш
    func finishActionFlow()
}

/// MARK: Координатор  для регистрации
final class RegistrationCoordinator: CoreBaseCoordinator, RegistrationCoordinatorProtocol {
    private let router: CoreRouter
    private let factoryCoordinators: RegistrationCoordinatorsFactoryProtocol
    private let appearanceFactory: RegistrationAppearanceFactoryProtocol
    private let layoutFactory: RegistrationLayoutFactoryProtocol
    private let repository: RegistrationUnionRepositoryProtocol
    
    var toEmail: Bool?
    
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
        let instructor = Instructor.setup(toEmail: self.toEmail)
        /// Очитска значений
        self.toEmail = nil
        /// Переходы
        switch instructor {
            /// Старт
            case .startFlow:
                self.performFlow()
            /// Переход к webView
            case .toEmail:
                self.transitionToEmail()
        }
    }
    
    /// Финиш
    func finishActionFlow() {
        self.start()
    }
}

extension RegistrationCoordinator {
    /// Выполнение флоу
    private func performFlow() {
        let vm = RegistrationViewModel(image: UIImage(named: "logo"),
                                       message: "Create an account to\ntrack & save your progress",
                                       agreements: "By tapping Continue your agree to our Terms and acknowledge that you have read Privacy Policy",
                                       repository: self.repository,
                                       emailTitle: "Continue with Email",
                                       appleTitle: "Continue with Apple",
                                       facebookTitle: "Continue with Facebook",
                                       googleTitle: "Continue with Google",
                                       coordinator: self)
        let vc = RegistrationViewController(layout: self.layoutFactory.types,
                                            appearance: self.appearanceFactory.types,
                                            viewModel: vm)
        self.router.push(vc)
    }
    
    /// Переход к email
    private func transitionToEmail() {
        let coordinator = self.factoryCoordinators.makeEmailRegisration(router: self.router)
        self.addDependency(coordinator)
    }
}

//
//  NavigationFactory.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

/// Фабрика координаторов навигации
final class NavigationFactory: NavigationFactoryProtocol {
    /// Создать координатор для старта приложения
    /// - Returns: Coordinator
    func makeStartCoordinator(router: CoreRouter) -> CoreCoordinator {
        let appearanceFactory = RegistrationAppearanceFactory()
        let layoutFactory = RegistrationLayoutFactory()
        let factoryCoordinators = RegistrationCoordinatorsFactory(appearanceFactory: appearanceFactory,
                                                                  layoutFactory: layoutFactory)
        let repository = RegistrationRepository(authApi: FirebaseAPIWrappers())
        let coordinator = RegistrationCoordinator(router: router,
                                                  factoryCoordinators: factoryCoordinators,
                                                  appearanceFactory: appearanceFactory,
                                                  layoutFactory: layoutFactory,
                                                  repository: repository)
        return coordinator
    }
}

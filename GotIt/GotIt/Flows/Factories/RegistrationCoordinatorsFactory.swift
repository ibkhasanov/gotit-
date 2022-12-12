//
//  RegistrationCoordinatorsFactory.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation

protocol RegistrationCoordinatorsFactoryProtocol {
    func makeEmailRegisration(router: CoreRouter) -> CoreBaseCoordinator
}

final class RegistrationCoordinatorsFactory: RegistrationCoordinatorsFactoryProtocol {
    private let appearanceFactory: RegistrationAppearanceFactoryProtocol
    private let layoutFactory: RegistrationLayoutFactoryProtocol
    
    init(appearanceFactory: RegistrationAppearanceFactoryProtocol,
         layoutFactory: RegistrationLayoutFactoryProtocol) {
        self.appearanceFactory = appearanceFactory
        self.layoutFactory = layoutFactory
    }
    
    func makeEmailRegisration(router: CoreRouter) -> CoreBaseCoordinator {
        return EmailRegistrationCoordinator(router: router,
                                            factoryCoordinators: self)
    }
}

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
    private let repository: RegistrationUnionRepositoryProtocol
    
    init(appearanceFactory: RegistrationAppearanceFactoryProtocol,
         layoutFactory: RegistrationLayoutFactoryProtocol,
         repository: RegistrationUnionRepositoryProtocol) {
        self.appearanceFactory = appearanceFactory
        self.layoutFactory = layoutFactory
        self.repository = repository
    }
    
    func makeEmailRegisration(router: CoreRouter) -> CoreBaseCoordinator {
        return EmailRegistrationCoordinator(router: router,
                                            factoryCoordinators: self,
                                            appearanceFactory: self.appearanceFactory,
                                            layoutFactory: self.layoutFactory,
                                            repository: self.repository)
    }
}

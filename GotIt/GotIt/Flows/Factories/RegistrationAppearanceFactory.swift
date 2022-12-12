//
//  RegistrationAppearanceFactory.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

/// MARK: Протокол фабрики внешнего вида экранов
protocol RegistrationAppearanceFactoryProtocol {
    ///  Типы
    var types: RegistrationViewController.Appearance { get }
    ///  По почте
    var email: EmailRegistrationViewController.Appearance { get }
}

/// MARK: Фабрика внешнего вида экранов
struct RegistrationAppearanceFactory: RegistrationAppearanceFactoryProtocol {
    init() { }
}

extension RegistrationAppearanceFactory {
    var types: RegistrationViewController.Appearance {
        return .init()
    }
    
    var email: EmailRegistrationViewController.Appearance {
        return .init()
    }
}

//
//  RegistrationLayoutFactory.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation
import UIKit

/// MARK: Протокол отступов внешнего вида экранов
protocol RegistrationLayoutFactoryProtocol {
    /// Информационный экран
    var types: RegistrationViewController.Layout { get }
    ///  По почте
    var email: EmailRegistrationViewController.Layout { get }
}

/// MARK: Фабрика отступов экранов
struct RegistrationLayoutFactory: RegistrationLayoutFactoryProtocol {
    init() { }
}

extension RegistrationLayoutFactory {
    var types: RegistrationViewController.Layout {
        return .init()
    }
    
    var email: EmailRegistrationViewController.Layout {
        return .init()
    }
}

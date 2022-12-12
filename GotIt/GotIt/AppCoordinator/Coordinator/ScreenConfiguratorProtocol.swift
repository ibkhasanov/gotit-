//
//  ScreenConfiguratorProtocol.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

/// Общий протокол Конфигуратора для экранов
public protocol ScreenConfiguratorProtocol {
    /// Конфигурация Экрана
    /// - Returns: UIViewController
    func configure() -> UIViewController
}

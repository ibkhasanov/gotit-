//
//  CorePresentable.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation
import UIKit

/// Протокол Представления
public protocol CorePresentable {
    /// Получить экран Представления
    /// - Returns: UIViewController?
    func toPresent() -> UIViewController?
}

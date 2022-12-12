//
//  +UIViewController.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

/// Расширение UIViewController
extension UIViewController: CorePresentable {
    /// Экран Представления
    /// - Returns: UIViewController?
    public func toPresent() -> UIViewController? {
        return self
    }
}

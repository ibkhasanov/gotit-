//
//  +UINavigationController.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation
import UIKit

/// Расширение UINavigationController
public extension UINavigationController {
    /// Вернуться к экрану или к главному экрану
    /// - Parameters:
    ///   - withClass: UIViewController
    ///   - animated: Bool
    func popToViewControllerOrRoot(withClass: UIViewController.Type, animated: Bool = true) {
        for controller in viewControllers {
            if controller.isKind(of: withClass) {
                popToViewController(controller, animated: animated)
                return
            }
        }
        
        popToRootViewController(animated: animated)
    }
}

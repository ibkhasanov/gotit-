//
//  NavigationController.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

/// Класс для Навигации
open class NavigationController: UINavigationController {
    /// Статус бар
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.default
    }
    
    /// ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// ViewWillAppear
    /// - Parameter animated: Bool
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}

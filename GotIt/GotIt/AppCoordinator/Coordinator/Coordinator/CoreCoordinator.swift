//
//  CoreCoordinator.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation

public typealias CoordinatorCompletionHandler = CustomActionHandler<(CoreBaseCoordinator) -> Void>

/// Протокол координатора
public protocol CoreCoordinator: AnyObject {
    /// Старт
    func start()
}
